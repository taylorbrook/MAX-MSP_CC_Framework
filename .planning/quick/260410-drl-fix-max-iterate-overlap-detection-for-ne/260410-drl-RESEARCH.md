# Quick Task: Fix max-iterate overlap detection - Research

**Researched:** 2026-04-10
**Domain:** Patcher API -- overlap detection in add_box()
**Confidence:** HIGH

## Summary

The overlap problem is clear: `add_box()` blindly places boxes at the given (x, y) coordinates with no collision check against existing boxes. During iterate sessions, new objects added at coordinates that happen to overlap pre-existing objects (from earlier iterates or manual edits) stack on top of each other. The existing `_find_clear_position()` method already implements collision detection but is only reachable via `_auto_position()`, which is only called by `insert_into_connection()`.

**Primary recommendation:** Add overlap detection directly inside `add_box()` using the existing `_find_clear_position()` algorithm, refactored for down-first nudging. Add a `skip_overlap_check` parameter defaulting to `False` for callers that handle their own positioning.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Overlap detection built into add_box() itself, not as a post-step
- Every add_box() call checks against all existing boxes in that patcher
- Opt-out flag available for cases where explicit positioning is needed
- Nudge downward first to preserve horizontal signal flow layout, then right if column full
- Check against every box in patcher.boxes at call time (live state)

### Claude's Discretion
- Specific COLLISION_PAD value and grid increment size
- Whether opt-out flag is a boolean param on add_box() or a separate method
- Wrap threshold (currently 1200px) adjustment
</user_constraints>

## Current Architecture [VERIFIED: codebase]

### add_box() (patcher.py:393-417)
- Signature: `add_box(name, args=None, x=0.0, y=0.0) -> Box`
- Creates Box at exact (x, y), appends to `self.boxes`, returns Box
- No collision detection whatsoever

### _find_clear_position() (patcher.py:1098-1147)
- Signature: `_find_clear_position(x, y, w, h, exclude_box=None) -> (x, y)`
- Snaps to 15px grid, iterates up to 50 nudge attempts
- **Current nudge direction: right first** (x += 15), wraps to next row at x > 1200
- Uses `COLLISION_PAD = 5.0` (patcher.py:30) -- doubles up in the overlap check (effectively 10px gap)
- Checks ALL boxes in `self.boxes` (the live patcher state)

### _auto_position() (patcher.py:1149-1178)
- Only called by `insert_into_connection()` (patcher.py:1068)
- Places box below `near_box` with `V_SPACING` gap, then calls `_find_clear_position()`
- Also syncs `box._raw` for round-trip fidelity

### finalize_patch() (hooks.py:63-88)
- `is_new=True`: runs `apply_layout()` (full repositioning) -- overlap detection in add_box is irrelevant here
- `is_new=False` (iterate path): only regenerates midpoints and assistance comments -- **no repositioning**, which is why overlaps persist

## Caller Analysis [VERIFIED: codebase grep]

### Callers that provide explicit (x, y) -- need overlap detection
These are the iterate-path callers where overlaps actually happen:
- **Agent-driven add_box() calls** during `/max-iterate` -- agents specify x/y based on analysis but don't check existing boxes
- `replace_box()` (patcher.py:1014) -- places at old box's exact position after removing old box; collision unlikely but possible if sizes differ
- `insert_into_connection()` (patcher.py:1065) -- already calls `_auto_position()` after `add_box()`, so it already has collision detection

### Callers that handle their own positioning -- need opt-out
- `add_subpatcher()` inlet/outlet boxes (patcher.py:1375, 1383) -- positioned on a fixed grid inside subpatcher; overlap check would interfere
- `apply_layout()` in layout.py -- repositions everything; overlap check during add_box is wasted work (but layout runs after all adds, not during)
- `externals.py` test patch generation (lines 174-203) -- fixed positions for demo patches, followed by `finalize_patch(is_new=True)`
- `rnbo.py` (line 453, 468) -- fixed adc~/dac~ positions in RNBO container

### Callers that leave (x=0, y=0) -- benefit most from overlap detection
- Many test file callers leave default (0, 0) positions, relying on `apply_layout()` afterward
- `insert_into_connection()` creates at (0, 0) then calls `_auto_position()` -- overlap detection in add_box would fire redundantly but harmlessly (box at origin, no collisions there typically)

## Recommended Design

### Parameter: `skip_overlap_check: bool = False`
Add to `add_box()` signature. Boolean param is simpler than a separate method and follows the existing pattern of optional params in the API.

**Rationale over separate method:** The overlap check must happen at insertion time (before the box is in `self.boxes`). A post-hoc method would require removing and re-adding the box. A param keeps it atomic.

### Refactored _find_clear_position() -- down-first nudge
```python
def _find_clear_position(self, x, y, w, h, exclude_box=None):
    x = round(x / 15.0) * 15.0
    y = round(y / 15.0) * 15.0
    start_x = x
    
    for _ in range(200):  # more attempts for vertical space
        collision = False
        for box in self.boxes:
            if box is exclude_box:
                continue
            bx, by, bw, bh = box.patching_rect
            if not (
                x + w + COLLISION_PAD <= bx - COLLISION_PAD
                or x - COLLISION_PAD >= bx + bw + COLLISION_PAD
                or y + h + COLLISION_PAD <= by - COLLISION_PAD
                or y - COLLISION_PAD >= by + bh + COLLISION_PAD
            ):
                collision = True
                break
        if not collision:
            return (x, y)
        # Nudge DOWN first (preserves horizontal signal flow)
        y += 15.0
        if y > 2400:  # wrap threshold for vertical
            y = round(start_x / 15.0) * 15.0  # reset y to original
            x += 15.0  # shift right one column
    return (x, y)
```

**Key changes from current:**
1. Nudge y first (down), not x (right)
2. Wrap to next column when y exceeds threshold (2400 suggested -- double the current horizontal 1200)
3. Increase max attempts from 50 to 200 (vertical space is deeper than horizontal)

### Modified add_box()
```python
def add_box(self, name, args=None, x=0.0, y=0.0, skip_overlap_check=False):
    box_id = self._gen_id()
    box = Box(name=name, args=args, box_id=box_id, db=self.db, x=x, y=y)
    
    if not skip_overlap_check:
        w = box.patching_rect[2]
        h = box.patching_rect[3]
        new_x, new_y = self._find_clear_position(x, y, w, h)
        if new_x != x or new_y != y:
            box.patching_rect[0] = new_x
            box.patching_rect[1] = new_y
    
    self.boxes.append(box)
    return box
```

### Other add_* methods that bypass add_box()
These methods directly construct Box objects and append to `self.boxes`:
- `add_comment()` -- builds its own Box, appends directly
- `add_message()` -- builds its own Box, appends directly
- `add_panel()` -- uses `Box.__new__()`, inserts at index 0
- `add_step_marker()` -- uses `Box.__new__()`, inserts at index 0
- `add_subpatcher()` -- uses `Box.__new__()` for parent, appends directly
- `add_bpatcher()` -- uses `Box.__new__()`, appends directly

**Decision needed:** Should these also get overlap detection? Panels and step markers are background elements (`background=1`) and should be excluded. Comments are associated with targets and positioned by layout. Messages might benefit.

**Recommendation:** Only add overlap detection to `add_box()` for this task. The other `add_*` methods either have dedicated positioning logic or are decorative. This matches the CONTEXT.md scope.

## Common Pitfalls

### Pitfall 1: Double-checking in insert_into_connection
`insert_into_connection()` calls `add_box()` then `_auto_position()`. With overlap detection in `add_box()`, the box gets nudged once at (0,0) then repositioned by `_auto_position()` -- the first check is wasted but harmless. Consider passing `skip_overlap_check=True` in `insert_into_connection()` since it does its own positioning immediately after.

### Pitfall 2: _raw sync for round-trip fidelity
When overlap detection nudges a box, `box._raw` (if present) won't reflect the new position. For loaded-from-disk boxes this matters. However, `add_box()` creates new boxes (no `_raw`), so this is only relevant if the pattern is later used for repositioning loaded boxes.

### Pitfall 3: Test breakage
Many tests call `add_box()` at default (0, 0) and rely on `apply_layout()` to reposition. With overlap detection on, multiple boxes at (0, 0) will get nudged to different positions pre-layout. Since layout overwrites all positions, this is functionally harmless but positions in intermediate assertions may change. Scan tests for position assertions between `add_box()` and `apply_layout()`.

### Pitfall 4: replace_box() position shift
`replace_box()` calls `add_box(name, args=args, x=old_x, y=old_y)` after removing the old box. If the new box is wider/taller and overlaps a neighbor, it'll get nudged. This could be surprising. Consider using `skip_overlap_check=True` in `replace_box()` since the intent is explicit repositioning at the old location.

## Files to Modify

| File | Change |
|------|--------|
| `src/maxpat/patcher.py` | Refactor `_find_clear_position()` for down-first nudging |
| `src/maxpat/patcher.py` | Add `skip_overlap_check` param to `add_box()` |
| `src/maxpat/patcher.py` | Pass `skip_overlap_check=True` in `insert_into_connection()` (already has its own positioning) |
| `src/maxpat/patcher.py` | Optionally pass `skip_overlap_check=True` in `replace_box()` |
| `tests/test_patcher.py` | Add tests for overlap detection in add_box() |
| `tests/test_patcher.py` | Add test for down-first nudge direction |
| `tests/test_patcher.py` | Add test for skip_overlap_check opt-out |

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | 2400px vertical wrap threshold is reasonable | Recommended Design | Boxes could wrap too early/late; easy to tune |
| A2 | 200 max attempts is sufficient | Recommended Design | Pathological layouts could exceed; fallback returns last position |

## Sources

### Primary (HIGH confidence)
- `src/maxpat/patcher.py` lines 393-417 (add_box), 1098-1178 (_find_clear_position, _auto_position)
- `src/maxpat/hooks.py` lines 63-88 (finalize_patch iterate path)
- `src/maxpat/layout.py` lines 68-170 (apply_layout full repositioning)
- Full codebase grep for `.add_box(` -- 100+ call sites catalogued
