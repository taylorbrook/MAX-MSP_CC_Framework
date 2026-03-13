# Phase 11: Layout Refinements - Research

**Researched:** 2026-03-13
**Domain:** MAX/MSP patch layout engine -- object sizing, cable alignment, grid snapping, configurable layout parameters
**Confidence:** HIGH

## Summary

Phase 11 modifies the existing layout engine (`layout.py`, `sizing.py`, `defaults.py`) to produce tighter, more professional MAX patch layouts. The four main improvements are: (1) accurate box widths from help patch measurements replacing the character-width approximation, (2) inlet-under-outlet alignment for straighter cables, (3) 15px grid snapping matching MAX's native grid, and (4) a `LayoutOptions` dataclass replacing hardcoded module-level constants.

The existing codebase is well-structured for these changes. `calculate_box_size()` has a clear entry point for width override lookup. `_position_component()` already computes parent center-x for child positioning -- this extends naturally to outlet-specific X targeting. Grid snapping is a thin round-to-nearest-multiple pass applied after positioning. `LayoutOptions` replaces the module-level constant imports already used by `layout.py`.

**Primary recommendation:** Implement LYOT-06 (test refactoring) first as a standalone commit, then layer the remaining changes on top. This prevents cascading test failures when spacing constants change.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Width override strategy: audit median_width as primary override, falling back to text-length calculation for objects not in audit data. Overrides keyed by (object_name, argument_count). Width override table stored as JSON at `.claude/max-objects/audit/width-overrides.json`, loaded at import time by sizing.py
- Instance count threshold for inclusion: Claude's discretion (filter noisy single-instance widths)
- Inlet alignment: child objects positioned so their destination inlet X aligns under the parent's source outlet X. When multiple children target the same outlet, first child gets ideal alignment; subsequent children pushed right by H_GUTTER. When a child has multiple parents, average the target positions. Grid snapping applied AFTER inlet alignment -- slight cable angle from rounding is acceptable. Both X and Y positions snap to 15px grid
- Comment association: explicit `target_id` field on Box (optional, layout-time only, not serialized to .maxpat). Associated comments placed to the right of target object, same Y, with 10px gap. Section header comments stay standalone. `add_comment()` gains optional `target` parameter
- LayoutOptions dataclass: fields v_spacing (20.0), h_gutter (15.0), patcher_padding (40.0), grid_size (15.0), grid_snap (True), inlet_align (True), comment_gap (10.0). Internal thresholds stay hardcoded. Passed as optional parameter: `apply_layout(patcher, options=None)`. Location: Claude's discretion
- Test refactoring (LYOT-06): must happen FIRST. Existing hardcoded assertion ranges refactored to assert relative to LayoutOptions defaults. Committed before any spacing/sizing constant changes

### Claude's Discretion
- Width override instance count threshold (filtering noisy audit data)
- LayoutOptions module location (defaults.py vs layout_options.py)
- Internal implementation of grid snap function
- How width-overrides.json is generated from audit-report.json (script or one-time extraction)
- Exact tolerance values for relative test assertions

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| LYOT-01 | Box width calculation improved using per-object width override table extracted from help patch measurements | Width override table design, `calculate_box_size()` integration pattern, audit data analysis (1022 objects with width_finding, 513 with >= 3 instances) |
| LYOT-02 | Inlet-aligned cable routing positions child objects so inlets align under parent outlet X positions | `_outlet_x()` and `_inlet_x()` functions already exist in layout.py; `_position_component()` modification pattern for inlet-under-outlet alignment |
| LYOT-03 | 15px grid snapping rounds all object positions to MAX's native grid | Grid size already in DEFAULT_PATCHER_PROPS (gridsize: [15.0, 15.0]), snap function is simple round-to-nearest-multiple |
| LYOT-04 | Comment association placement positions comments near their target objects with consistent offset | Box.target_id field pattern, `_place_associated_comments()` function design, `add_comment()` target parameter |
| LYOT-05 | LayoutOptions dataclass replaces module-level constants for configurable spacing, grid, and alignment parameters | Dataclass fields match defaults.py constants; `apply_layout()` signature extension |
| LYOT-06 | Layout tests refactored to relative assertions before any spacing constant changes | Three hardcoded assertions identified in test_layout.py lines 154, 173, 193 |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python dataclasses | stdlib | LayoutOptions definition | Already used by BoxInstance in audit; no external dependency |
| json (stdlib) | stdlib | Load width-overrides.json | Already used throughout codebase |
| statistics (stdlib) | stdlib | Median computation for override generation | Already used by analyzer.py |

### Supporting
No additional libraries needed. All changes use standard library features already present in the codebase.

## Architecture Patterns

### Recommended File Changes
```
src/maxpat/
  defaults.py           # Add LayoutOptions dataclass, keep existing constants as fallbacks
  sizing.py             # Add width override lookup before text-length calculation
  layout.py             # Modify _position_component() for inlet alignment, add grid snap pass, add comment placement
  patcher.py            # Add target parameter to add_comment(), add target_id to Box

.claude/max-objects/audit/
  width-overrides.json  # NEW: generated from audit-report.json

tests/
  test_layout.py        # Refactor hardcoded assertions to use LayoutOptions defaults
  test_sizing.py        # Add tests for width override lookup
```

### Pattern 1: Width Override Lookup in calculate_box_size()

**What:** Insert width override lookup before the text-length fallback calculation.
**When to use:** Every call to `calculate_box_size()` for `newobj` maxclass objects.

```python
# In sizing.py
import json
from pathlib import Path

# Load width overrides at import time (cached)
_WIDTH_OVERRIDES: dict[str, dict[int, float]] = {}

def _load_width_overrides() -> dict[str, dict[int, float]]:
    """Load width override table from audit data.

    Returns dict keyed by object_name, values are dicts of arg_count -> width.
    """
    override_path = Path(__file__).parent.parent.parent / ".claude" / "max-objects" / "audit" / "width-overrides.json"
    if not override_path.exists():
        return {}
    with open(override_path) as f:
        return json.load(f)

_WIDTH_OVERRIDES = _load_width_overrides()


def calculate_box_size(text: str, maxclass: str) -> tuple[float, float]:
    # ... existing UI_SIZES check ...

    # Width override lookup for newobj
    if maxclass == "newobj" and text:
        parts = text.split()
        obj_name = parts[0]
        arg_count = len(parts) - 1

        overrides = _WIDTH_OVERRIDES.get(obj_name)
        if overrides:
            # Try exact arg_count match first, then fallback to 0-arg entry
            width = overrides.get(str(arg_count)) or overrides.get("default")
            if width:
                return (width, DEFAULT_HEIGHT)

    # Fallback: text-length calculation (existing logic)
    width = len(text) * CHAR_WIDTH + PADDING
    width = max(width, MIN_BOX_WIDTH)
    # ... rest of existing logic ...
```

### Pattern 2: Inlet-Under-Outlet Alignment in _position_component()

**What:** Replace center-under-center child positioning with outlet-X-to-inlet-X alignment.
**When to use:** In `_position_component()` when positioning child rows.

```python
def _target_x_for_child(
    child: Box,
    reverse_adj: dict[str, list[str]],
    box_map: dict[str, Box],
    lines: list,
) -> float:
    """Compute ideal x for child so its inlet aligns under parent's outlet.

    For each parent connection, finds the specific outlet X and inlet X,
    then computes what child.x should be for alignment. When multiple
    parents exist, averages the target positions.
    """
    targets = []
    for line in lines:
        if line.dest_id == child.id:
            parent = box_map.get(line.source_id)
            if parent and parent.patching_rect[1] < child.patching_rect[1]:
                outlet_x_pos = _outlet_x(parent, line.source_outlet)
                inlet_x_pos = _inlet_x(child, line.dest_inlet)
                # We want child.x such that inlet_x(child) == outlet_x_pos
                # inlet_x = child.x + IO_MARGIN + inlet_idx * spacing
                # So child.x = outlet_x_pos - (inlet_x - child.x)
                inlet_offset = inlet_x_pos - child.patching_rect[0]
                ideal_child_x = outlet_x_pos - inlet_offset
                targets.append(ideal_child_x)

    if targets:
        return sum(targets) / len(targets)

    # Fallback to center-under-parent-center (existing behavior)
    return _parent_center_x(child, reverse_adj, box_map) - child.patching_rect[2] * 0.5
```

### Pattern 3: Grid Snap Pass

**What:** Round all box positions to the nearest multiple of grid_size after layout.
**When to use:** Final step before midpoint generation in `apply_layout()`.

```python
def _snap_to_grid(boxes: list[Box], grid_size: float) -> None:
    """Round all box positions to nearest grid multiple."""
    for box in boxes:
        box.patching_rect[0] = round(box.patching_rect[0] / grid_size) * grid_size
        box.patching_rect[1] = round(box.patching_rect[1] / grid_size) * grid_size
```

### Pattern 4: LayoutOptions Dataclass

**What:** Replace module-level constant imports with a configurable dataclass.
**When to use:** Passed to `apply_layout()` as optional parameter.

```python
from dataclasses import dataclass

@dataclass
class LayoutOptions:
    """Configurable layout parameters for patch generation."""
    v_spacing: float = 20.0
    h_gutter: float = 15.0
    patcher_padding: float = 40.0
    grid_size: float = 15.0
    grid_snap: bool = True
    inlet_align: bool = True
    comment_gap: float = 10.0
```

### Pattern 5: Comment Association

**What:** Add `target_id` to Box, `target` parameter to `add_comment()`, position associated comments to the right of their targets.
**When to use:** Inline annotation comments that should stay near a specific object.

```python
# In patcher.py - Box class gets target_id attribute
self.target_id: str | None = None  # Layout-time only, not serialized

# In patcher.py - add_comment() gains target parameter
def add_comment(self, text: str, x: float = 0.0, y: float = 0.0, target: Box | None = None) -> Box:
    box = ...  # existing logic
    if target is not None:
        box.target_id = target.id
    return box

# In layout.py - new function after component positioning
def _place_associated_comments(boxes: list[Box], comment_gap: float) -> None:
    """Position comments with target_id next to their target objects."""
    box_map = {b.id: b for b in boxes}
    for box in boxes:
        if box.maxclass == "comment" and box.target_id:
            target = box_map.get(box.target_id)
            if target:
                box.patching_rect[0] = target.patching_rect[0] + target.patching_rect[2] + comment_gap
                box.patching_rect[1] = target.patching_rect[1]
```

### Anti-Patterns to Avoid

- **Snapping before alignment:** Grid snap MUST happen after inlet alignment, not before. Snapping first would destroy alignment precision.
- **Modifying patcher.lines during layout:** The inlet alignment reads lines to find connections. Do not modify the lines list during positioning -- treat it as read-only during the layout pass.
- **Serializing target_id to JSON:** The `target_id` field is layout-time metadata only. It must NOT appear in `Box.to_dict()` output. Keep it as a Python-only attribute.
- **Breaking backward compatibility:** `apply_layout(patcher)` with no options must produce the same output as before LayoutOptions existed (defaults match current constants).

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Width measurement | Don't manually measure objects in MAX | Use audit-report.json median_width | Already extracted from 973 help patches with 12,952 instances |
| Grid snap math | Don't write complex rounding with edge cases | `round(x / grid) * grid` | Standard round-to-nearest-multiple; Python's `round()` handles .5 correctly |
| Per-instance width-arg correlation | Don't re-parse all 973 help patches | Use median_width from audit as default per object, keyed by arg_count where feasible | Per-arg-count correlation would require parser modifications and re-running audit; median_width is already 92% more accurate than text-length |

**Key insight:** The audit-report.json has aggregated width data (all instances merged per object) but does NOT have per-instance text-to-width correlation. The width_finding.widths list is a flat array without corresponding argument data. For the LYOT-01 override table, use median_width as the "default" key for each object. Per-arg-count keys can be derived from the argument_finding.patterns where the most common patterns map to common width clusters, but this is an approximation. This is acceptable because:
- 92% of objects with >= 3 instances get a width improvement > 5px from the median override alone
- Only 25% of objects have tight enough width ranges that per-arg-count would significantly help
- The text-length fallback still covers unlisted arg counts

## Common Pitfalls

### Pitfall 1: Width Override Loading Path
**What goes wrong:** Using a relative path that breaks when the module is imported from different working directories.
**Why it happens:** `Path("...")` uses cwd, not module location.
**How to avoid:** Use `Path(__file__).parent.parent.parent / ".claude" / "max-objects" / "audit" / "width-overrides.json"` -- anchored to the module's own location.
**Warning signs:** Tests pass locally but fail in CI or when run from project root vs src/.

### Pitfall 2: Grid Snap Accumulating Drift on Companion/UI Control Placement
**What goes wrong:** Companion objects (meter~, etc.) and UI controls are placed relative to their parent, then grid-snapped independently, causing visual misalignment.
**How to avoid:** Apply grid snap as a single pass on ALL boxes after ALL positioning is complete (including companion and UI control placement). Do NOT snap during positioning.
**Warning signs:** meter~ appears 15px offset from its parent gain~.

### Pitfall 3: Inlet Alignment for Single-Inlet Objects
**What goes wrong:** Objects with `numinlets=1` have their inlet at center (w*0.5), but the alignment math may compute incorrect offsets if it doesn't account for the `n<=1` special case in `_inlet_x()`.
**How to avoid:** The existing `_inlet_x()` already handles `n<=1` by returning `x + w*0.5`. The alignment function must use `_inlet_x()` consistently, not reimplementing the math.
**Warning signs:** Single-inlet children placed at wrong X.

### Pitfall 4: Existing Tests With Hardcoded Ranges Break
**What goes wrong:** Tests asserting `10 <= gap <= 40` break when V_SPACING changes to 25.
**Why it happens:** Test constants were hardcoded to match the original V_SPACING=20, H_GUTTER=15 defaults.
**How to avoid:** LYOT-06 must be implemented FIRST. Refactor these assertions to reference LayoutOptions defaults: e.g., `assert abs(gap - opts.v_spacing) < tolerance`.
**Warning signs:** 3 tests fail immediately when any spacing constant changes.

### Pitfall 5: Circular Import with LayoutOptions in defaults.py
**What goes wrong:** If layout.py imports LayoutOptions from defaults.py, and defaults.py imports something from layout.py, circular import occurs.
**Why it happens:** defaults.py is already imported by sizing.py and patcher.py.
**How to avoid:** LayoutOptions belongs in defaults.py (it only depends on stdlib `dataclasses`). layout.py already imports from defaults.py -- adding LayoutOptions to that import is safe. The dependency graph is: defaults.py <- sizing.py <- patcher.py, and defaults.py <- layout.py. No reverse dependency exists.
**Warning signs:** ImportError at import time.

### Pitfall 6: Width Override for Aliased Objects
**What goes wrong:** Object created as `t` (alias for `trigger`) doesn't match override keyed as `trigger`.
**Why it happens:** Box stores `name = "t"` but override table uses canonical names from audit.
**How to avoid:** The override table should use the names as they appear in help patches (which use canonical names like `trigger`). In `calculate_box_size()`, the text field contains the actual typed name (e.g., "t b b"), so lookup should try both the first token AND its canonical name via alias resolution. However, since `calculate_box_size()` receives text and maxclass (not the alias map), the simpler approach is to key the override table by the names as commonly used. The audit data uses canonical names. In practice, the text-length fallback handles short aliases well (short names = small boxes, which is correct).
**Warning signs:** Override lookups miss aliased objects.

## Code Examples

### Width Override Table Format (width-overrides.json)
```json
{
  "cycle~": {"default": 68.0, "0": 57.0, "1": 68.0},
  "loadbang": {"default": 62.0},
  "*~": {"default": 42.0},
  "trigger": {"default": 80.5},
  "pack": {"default": 88.0},
  "route": {"default": 101.0},
  "metro": {"default": 69.0},
  "prepend": {"default": 97.0}
}
```
The "default" key is used when arg_count doesn't match any specific key. Specific arg_count keys (as strings: "0", "1", "2") are used when available.

### Test Refactoring Example (LYOT-06)
```python
# BEFORE (hardcoded ranges):
assert 10 <= gap <= 40, f"Vertical gap {gap} outside acceptable range"

# AFTER (relative to LayoutOptions defaults):
from src.maxpat.defaults import LayoutOptions
opts = LayoutOptions()
assert abs(gap - opts.v_spacing) <= opts.v_spacing * 0.5, (
    f"Vertical gap {gap} not within 50% of default {opts.v_spacing}"
)
```

### LayoutOptions Integration in apply_layout()
```python
def apply_layout(patcher: Patcher, options: LayoutOptions | None = None) -> None:
    if options is None:
        options = LayoutOptions()

    # Use options.v_spacing instead of V_SPACING module constant
    # Use options.h_gutter instead of H_GUTTER module constant
    # etc.

    # ... existing logic with options threaded through ...

    # Grid snap as final pass (before midpoint generation)
    if options.grid_snap:
        _snap_to_grid(patcher.boxes, options.grid_size)

    # Then midpoint generation (uses final snapped positions)
    _generate_midpoints(patcher)
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Text-length width: `len(text) * 7.0 + 16.0` | Audit-based median_width overrides | Phase 11 | 92% of objects get more accurate widths |
| Center-under-center child positioning | Inlet-under-outlet alignment | Phase 11 | Straight vertical cables instead of diagonal |
| No grid snapping | 15px grid snap on all positions | Phase 11 | Matches MAX native grid, objects don't shift on open |
| Hardcoded module-level constants | LayoutOptions dataclass | Phase 11 | User-configurable spacing and alignment |

## Open Questions

1. **Width override generation approach**
   - What we know: audit-report.json has per-object median_width and argument_finding.patterns separately. The widths list is flat (no per-instance text correlation).
   - What's unclear: Whether to build a script that re-processes help patches for per-arg-count width data, or extract a simpler table using median_width as the "default" key for each object.
   - Recommendation: Start with median_width as "default" for all objects with instance_count >= 3 (513 objects). This covers 92% of the improvement. Per-arg-count refinement can be a follow-up. The CONTEXT.md says Claude's discretion on instance count threshold -- recommend threshold of 3.

2. **Instance count threshold for width overrides**
   - What we know: 330 objects have only 1 instance, 179 have 2, 513 have >= 3. Single-instance widths may reflect specific help patch styling rather than "typical" widths.
   - Recommendation: Use threshold of 3 instances minimum. This filters noisy single-instance data while keeping 513 objects (50% of all audited objects). Objects with 1-2 instances fall back to text-length calculation.

3. **LayoutOptions module location**
   - Option A: Add to `defaults.py` (natural home, already imported by layout.py and sizing.py)
   - Option B: New `layout_options.py` module (cleaner separation)
   - Recommendation: `defaults.py` -- it already contains all the constants that LayoutOptions replaces. Adding a 10-line dataclass there avoids a new import and keeps constants co-located. The dataclass default values should match the existing module-level constants exactly.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or pytest.ini (standard) |
| Quick run command | `python3 -m pytest tests/test_layout.py tests/test_sizing.py -x -q` |
| Full suite command | `python3 -m pytest -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| LYOT-01 | Width override lookup returns audit median for known objects | unit | `python3 -m pytest tests/test_sizing.py -x -q -k "override"` | No -- Wave 0 |
| LYOT-01 | Width override falls back to text-length for unknown objects | unit | `python3 -m pytest tests/test_sizing.py -x -q -k "fallback"` | No -- Wave 0 |
| LYOT-02 | Child inlet X aligns under parent outlet X after layout | unit | `python3 -m pytest tests/test_layout.py -x -q -k "inlet_align"` | No -- Wave 0 |
| LYOT-02 | Multiple children on same outlet: first aligned, rest pushed right | unit | `python3 -m pytest tests/test_layout.py -x -q -k "multi_child"` | No -- Wave 0 |
| LYOT-03 | All box positions are multiples of 15.0 after layout | unit | `python3 -m pytest tests/test_layout.py -x -q -k "grid_snap"` | No -- Wave 0 |
| LYOT-04 | Comments with target_id placed to right of target, same Y | unit | `python3 -m pytest tests/test_layout.py -x -q -k "comment_assoc"` | No -- Wave 0 |
| LYOT-05 | apply_layout(patcher, LayoutOptions(v_spacing=30)) uses custom spacing | unit | `python3 -m pytest tests/test_layout.py -x -q -k "layout_options"` | No -- Wave 0 |
| LYOT-05 | apply_layout(patcher) with no options produces same results as before | unit | `python3 -m pytest tests/test_layout.py -x -q -k "backward_compat"` | No -- Wave 0 |
| LYOT-06 | Existing 54 layout+sizing tests pass after refactoring assertions | regression | `python3 -m pytest tests/test_layout.py tests/test_sizing.py -x -q` | Yes -- refactor existing |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_layout.py tests/test_sizing.py -x -q`
- **Per wave merge:** `python3 -m pytest -x -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_layout.py` -- refactor 3 hardcoded assertions (lines 154, 173, 193) to reference LayoutOptions defaults (LYOT-06)
- [ ] `tests/test_sizing.py` -- add tests for width override lookup and fallback behavior (LYOT-01)
- [ ] `tests/test_layout.py` -- add tests for inlet alignment, grid snap, comment association, LayoutOptions integration (LYOT-02 through LYOT-05)
- [ ] `.claude/max-objects/audit/width-overrides.json` -- generate from audit-report.json (LYOT-01 prerequisite)

## Existing Code Analysis

### Files to Modify (with specific locations)

**`src/maxpat/defaults.py`:**
- Add `LayoutOptions` dataclass (new, after existing constants)
- Keep existing module-level constants (V_SPACING, H_GUTTER, etc.) as backward compatibility -- LayoutOptions defaults should equal these values

**`src/maxpat/sizing.py`:**
- Add `_load_width_overrides()` function and `_WIDTH_OVERRIDES` module-level cache
- Modify `calculate_box_size()`: insert width override lookup after UI_SIZES check, before text-length calculation (line 107)
- Override lookup: `text.split()[0]` -> look up in `_WIDTH_OVERRIDES` -> try arg_count key -> try "default" key -> fallback to text-length

**`src/maxpat/layout.py`:**
- Modify `apply_layout()` signature: add `options: LayoutOptions | None = None` parameter (line 67)
- Thread `options` through to `_position_component()`, `_place_ui_controls()`, `_place_companions()`
- Modify `_position_component()`: replace `_parent_center_x()` with `_target_x_for_inlet_align()` when `options.inlet_align` is True (line 366-369)
- Add `_target_x_for_inlet_align()` function: uses patcher.lines to find outlet/inlet indices, computes ideal child X
- Add `_snap_to_grid()` function: applied after all positioning, before `_generate_midpoints()`
- Add `_place_associated_comments()` function: positions comments with `target_id` near their targets
- Replace all references to `V_SPACING`, `H_GUTTER`, `PATCHER_PADDING` with `options.v_spacing`, `options.h_gutter`, `options.patcher_padding`

**`src/maxpat/patcher.py`:**
- Add `self.target_id: str | None = None` to `Box.__init__()` (after line 163)
- Add `target: Box | None = None` parameter to `Patcher.add_comment()` (line 300)
- Set `box.target_id = target.id` when target is provided
- Ensure `target_id` is NOT included in `Box.to_dict()` output (it is layout-time only)
- NOTE: `Box.__new__(Box)` calls in `add_panel()`, `add_step_marker()`, etc. must also set `target_id = None`

**`tests/test_layout.py`:**
- Line 154: `assert 10 <= gap <= 40` -> `assert abs(gap - opts.v_spacing) <= tolerance`
- Line 173: `assert 5 <= gutter <= 30` -> `assert abs(gutter - opts.h_gutter) <= tolerance` (or `gutter >= opts.h_gutter - 1`)
- Line 193: `assert abs(actual_gap - expected_gap) < 5.0` -> keep as-is (already relative to V_SPACING via `expected_gap`)

### Hardcoded Test Assertions Requiring Refactoring (LYOT-06)

| Line | Current Assertion | Issue | Proposed Fix |
|------|-------------------|-------|--------------|
| 154 | `assert 10 <= gap <= 40` | Hardcoded range assumes V_SPACING ~20 | `assert abs(gap - V_SPACING) <= V_SPACING * 0.5` |
| 173 | `assert 5 <= gutter <= 30` | Hardcoded range assumes H_GUTTER ~15 | `assert gutter >= H_GUTTER * 0.5` (child may be pushed by alignment) |
| 193 | `assert abs(actual_gap - expected_gap) < 5.0` | Already relative (uses V_SPACING in expected_gap computation) | Keep as-is, tolerance is fine |

Note: Line 193's assertion already computes `expected_gap` from `tallest_h + V_SPACING`, so it's implicitly relative. Only lines 154 and 173 need changes.

## Sources

### Primary (HIGH confidence)
- `src/maxpat/layout.py` -- current layout engine implementation (882 lines)
- `src/maxpat/sizing.py` -- current box sizing implementation (116 lines)
- `src/maxpat/defaults.py` -- current constants (114 lines)
- `src/maxpat/patcher.py` -- Box/Patcher data model (1002 lines)
- `tests/test_layout.py` -- existing 27 layout tests
- `tests/test_sizing.py` -- existing 27 sizing tests
- `.claude/max-objects/audit/audit-report.json` -- 1022 objects with width_finding from 973 help patches

### Secondary (MEDIUM confidence)
- MAX 9 DEFAULT_PATCHER_PROPS.gridsize: [15.0, 15.0] -- confirms 15px grid (from defaults.py, verified against MAX 9 default behavior)

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all stdlib, no new dependencies
- Architecture: HIGH -- modifications to existing well-understood codebase, clear integration points
- Pitfalls: HIGH -- identified from direct code analysis, not speculation
- Width data: MEDIUM -- median_width is reliable for consistent objects but approximate for variable-width objects

**Research date:** 2026-03-13
**Valid until:** 2026-04-13 (stable domain, no external API dependencies)
