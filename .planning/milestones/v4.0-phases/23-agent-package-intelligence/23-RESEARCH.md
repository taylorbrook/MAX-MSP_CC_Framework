# Phase 23: Agent Package Intelligence - Research

**Researched:** 2026-04-14
**Domain:** Agent knowledge systems, layout engine, package conventions
**Confidence:** HIGH

## Summary

This phase adds domain-specific package intelligence so agents generate idiomatic package patches, not just valid ones. The work divides into four domains: (1) a shared knowledge document `PACKAGES.md` plus per-agent SKILL.md updates, (2) package relationship entries in relationships.json, (3) DB-driven bpatcher sizing in `calculate_box_size()`, and (4) adaptive layout spacing for large bpatcher rows.

All target files and APIs exist and are well-understood. The BEAP and Vizzie DB entries already contain `bpatcher_dimensions`, `signal_convention`, and `category` fields from Phase 21 extraction. The sizing and layout code paths are clear, with single points of modification. The SKILL.md files have established section patterns. No external dependencies are needed.

**Primary recommendation:** Work bottom-up: sizing/layout code first (provides immediate correctness), then knowledge docs (PACKAGES.md and relationship entries), then agent SKILL.md updates last (they reference everything else).

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Hybrid approach -- shared reference doc at `.claude/max-objects/PACKAGES.md` for common facts (naming, signal conventions, bpatcher dimensions, categories), plus per-agent domain-specific sections in each SKILL.md
- **D-02:** Scope: bundled packages only (BEAP, Vizzie, jit.mo, Jitter Geometry, Jitter Tools, ableton-dsp, Mira, maxforlive-elements)
- **D-03:** Both templates + rules for BEAP. CV is 0-5V, audio is +/-1, always terminate with bp.Stereo/bp.Mono, use bp.VCA for gain control, 1V/oct for pitch tracking. Plus 3-5 canonical signal chain templates
- **D-04:** Each template lists which bp.* modules to use and connection order
- **D-05:** BEAP functional roles: Sources, Processors, Modulators, Output, Utility
- **D-06:** Vizzie same depth as BEAP -- templates for common video chains plus Jitter matrix conventions
- **D-07:** Essential pairs only -- 15-25 key pairs for relationships.json
- **D-08:** Add to existing relationships.json alongside the 19 core pairs. Tag package pairs with a `"package"` field for filtering
- **D-09:** DB-driven sizing -- look up `bpatcher_dimensions` from DB, flow through `calculate_box_size()` in sizing.py
- **D-10:** Adaptive spacing -- when row contains large bpatchers, increase vertical spacing proportionally

### Claude's Discretion
- Exact wording and formatting of PACKAGES.md sections
- Which specific BEAP/Vizzie modules appear in each template chain
- How per-agent SKILL.md sections reference the shared PACKAGES.md
- Specific spacing formula for bpatcher rows (proportional vs. fixed padding tiers)
- How `calculate_box_size()` accesses DB dimensions (parameter, lookup, or cached)

### Deferred Ideas (OUT OF SCOPE)
None
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| PKG-14 | Agent-specific guidance per package in SKILL.md files | SKILL.md section patterns documented; per-agent domain mapping researched |
| PKG-15 | BEAP modular patching patterns documented for agents | BEAP categories, I/O specs, signal conventions, template chains all researched |
| PKG-16 | Package-specific relationships.json entries | Existing format documented; BEAP/Vizzie pair candidates identified |
| PKG-17 | Layout overrides for bpatcher-based package objects | `calculate_box_size()` code path traced; modification approach clear |
| PKG-18 | Full parity with core domains (not just DB entries) | Gaps between core and package coverage identified |
</phase_requirements>

## Standard Stack

No new libraries needed. This phase modifies existing project files only.

### Core (Existing Project Modules)
| Module | Path | Purpose | Modification Needed |
|--------|------|---------|---------------------|
| `sizing.py` | `src/maxpat/sizing.py` | Box dimension calculation | Add bpatcher DB lookup for `bpatcher_dimensions` |
| `layout.py` | `src/maxpat/layout.py` | Row-based topological layout | Add adaptive v_spacing for tall bpatcher rows |
| `db_lookup.py` | `src/maxpat/db_lookup.py` | Object database interface | Already has `get_package_objects()`, `lookup()` with dimension data |
| `defaults.py` | `src/maxpat/defaults.py` | Spacing constants | May need bpatcher-specific spacing constant |
| `patcher.py` | `src/maxpat/patcher.py` | Patch construction API | `add_bpatcher()` may need auto-sizing from DB |

### Files to Create
| File | Purpose |
|------|---------|
| `.claude/max-objects/PACKAGES.md` | Shared package reference: signal conventions, functional roles, templates |
| SKILL.md updates (5 agents) | Per-agent package guidance sections |
| relationships.json additions | 15-25 package pair entries with `"package"` field |

## Architecture Patterns

### Pattern 1: DB-Driven Bpatcher Sizing (D-09)

**What:** When `calculate_box_size()` receives a bpatcher, it looks up actual dimensions from the ObjectDatabase instead of returning the fixed 200x100 default.

**Current code path:** [VERIFIED: codebase]
```python
# sizing.py line 160-161: bpatcher hits UI_SIZES fixed value
UI_SIZES = {
    ...
    "bpatcher": (200.0, 100.0),
    ...
}
```

**Problem:** `calculate_box_size(text, maxclass)` has no access to the object name. For bpatchers, `text` is `""` and `maxclass` is `"bpatcher"`, so there's no way to identify which BEAP/Vizzie module it is.

**Recommended approach:** Add an optional `object_name` parameter to `calculate_box_size()`. When `maxclass == "bpatcher"` and `object_name` is provided, look up `bpatcher_dimensions` from the DB.

```python
def calculate_box_size(
    text: str,
    maxclass: str,
    object_name: str | None = None,
    db: ObjectDatabase | None = None,
) -> tuple[float, float]:
    if maxclass == "bpatcher" and object_name and db:
        obj = db.lookup(object_name)
        if obj and "bpatcher_dimensions" in obj:
            dims = obj["bpatcher_dimensions"]
            return (float(dims[0]), float(dims[1]))
    # ... existing logic unchanged ...
```

**Alternative (Claude's discretion):** Build a static lookup dict from package DB files at module load time, avoiding the need to pass `db` parameter. This is simpler but less flexible. [ASSUMED]

**Integration points:**
- `patcher.py` line 210: `calculate_box_size(self.text, self.maxclass)` -- bpatchers are created via `add_bpatcher()`, not `Box.__init__()`, so this path is NOT the issue
- `patcher.py` line 1505: `bpatch_box.patching_rect = [x, y, width, height]` -- this is where the 200x100 default flows in from `add_bpatcher()` default params
- The better fix: make `add_bpatcher()` auto-lookup dimensions when width/height are not explicitly provided [VERIFIED: codebase]

**Cleanest approach:** Modify `add_bpatcher()` to accept an optional `object_name` parameter. When provided, look up `bpatcher_dimensions` from the DB and use them as width/height defaults instead of 200/100.

```python
def add_bpatcher(
    self,
    filename: str | None = None,
    embedded: bool = False,
    args: list[str] | None = None,
    x: float = 0.0,
    y: float = 0.0,
    width: float | None = None,  # Changed from 200.0
    height: float | None = None,  # Changed from 100.0
    numinlets: int = 1,
    numoutlets: int = 1,
    object_name: str | None = None,  # NEW: for DB dimension lookup
) -> Box | tuple[Box, Patcher]:
    # Auto-size from DB if object_name provided and dimensions not explicit
    if width is None or height is None:
        if object_name and self.db:
            obj = self.db.lookup(object_name)
            if obj and "bpatcher_dimensions" in obj:
                dims = obj["bpatcher_dimensions"]
                width = width or float(dims[0])
                height = height or float(dims[1])
        width = width or 200.0
        height = height or 100.0
```

**Also update `calculate_box_size()`** for the sizing.py code path used by non-`add_bpatcher` flows (e.g., `from_dict()` round-trip). Add a static bpatcher dimension cache loaded at module init.

### Pattern 2: Adaptive Row Spacing for Bpatchers (D-10)

**What:** When a layout row contains tall bpatchers (e.g., bp.Classroom Samplr at 484px), increase vertical spacing proportionally so the next row doesn't overlap.

**Current behavior:** [VERIFIED: codebase, layout.py line 360-363]
```python
for i in range(1, len(rows)):
    prev_row = rows[i - 1]
    max_height = max(b.patching_rect[3] for b in prev_row)
    row_y.append(row_y[-1] + max_height + options.v_spacing)
```

The engine already uses `max_height` of the previous row. The gap between rows is always `options.v_spacing` (default 20px). This works correctly as long as bpatcher boxes have correct heights.

**Key insight:** Once D-09 (DB-driven sizing) is implemented, this code will automatically produce correct spacing because `b.patching_rect[3]` will reflect actual bpatcher height. The existing `max_height + v_spacing` formula handles tall elements correctly.

**What D-10 adds beyond D-09:** For very large bpatchers (>200px tall), the fixed 20px v_spacing gap may feel too tight. A proportional gap improves readability.

**Recommended formula (Claude's discretion):**
```python
# Proportional padding: 20px base + 10% of tallest element height (clamped)
adaptive_gap = options.v_spacing + max(0, (max_height - 100) * 0.1)
row_y.append(row_y[-1] + max_height + adaptive_gap)
```

This gives:
- Standard objects (22px): 20px gap (unchanged)
- Small bpatchers (116px): 21.6px gap (barely different)
- Large bpatchers (484px): 58.4px gap (breathing room)

### Pattern 3: PACKAGES.md Shared Reference (D-01)

**What:** A single Markdown file at `.claude/max-objects/PACKAGES.md` containing facts that all agents share: signal conventions, functional categories, naming patterns, canonical templates.

**Structure:**
```markdown
# Package Reference

## Signal Conventions
### BEAP
- All CV signals: 0 to +5V range
- Audio signals: +/-1 range (standard MSP)
- 1V/oct pitch tracking on CV1 inputs
- Gate signals: 0V (off) to +5V (on)

### Vizzie
- All data flows as Jitter matrices between modules
- Matrix inlets accept `jit_matrix` type
- Control inlets accept int/float messages

## Functional Roles
### BEAP
| Role | Category | Key Modules |
|------|----------|-------------|
| Sources | Oscillator, Input | bp.Oscillator, bp.Keyboard, bp.Noise, bp.FM |
| Processors | Filter, Effects, Level | bp.LPF, bp.VCA, bp.Chorus, bp.Feedback Delay |
| Modulators | LFO, Envelope | bp.LFO, bp.ADSR, bp.AD, bp.Envelope Follower |
| Output | Output | bp.Stereo, bp.Mono |
| Utility | Scope, Misc, Sequencer, Mixers | bp.Scope, bp.Sequencer, bp.Audio Mixer |

### Vizzie
| Role | Category | Key Modules |
|------|----------|-------------|
| Sources | Input, Generate | vz.playr, vz.grabbr, vz.1easemappr |
| Effects | Effect, Transform | vz.blurrr, vz.scramblr, vz.delayr |
| Control | Control | vz.fadr, vz.slidr, vz.knobz |
| Compositing | Mix-Composite | vz.chromakeyr, vz.mixxr |
| Output | Output | vz.viewr, vz.projectr, vz.recordr |
| Utility | Utility | vz.presettr, vz.timeliner |

## Canonical Templates
[3-5 BEAP templates, 3 Vizzie templates with module lists and connection order]
```

### Pattern 4: Relationship Entry Format (D-07, D-08)

**What:** Add 15-25 package pairs to existing `relationships.json`, tagged with `"package"` field.

**Existing format:** [VERIFIED: codebase]
```json
{"objects": ["tapin~", "tapout~"], "relationship": "required_pair", "note": "..."}
```

**New entries add `"package"` field:**
```json
{"objects": ["bp.Oscillator", "bp.VCA"], "relationship": "signal_chain", "package": "BEAP", "note": "Oscillator output to VCA signal input for volume control"}
```

**Relationship types for packages:**
- `signal_chain` -- audio signal flow order (BEAP)
- `cv_pair` -- CV modulation source/destination (BEAP)
- `matrix_chain` -- Jitter matrix flow (Vizzie)
- `required_pair` -- must be used together

### Pattern 5: Per-Agent SKILL.md Updates (D-01, PKG-14)

**What:** Each agent gets a new section referencing PACKAGES.md and adding domain-specific guidance.

**Agent-to-package mapping:** [VERIFIED: CONTEXT.md canonical refs]

| Agent | Package Guidance Needed |
|-------|------------------------|
| max-patch-agent | BEAP modular patterns, Vizzie chains, bpatcher argument conventions for packages |
| max-dsp-agent | BEAP CV signal conventions (0-5V), audio signal handling, how BEAP relates to raw MSP |
| max-ui-agent | Bpatcher layout rules, package module sizing, presentation mode for package patches |
| max-rnbo-agent | Note that BEAP/Vizzie are NOT RNBO-compatible (negative guidance) |
| max-js-agent | Light touch -- package-aware scripting patterns if relevant |

**Section template for SKILL.md:**
```markdown
## Package Intelligence

Before generating patches with package objects, read `.claude/max-objects/PACKAGES.md` for:
- Signal conventions (BEAP: 0-5V CV, +/-1 audio; Vizzie: Jitter matrices)
- Functional roles and canonical module selection
- Template signal chains with connection order

### [Agent-Specific Section]
[Domain-specific rules for this agent]
```

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Bpatcher dimensions | Hardcoded dimension tables in agent prompts | DB `bpatcher_dimensions` field via `ObjectDatabase.lookup()` | 295 objects already have measured dimensions from Phase 21 extraction |
| BEAP category lists | Manual category lists in docs | `ObjectDatabase.get_package_objects("BEAP")` + filter by `category` field | DB already has category for all 185 BEAP objects |
| Vizzie category lists | Manual category lists | Same DB approach with Vizzie | DB has category for all 110 Vizzie objects |
| Object I/O details | Copy-pasting inlet/outlet descriptions | DB entries already have `digest` text on each inlet/outlet | Inlet digests contain signal conventions (e.g., "0 to +5v scales signal") |
| Package membership check | Manual prefix matching (bp., vz.) | `ObjectDatabase.get_package()` and `is_core()` | Handles edge cases, already tested |

## Common Pitfalls

### Pitfall 1: Breaking `calculate_box_size()` Signature
**What goes wrong:** Adding parameters to `calculate_box_size()` breaks all 15+ call sites in patcher.py, sizing.py, externals.py, rnbo.py.
**Why it happens:** The function is called in many places with just `(text, maxclass)`.
**How to avoid:** Make all new parameters optional with defaults. OR better: fix the bpatcher sizing at the `add_bpatcher()` level where the object name IS known, and only add a static cache to `calculate_box_size()` for round-trip scenarios.
**Warning signs:** Test failures in test_sizing.py (41 tests), test_layout.py (49 tests).

### Pitfall 2: Bpatcher Width/Height Default Breakage
**What goes wrong:** Changing `add_bpatcher()` default width/height from `200.0`/`100.0` to `None` breaks callers that don't pass explicit dimensions.
**Why it happens:** Existing code relies on the 200x100 fallback for non-package bpatchers (embedded subpatches, custom abstractions).
**How to avoid:** Keep 200x100 as the fallback when no `object_name` is provided or object has no `bpatcher_dimensions`. Only override when DB has actual dimensions.
**Warning signs:** Tests using `add_bpatcher()` without width/height start failing.

### Pitfall 3: relationships.json Format Inconsistency
**What goes wrong:** New package entries use different field names or structure than existing 19 core pairs.
**Why it happens:** Adding new relationship types (signal_chain, cv_pair, matrix_chain) that don't exist in the original.
**How to avoid:** Keep the same base structure: `objects`, `relationship`, `note`. The `package` field is purely additive. Validate all entries load correctly in tests.
**Warning signs:** Agent code that reads relationships.json breaks.

### Pitfall 4: PACKAGES.md Becomes Too Large for Agent Context
**What goes wrong:** If PACKAGES.md grows too large (>500 lines), agents won't read it efficiently.
**Why it happens:** Trying to document every object detail instead of patterns and conventions.
**How to avoid:** Keep PACKAGES.md focused on rules and templates (target: 150-250 lines). Individual object details stay in the DB JSON files where agents already look them up.
**Warning signs:** Agent response quality degrades because context window is spent on reference docs.

### Pitfall 5: Layout Test Assumptions About Fixed Spacing
**What goes wrong:** Existing layout tests may assert exact pixel positions that change with adaptive spacing.
**Why it happens:** Tests check specific y-coordinates derived from fixed 20px v_spacing.
**How to avoid:** Review test_layout.py for assertions on exact y-positions. Tests with standard-height objects (22px) should be unaffected by adaptive spacing since the formula adds 0 extra for heights under 100px.
**Warning signs:** test_layout.py failures after spacing changes.

## Code Examples

### Example 1: DB-Driven Bpatcher Sizing in add_bpatcher()

```python
# Source: sizing.py + patcher.py analysis [VERIFIED: codebase]
# Modified add_bpatcher() with DB dimension lookup

def add_bpatcher(
    self,
    filename: str | None = None,
    embedded: bool = False,
    args: list[str] | None = None,
    x: float = 0.0,
    y: float = 0.0,
    width: float | None = None,
    height: float | None = None,
    numinlets: int = 1,
    numoutlets: int = 1,
    object_name: str | None = None,
) -> Box | tuple[Box, Patcher]:
    if args is None:
        args = []
    
    # DB-driven dimension lookup
    if (width is None or height is None) and object_name and self.db:
        obj = self.db.lookup(object_name)
        if obj and "bpatcher_dimensions" in obj:
            dims = obj["bpatcher_dimensions"]
            if width is None:
                width = float(dims[0])
            if height is None:
                height = float(dims[1])
    
    # Fallback to standard defaults
    if width is None:
        width = 200.0
    if height is None:
        height = 100.0
    
    # ... rest of existing add_bpatcher() unchanged ...
```

### Example 2: Adaptive Row Spacing

```python
# Source: layout.py _position_component analysis [VERIFIED: codebase]
# Modified row Y computation with proportional gap

# In _position_component():
row_y: list[float] = [start_y]
for i in range(1, len(rows)):
    prev_row = rows[i - 1]
    max_height = max(b.patching_rect[3] for b in prev_row)
    # Adaptive gap: base spacing + proportional for tall elements
    gap = options.v_spacing
    if max_height > 100:
        gap += (max_height - 100) * 0.1
    row_y.append(row_y[-1] + max_height + gap)
```

### Example 3: Package Relationship Entry

```json
// Source: relationships.json format analysis [VERIFIED: codebase]
{
    "objects": ["bp.Keyboard", "bp.Oscillator"],
    "relationship": "cv_pair",
    "package": "BEAP",
    "note": "Keyboard pitch CV (outlet 0) to Oscillator CV1 (inlet 0) for 1V/oct tracking"
}
```

### Example 4: BEAP Template Chain (Subtractive Synth)

```markdown
### Subtractive Synthesizer
**Modules:** bp.Keyboard -> bp.Oscillator -> bp.LPF -> bp.VCA -> bp.Stereo
**Modulation:** bp.ADSR -> bp.VCA (CV), bp.LFO -> bp.LPF (CV2)
**Connections:**
1. bp.Keyboard outlet 0 (pitch CV) -> bp.Oscillator inlet 0 (CV1)
2. bp.Oscillator outlet 0 (signal) -> bp.LPF inlet 0 (signal input)
3. bp.LPF outlet 0 -> bp.VCA inlet 0 (signal input)
4. bp.VCA outlet 0 -> bp.Stereo inlet 0
5. bp.Keyboard outlet 1 (gate) -> bp.ADSR inlet 0 (gate)
6. bp.ADSR outlet 0 -> bp.VCA inlet 1 (CV)
7. bp.LFO outlet 0 -> bp.LPF inlet 1 (CV2 cutoff modulation)
```

### Example 5: Vizzie Template Chain (Effects Processing)

```markdown
### Video Effects Chain
**Modules:** vz.playr -> vz.blurrr -> vz.chromakeyr -> vz.viewr
**Connections:**
1. vz.playr outlet 0 (matrix) -> vz.blurrr inlet 0 (matrix input)
2. vz.blurrr outlet 0 (matrix) -> vz.chromakeyr inlet 0 (foreground matrix)
3. vz.chromakeyr outlet 0 (composited matrix) -> vz.viewr inlet 0 (matrix display)
```

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | `pyproject.toml` (assumed) |
| Quick run command | `python3 -m pytest tests/test_sizing.py tests/test_layout.py tests/test_package_schema.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| PKG-14 | Agent SKILL.md files contain package sections | content check | `python3 -m pytest tests/test_agent_skills.py -x -q` | Yes (needs new tests) |
| PKG-15 | PACKAGES.md has BEAP templates and rules | content check | `python3 -m pytest tests/test_package_schema.py -x -q` | Yes (needs new tests) |
| PKG-16 | relationships.json has package entries with package field | schema | `python3 -m pytest tests/test_package_schema.py -x -q` | Yes (needs new tests) |
| PKG-17 | Bpatcher sizing returns DB dimensions | unit | `python3 -m pytest tests/test_sizing.py -x -q` | Yes (needs new tests) |
| PKG-18 | Parity check: package objects have same coverage as core | integration | `python3 -m pytest tests/test_package_schema.py -x -q` | Yes (needs new tests) |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_sizing.py tests/test_layout.py tests/test_package_schema.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_sizing.py` -- add tests for bpatcher DB-driven sizing
- [ ] `tests/test_layout.py` -- add test for adaptive spacing with tall bpatchers
- [ ] `tests/test_package_schema.py` -- add tests for relationship package field, PACKAGES.md existence
- [ ] `tests/test_agent_skills.py` -- add tests for package intelligence sections in SKILL.md files

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Flat 200x100 bpatcher sizing | DB-driven from extracted dimensions | Phase 23 (this phase) | Correct visual layout for all 295 package bpatchers |
| No package knowledge in agents | PACKAGES.md + SKILL.md sections | Phase 23 (this phase) | Agents generate idiomatic package patches |
| Core-only relationships.json | Package pairs included | Phase 23 (this phase) | Agents suggest correct package companions |

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | Adaptive spacing formula `gap + (max_height - 100) * 0.1` produces good visual results | Architecture Patterns / Pattern 2 | Low -- formula is tunable, exact coefficients can be adjusted during implementation |
| A2 | Static bpatcher dimension cache in sizing.py is a viable alternative to passing DB parameter | Architecture Patterns / Pattern 1 | Low -- either approach works, Claude's discretion |
| A3 | PACKAGES.md target length 150-250 lines is sufficient for all conventions and templates | Common Pitfalls / Pitfall 4 | Medium -- may need to be longer for 8 packages with templates |

## Open Questions

1. **How should `from_dict()` round-trip handle bpatcher dimensions?**
   - What we know: `from_dict()` reads `patching_rect` directly from JSON, so actual dimensions are preserved on round-trip. `calculate_box_size()` is only called on new box creation.
   - What's unclear: Whether the static cache in sizing.py is needed at all, or if the `add_bpatcher()` fix alone is sufficient.
   - Recommendation: Implement `add_bpatcher()` fix first. Add sizing.py cache only if round-trip tests reveal dimension loss.

2. **Should the `object_name` parameter on `add_bpatcher()` also auto-set numinlets/numoutlets from DB?**
   - What we know: `add_bpatcher()` defaults to numinlets=1, numoutlets=1. Package bpatchers have variable I/O counts in the DB.
   - What's unclear: Whether callers currently rely on the default I/O or always pass explicit values.
   - Recommendation: Yes, auto-set I/O from DB when `object_name` is provided. This makes the `add_bpatcher(object_name="bp.Oscillator")` call fully self-contained.

## BEAP Domain Details

### Dimension Ranges [VERIFIED: codebase]
- Width: 52px (bp.Mono) to 895px (bp.Classroom Samplr)
- Height: 24px (bp.serialosc) to 484px (bp.Classroom Samplr)
- Most common height: 116px (standard module height)
- Standard modules: ~116px tall, 90-400px wide

### Categories (22 total) [VERIFIED: codebase]
Analysis (2), Effects (15), Envelope (13), Filter (12), Input (7), LFO (7), Level (16), MIDI (21), Misc (17), Mixers (5), Oscillator (15), Output (7), Quantizer (3), Random (5), Scope (9), Sequencer (12), Serialosc (15), Waveshapers (4)

### Key Template Modules [VERIFIED: codebase]

**Sources:**
- bp.Keyboard: 578x117, 0 in / 4 out (pitch CV, gate, velocity, aftertouch)
- bp.Oscillator: 314x116, 6 in / 2 out (CV1 1V/oct, CV2, CV3, FM, PWM, Sync)
- bp.Noise: ~similar pattern, 0 in / 1 out

**Processors:**
- bp.VCA: 113x116, 2 in / 1 out (signal, CV)
- bp.LPF: 304x116, 5 in / 1 out (signal, CV freq, CV res, ...)
- bp.Feedback Delay: 279x116, 1 in / 1 out

**Modulators:**
- bp.ADSR: 234x116, 2 in / 1 out (gate, retrigger)
- bp.LFO: 137x116, 0 in / 5 out (multiple waveforms)

**Output:**
- bp.Stereo: 148x116, 2 in / 0 out
- bp.Mono: 52x116, 1 in / 0 out

## Vizzie Domain Details

### Dimension Ranges [VERIFIED: codebase]
- Width: 71px to 738px
- Height: 57px to 517px

### Categories (8 total) [VERIFIED: codebase]
Control (21), Effect (23), Generate (23), Input (4), Mix-Composite (10), Output (5), Transform (16), Utility (8)

### I/O Type Convention [VERIFIED: codebase]
- Vizzie uses `matrix` and `control` I/O types (NOT signal)
- Modules pass Jitter matrices between them
- No audio signal processing -- pure video/visual domain

### Key Template Modules [VERIFIED: codebase]

**Sources:**
- vz.playr: 349x158, 7 in / 2 out (video file player)
- vz.grabbr: 355x158, 2 in / 1 out (camera/device input)

**Effects:**
- vz.blurrr, vz.scramblr, vz.delayr, etc.
- All follow pattern: matrix in -> processing -> matrix out

**Output:**
- vz.viewr: 230x208, 1 in / 0 out (display window)
- vz.projectr: 180x107, 4 in / 1 out (fullscreen output)
- vz.recordr: 318x145, 3 in / 0 out (save to file)

## Sources

### Primary (HIGH confidence)
- `src/maxpat/sizing.py` -- full code review, `calculate_box_size()` and `UI_SIZES` dict
- `src/maxpat/layout.py` -- full code review, `_position_component()` row spacing logic
- `src/maxpat/patcher.py` -- `add_bpatcher()` method, `Box.__init__()` sizing call
- `src/maxpat/db_lookup.py` -- `ObjectDatabase` class, `lookup()`, `get_package_objects()`
- `.claude/max-objects/packages/BEAP/objects.json` -- 185 objects with dimensions, categories, I/O
- `.claude/max-objects/packages/Vizzie/objects.json` -- 110 objects with dimensions, categories, I/O
- `.claude/max-objects/relationships.json` -- 19 existing core pairs, format reference
- `.claude/max-objects/package_info.json` -- 20 package entries with tier/prefix/description
- `.claude/skills/max-patch-agent/SKILL.md` -- existing section structure
- `.claude/skills/max-dsp-agent/SKILL.md` -- existing section structure
- `.claude/skills/max-ui-agent/SKILL.md` -- existing section structure
- `tests/test_sizing.py` -- 41 existing tests, all passing
- `tests/test_layout.py` -- 49 existing tests, all passing
- `tests/test_package_schema.py` -- existing package schema tests

### Secondary (MEDIUM confidence)
- None needed -- all information from codebase analysis

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- no new libraries, all existing code paths traced
- Architecture: HIGH -- clear modification points identified with exact line numbers
- Pitfalls: HIGH -- based on actual code analysis, not speculation
- BEAP/Vizzie domain: HIGH -- all data from extracted DB entries

**Research date:** 2026-04-14
**Valid until:** 2026-05-14 (stable -- internal codebase, no external dependencies)
