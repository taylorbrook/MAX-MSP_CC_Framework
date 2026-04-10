# Quick Task 260410-drl: Fix max-iterate overlap detection - Context

**Gathered:** 2026-04-10
**Status:** Ready for planning

<domain>
## Task Boundary

Fix max-iterate overlap detection for new objects against pre-existing objects from earlier iterates and manual changes. Currently add_box() places objects at specified coordinates with no collision check, causing overlaps when iterate agents add new objects to patches with existing content.

</domain>

<decisions>
## Implementation Decisions

### Fix Scope
- Overlap detection built into add_box() itself, not as a post-step
- Every add_box() call checks against all existing boxes in that patcher
- Opt-out flag available for cases where explicit positioning is needed (e.g., layout engine)

### Nudge Direction
- Nudge downward first to preserve horizontal signal flow layout
- Then right if column is full
- Replaces current right-first behavior from _find_clear_position

### Position Source
- Check against every box in patcher.boxes at call time
- Includes both loaded-from-disk objects AND objects added earlier in the same session
- This ensures iterate sessions that add multiple objects don't stack them on top of each other

### Claude's Discretion
- Specific COLLISION_PAD value and grid increment size
- Whether opt-out flag is a boolean param on add_box() or a separate method
- Wrap threshold (currently 1200px) adjustment

</decisions>

<specifics>
## Specific Ideas

- _find_clear_position() already has collision detection logic at patcher.py:1098-1147 — refactor to support down-first nudging
- _auto_position() at patcher.py:1149-1178 is only called by insert_into_connection() — the pattern should be available to add_box()
- finalize_patch(is_new=False) correctly preserves positions but never runs overlap resolution

</specifics>
