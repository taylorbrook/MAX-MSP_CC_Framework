# Quick Task 12: Fix python generation script overwriting manual patch improvements - Context

**Gathered:** 2026-03-16
**Status:** Ready for planning

<domain>
## Task Boundary

Fix the incremental patching system (src/maxpat/incremental.py) so that running generate.py preserves user modifications made in the MAX GUI. Three critical gaps exist:

1. Subpatcher content is replaced wholesale (no recursive merge)
2. Generator-owned box attributes (position, params) fully replaced instead of merged
3. Layout recomputation overwrites user positions on every run

</domain>

<decisions>
## Implementation Decisions

### Attribute ownership model
- Generator owns **structure**: object text, connections, I/O counts, maxclass
- User owns **presentation**: position (patching_rect), size, visual attributes, parameter values
- On conflict: merge attributes per this ownership split

### Change preservation
- All change types equally important: positions, parameter values, user-added objects
- Applies to both main patcher AND subpatchers recursively

### Scope
- Fix in shared `src/maxpat/incremental.py` so all patches benefit
- Not limited to performancepatchtest — rhythmic-sampler and future patches too

### Claude's Discretion
- Implementation approach for recursive subpatcher merging
- How to handle manifest tracking for nested content (flat vs hierarchical manifest)
- Whether to skip layout for generator-owned boxes that have user-modified positions

</decisions>

<specifics>
## Specific Ideas

- Manifest.from_patcher() needs to recurse into subpatchers
- merge_and_write() needs recursive merge logic for subpatcher content
- Generator-owned boxes should preserve user's patching_rect, presentation_rect, and extra_attrs from the on-disk version
- apply_layout() should only run on first generation (no existing file), not on merge runs
- Or: layout should only apply to NEW objects not present in the old manifest

</specifics>
