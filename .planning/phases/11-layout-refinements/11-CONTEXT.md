# Phase 11: Layout Refinements - Context

**Gathered:** 2026-03-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Object positioning produces tighter, more professional layouts with accurate box sizing, aligned cables, grid-snapped positions, and configurable spacing parameters. Uses per-object width data from Phase 8 audit. This phase modifies the layout engine and sizing; Phase 12 wires these improvements into the generation pipeline and agent docs.

</domain>

<decisions>
## Implementation Decisions

### Width override strategy
- Audit median_width used as primary override, falling back to text-length calculation for objects not in audit data
- Overrides keyed by (object_name, argument_count) -- e.g., `cycle~` with 0 args = 57px, with 1 arg = 68px, with 2 args = 79px
- Width override table stored as JSON at `.claude/max-objects/audit/width-overrides.json`, loaded at import time by sizing.py
- Instance count threshold for inclusion: Claude's discretion (filter noisy single-instance widths)

### Inlet alignment
- Child objects positioned so their destination inlet X aligns under the parent's source outlet X -- produces straight vertical cables
- When multiple children target the same outlet, first child gets ideal alignment; subsequent children pushed right by H_GUTTER
- When a child has multiple parents, average the target positions
- Grid snapping (15px) applied AFTER inlet alignment -- slight cable angle from rounding is acceptable
- Both X and Y positions snap to the 15px grid

### Comment association
- Explicit `target_id` field on Box (optional, layout-time only, not serialized to .maxpat)
- Associated comments placed to the right of the target object, same Y, with 10px gap
- Section header comments (from Phase 10) stay standalone -- not target-associated. Only inline annotations use target association
- `add_comment()` gains optional `target` parameter to set the association

### LayoutOptions dataclass
- Fields: v_spacing (20.0), h_gutter (15.0), patcher_padding (40.0), grid_size (15.0), grid_snap (True), inlet_align (True), comment_gap (10.0)
- Internal thresholds (BUS_MARGIN, BUS_SPACING, HORIZONTAL_THRESHOLD, UPWARD_BUS_THRESHOLD) stay hardcoded -- implementation details
- Passed as optional parameter: `apply_layout(patcher, options=None)` -- None uses defaults, backward compatible
- Location: Claude's discretion (defaults.py or own module)

### Test refactoring (LYOT-06 -- must happen FIRST)
- Existing hardcoded assertion ranges (e.g., `10 <= gap <= 40`) refactored to assert relative to LayoutOptions defaults
- Refactoring committed BEFORE any spacing/sizing constant changes to prevent false regressions

### Claude's Discretion
- Width override instance count threshold (filtering noisy audit data)
- LayoutOptions module location (defaults.py vs layout_options.py)
- Internal implementation of grid snap function
- How width-overrides.json is generated from audit-report.json (script or one-time extraction)
- Exact tolerance values for relative test assertions

</decisions>

<specifics>
## Specific Ideas

- Width overrides keyed by arg count captures the meaningful variation: `trigger b b` vs `trigger b i f s` have very different widths
- Inlet-under-outlet alignment is the single biggest visual improvement -- straight cables make patches look hand-authored
- Grid snapping after alignment (not before) preserves alignment intent while staying on MAX's native grid
- Test refactoring as a prerequisite step (LYOT-06 first) prevents a cascade of false failures when constants change

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `sizing.py` (`calculate_box_size()`): Current sizing entry point -- extend with width override lookup before text-length fallback
- `layout.py` (`_position_component()`): Row-based positioning with parent-center alignment -- modify for inlet-under-outlet
- `layout.py` (`_outlet_x()`, `_inlet_x()`): Already compute I/O positions using _IO_MARGIN and spacing -- reuse for alignment targets
- `defaults.py`: All layout constants live here -- natural home for LayoutOptions dataclass
- `audit-report.json`: Per-object width_finding with median_width, min_width, max_width, instance_count -- source for width-overrides.json

### Established Patterns
- Box sizing: `Box.__init__` calls `calculate_box_size()` which returns (width, height) -- override table slots into this chain
- Layout flow: `apply_layout()` -> `_position_component()` -> row-by-row positioning -- grid snap adds a final pass
- Constants imported from defaults.py by layout.py -- LayoutOptions replaces these module-level imports
- Box has `extra_attrs` dict for non-standard fields -- `target_id` follows this pattern but stays on Box itself (layout-only, not serialized)

### Integration Points
- `calculate_box_size()` in sizing.py -- width override lookup added here
- `_position_component()` in layout.py -- inlet alignment logic replaces center-under-center
- `apply_layout()` signature -- gains `options: LayoutOptions | None = None`
- `Patcher.add_comment()` -- gains optional `target` parameter
- Test file `test_layout.py` -- assertions refactored to use LayoutOptions defaults

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 11-layout-refinements*
*Context gathered: 2026-03-13*
