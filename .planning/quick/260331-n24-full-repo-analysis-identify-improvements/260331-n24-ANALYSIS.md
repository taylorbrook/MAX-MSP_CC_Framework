# MAX Framework Deep Analysis -- March 31, 2026

## Executive Summary

Nine days after the initial review (260322-bbh), the framework has improved substantially. 10 of 12 action items were implemented. This follow-up analysis goes deeper -- examining actual patch output quality, not just architecture. Key findings:

1. **Round-trip bug: `Box.to_dict()` injects spurious `text: ""` on UI boxes.** This causes 8 of 13 round-trip test failures. The `from_dict()` path defaults `text` to `""` for boxes without a `text` key (panels, toggles, dials), then the round-trip serializer writes it back because `"" is not None`. A one-line fix in `from_dict()` (use `box_data.get("text")` instead of `box_data.get("text", "")`) would resolve 8 failures instantly.

2. **MSP override coverage is still low.** Only ~170 of 248 MSP objects are verified. Common objects like `*~`, `saw~`, `noise~`, `sig~`, `gen~`, `selector~`, `receive~`, `send~` are all unverified. Every patch generates "unverified outlet types" warnings. The previous review's #2 action item (bulk-correct MSP outlets) was only partially addressed.

3. **Fan-out without trigger is rampant in generated patches.** kicksynth: 8 instances, stutter: 8, gen-eq: 14, scala-synth: 16. The structure_critic catches these but they are only warnings. The agents are not consistently following CLAUDE.md Rule #3/#4 about trigger usage. This is the most common structural quality issue.

4. **All 4+ sampled patches pass connection validation** -- zero out-of-bounds indices, zero PD objects, zero missing boxes. The connection-level correctness is solid.

5. **Validation pipeline now covers 11 of 13 original feedback issues** (up from 3). The 8 checks added in 260322-dz9 are functioning correctly. Two uncovered gaps remain: maxclass "newobj" confusion (Category A -- database issue, not validation) and the MSP outlet type systematic error.

6. **New feature test coverage is good.** z-order API (20 references), finalize_patch (18), version tracking (54), gen~ patterns (72). All 33 public Patcher methods have test coverage. 32 of 33 have full type annotations.

7. **SKILL.md agent instructions are accurate and current.** The shared-capabilities.md extraction (260322-fee) works correctly. Context budget section (260322-fyt) is in the router. No stale references to deprecated patterns found.

8. **One significant code quality issue: `patcher.py` is 2827 lines.** While organized into clear sections, it combines data model (Box, Patchline), patch construction, graph traversal, and analysis into a single file. The `analyze()` family alone is ~350 lines that could be a separate module.

9. **Older patches lack version comments and newer aesthetic features.** kicksynth, stutter, wormhole have no version comment. Only scala-synth, gen-eq, and rhythmic-sampler have them (added in 260322-hmn).

10. **The gen-eq patch uses external .gendsp files** (gen-eq-engine.gendsp via `gen~ @gen` attribute), not inline codebox. This means gen~ I/O validation cannot check the code unless the .gendsp is loaded separately.

---

## Delta from Previous Review (260322-bbh)

| # | Previous Action Item | Status | Evidence |
|---|---------------------|--------|----------|
| 1 | Add 8 targeted validation checks for Category B issues | DONE | All 8 checks implemented in `validation.py` lines 499-976. GenExpr I/O, delay(), @param, comment #N, line~ comma, fetchindex, umenu items, assistance comments |
| 2 | Bulk-correct MSP outlet types (232 remaining) | PARTIAL | `is_overridden()` returns True for ~170 objects (via multiple sources), but 28+ common MSP objects remain unverified (saw~, *~, noise~, gen~, selector~, etc.) |
| 3 | Add safeguard: don't auto-remove connections for uncorrected MSP objects | DONE | `validation.py` lines 335-344: emits warning and preserves connection for non-overridden MSP objects |
| 4 | Retire in-app memory system | DONE | 260322-eva removed max-memory-agent. `memory.py` module still exists but is not referenced by any SKILL.md or command |
| 5 | Extract shared SKILL.md blocks into shared-capabilities.md | DONE | `references/shared-capabilities.md` (99 lines) covers assistance comments, finalize_patch, z-order, aesthetics, layout, editing, version comment |
| 6 | Add cross-domain lookup guidance | DONE | CLAUDE.md and SKILL.md files updated (260322-fpd) to recommend `ObjectDatabase` as primary method |
| 7 | Add line~ and MC variants to gain staging critic | DONE | `dsp_critic.py` lines 355-531: line~ trace-through, MC variants in `_GAIN_NAMES`, `_parse_line_tilde_targets()` for message value checking |
| 8 | Add context budget note to router | DONE | `max-router/SKILL.md` lines 57-88: full context budget section with loading tiers, per-agent section map, example |
| 9 | Fix layout inlet alignment test | DONE | 260322-hcn: tolerance increased or algorithm adjusted (test passes) |
| 10 | Fix round-trip em-dash test | NOT DONE | minitaur round-trip still fails (3 of 13 failures are byte-identity tests on externally-modified patches) |
| 11 | Add soft limit to critic loop | DONE | 260322-hhw: 3-round soft limit with user approval to continue |
| 12 | Document --full requires interactive mode | DONE | 260322-hk7: interactive mode note added to max-iterate flags |

**Score: 10 of 12 implemented.** Items #2 (partial) and #10 (not done) remain.

**New features since 260322-bbh:**
- Z-order manipulation API (260331-eqh): `bring_to_front()`, `send_to_back()`, `set_z_index()`
- Finalize_patch hook (260322-pkm): single-call layout cleanup
- Version tracking (260322-hmn): `update_version_comment()`, versions.json
- Gen~ pattern library (260322-n59): 19 .gendsp files across 7 categories
- File caching fix (260322-pxv): os.fsync on all write paths
- Gain staging extensions (260322-g3q): expr/vexpr conservative check, line~ tracing, MC variants

---

## Dimension 1: Patch Correctness

### Patches Examined

| Patch | Boxes | Lines | Connection Issues | PD Objects | OOB Indices |
|-------|-------|-------|-------------------|------------|-------------|
| kicksynth | 146 | 126 | 0 | 0 | 0 |
| stutter | 79 | 68 | 0 | 0 | 0 |
| wormhole | 96 | 71 | 0 | 0 | 0 |
| scala-synth | 141 | 132 | 0 | 0 | 0 |
| gen-eq | 107 | 81 | 0 | 0 | 0 |

**Connection validation: perfect.** All 5 patches pass with zero out-of-bounds connections, zero missing box references, and zero PD object hallucinations. This is the framework's strongest area.

### Validation Pipeline Results

| Patch | Errors | Warnings | Info |
|-------|--------|----------|------|
| kicksynth | 0 | 5 | 0 |
| stutter | 0 | 10 | 0 |
| wormhole | 0 | 20 | 0 |
| scala-synth | 0 | 6 | 0 |
| gen-eq | 0 | 1 | 0 |

All warnings are "unverified outlet types" for non-overridden MSP objects. Zero semantic errors detected. This is both a strength (no bugs) and a potential blind spot (the validator may not be catching everything).

### Fan-out Without Trigger (Structure Critic)

| Patch | Trigger Objects | Fan-out Without Trigger |
|-------|----------------|------------------------|
| kicksynth | 1 | 8 |
| stutter | 1 | 8 |
| wormhole | 0 | 0 |
| scala-synth | 4 | 16 |
| gen-eq | 0 | 14 |
| rhythmic-sampler | 1 | 2 |

This is the most common structural quality issue. The agents generate patches with control-rate fan-out from non-trigger objects, creating undefined execution order. The wormhole patch is the only one with zero instances (all connections are signal-rate).

### Gen~ Codebox Analysis

The gen-eq patch uses `gen~ @gen gen-eq-engine.gendsp` (external file reference), not an inline codebox. This means the DSP critic's GenExpr I/O validation (`_check_gen_io_match`) cannot check the code at validation time -- it only inspects embedded `codebox` objects inside `gen~.patcher`. External .gendsp files referenced via `@gen` are invisible to the validator.

### Bpatcher Argument Usage

Checked `rhythmic-sampler/slot.maxpat`: uses `flonum` readouts with `ignoreclick=1` overlay pattern (z-order aware), proper `presentation_rect` positioning. No compound `#N` substitution violations found.

---

## Dimension 2: Patch Aesthetics

### Visual Quality Assessment

| Aspect | kicksynth | stutter | wormhole | scala-synth | gen-eq |
|--------|-----------|---------|----------|-------------|--------|
| Negative coords | 0 | 0 | 0 | 0 | 0 |
| Object overlaps | 3 | 0 | 4 | 8 | N/A |
| Presentation mode | Yes | Yes | Yes (48 objects) | Yes | Yes |
| Panels | 10 | 0 | 6 | 1 | 1 |
| Comments | 12+ | 0 | 24 | 5 | 2 |
| Version comment | No | No | No | Yes (v2.2.0) | Yes (v2.0.0) |

**Observations:**
- Object overlaps exist in kicksynth (3), wormhole (4), and scala-synth (8). These are mostly in patching mode where the auto-layout positions objects in tight rows. The layout critic would catch these if run.
- Stutter has zero decorative elements (no panels, no comments) -- it's the most bare patch.
- Wormhole is the most polished: dark theme, orange accent title, 6 panel sections, 24 comments, full presentation mode with labeled panels.
- kicksynth has the most complex presentation layout (10 panels, gradient styling) with professional-looking UI sections.
- Older patches (kicksynth, stutter, wormhole) lack version comments because they were generated before 260322-hmn.

### Spacing Consistency

All patches use the default 20px vertical spacing from `defaults.py`. No instances of the old 80-120px spacing from training data. The documentation fix (260317-g0a) and defaults enforcement are working.

---

## Dimension 3: Validation Coverage

### Layer-by-Layer Coverage

| Layer | Checks | Status |
|-------|--------|--------|
| Layer 1 (JSON) | patcher key, boxes array, lines array | Working -- catches structural malformation |
| Layer 2 (Objects) | DB existence, PD blocklist, alias resolution | Working -- downgrades unknown to warning (260322-dz9) |
| Layer 3 (Connections) | Index bounds, signal type compat, MSP safeguard | Working -- MSP safeguard preserves unverified connections |
| Layer 4 (Domain) | 13 domain-specific checks | Working -- all 8 new checks from 260322-dz9 functional |

### Detailed Layer 4 Check Catalog

1. Compound #N argument substitution (bpatcher args)
2. Unterminated signal chains (MSP objects with no downstream)
3. Gain staging (oscillator -> dac~ without *~/gain~)
4. Unsafe gain values (*~ with arg > 1.0)
5. Feedback loop detection (cycles without delay objects)
6. GenExpr I/O syntax (`in 1` vs `in1` in codebox)
7. GenExpr delay() usage (should be Delay.read()/write())
8. gen~ @param message syntax (should be plain name)
9. Comment #N substitution (comment boxes don't support #N)
10. line~ comma messages (commas restart ramps)
11. multislider fetchindex (doesn't exist, use fetch)
12. umenu items format (needs comma separators)
13. Assistance comments (inlet/outlet tooltip coverage)

### What Still Slips Through

1. **External .gendsp file validation.** gen~ boxes using `@gen filename.gendsp` reference external files that are not loaded or checked by the validator. I/O mismatch between the .gendsp and the gen~ box would not be caught.

2. **Fan-out without trigger.** The structure_critic catches this but it's only a warning, not an error. Given how prevalent it is (8-16 instances per patch), the agents are not treating it as a hard requirement.

3. **Maxclass confusion residual.** The previous review noted ~667 objects had wrong maxclass (should be "newobj"). While the feedback corrected the agents, there's no validation check that verifies `maxclass` is correct for each object type. An agent could still generate a `"maxclass": "cycle~"` instead of `"maxclass": "newobj"` with `"text": "cycle~"`.

4. **mc. domain gain staging.** The DSP critic added MC variants to `_GAIN_NAMES` but the oscillator check (`_OSCILLATOR_NAMES`) doesn't include MC oscillator variants like `mc.cycle~`, `mc.saw~`, etc.

---

## Dimension 4: Agent Effectiveness

### SKILL.md Size and Structure

| Agent | Lines | Shared-cap Reference | Stale References |
|-------|-------|---------------------|-----------------|
| max-patch-agent | 116 | Yes | None found |
| max-dsp-agent | 141 | Yes | None found |
| max-ui-agent | 120 | Yes | None found |
| max-js-agent | 103 | Yes | None found |
| max-ext-agent | 108 | Yes | None found |
| max-rnbo-agent | 102 | Yes | None found |
| max-critic | 74 | N/A (different role) | None found |
| max-lifecycle | 86 | N/A | None found |
| max-router | 119 | N/A | None found |

**Total SKILL.md: 969 lines** across 9 agents. The shared-capabilities.md extraction (260322-fee) successfully reduced duplication. Each SKILL.md now contains domain-specific content with a reference to the shared file.

### Agent Instruction Accuracy

Checked all SKILL.md files against current API:
- `finalize_patch(patcher, is_new=True)` -- correctly documented in shared-capabilities.md
- `ObjectDatabase` from `src.maxpat.db_lookup` -- correctly referenced as primary lookup method
- `write_gendsp()` import from `src.maxpat.hooks` (not `src.maxpat.patcher`) -- correctly noted in DSP agent
- Z-order methods -- documented in shared-capabilities.md
- Version comment -- `update_version_comment()` documented in shared-capabilities.md

No stale references to deprecated patterns (old `write_patch()`, old command format `/max:`) found. The cleanup from 260317-g0a was thorough.

### Context Budget Effectiveness

The router's context budget section targets ~250 lines for 3+ agent dispatch. Current per-agent sizes:
- Full load: 86-141 lines per agent
- Domain-specific only (DCL + Capabilities): ~40-65 lines per agent

For a typical "MIDI synth with controls" (DSP lead + Patch + UI):
- Full DSP: ~141 lines
- Patch DCL+Cap: ~59 lines
- UI DCL+Cap: ~62 lines
- Total: ~262 lines (slightly over 250 target)

The budget is reasonable but the 250-line target is tight for 3-agent dispatch.

---

## Dimension 5: Round-Trip Fidelity (13 Failures)

### Failure Categorization

| Category | Count | Root Cause |
|----------|-------|-----------|
| Spurious `text: ""` on UI boxes | 8 | `from_dict()` defaults text to `""` for boxes without text key |
| Byte-identity on externally modified patches | 3 | Patches edited by user/MAX after generation; dict structure changed |
| Byte-identity encoding differences | 2 | MAX JSON serializer uses different Unicode encoding than Python |

### Root Cause: Spurious `text: ""`

**File:** `src/maxpat/patcher.py` line 1950
**Code:** `box.text = box_data.get("text", "")`
**Issue:** Panel, toggle, dial, and other UI boxes that never had a `text` field in their JSON get `text = ""` assigned. In `to_dict()` (line 352), the check `if self.text is not None` passes because `"" is not None`, so `text: ""` gets written to the output dict.

**Fix:** Change line 1950 to `box.text = box_data.get("text")` (defaults to None). This preserves the original absence of the text field during round-trip.

**Impact:** Would fix 8 of 13 failures (61% reduction).

### Externally Modified Patches (3 failures)

These are patches that were hand-edited in MAX after framework generation:
- minitaur: em-dash encoding difference + external edits
- performancepatchtest: structure modified externally (deleted and recreated)
- scala-synth: iteratively modified via /max-iterate

These failures are expected and should be xfailed or removed from the byte-identity test suite. The dict-identity test (`TestRoundTripIdentity`) is the correct test for framework-generated patches.

### Byte-Identity Encoding (2 failures)

`test_max_saved_file_byte_identical` and `test_framework_file_byte_identical` compare raw file bytes. Differences arise from:
- JSON indentation detection (`detect_indent()`) may not perfectly match the original
- Unicode handling in `json.dumps(ensure_ascii=False)` differs from MAX's serializer

These are inherent limitations of byte-identical round-tripping with a third-party JSON serializer.

---

## Dimension 6: Test Coverage Gaps

### Test Suite Overview

| Test File | Tests | Coverage Area |
|-----------|-------|---------------|
| test_patcher.py | 169 | Core data model, construction, connections |
| test_validation.py | 64 | 4-layer validation pipeline |
| test_aesthetics.py | 59 | Styling, auto-sizing, palette |
| test_codegen.py | 55 | GenExpr code generation |
| test_critics.py | 56 | DSP, structure, layout, RNBO, ext critics |
| test_agent_skills.py | 52 | SKILL.md file validation |
| test_analysis.py | 53 | Patcher.analyze() output |
| test_project.py | 50 | Project lifecycle |
| test_round_trip.py | 42 | from_dict/to_dict fidelity |
| test_layout.py | 40 | Auto-layout positioning |
| test_hooks.py | 24 | File I/O, finalize_patch |
| Others | 571 | Various (sizing, externals, etc.) |
| **Total** | **1235** | |

**All 33 public Patcher methods have test coverage.** 32 of 33 have full type annotations.

### Coverage Gaps Identified

1. **No integration test for validation on actual patches.** The validation tests use synthetic fixtures. There's no test that runs `validate_patch()` on the real generated patches in `patches/` and asserts zero errors. Adding this would catch regressions where agent changes introduce invalid patterns.

2. **Critics test edge cases but not on real patches.** `test_critics.py` uses synthetic patch dicts. No test feeds a real kicksynth.maxpat through `review_dsp()` or `review_structure()` to verify the critics function on production data.

3. **`finalize_patch()` has limited edge case coverage.** 18 test references but no test verifying behavior on a patch with subpatchers (recursive finalization) or on an empty patch.

4. **External .gendsp validation is untested.** No test checks whether the validator handles gen~ boxes that reference external .gendsp files via `@gen`. The current behavior is silent pass-through.

5. **New z-order API has 20 test references** but no test for the interaction between `add_panel()` (auto-inserts at index 0) and `bring_to_front()`. Edge case: what happens if you `bring_to_front(panel_box)` on a box that `add_panel()` already placed at index 0?

---

## Dimension 7: Documentation Accuracy

### CLAUDE.md vs Actual API

| Rule/Section | Documented | Actual | Match? |
|-------------|-----------|--------|--------|
| Rule #1: Never Guess Objects | `ObjectDatabase.lookup()` | `ObjectDatabase.lookup()` | Yes |
| Rule #2: Verify Before Connect | Index bounds check | `validation.py` Layer 3 | Yes |
| Rule #3: Hot/Cold Ordering | trigger usage | `structure_critic.py` warns | Yes |
| Rule #4: Patch Style | 20px spacing | `defaults.py V_SPACING=20` | Yes |
| Rule #5: No Generator Scripts | No generate.py | Enforced (deprecated milestone 2.0) | Yes |
| Rule #6: Z-Order Awareness | `bring_to_front()`, `send_to_back()`, `set_z_index()` | Implemented in patcher.py | Yes |
| Bpatcher #N rule | Standalone tokens only | Validated in Layer 4 | Yes |
| Variable I/O | `compute_io_counts()` | Implemented in `db_lookup.py` | Yes |
| GenExpr I/O syntax | `in1`/`out1` in codebox | Validated in Layer 4 | Yes |
| Gen~ Delay syntax | `Delay.read()`/`.write()` | Validated in Layer 4 | Yes |
| Gen~ param messages | Plain name, not @name | Validated in Layer 4 | Yes |

**Documentation accuracy is excellent.** All rules documented in CLAUDE.md match the actual implementation. The memory feedback entries are consistent with the codebase.

### SKILL.md Accuracy

All 9 SKILL.md files reference correct API methods and import paths. The `shared-capabilities.md` file is up-to-date with all recent additions (z-order, finalize_patch, version comment).

One minor issue: `max-dsp-agent/SKILL.md` line 31 references `build_genexpr()` but this function is in `src.maxpat.codegen`, not re-exported from `src.maxpat`. The import path should be explicit.

---

## Dimension 8: Code Quality

### Module Size Analysis

| Module | Lines | Concern |
|--------|-------|---------|
| patcher.py | 2827 | Large -- combines model, construction, traversal, analysis |
| validation.py | 976 | Good -- single responsibility (validation pipeline) |
| layout.py | 969 | Good -- single responsibility (layout engine) |
| externals.py | 564 | OK |
| hooks.py | 345 | OK |
| codegen.py | 339 | OK |
| project.py | 454 | OK |
| All others | <350 each | Good |

### patcher.py Decomposition Opportunity

The 2827-line `patcher.py` contains four logical sections:

1. **Data model** (lines 1-440): Box, Patchline classes + serialization (~440 lines)
2. **Patcher construction** (lines 440-1900): Box management, connections, subpatchers (~1460 lines)
3. **Graph traversal** (lines 2065-2390): downstream, upstream, signal_path, connected_components (~325 lines)
4. **Analysis** (lines 2390-2827): analyze(), sections, complexity, signal chains (~437 lines)

Sections 3 and 4 (~762 lines combined) could be extracted to a `graph.py` and `analysis.py` module without breaking any API, since `downstream()`, `upstream()`, etc. are methods that only read `self.boxes` and `self.lines`. This would bring patcher.py to ~2065 lines.

### Duplication Across Modules

The `_get_box_name()` helper appears in 4 places:
- `validation.py` line 524
- `dsp_critic.py` line 170
- `structure_critic.py` line 65
- `layout_critic.py` line 126

All 4 implementations are identical. This should be a single shared utility.

### Error Handling

Error handling is consistent:
- `ValueError` for invalid inputs (Box constructor, find operations)
- `TypeError` for type mismatches in from_dict
- `PatchGenerationError` / `PatchValidationError` in hooks.py
- Validation results use levels (error/warning/info/fixed) not exceptions

No instances of swallowed errors found. All exceptions propagate with descriptive messages.

### Circular Import Prevention

Clean import structure using `TYPE_CHECKING` pattern:
- `validation.py` imports Patcher under TYPE_CHECKING
- `hooks.py` imports Patcher under TYPE_CHECKING
- `aesthetics.py` imports Box, Patcher under TYPE_CHECKING
- `project.py` imports Patcher, Box under TYPE_CHECKING

No circular import risks found.

---

## Dimension 9: User Workflow

### /max-build Flow (New Patch)

Steps: 1. Create project (lifecycle) -> 2. Discuss requirements -> 3. Router dispatch -> 4. Agent generation -> 5. Critic review -> 6. Fix loop -> 7. Save -> 8. Version bump

**Friction points:**
- Step 2 (discuss) is optional but recommended -- agents benefit from context.md. If skipped, agent makes assumptions.
- Step 6 (fix loop) now has soft limit (3 rounds) per 260322-hhw. Previously could loop indefinitely.
- No friction in the actual generation path. `finalize_patch()` consolidates layout/styling/comments into one call.

### /max-iterate Flow (Edit Patch)

Steps: 1. Load patch -> 2. Analyze -> 3. Describe change -> 4. Router dispatch -> 5. Surgical/section edit -> 6. Critic review -> 7. Save -> 8. Version bump

**Improvements since last review:**
- Inline project switching (260318-s03): `/max-iterate rhythmic-sampler: adjust filter cutoff` auto-switches
- --full flag (260321-6mo): discuss -> research -> plan -> build pipeline
- Interactive mode note (260322-hk7): documented in flags

**Remaining friction:**
- The `analyze()` output is ~50 lines. For large patches (kicksynth: 146 boxes), this adds significant context. Consider a compact mode.
- Critic loop convergence: the structure critic warns about fan-out on every pass for patches that don't use triggers. These warnings never go away, contributing to loop noise.

### Project Management

`project.py` (454 lines) handles create, switch, status, versions. Clean API surface. The version tracking (260322-hmn) integrates smoothly -- `bump_version()` updates both `versions.json` and the in-patch comment.

---

## Dimension 10: Prioritized Recommendations

### Priority Table

| # | Recommendation | Impact | Effort | Category |
|---|---------------|--------|--------|----------|
| 1 | **Fix round-trip `text: ""` bug** -- change `box_data.get("text", "")` to `box_data.get("text")` in `from_dict()` line 1950 | HIGH | TINY | Bug fix |
| 2 | **Bulk-verify remaining MSP outlet types** -- complete the override coverage for the ~80 commonly used MSP objects (saw~, *~, noise~, sig~, gen~, etc.) | HIGH | MEDIUM | Data quality |
| 3 | **Reduce fan-out-without-trigger in generation** -- strengthen Rule #3 enforcement in agent instructions: make trigger usage a MUST for control-rate fan-out, not a SHOULD. Add examples of correct trigger usage to each agent's SKILL.md | HIGH | SMALL | Agent quality |
| 4 | **Add integration validation tests on real patches** -- parametrized test that runs `validate_patch()` + all 5 critics on each `patches/*/generated/*.maxpat` and asserts zero errors | MEDIUM | SMALL | Test quality |
| 5 | **Extract `_get_box_name()` to shared utility** -- deduplicate the 4 identical copies across validation.py and 3 critics into `src/maxpat/utils.py` | MEDIUM | TINY | Code quality |
| 6 | **Add external .gendsp validation** -- when a gen~ box has `@gen filename.gendsp`, load the .gendsp file and check I/O counts match | MEDIUM | MEDIUM | Validation |
| 7 | **Decompose patcher.py** -- extract graph traversal (~325 lines) and analysis (~437 lines) into separate modules | MEDIUM | MEDIUM | Code quality |
| 8 | **xfail or update 5 byte-identity round-trip tests** -- the 3 externally-modified patches and 2 encoding-difference tests are not framework bugs; mark as expected failures | LOW | TINY | Test hygiene |
| 9 | **Add MC oscillator variants to gain staging check** -- add mc.cycle~, mc.saw~, etc. to `_OSCILLATOR_NAMES` in validation.py and dsp_critic.py | LOW | TINY | Validation |
| 10 | **Add maxclass validation check** -- verify that non-UI objects use `maxclass: "newobj"`, not their object name as maxclass | LOW | SMALL | Validation |

### Impact/Effort Matrix

```
          TINY      SMALL      MEDIUM     LARGE
HIGH    | #1       | #3       | #2       |
MEDIUM  | #5       | #4       | #6, #7   |
LOW     | #8, #9   | #10      |          |
```

---

## Suggested Next Milestone Scope

### "Polish and Professional" Milestone (v2.1)

Focus: Close the remaining quality gaps to achieve consistently professional patch output.

**Must-have (4 items):**
1. Fix round-trip bug (#1) -- unblocks 8 test failures
2. Complete MSP outlet verification (#2) -- eliminates validation noise
3. Enforce trigger usage in generation (#3) -- biggest single quality uplift
4. Integration validation tests (#4) -- regression safety net

**Should-have (3 items):**
5. Extract shared utilities (#5) -- code hygiene
6. External .gendsp validation (#6) -- closes last validation blind spot
7. xfail byte-identity tests (#8) -- clean test suite

**Nice-to-have (3 items):**
8. Decompose patcher.py (#7)
9. MC oscillator gain staging (#9)
10. Maxclass validation (#10)

**Estimated scope:** 4 must-have items at ~2-4 hours total. The v2.1 milestone would bring the framework from "generates correct patches" to "generates correct AND structurally clean patches" -- closing the gap between mechanical correctness (which is already solid) and professional quality (trigger usage, clean warnings, comprehensive validation).
