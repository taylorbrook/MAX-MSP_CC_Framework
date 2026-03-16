---
phase: quick-12
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/incremental.py
  - tests/test_incremental.py
autonomous: true
must_haves:
  truths:
    - "User-modified positions on generator-owned boxes survive regeneration"
    - "Subpatcher inner content (user edits) survives regeneration"
    - "Layout does not recompute positions for existing boxes on merge runs"
    - "Generator structural changes (text, connections, I/O) still propagate"
  artifacts:
    - path: "src/maxpat/incremental.py"
      provides: "Attribute-level merge for generator boxes, recursive subpatcher merge, conditional layout"
    - path: "tests/test_incremental.py"
      provides: "Tests for all three bug fixes"
  key_links:
    - from: "merge_and_write()"
      to: "_merge_box_attrs()"
      via: "attribute-level merge instead of wholesale replacement"
      pattern: "_merge_box_attrs"
    - from: "merge_and_write()"
      to: "apply_layout()"
      via: "conditional: only on fresh write, not merge"
      pattern: "existing_data is None.*apply_layout"
---

<objective>
Fix three critical bugs in the incremental patching system that cause generate.py to overwrite user modifications made in the MAX GUI.

Purpose: Running generate.py currently destroys user work -- moved objects snap back, subpatcher edits vanish, and manual parameter tweaks are lost. This makes the incremental patching system unreliable for iterative development.

Output: Updated `src/maxpat/incremental.py` with attribute-level merge, recursive subpatcher preservation, and conditional layout. Updated tests proving all three fixes.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/incremental.py
@src/maxpat/patcher.py
@src/maxpat/layout.py
@tests/test_incremental.py

<interfaces>
<!-- Key types and contracts the executor needs -->

From src/maxpat/incremental.py:
```python
class Manifest:
    box_ids: list[str]
    connections: list[tuple]
    @classmethod
    def from_patcher(cls, patcher: "Patcher") -> Manifest  # Only tracks top-level box IDs
    def save(self, path: Path) -> None
    @classmethod
    def load(cls, path: Path) -> Manifest

def merge_and_write(patcher, path, validate=True, layout_options=None) -> list[ValidationResult]
```

From src/maxpat/patcher.py Box.to_dict():
```python
# Generator-owned (structural) keys:
#   maxclass, id, numinlets, numoutlets, outlettype, text, fontname, fontsize
# User-owned (presentation) keys:
#   patching_rect, presentation, presentation_rect, extra_attrs (visual)
# Subpatcher content:
#   box._inner_patcher -> serialized via _inner_patcher.to_dict()["patcher"] into box_dict["patcher"]
```

Box serialization produces:
```python
{"box": {"maxclass": "...", "id": "...", "patching_rect": [...], "patcher": {...}, ...}}
```

Existing .maxpat on-disk box format is identical dict structure under "patcher" > "boxes" array.
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add attribute-level merge and skip layout on merge runs</name>
  <files>src/maxpat/incremental.py, tests/test_incremental.py</files>
  <behavior>
    - Test: User moves a generator-owned box (changes patching_rect) -> regenerate -> user's patching_rect preserved, generator's text/maxclass updated
    - Test: User changes extra_attrs on generator box (e.g., bgcolor) -> regenerate -> user's extra_attrs preserved
    - Test: Generator changes object text (e.g., "cycle~ 440" to "cycle~ 880") -> regenerate -> text updated but position preserved
    - Test: Merge run does NOT call apply_layout (positions from existing file preserved)
    - Test: Fresh write (no existing file) DOES call apply_layout (first-time layout still works)
    - Test: Subpatcher inner content from existing file preserved when generator re-emits the same parent box
    - Test: User adds objects inside a subpatcher -> regenerate -> user's inner objects survive
  </behavior>
  <action>
**Bug 1 fix -- Attribute-level merge for generator boxes (lines 159-169 of incremental.py):**

Instead of replacing generator-owned boxes wholesale with `box.to_dict()`, merge attributes per the ownership model:
- Generator owns: `text`, `maxclass`, `numinlets`, `numoutlets`, `outlettype`, `fontname`, `fontsize`
- User owns: `patching_rect`, `presentation`, `presentation_rect`, and any extra visual attrs not in the generator-owned set

Add a helper function `_merge_box_attrs(existing_box_dict: dict, generator_box_dict: dict) -> dict` that:
1. Starts with a copy of the existing box dict (preserves user attrs)
2. Overwrites only generator-owned structural keys from the generator dict
3. For `extra_attrs` / unknown keys: if the key exists in the generator dict AND does not exist in the existing dict, add it. If it exists in both, keep the existing value (user wins). EXCEPTION: keys that are structural (`code` for gen~ codeboxes, `args` for bpatchers) should come from generator.
4. Returns the merged dict

In `merge_and_write()`, change the generator_boxes construction (around line 169) from:
```python
generator_boxes = [box.to_dict() for box in patcher.boxes]
```
to: serialize each generator box with `to_dict()`, then for each one whose ID is in `old_manifest_ids` AND also present in `existing_boxes`, call `_merge_box_attrs()` to merge user presentation attrs from the existing on-disk version.

Build a lookup dict from existing boxes: `existing_box_map = {b["box"]["id"]: b for b in existing_boxes}`. For each generator box, if its ID is in `existing_box_map`, merge. Otherwise use the generator version as-is (new box).

**Bug 2 fix -- Recursive subpatcher content preservation:**

In `_merge_box_attrs()`, handle the `patcher` key (inner patcher content) specially:
- If the existing box has a `"patcher"` key and the generator box has a `"patcher"` key, recursively merge the inner patcher content using a new `_merge_inner_patcher(existing_inner: dict, generator_inner: dict, manifest_box_ids: set | None) -> dict` function.
- `_merge_inner_patcher` applies the same box merge logic to the inner boxes: keep user-added inner boxes, update generator-owned inner boxes with attribute merge, remove stale generator inner boxes.
- For inner patcher tracking: since `Manifest.from_patcher()` only tracks top-level IDs, the inner merge should use the generator's inner box IDs as the "known set" and treat everything else as user-added. This means: collect all box IDs from the generator's inner patcher dict, use those as the manifest for the inner level.
- This is naturally recursive for nested subpatchers.

**Bug 3 fix -- Skip layout on merge runs (line 161-167):**

Move the `apply_layout()` call so it ONLY runs on fresh writes (when `existing_data is None`). The fresh write path already calls `write_patch` which includes layout. For the merge path, do NOT call `apply_layout()` on the patcher -- the existing file already has positions, and the merge preserves them.

However, still call `apply_layout()` for boxes that are NEW (not in old_manifest_ids and not in existing_box_map) since they have no existing positions. Do this by:
- After building merged_boxes, identify which generator boxes are genuinely new (ID not in `existing_box_map`)
- If there are new boxes, they already have default positions from the generator (0,0 or whatever the Patcher assigned). These positions are acceptable since the user hasn't placed them yet. The layout engine's positions would be better but would require running layout on just those boxes which is complex. Accept generator default positions for new boxes. The user will move them in MAX if needed.

So the simplest correct fix: remove `apply_layout(patcher, layout_options)` from the merge path entirely. Keep `_apply_auto_styling` since it only affects colors (non-positional).

Also remove the midpoints from generator patchlines during merge -- they would be stale since positions are preserved from the existing file. Clear `line.midpoints = None` on generator Patchline objects before serialization in the merge path (or just let the existing file's midpoints for user lines persist as-is, and don't add generator midpoints since they'd be computed from wrong positions).

**Write tests FIRST (RED), then implement (GREEN).**

Add these test classes to `tests/test_incremental.py`:

1. `TestMergePreservesUserPositions` -- modify patching_rect on a generator box in the .maxpat, regenerate, verify the user's position is kept but text is updated.

2. `TestMergePreservesSubpatcherContent` -- create a patcher with a subpatcher, write it, add a user object inside the subpatcher in the .maxpat JSON, regenerate, verify the user's inner object survives.

3. `TestMergeLayoutSkippedOnMerge` -- verify that box positions from the existing file are preserved (not recomputed) on merge runs. Can check by setting a known position, regenerating, and confirming it hasn't changed.

4. `TestMergeFreshWriteStillLayouts` -- verify fresh write still produces laid-out positions (not all 0,0).
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/test_incremental.py -x -v 2>&1 | tail -40</automated>
  </verify>
  <done>
    - All existing 18 tests still pass (no regressions)
    - New tests for position preservation pass: user's patching_rect survives regeneration
    - New tests for subpatcher preservation pass: user objects inside subpatchers survive
    - New tests for layout skip pass: merge runs don't recompute positions
    - Fresh writes still get proper layout
    - Generator structural changes (text, connections) still propagate correctly
  </done>
</task>

<task type="auto">
  <name>Task 2: Validate with real patch regeneration</name>
  <files>patches/performancepatchtest/generate.py</files>
  <action>
Run the performancepatchtest generate.py script twice to confirm idempotency with the real patch:

1. First, capture the current state of `patches/performancepatchtest/generated/performancepatchtest.maxpat` (save a copy or checksum).
2. Run `python3 patches/performancepatchtest/generate.py` -- this exercises the real merge path.
3. Run it again -- output should be identical (idempotent).
4. Verify no errors or exceptions.

If the generate.py script doesn't use `merge_and_write()` yet (check first), update it to use `merge_and_write` instead of `write_patch` if it doesn't already.

Do NOT modify the .maxpat file structure -- just verify the merge works correctly with a real patch.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 patches/performancepatchtest/generate.py 2>&1 && echo "SUCCESS: generate.py completed without error"</automated>
  </verify>
  <done>
    - performancepatchtest/generate.py runs without errors
    - Running generate.py twice produces identical output (idempotent merge)
    - No regression in generated .maxpat structure
  </done>
</task>

</tasks>

<verification>
1. All tests pass: `python3 -m pytest tests/test_incremental.py -x -v`
2. Existing 18 tests show no regressions
3. New tests cover all three bug fixes
4. Real patch generation works: `python3 patches/performancepatchtest/generate.py`
</verification>

<success_criteria>
- Generator-owned boxes preserve user's patching_rect, presentation_rect, and visual attrs on regeneration
- Subpatcher inner content from existing .maxpat is preserved (user-added inner objects survive)
- Layout engine only runs on fresh writes, not merge runs
- Generator structural changes (text, connections, I/O counts) still propagate to the .maxpat
- All tests pass, real patch generation succeeds
</success_criteria>

<output>
After completion, create `.planning/quick/12-fix-python-generation-script-overwriting/12-SUMMARY.md`
</output>
