---
phase: 260410-drl
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/patcher.py
  - tests/test_patcher.py
autonomous: true
requirements: [260410-drl]

must_haves:
  truths:
    - "add_box() nudges new objects away from pre-existing objects automatically"
    - "Nudging goes downward first, then right when vertical space exhausted"
    - "Callers can opt out with skip_overlap_check=True"
    - "insert_into_connection() and replace_box() skip the redundant overlap check"
    - "Subpatcher inlet/outlet adds skip overlap check (fixed grid positioning)"
    - "All existing auto-position tests still pass (updated for down-first nudge)"
  artifacts:
    - path: "src/maxpat/patcher.py"
      provides: "add_box() with overlap detection, _find_clear_position() with down-first nudge"
      contains: "skip_overlap_check"
    - path: "tests/test_patcher.py"
      provides: "Tests for add_box overlap detection and down-first nudge"
      contains: "test_add_box_overlap_detection"
  key_links:
    - from: "add_box()"
      to: "_find_clear_position()"
      via: "Called when skip_overlap_check is False"
      pattern: "_find_clear_position"
    - from: "insert_into_connection()"
      to: "add_box()"
      via: "skip_overlap_check=True"
      pattern: "skip_overlap_check=True"
---

<objective>
Fix overlap detection so add_box() automatically nudges new objects to avoid collisions with pre-existing objects. Refactor _find_clear_position() to nudge down-first (preserving horizontal signal flow), then right when column is full.

Purpose: During max-iterate sessions, agents add objects at coordinates that may overlap pre-existing boxes from earlier iterates or manual edits. Without collision detection in add_box(), objects stack on top of each other.

Output: Modified patcher.py with overlap-aware add_box() and down-first nudge algorithm. Tests proving the behavior.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/patcher.py
@tests/test_patcher.py

<interfaces>
From src/maxpat/patcher.py:

```python
# Line 30 -- collision pad constant
COLLISION_PAD = 5.0

# Line 393 -- current add_box signature (to be modified)
def add_box(self, name: str, args: list[str] | None = None, x: float = 0.0, y: float = 0.0) -> Box:

# Line 1098 -- current _find_clear_position (to be refactored)
def _find_clear_position(self, x: float, y: float, w: float, h: float, exclude_box: Box | None = None) -> tuple[float, float]:
    # Snaps to 15px grid, nudges RIGHT first (to become DOWN first)
    # Wraps at x > 1200 to next row (to become y > 2400 to next column)
    # Max 50 attempts (to become 200)

# Line 1014 -- replace_box calls add_box at old position
new_box = self.add_box(new_name, args=args, x=old_x, y=old_y)

# Line 1065 -- insert_into_connection calls add_box then _auto_position
new_box = self.add_box(name, args=args)
self._auto_position(new_box, near_box=source)

# Lines 1375, 1383 -- add_subpatcher creates inlet/outlet boxes on fixed grid
inlet_box = inner.add_box("inlet", x=50.0 + i * inlet_spacing, y=30.0)
outlet_box = inner.add_box("outlet", x=50.0 + i * inlet_spacing, y=250.0)
```
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Refactor _find_clear_position for down-first nudging and add overlap detection to add_box</name>
  <files>src/maxpat/patcher.py, tests/test_patcher.py</files>
  <behavior>
    - Test: add_box at position overlapping existing box nudges the new box to a clear position (y increases)
    - Test: add_box at position with no overlap returns box at exact requested position (snapped to grid)
    - Test: add_box with skip_overlap_check=True places at exact position even if overlapping
    - Test: _find_clear_position nudges DOWN first (y += 15), not right
    - Test: _find_clear_position wraps to next column (x += 15, reset y) when y > 2400
    - Test: Multiple add_box calls at same position don't stack -- each gets nudged past the previous
    - Test: Existing test_collision_nudge_right updated to expect downward nudge instead of rightward
    - Test: Existing test_collision_wrap_to_next_row updated for vertical wrap threshold (y > 2400)
  </behavior>
  <action>
**1. Refactor `_find_clear_position()` (patcher.py ~line 1098):**
- Change nudge direction from right-first to down-first: on collision, `y += 15.0` instead of `x += 15.0`
- Change wrap condition: when `y > 2400` (vertical threshold), reset `y` to the original starting y value (`start_y = y` at top), and `x += 15.0`
- Track `start_y` alongside existing `start_x`
- Increase max attempts from 50 to 200 (vertical space is deeper)
- Update docstring to reflect "nudges down" instead of "nudges right"
- Keep everything else identical (15px grid snap, COLLISION_PAD, exclude_box)

**2. Add `skip_overlap_check` parameter to `add_box()` (patcher.py ~line 393):**
- New signature: `add_box(self, name, args=None, x=0.0, y=0.0, skip_overlap_check=False)`
- When `skip_overlap_check` is False (default): after creating the Box, call `self._find_clear_position(x, y, box.patching_rect[2], box.patching_rect[3])` and update `box.patching_rect[0]` and `box.patching_rect[1]` if position changed
- When True: current behavior (place at exact coordinates)
- Update docstring to document the new parameter

**3. Add `skip_overlap_check=True` to internal callers that handle their own positioning:**
- `replace_box()` (line 1014): `self.add_box(new_name, args=args, x=old_x, y=old_y, skip_overlap_check=True)` -- replacing at old position is intentional
- `insert_into_connection()` (line 1065): `self.add_box(name, args=args, skip_overlap_check=True)` -- `_auto_position()` handles positioning immediately after
- `add_subpatcher()` inlet/outlet creation (lines 1375, 1383): `inner.add_box("inlet", x=..., y=..., skip_overlap_check=True)` and `inner.add_box("outlet", x=..., y=..., skip_overlap_check=True)` -- fixed grid inside subpatcher

**4. Update existing tests in TestAutoPosition:**
- `test_collision_nudge_right` (line 1441): Rename to `test_collision_nudge_down`. Update assertion to check that y changed (not x). The blocker is at the target y position, so the new box should nudge down past it.
- `test_collision_wrap_to_next_row` (line 1456): Rename to `test_collision_wrap_to_next_column`. Create a blocker scenario where y exceeds 2400, verify x changed and y reset. The current test places a wide box at x=1185 and checks y > 60 -- replace with a scenario that fills vertical space and checks x shift.

**5. Add new tests in a new class `TestAddBoxOverlapDetection`:**
- `test_add_box_nudges_on_overlap`: Create box A at (60, 60). Create box B at (60, 60). Assert B's position differs from A's, and B.y > A.y (nudged down).
- `test_add_box_no_overlap_exact_position`: Create box at (60, 60) with no other boxes. Assert position is (60, 60) (already on grid).
- `test_add_box_skip_overlap_check`: Create box A at (60, 60). Create box B at (60, 60) with `skip_overlap_check=True`. Assert B's position is (60, 60) (same as A -- overlap allowed).
- `test_add_box_multiple_same_position`: Create 5 boxes all at (60, 60). Assert all have different y positions and they're in ascending y order (each nudged past the previous).
- `test_add_box_snaps_to_grid`: Create box at (67, 53). Assert position snapped to (60, 45) or (75, 60) depending on rounding.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/test_patcher.py::TestAutoPosition tests/test_patcher.py::TestAddBoxOverlapDetection -v --tb=short 2>&1 | tail -30</automated>
  </verify>
  <done>
    - add_box() has skip_overlap_check parameter defaulting to False
    - _find_clear_position() nudges DOWN first, wraps to next column at y > 2400
    - replace_box(), insert_into_connection(), and add_subpatcher() pass skip_overlap_check=True
    - All existing TestAutoPosition tests pass (updated for down-first behavior)
    - New TestAddBoxOverlapDetection tests pass (overlap, no-overlap, opt-out, multiple-stack, grid-snap)
    - Full test suite: python3 -m pytest tests/test_patcher.py passes with 0 failures
  </done>
</task>

<task type="auto">
  <name>Task 2: Run full patcher test suite and verify no regressions</name>
  <files>tests/test_patcher.py</files>
  <action>
Run the complete test suite for the patcher module to catch any regressions from the overlap detection changes.

**Specific concerns to watch for:**
- Tests that assert exact box positions between add_box() and apply_layout() -- these may now get nudged positions instead of (0, 0)
- Tests that create multiple boxes at default (0, 0) -- with overlap detection, second+ boxes will be nudged away from origin
- If any tests fail because of position changes at (0, 0), add `skip_overlap_check=True` to those test setups OR adjust the assertions to account for nudged positions -- whichever is simpler

Run `python3 -m pytest tests/test_patcher.py -x -v` and fix any failures.
Also run `python3 -m pytest tests/ -x --timeout=60` to check the broader test suite.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/test_patcher.py -v --tb=short 2>&1 | tail -40</automated>
  </verify>
  <done>
    - python3 -m pytest tests/test_patcher.py passes with 0 failures
    - python3 -m pytest tests/ passes with 0 failures (no regressions outside patcher tests)
  </done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

No trust boundaries -- this is internal patch generation logic with no external input or user-facing API.

## STRIDE Threat Register

| Threat ID | Category | Component | Disposition | Mitigation Plan |
|-----------|----------|-----------|-------------|-----------------|
| T-260410-01 | D (Denial of Service) | _find_clear_position loop | accept | Max 200 iterations with fallback return; pathological layouts extremely unlikely in practice |
</threat_model>

<verification>
- `python3 -m pytest tests/test_patcher.py -v` -- all tests pass including new overlap detection tests
- `python3 -m pytest tests/ -x` -- no regressions across full test suite
- Manual: Create a Patcher, add_box("toggle", x=60, y=60) twice, verify second box has y > 60
- Manual: add_box with skip_overlap_check=True at same position -- verify no nudge
</verification>

<success_criteria>
- add_box() detects and resolves overlaps by default for every call
- Nudge direction is DOWN first, RIGHT on column overflow (y > 2400)
- Internal callers (replace_box, insert_into_connection, add_subpatcher) opt out correctly
- Zero test regressions across the full test suite
</success_criteria>

<output>
After completion, create `.planning/quick/260410-drl-fix-max-iterate-overlap-detection-for-ne/260410-drl-SUMMARY.md`
</output>
