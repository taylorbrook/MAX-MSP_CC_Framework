# Architecture Patterns: v2.0 Direct .maxpat Editing

**Domain:** Refactoring from Python generation pipeline to direct .maxpat reading/editing
**Researched:** 2026-03-15
**Confidence:** HIGH (based on direct analysis of existing codebase -- all components are custom Python with no external dependencies to verify)

## Current Architecture (v1.x)

The v1.x pipeline follows a write-only model where Python scripts are the source of truth:

```
Agent -> generate.py (builds Patcher) -> apply_layout() -> validate_patch() -> merge_and_write() -> .maxpat
```

**Key friction:** The `.maxpat` file is an output, not a source. When users edit in MAX, their changes compete with `generate.py`. The `incremental.py` module partially addresses this via manifest-tracked merge, but the fundamental problem remains: agents think in Python, not in patches.

### Component Inventory (What Exists)

| Component | File(s) | Lines | Role | v2 Impact |
|-----------|---------|-------|------|-----------|
| Data Model | `patcher.py` | 1134 | Patcher/Box/Patchline + `from_dict()` + `to_dict()` | MAJOR: becomes read-write editor |
| Layout | `layout.py` | 970 | Row-based topological positioning | MODERATE: selective re-layout only |
| Validation | `validation.py` | 669 | 4-layer pipeline (JSON/objects/connections/domain) | MODERATE: adapt to edit-time use |
| Hooks | `hooks.py` | 269 | `write_patch`, `validate_file` | MODERATE: add `read_patch`, `edit_patch` |
| Incremental | `incremental.py` | 476 | Manifest-based merge | REMOVE: direct editing replaces merging |
| Critics | `critics/` | 4 files | Semantic review (DSP, structure, RNBO, external) | MINOR: unchanged, operate on dicts |
| DB Lookup | `db_lookup.py` | 287 | Object existence, I/O counts, alias resolution | UNCHANGED |
| Aesthetics | `aesthetics.py` | ~100 | Canvas/object bg color, panel sizing | MINOR: works via extra_attrs |
| Sizing | `sizing.py` | ~150 | Content-aware box dimensions | UNCHANGED |
| Defaults | `defaults.py` | 133 | Constants, LayoutOptions | MINOR: add EditOptions |
| Codegen | `codegen.py` | ~300 | GenExpr/N4M/js generation | UNCHANGED |
| Code Validation | `code_validation.py` | ~300 | GenExpr/js syntax checks | UNCHANGED |
| Maxclass Map | `maxclass_map.py` | ~70 | UI vs newobj resolution | UNCHANGED |
| Project | `project.py` | ~400 | Project lifecycle, versioning | MODERATE: remove generate.py dependency |
| Memory | `memory.py` | ~268 | Dual-scope pattern storage | UNCHANGED |
| RNBO | `rnbo.py`, `rnbo_validation.py` | ~600 | RNBO generation/validation | UNCHANGED |
| Externals | `externals.py`, `ext_*.py` | ~900 | C++ external scaffolding | UNCHANGED |
| Commands | `.claude/commands/max-*.md` | 10 files | Slash command definitions | MAJOR: rewrite workflow |
| Public API | `__init__.py` | 195 | Re-exports | MODERATE: add read/edit API |

---

## Recommended Architecture (v2.0)

### Core Principle: .maxpat as Single Source of Truth

The .maxpat file IS the project. Agents read it, understand it, modify it, and write it back. No intermediate Python representation is authoritative.

```
.maxpat (on disk)
    |
    v
read_patch() -> Patcher (in-memory, hydrated from JSON)
    |
    v
Agent analyzes / modifies Patcher (add_box, remove_box, rewire, etc.)
    |
    v
validate_patch(patcher) -> ValidationResult[]
    |
    v
write_patch_direct(patcher, path) -> .maxpat (on disk)
```

### Component Boundaries

| Component | Responsibility | Communicates With |
|-----------|---------------|-------------------|
| **PatchReader** (`patcher.py::from_dict()` -- enhanced) | Load .maxpat JSON into hydrated Patcher with full Box metadata | Hooks, Agents |
| **PatchEditor** (new methods on Patcher) | Surgical operations: add/remove/replace boxes, rewire, modify attrs | Agents, Validation |
| **PatchWriter** (`hooks.py::write_patch_direct()`) | Serialize Patcher back to .maxpat JSON, preserving unknown keys | PatchEditor |
| **PatchAnalyzer** (new: `analyzer.py`) | Read-only inspection: signal chains, component graph, object inventory | /max-onboard, Agents |
| **Validation Pipeline** (`validation.py` -- adapted) | Run on Patcher objects (not just dicts), edit-time incremental checks | PatchEditor |
| **Layout Engine** (`layout.py` -- selective mode) | Selective re-layout: position only new/unpositioned boxes | PatchEditor |
| **Object Database** (`db_lookup.py`) | Unchanged: existence, I/O counts, alias resolution | PatchReader, PatchEditor, Validation |
| **Critics** (`critics/`) | Unchanged: semantic review on dict output | /max-verify |
| **Commands** (`.claude/commands/`) | Rewritten workflows: read-modify-write cycle | All components |
| **Project** (`project.py`) | Simplified: no generate.py, no manifest | Commands |

---

## New Components

### 1. Enhanced `Patcher.from_dict()` -- The Read Path

**Current state:** `from_dict()` already exists (lines 1012-1122 of patcher.py). It reconstructs boxes and lines but skips DB hydration (uses `Box.__new__` to bypass validation). This is correct for loading -- we trust the file.

**What needs to change:**

```python
# Current: Box created via __new__, minimal metadata
box.name = box.text.split()[0]
box.args = parts[1:]

# Needed: Optional DB enrichment for analysis
if db and db.exists(box.name):
    obj_data = db.lookup(box.name)
    box._db_inlets = obj_data.get("inlets", [])
    box._db_outlets = obj_data.get("outlets", [])
    box._db_variable_io = obj_data.get("variable_io", False)
```

The key insight: `from_dict()` must NOT validate or error on unknown objects. Files from any source may contain objects not in our database. But it SHOULD optionally enrich boxes with DB metadata when available -- this powers analysis and smart editing.

**Specific enhancements:**

| Enhancement | Why | Complexity |
|-------------|-----|-----------|
| bpatcher attr reconstruction | `_bpatcher_attrs` not populated from JSON; needed for round-trip fidelity | Low |
| Unknown key preservation | `extra_attrs` already captures extras, but verify completeness | Low |
| DB-optional enrichment | Attach DB metadata when available, skip when not | Low |
| Nested patcher depth tracking | Know whether a box is top-level or inside a subpatcher | Low |
| ID collision detection | Loaded patches may have ID conflicts; detect and report | Low |

**What NOT to change:** Do not add DB validation to the read path. A .maxpat file loaded from disk is valid by definition (MAX created it). Our DB may be incomplete. The read path must never reject a file.

### 2. PatchEditor Methods on Patcher

New methods that perform surgical modifications on a loaded Patcher. These are the operations agents will use instead of building from scratch.

```python
class Patcher:
    # --- Existing (keep) ---
    def add_box(self, name, args, x, y) -> Box: ...
    def add_connection(self, src, outlet, dst, inlet) -> Patchline: ...
    def add_subpatcher(self, name, inlets, outlets) -> (Box, Patcher): ...
    # etc.

    # --- New: Read ---
    @classmethod
    def from_dict(cls, data, db=None) -> Patcher: ...       # Enhanced (exists)
    def find_box(self, name=None, id=None, text=None) -> Box | None: ...
    def find_boxes(self, name=None, maxclass=None) -> list[Box]: ...
    def find_connections_from(self, box) -> list[Patchline]: ...
    def find_connections_to(self, box) -> list[Patchline]: ...
    def get_signal_chain(self, start_box) -> list[Box]: ...

    # --- New: Edit ---
    def remove_box(self, box_or_id) -> None: ...          # Also removes connected lines
    def replace_box(self, old, new_name, new_args) -> Box: ...  # Preserves position + connections
    def disconnect(self, src, outlet, dst, inlet) -> None: ...
    def rewire(self, old_src, old_outlet, new_src, new_outlet, dst, inlet) -> None: ...
    def move_box(self, box, x, y) -> None: ...
    def set_attr(self, box, key, value) -> None: ...

    # --- New: Layout ---
    def layout_new_boxes(self, boxes) -> None: ...         # Position only newly added boxes
    def auto_position_near(self, box, reference_box, direction="below") -> None: ...
```

**Design decisions:**

1. **`remove_box()` cascades to connections.** When a box is removed, all patchlines referencing it are also removed. This matches MAX behavior and prevents dangling connections.

2. **`replace_box()` preserves position and connections.** Swapping `cycle~ 440` for `saw~ 440` keeps the same x/y, reconnects existing cables where inlet/outlet counts allow. Excess connections are dropped with a warning.

3. **`find_box()` searches by multiple criteria.** Agents need to locate boxes by name ("find the dac~"), by ID (from error messages), or by text content (for gen~ codeboxes).

4. **No implicit layout.** Editing methods do NOT trigger automatic layout. Position is preserved from the file. New boxes are placed at a specified position or via explicit `auto_position_near()`.

5. **ID stability.** All editing operations preserve existing box IDs. New boxes get IDs from `_next_id` (which `from_dict` already initializes past the highest existing ID). This means connections between existing boxes remain valid.

### 3. PatchAnalyzer (`analyzer.py`)

Read-only analysis of a loaded Patcher. Powers `/max-onboard` and gives agents structural understanding.

```python
class PatchAnalyzer:
    def __init__(self, patcher: Patcher, db: ObjectDatabase): ...

    # Structure
    def inventory(self) -> dict:
        """Count objects by domain (MSP, Max, Jitter, etc.)."""
    def signal_chains(self) -> list[list[Box]]:
        """Trace all signal paths from sources to sinks."""
    def control_chains(self) -> list[list[Box]]:
        """Trace control-rate message paths."""
    def subpatcher_tree(self) -> dict:
        """Nested dict of subpatcher hierarchy."""
    def find_orphans(self) -> list[Box]:
        """Boxes with no connections."""

    # Semantic
    def classify_purpose(self) -> str:
        """Heuristic: 'synthesizer', 'effect', 'sequencer', 'utility', etc."""
    def identify_parameters(self) -> list[dict]:
        """Find user-facing controls (number, slider, dial + what they control)."""
    def identify_signal_flow(self) -> str:
        """Human-readable description: 'osc -> filter -> gain -> dac'."""

    # Validation
    def check_health(self) -> list[ValidationResult]:
        """Run validation pipeline on the loaded patch."""
    def diff(self, other: Patcher) -> list[str]:
        """Compare two patches: added/removed/changed boxes and connections."""
```

**Why a separate class:** Analysis is read-only and stateless. Putting it on Patcher would bloat the class. The analyzer takes a Patcher and DB, uses them for inspection, returns results. Clean separation.

### 4. Direct Write (`hooks.py::write_patch_direct()`)

A new write function that skips layout and writes a Patcher directly to disk. For the edit workflow, layout has already been done (positions come from the loaded file), so re-running full layout would destroy user positioning.

```python
def write_patch_direct(
    patcher: Patcher,
    path: str | Path,
    validate: bool = True,
) -> list[ValidationResult]:
    """Write a Patcher directly to .maxpat without applying layout.

    Used for the edit workflow where positions are already set from the
    loaded file. New boxes should be positioned before calling this.

    Runs validation unless validate=False. Does NOT auto-fix -- reports only.
    """
```

**Key difference from `write_patch()`:** No `apply_layout()` call. No `_apply_auto_styling()` on loaded boxes (only on new boxes the agent explicitly styles). Preserves the exact JSON structure from the loaded file with only targeted edits applied.

---

## Integration Points: Agents and Commands

### Current Agent Data Flow (v1.x)

```
/max-build "kick synth"
    -> max-router dispatches to max-dsp-agent
    -> Agent writes generate.py (Python code that builds Patcher)
    -> Agent runs generate.py
    -> merge_and_write() outputs .maxpat
```

The agent never touches the .maxpat directly. It writes Python code that creates Python objects that serialize to JSON. Three layers of indirection.

### New Agent Data Flow (v2.0)

```
/max-build "kick synth"
    -> max-router dispatches to max-dsp-agent
    -> Agent calls read_patch() if .maxpat exists (or creates empty Patcher)
    -> Agent calls Patcher methods directly (add_box, add_connection, etc.)
    -> Agent calls write_patch_direct()
    -> .maxpat updated
```

```
/max-iterate "add LFO to filter"
    -> read_patch() loads existing .maxpat
    -> PatchAnalyzer identifies the filter and its control inputs
    -> Agent calls add_box("cycle~", ["0.5"]) for LFO
    -> Agent calls add_connection(lfo, 0, filter_cutoff_inlet)
    -> Agent calls auto_position_near(lfo, filter, "above")
    -> validate_patch(patcher) checks the edit
    -> write_patch_direct() saves
```

```
/max-onboard
    -> read_patch() loads unknown .maxpat
    -> PatchAnalyzer runs full analysis
    -> Output: inventory, signal chains, parameter map, health check
    -> Findings written to project context.md
```

### Command Rewrites

| Command | v1.x Behavior | v2.0 Behavior | Change Scope |
|---------|--------------|---------------|-------------|
| `/max-new` | Creates project dir + empty generate.py | Creates project dir + empty .maxpat (or no file) | MINOR |
| `/max-build` | Agent writes generate.py, runs it | Agent reads/creates .maxpat, edits directly, writes | MAJOR |
| `/max-iterate` | Agent edits generate.py, runs it | Agent reads .maxpat, edits directly, writes | MAJOR |
| `/max-verify` | Runs validate_file + critics on .maxpat | Same -- unchanged (already reads .maxpat) | NONE |
| `/max-research` | Looks up object DB | Same -- unchanged | NONE |
| `/max-memory` | Read/write patterns | Same -- unchanged | NONE |
| `/max-status` | Read project status | Same -- unchanged | NONE |
| `/max-switch` | Switch active project | Same -- unchanged | NONE |
| `/max-test` | Run test suite | Same -- unchanged | NONE |
| `/max-discuss` | Conversational | Same -- unchanged | NONE |
| `/max-onboard` | DOES NOT EXIST | NEW: analyze unknown .maxpat | NEW |

**Key insight:** Only 3 commands change (build, iterate, new). The rest already work on .maxpat files or are independent of the generation pipeline. The /max-onboard command is entirely new.

### Validation Hook Integration

**Current:** Validation runs on the `dict` output of `patcher.to_dict()` inside `write_patch()`. It operates on raw JSON, not Patcher objects.

**v2.0 changes:**

1. **`validate_patch()` already accepts both Patcher and dict.** Lines 84-108 of validation.py show it converts Patcher to dict if needed. No change required for the entry point.

2. **Edit-time validation (new).** For interactive editing, we want to validate specific changes without running the full pipeline:

```python
def validate_edit(patcher: Patcher, changed_boxes: list[Box]) -> list[ValidationResult]:
    """Validate only the boxes and connections affected by recent edits.

    Runs Layer 2 (object existence) and Layer 3 (connection bounds) only on
    the changed boxes and their connections. Skips Layer 1 (JSON structure,
    which is always valid for Patcher objects) and Layer 4 (domain rules,
    which are best run as a full-patch check at write time).
    """
```

3. **Validation on load (optional).** When `/max-onboard` loads an unknown patch, it should run validation to report health. This already works via `validate_file()` -- no change needed.

4. **Critic review timing is unchanged.** Critics run on the final dict before the user sees results. They check semantics (gain staging, fan-out patterns, RNBO fitness), not structural validity. The `/max-verify` command continues to invoke them.

---

## Data Flow Changes: Detailed

### Before (v1.x): Build Flow

```
User: /max-build "kick drum synth"
  |
  v
max-router -> max-dsp-agent
  |
  v
Agent generates generate.py:
  from src.maxpat import Patcher, merge_and_write
  p = Patcher()
  osc = p.add_box("cycle~", ["440"])
  dac = p.add_box("dac~")
  p.add_connection(osc, 0, dac, 0)
  merge_and_write(p, "patches/kick/generated/kick.maxpat")
  |
  v
merge_and_write():
  1. Load old manifest (sidecar .manifest.json)
  2. Load existing .maxpat
  3. Merge: keep user boxes, replace generator boxes, merge attrs
  4. apply_layout() on merged patcher
  5. validate_patch() on merged dict
  6. Write .maxpat + manifest
```

### After (v2.0): Build Flow

```
User: /max-build "kick drum synth"
  |
  v
max-router -> max-dsp-agent
  |
  v
Agent reads existing or creates new:
  from src.maxpat import Patcher, read_patch, write_patch_direct
  p = read_patch("patches/kick/kick.maxpat")  # or Patcher() if new
  |
  v
Agent edits directly:
  osc = p.add_box("cycle~", ["440"], x=100, y=50)
  gain = p.add_box("*~", ["0.5"], x=100, y=80)
  dac = p.add_box("dac~", x=100, y=110)
  p.add_connection(osc, 0, gain, 0)
  p.add_connection(gain, 0, dac, 0)
  p.add_connection(gain, 0, dac, 1)
  |
  v
write_patch_direct(p, "patches/kick/kick.maxpat"):
  1. validate_patch(p)
  2. p.to_dict()
  3. Write JSON to disk
  # No manifest. No merge. No layout (agent positioned boxes).
```

### Before (v1.x): Iterate Flow

```
User: /max-iterate "add reverb to output"
  |
  v
Agent edits generate.py (adds reverb section)
  |
  v
Agent runs generate.py
  |
  v
merge_and_write() merges with existing .maxpat
  (user changes preserved via manifest tracking)
```

### After (v2.0): Iterate Flow

```
User: /max-iterate "add reverb to output"
  |
  v
p = read_patch("patches/kick/kick.maxpat")
analyzer = PatchAnalyzer(p, db)
  |
  v
Agent identifies: dac~ is the output, gain~ feeds it
  chains = analyzer.signal_chains()
  # Finds: [cycle~ -> *~ -> dac~]
  |
  v
Agent inserts reverb between gain and dac:
  rev = p.add_box("yafr2~")
  p.auto_position_near(rev, gain_box, "below")
  p.disconnect(gain_box, 0, dac_box, 0)
  p.add_connection(gain_box, 0, rev, 0)
  p.add_connection(rev, 0, dac_box, 0)
  p.add_connection(rev, 1, dac_box, 1)
  |
  v
write_patch_direct(p, "patches/kick/kick.maxpat")
  # User's manual edits are FULLY preserved (we loaded them).
  # No manifest needed -- we read the whole file and edited in place.
```

**The critical improvement:** User changes are preserved by default because we loaded them. No manifest tracking needed. No merge logic. The .maxpat file is the single source of truth at every step.

### New: /max-onboard Flow

```
User: /max-onboard (with a .maxpat file present)
  |
  v
p = read_patch("patches/imported/some-patch.maxpat")
analyzer = PatchAnalyzer(p, db)
  |
  v
report = {
    "object_count": 47,
    "domain_breakdown": {"MSP": 23, "Max": 18, "Jitter": 6},
    "signal_chains": ["cycle~ -> svf~ -> *~ -> dac~"],
    "parameters": [
        {"name": "cutoff", "control": "dial", "target": "svf~", "inlet": 1},
    ],
    "health": [
        "WARNING: Missing gain staging on cycle~ -> dac~ path",
    ],
    "subpatchers": {"p filter-section": 12, "p modulation": 8},
    "purpose": "subtractive synthesizer with filter modulation",
}
  |
  v
Write report to project context.md
Agent can now /max-iterate on this patch with full understanding
```

---

## Files to Remove (v2.0 cleanup)

| File/Artifact | Why Remove |
|---------------|-----------|
| `patches/*/generated/generate.py` | Replaced by direct editing |
| `patches/*/generated/build_*.py` | Same -- generation scripts |
| `patches/*/generated/*.manifest.json` | Manifest tracking obsolete |
| `src/maxpat/incremental.py` | Merge logic obsolete -- direct editing replaces it |
| `Manifest` class and `merge_and_write()` | No longer needed |

**Migration path:** Existing patches keep their .maxpat files. The .maxpat is already the authoritative output -- generation scripts and manifests were the infrastructure around it. Remove the infrastructure, keep the output.

---

## Patterns to Follow

### Pattern 1: Round-Trip Fidelity

**What:** Any .maxpat loaded via `from_dict()` and immediately saved via `to_dict()` must produce byte-identical JSON (modulo whitespace).

**When:** Always. This is the foundation of trust in direct editing.

**Implementation:** `from_dict()` already preserves unknown keys via `extra_attrs`. The enhancement needed is ensuring key ordering in `to_dict()` matches the original file. Use `collections.OrderedDict` or sort keys to match MAX's output order.

**Test:** Load every existing project .maxpat, round-trip through from_dict/to_dict, assert JSON equality.

```python
def test_round_trip_fidelity(maxpat_path):
    original = json.loads(Path(maxpat_path).read_text())
    patcher = Patcher.from_dict(original)
    roundtripped = patcher.to_dict()
    assert roundtripped == original
```

### Pattern 2: Defensive Loading

**What:** `from_dict()` never raises exceptions on valid .maxpat JSON, even if objects are unknown to our database.

**When:** Always. Users import patches from anywhere.

**Implementation:** Already implemented -- `from_dict()` uses `Box.__new__` to bypass DB validation. The enhancement is to also gracefully handle:
- Missing `text` fields on `newobj` boxes (corrupted but loadable)
- Non-standard ID formats (e.g., "obj-0042", "mybox", UUID strings)
- Recursive subpatcher depth > 10 (some patches nest deeply)
- Extremely large patches (1000+ boxes -- memory-safe iteration)

### Pattern 3: Preserve-by-Default

**What:** Every attribute of every box is preserved unless explicitly changed by an edit operation.

**When:** Always during edit operations.

**Implementation:** Edit methods modify specific fields on Box objects. They never create new Box objects for existing boxes (which would lose extra_attrs). `replace_box()` copies position, extra_attrs, and presentation from the old box.

### Pattern 4: Position-Aware Insertion

**What:** When adding new boxes to an existing patch, position them intelligently relative to existing content.

**When:** All add operations in edit context.

**Implementation:**

```python
def auto_position_near(self, box: Box, reference: Box, direction: str = "below") -> None:
    """Position box relative to reference, avoiding overlaps."""
    ref_rect = reference.patching_rect
    if direction == "below":
        box.patching_rect[0] = ref_rect[0]
        box.patching_rect[1] = ref_rect[1] + ref_rect[3] + V_SPACING
    elif direction == "right":
        box.patching_rect[0] = ref_rect[0] + ref_rect[2] + H_GUTTER
        box.patching_rect[1] = ref_rect[1]
    elif direction == "above":
        box.patching_rect[0] = ref_rect[0]
        box.patching_rect[1] = ref_rect[1] - box.patching_rect[3] - V_SPACING
    # Check for overlaps with existing boxes and shift if needed
    self._resolve_overlaps(box)
```

### Pattern 5: Edit Transaction Idiom

**What:** Group related edits into logical transactions so validation runs once per transaction, not per operation.

**When:** Complex edits that involve multiple add/remove/rewire operations.

**Implementation:**

```python
# Agent code for adding a reverb section:
p = read_patch(path)

# Transaction: multiple edits, validate once at the end
rev = p.add_box("yafr2~", x=200, y=300)
wet = p.add_box("*~", ["0.3"], x=200, y=330)
p.add_connection(rev, 0, wet, 0)
p.disconnect(gain_box, 0, dac_box, 0)
p.add_connection(gain_box, 0, rev, 0)
p.add_connection(wet, 0, dac_box, 0)

# Single validation at write time
write_patch_direct(p, path)
```

---

## Anti-Patterns to Avoid

### Anti-Pattern 1: Re-Layout on Edit

**What:** Running `apply_layout()` on a loaded-and-edited patch.

**Why bad:** Destroys all user positioning. A patch loaded from disk has positions that the user set in MAX. Re-laying out moves everything.

**Instead:** Only position newly added boxes. Use `auto_position_near()` or explicit coordinates. Never call `apply_layout()` on a loaded Patcher.

### Anti-Pattern 2: Recreate-to-Edit

**What:** Building a new Patcher from scratch to "edit" an existing patch (the v1.x approach).

**Why bad:** Loses everything not captured in generate.py: user-added objects, manual position tweaks, presentation mode adjustments, extra attributes set in MAX.

**Instead:** Load the existing .maxpat, modify it in place, write it back. The .maxpat file contains the complete truth.

### Anti-Pattern 3: Validation-Gated Loading

**What:** Refusing to load a .maxpat that fails validation.

**Why bad:** Any patch from the wild may have "errors" by our standards (objects not in our DB, unusual connections). Blocking load means we cannot analyze or edit these patches.

**Instead:** Load everything, validate optionally, report issues without blocking.

### Anti-Pattern 4: Agent Generates Python Code

**What:** v2.0 agents generating Python scripts that call Patcher methods.

**Why bad:** Adds an unnecessary indirection layer. The whole point of v2.0 is that agents edit patches directly.

**Instead:** Agents call Patcher methods directly in their execution context. No intermediate scripts.

### Anti-Pattern 5: Dual Source of Truth

**What:** Keeping generate.py alongside the .maxpat for the same project.

**Why bad:** The exact problem v2.0 solves. Two sources = inevitable drift.

**Instead:** One source: the .maxpat file. Period.

---

## Suggested Build Order

Based on dependency analysis, the implementation should proceed in this order:

### Phase 1: Round-Trip Foundation (no agent changes yet)

**Goal:** Prove that we can load any .maxpat and write it back unchanged.

**Components:**
1. Enhance `Patcher.from_dict()` -- fix bpatcher attr reconstruction, verify key preservation
2. Ensure `to_dict()` output matches input key order
3. Write round-trip fidelity tests for all existing project .maxpat files
4. Fix any round-trip failures (these are bugs in `from_dict()` or `to_dict()`)

**Dependencies:** None. This is the foundation everything else builds on.

**Tests:** Round-trip every existing .maxpat (kicksynth, minitaur, scala-synth, etc.). JSON deep equality after load-save cycle.

### Phase 2: Read Path + Search Methods

**Goal:** Agents can load a patch and find things in it.

**Components:**
1. `read_patch()` convenience function in hooks.py
2. `find_box()`, `find_boxes()`, `find_connections_from()`, `find_connections_to()` on Patcher
3. Optional DB enrichment during load (attach metadata to boxes)

**Dependencies:** Phase 1 (from_dict must work correctly).

**Tests:** Load a complex patch (kicksynth), find specific objects by name/id/text, verify connection queries return correct results.

### Phase 3: Edit Methods

**Goal:** Agents can modify a loaded patch surgically.

**Components:**
1. `remove_box()` with cascade connection removal
2. `disconnect()` and `rewire()`
3. `replace_box()` with position/connection preservation
4. `move_box()` and `set_attr()`
5. `auto_position_near()` for smart placement
6. `write_patch_direct()` in hooks.py

**Dependencies:** Phase 2 (search methods needed by edit methods, e.g., `find_connections_from` for cascade removal).

**Tests:** Load patch, remove a box, verify connections removed. Replace box, verify position preserved. Add box near reference, verify no overlaps.

### Phase 4: PatchAnalyzer

**Goal:** `/max-onboard` can understand any patch.

**Components:**
1. `analyzer.py` with inventory, signal chain tracing, parameter identification
2. `classify_purpose()` heuristic
3. Health check (delegates to existing validation)

**Dependencies:** Phase 2 (needs search methods for chain tracing).

**Tests:** Analyze kicksynth -- verify it identifies gen~ as the core, finds all parameters, traces signal chain from click~ through gen~ to dac~.

### Phase 5: Command Rewrites

**Goal:** `/max-build`, `/max-iterate`, `/max-new` use the new read-write workflow.

**Components:**
1. Rewrite `max-build.md` -- agents call Patcher methods directly
2. Rewrite `max-iterate.md` -- load-edit-save cycle
3. Rewrite `max-new.md` -- create empty .maxpat or project-dir-only
4. New `max-onboard.md` command
5. Update agent skill files (the instructions that guide specialist agents)

**Dependencies:** Phases 1-4 (all infrastructure must work before commands use it).

**Tests:** Integration tests that simulate the command workflow: create project, build patch, iterate on patch, verify output is valid.

### Phase 6: Cleanup

**Goal:** Remove v1.x generation artifacts.

**Components:**
1. Delete `generate.py` / `build_*.py` from all projects
2. Delete `.manifest.json` sidecar files
3. Remove `incremental.py` module
4. Remove `Manifest` and `merge_and_write` from public API
5. Update tests that depend on removed code

**Dependencies:** Phase 5 (commands must work without generate.py before we remove it).

**Tests:** Full test suite passes after removal. All existing .maxpat files are still valid and loadable.

---

## Scalability Considerations

| Concern | Small Patch (20 boxes) | Medium Patch (200 boxes) | Large Patch (1000+ boxes) |
|---------|----------------------|-------------------------|--------------------------|
| Load time | <10ms (JSON parse) | <50ms | <200ms |
| Memory | ~50KB (Patcher + Box objects) | ~500KB | ~2MB |
| Analysis | Instant | <100ms graph traversal | <500ms |
| Validation | <10ms | <50ms | <200ms |
| Save time | <10ms (JSON serialize) | <50ms | <200ms |

None of these are concerning. The largest existing patch (minitaur at 498KB JSON) loads in well under 100ms. Python's json module handles this scale trivially.

The real scalability question is **agent context window**: a 1000-box patch serialized to Python method calls is enormous. Agents should operate via the analyzer's summaries, not by reading the entire .maxpat as context. The analyzer exists to give agents a compact understanding of the patch without needing to see every box.

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Round-trip fidelity failures | HIGH (first attempt) | HIGH (foundation breaks) | Phase 1 is entirely about this; fix before proceeding |
| Key ordering in JSON output | MEDIUM | MEDIUM (cosmetic diffs confuse git) | Use OrderedDict or sorted keys matching MAX's order |
| Agent prompt changes needed | HIGH | LOW (prompt engineering, not code) | Update skill files incrementally during Phase 5 |
| Test suite disruption | MEDIUM | MEDIUM | Phase 6 cleanup is explicit; don't remove until commands work |
| Unknown .maxpat edge cases | HIGH | LOW per case | Defensive loading (Pattern 2); log warnings, never crash |
| Performance on large patches | LOW | LOW | Python JSON handling is adequate up to 10MB+ files |

---

## Sources

- Direct codebase analysis: `src/maxpat/patcher.py` (1134 lines, from_dict at L1012)
- Direct codebase analysis: `src/maxpat/hooks.py` (269 lines, write_patch/validate_file)
- Direct codebase analysis: `src/maxpat/incremental.py` (476 lines, merge_and_write)
- Direct codebase analysis: `src/maxpat/validation.py` (669 lines, 4-layer pipeline)
- Direct codebase analysis: `src/maxpat/layout.py` (970 lines, apply_layout)
- Direct codebase analysis: `.claude/commands/max-*.md` (10 command files)
- Direct codebase analysis: `patches/kicksynth/generated/build_kicksynth.py` (553 lines, typical generate.py)
- Confidence: HIGH -- all findings based on reading the actual code, no external sources needed
