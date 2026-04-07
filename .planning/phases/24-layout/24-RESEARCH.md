# Phase 24: Layout - Research

**Researched:** 2026-04-07
**Domain:** M4L presentation layout engine (Python, maxpat JSON manipulation)
**Confidence:** HIGH

## Summary

Phase 24 builds a standalone M4L presentation layout engine (`m4l_layout.py`) that positions live.* controls within Ableton's fixed 169px device height. The engine reuses Phase 23's semantic grouping (`_classify_parameter` from `m4l_polish.py`) to organize controls into functional columns, and supports three layout patterns: single-page, tabbed (via `live.tab` + `script hide/show`), and overlay (readout overlays + popup panels).

The implementation is pure Python operating on patch_dict (raw JSON dicts), following the same pattern as `m4l_polish.py` and `m4l_export.py`. No external libraries are needed. The core challenge is the packing algorithm -- fitting controls with known fixed dimensions into a 169px vertical budget with group labels, margins, and optional tab headers.

**Primary recommendation:** Build a column-packing layout engine that computes presentation_rect for each live.* control based on its group assignment and control dimensions from `sizing.py`, with tab overflow when controls exceed single-page capacity.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- **D-01:** Reuse Phase 23's Push bank semantic clustering logic (varname prefix/keyword analysis) as the grouping source. Single source of truth for both Push banks and visual layout.
- **D-02:** Each group gets a live.comment header label above it (e.g., "Filter", "Amp"). Standard M4L convention, costs ~18px height per group.
- **D-03:** Groups flow left-to-right as vertical columns within the device. Each group is a column: label on top, controls stacked below. Device widens if needed to fit all groups.
- **D-04:** Tabbed layout uses live.tab + bpatcher swap pattern. live.tab at top selects which bpatcher is visible. Each tab page is a separate bpatcher with its own controls. Standard M4L pattern used by Ableton stock devices.
- **D-05:** Tab trigger threshold: >8 controls per group, or total controls exceed what fits in devicewidth at 169px height. Auto-selected based on control count and device complexity.
- **D-06:** Overlay pattern covers two cases: (a) readout overlays -- flonum/live.numbox overlaid on live.dial with ignoreclick=1, and (b) popup panels -- hidden panels that slide over device for advanced settings (Show/Hide button pattern).
- **D-07:** Vertical allocation: ~18px for live.comment group label, ~4px gap, remaining height for controls. Two rows possible for smaller controls (live.numbox at 15px, live.toggle at 15px).
- **D-08:** Control sizes use exact dimensions from sizing.py. live.dial is always 44x66, live.slider always 39x87, etc. No scaling.
- **D-09:** Horizontal spacing between controls: tight 4-6px gap, matching Ableton stock devices.
- **D-10:** All presentation coordinates enforced as whole pixels (int() or round()). No fractional values causing blurry rendering.
- **D-11:** Auto-fit devicewidth starting at 300px default. Expands if controls don't fit. Ableton supports up to ~900px device width. Ensures nothing is clipped.
- **D-12:** New standalone module `src/maxpat/m4l_layout.py` with `layout_m4l_presentation(patch_dict)` function. Keeps layout.py focused on patching mode layout. Follows m4l_export.py and m4l_polish.py pattern.
- **D-13:** Pipeline order: agents build -> polish -> layout -> export. Layout reads polished parameter metadata to inform grouping. Explicit call by agents, not auto-triggered.
- **D-14:** Layout engine preserves manually-set presentation_rect values. If a control already has presentation_rect, layout leaves it alone. Only positions controls without presentation_rect.

### Claude's Discretion
- Internal algorithm for packing controls into columns within 169px
- Exact threshold constants for tab vs single-page decision
- Popup panel implementation details (show/hide scripting, panel sizing)
- How live.tab + bpatcher structure is generated (subpatcher creation, tab wiring)
- Group ordering heuristic (which group goes leftmost)

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope

</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| LAYOUT-01 | M4L presentation layout engine groups controls by function within 169px height constraint | Reuse `_classify_parameter()` from m4l_polish.py for grouping; height budget analysis confirms all standard controls fit with labels; column-packing algorithm positions each group as vertical column |
| LAYOUT-02 | Layout supports tabbed, single-page, and overlay patterns -- auto-selected based on control count and device complexity | Tab pattern uses `live.tab` + `script hide/show` via `thispatcher` + `varname` scripting names; threshold detection based on column count vs devicewidth and control count; overlay uses Z-order + ignoreclick |
| LAYOUT-03 | All presentation coordinates enforced as whole pixels (no fractional values causing blurry rendering) | `int()` rounding on all x, y, w, h values in presentation_rect; Ableton production guidelines confirm whole-pixel requirement |

</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib | 3.12+ | Pure dict manipulation, math | No external deps needed; layout is JSON arithmetic |
| `m4l_polish._classify_parameter` | internal | Semantic parameter grouping | D-01: single source of truth for both Push banks and visual layout |
| `m4l_polish._collect_live_controls` | internal | Recursive live.* control collection | Already handles subpatcher traversal and _LIVE_NO_PARAM exclusion |
| `sizing.UI_SIZES` | internal | Fixed control dimensions | Source of truth for all live.* control sizes |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| `m4l_constants` | internal | Device type constants, ParamType | When detecting device type for layout decisions |
| `critics.m4l_critic._LIVE_NO_PARAM` | internal | Non-parameter live.* objects | Already imported by m4l_polish; filter non-layoutable objects |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| Custom grouping logic | Reuse `_classify_parameter` | D-01 mandates reuse; no alternative needed |
| Patcher-level tab approach (subpatcher inspector tabs) | `live.tab` + `script hide/show` | D-04 mandates live.tab pattern; patcher tabs consume header space and have less control |

**Installation:** No installation needed -- pure internal Python modules.

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/
  m4l_layout.py      # NEW: M4L presentation layout engine (this phase)
  m4l_polish.py       # Existing: semantic grouping, parameter naming (Phase 23)
  m4l_export.py       # Existing: .amxd export (Phase 22)
  m4l_constants.py    # Existing: constants (Phase 20)
  sizing.py           # Existing: control dimensions
  layout.py           # Existing: patching-mode layout (unchanged)
tests/
  test_m4l_layout.py  # NEW: tests for layout engine
```

### Pattern 1: Standalone Module (dict-in, dict-out)
**What:** `layout_m4l_presentation(patch_dict) -> dict` operates on raw patch_dict, mutates in place, returns same dict. Follows m4l_polish.py and m4l_export.py pattern. [VERIFIED: codebase inspection of m4l_polish.py, m4l_export.py]
**When to use:** Always -- this is the mandated pattern (D-12).
**Example:**
```python
# Source: follows m4l_polish.py pattern (verified from codebase)
def layout_m4l_presentation(patch_dict: dict) -> dict:
    """Position live.* controls in M4L presentation view.

    Mutates patch_dict in place. Returns the same dict.
    Pipeline: agents build -> polish -> layout -> export (D-13).
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    controls = _collect_live_controls(boxes)

    if not controls:
        return patch_dict

    # Filter to controls without existing presentation_rect (D-14)
    needs_layout = [c for c in controls if not c.get("presentation_rect")]
    if not needs_layout:
        return patch_dict

    # Group by semantic function (D-01)
    groups = _group_controls(needs_layout)

    # Choose layout pattern
    pattern = _select_layout_pattern(groups, patcher)

    # Apply pattern
    if pattern == "single":
        _apply_single_page(groups, patcher)
    elif pattern == "tabbed":
        _apply_tabbed_layout(groups, patcher)

    return patch_dict
```

### Pattern 2: Column Packing (Height-First)
**What:** Each group occupies a vertical column. Within each column: live.comment label (18px) + 4px gap + controls stacked vertically. Groups placed left-to-right with 4-6px gaps. [VERIFIED: height math computed from sizing.py values]
**When to use:** All single-page layouts.

**Height Budget (169px device):**
```
Device height:           169px
Top margin:                4px
Bottom margin:             4px
Available:               161px

Group label:              18px (live.comment)
Label gap:                 4px
Remaining for controls:  139px

Control heights:
  live.dial:       66px  -> label+ctrl = 88px  (73px remaining)
  live.slider:     87px  -> label+ctrl = 109px (52px remaining)
  live.numbox:     15px  -> fits 2 rows stacked (56px used)
  live.toggle:     15px  -> fits 2 rows stacked (56px used)
  live.text:       15px  -> fits 2 rows stacked (56px used)
  live.menu:       15px  -> fits 2 rows stacked (56px used)
  live.gain~:     136px  -> label+ctrl = 158px (3px remaining, tight!)
```

### Pattern 3: Tab Switching via script hide/show
**What:** `live.tab` at top of device outputs tab index. A wiring chain converts tab index to `script show <page_name>` / `script hide <page_name>` messages sent to `thispatcher`. Each tab page is a group of controls sharing a `varname` for scripting. [VERIFIED: Cycling74 forums + thispatcher reference docs]
**When to use:** When controls exceed single-page capacity (D-05).

**Implementation approach:**
```python
# Tab switching wiring pattern (dict-level, not Patcher API)
# 1. Create live.tab with tab names = group names
# 2. For each group's controls, wrap in a panel or use individual scripting
# 3. Wire: live.tab outlet 0 -> select N N N -> messages "script show/hide" -> thispatcher
# 4. Set varname (scripting_name) on each tab-page panel/bpatcher

# Key JSON attributes for tab switching:
# live.tab box: {"maxclass": "live.tab", "num_lines_patching": 1, ...}
# thispatcher: {"maxclass": "thispatcher"}
# Panel with scripting name: {"maxclass": "panel", "varname": "page_filter", ...}
# Message: {"maxclass": "message", "text": "script show page_filter"}
```

**Two approaches for tab page containers:** [ASSUMED]
1. **Individual control hiding:** Set `varname` on each control, hide/show individually per tab. Simpler but more messages.
2. **Panel grouping:** Wrap each tab's controls in a panel with a single `varname`, hide/show the panel. Cleaner but panels need to be in presentation mode.

Recommendation: Use individual control hiding for simplicity -- each control already needs a unique `varname` for M4L parameters. Group them by adding a prefix: `page_filter_cutoff`, `page_amp_volume`.

**Alternative approach (simpler, recommended):** Rather than generating the full wiring chain in the layout engine, the layout engine can use the `hidden` box attribute directly. Set `"hidden": 1` on inactive tab page controls at save time, and document that tab switching requires the `live.tab` -> `thispatcher` -> `script hide/show` wiring. The wiring can be generated as part of the layout, or left for the agent to wire manually.

### Pattern 4: Overlay Readouts
**What:** `live.numbox` or `flonum` overlaid on `live.dial` at same position, with `ignoreclick=1` so the dial remains interactive. Already documented in CLAUDE.md Rule #6. [VERIFIED: CLAUDE.md Rule #6]
**When to use:** When a readout value display is desired on top of a dial/slider (D-06a).
**Example:**
```python
# Overlay pattern in dict form:
# 1. live.dial with presentation_rect = [x, y, 44, 66]
# 2. live.numbox with presentation_rect = [x, y+50, 44, 15], ignoreclick=1
# Z-order: numbox earlier in boxes array = renders on top
```

### Anti-Patterns to Avoid
- **Scaling control dimensions:** Live controls have fixed sizes. Never scale a live.dial to 30x45 -- it will render incorrectly. Always use exact sizes from `sizing.UI_SIZES`. [VERIFIED: D-08, sizing.py]
- **Fractional pixel coordinates:** Causes blurry rendering on non-retina displays. Always `int()` round all presentation_rect values. [VERIFIED: Ableton M4L Production Guidelines]
- **Manipulating Patcher objects:** The layout engine works on patch_dict (raw JSON), not Patcher class instances. m4l_polish.py established this pattern. Don't mix levels.
- **Ignoring existing presentation_rect:** D-14 mandates preserving manually-set values. Always filter `controls_needing_layout = [c for c in controls if not c.get("presentation_rect")]`.
- **Hard-coding group order:** Use a priority mapping (Pitch -> Filter -> Amp -> Envelope -> Mod -> FX -> Mix -> Main) rather than alphabetical or insertion order. The order should reflect typical synth signal flow.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Parameter grouping | Custom keyword matching | `m4l_polish._classify_parameter()` | D-01: single source of truth; already tested |
| Control collection | Manual box iteration | `m4l_polish._collect_live_controls()` | Handles subpatcher recursion, _LIVE_NO_PARAM filtering |
| Control dimensions | Hard-coded size constants | `sizing.UI_SIZES[maxclass]` | Source of truth; auto-updated if sizes change |
| Non-parameter exclusion | Custom filter | `_LIVE_NO_PARAM` from m4l_critic | Already maintained centrally |
| Z-order manipulation | Array splicing | `bring_to_front()` pattern from patcher.py | Only relevant if using Patcher API; for dict-level, insert at index 0 |

**Key insight:** The layout engine is essentially a geometry calculator. It consumes grouping and sizing data from existing modules, then writes `presentation_rect` values into the patch_dict. No new data models, no new dependencies.

## Common Pitfalls

### Pitfall 1: live.gain~ Overflows 169px in Tabbed Layout
**What goes wrong:** `live.gain~` is 136px tall. With tab header (20px + 4px gap) and group label (18px + 4px gap), total is 182px -- exceeds 169px.
**Why it happens:** `live.gain~` is designed to be the full device height; it doesn't fit in a tabbed sub-page.
**How to avoid:** Special-case `live.gain~` and `live.scope~` (131px): these always go on the main page, never inside a tab. Skip the group label for gain -- it IS the group.
**Warning signs:** Any control taller than 100px in a tabbed context.

### Pitfall 2: Hidden Attribute vs Presentation Attribute
**What goes wrong:** Using `"presentation": 0` to hide tab pages resets the control's `presentation_rect`, requiring re-computation when shown again.
**Why it happens:** Toggling `@presentation` attribute resets spatial coordinates in MAX. [VERIFIED: Cycling74 forum "Turning presentation mode off/on resets location"]
**How to avoid:** Use `"hidden": 1` attribute instead, which hides the object without disturbing its presentation_rect. Or use `script hide/show` via thispatcher which also preserves coordinates.
**Warning signs:** Controls appearing at wrong positions after tab switching.

### Pitfall 3: varname Collision Between Layout and Polish
**What goes wrong:** m4l_polish.py sets `varname` for parameter naming. Layout engine needs `varname` for scripting names on tab pages/panels. They collide.
**Why it happens:** `varname` serves dual purpose: parameter scripting name AND thispatcher scripting name.
**How to avoid:** For live.* controls that already have `varname` from polish, the scripting name is already set. For non-parameter objects (panels, bpatchers used as tab containers), use a different naming convention: `_layout_page_filter`, `_layout_page_amp` (prefix with `_layout_`).
**Warning signs:** `thispatcher` failing to find objects by scripting name.

### Pitfall 4: Forgetting devicewidth Auto-Expansion
**What goes wrong:** Controls placed beyond the default 300px devicewidth are invisible/clipped in Ableton.
**Why it happens:** Layout computes positions but doesn't update `devicewidth` in patcher props.
**How to avoid:** After positioning all groups, compute `max_x + rightmost_control_width + right_margin` and update `patcher.get("patcher", {})["devicewidth"]` to at least that value. [VERIFIED: D-11]
**Warning signs:** Rightmost controls not visible in Ableton Live.

### Pitfall 5: Round-Trip Extra Attrs Not Applied
**What goes wrong:** Setting `box.extra_attrs["varname"] = ...` on a round-tripped Box (loaded from file) has no effect because the round-trip serialization path in `patcher.py` ignores `extra_attrs`.
**Why it happens:** `to_dict()` round-trip path starts from `_raw` dict and only overlays specific fields. `extra_attrs` only merge in the creation path.
**How to avoid:** The layout engine operates on raw patch_dict (JSON dicts), NOT on Patcher/Box objects. Set `box_dict["varname"] = ...` directly on the dict. This is the same approach m4l_polish.py uses.
**Warning signs:** Attributes set via extra_attrs disappearing after save.

### Pitfall 6: live.tab "Live Mode" for Pixel Snapping
**What goes wrong:** `live.tab` renders with fuzzy edges on non-retina displays.
**Why it happens:** Default `live.tab` doesn't snap to pixel grid.
**How to avoid:** Set `"livemode": 1` on live.tab objects. [VERIFIED: Ableton M4L Production Guidelines recommend "Live mode" for live.tab]
**Warning signs:** Blurry tab labels in Live.

## Code Examples

### Collecting and Grouping Controls
```python
# Source: m4l_polish.py (verified from codebase)
from src.maxpat.m4l_polish import _collect_live_controls, _classify_parameter

patcher = patch_dict.get("patcher", {})
boxes = patcher.get("boxes", [])
controls = _collect_live_controls(boxes)

# Group controls by semantic function
groups: dict[str, list[dict]] = {}
for box in controls:
    saa = box.get("saved_attribute_attributes", {})
    valueof = saa.get("valueof", {})
    longname = valueof.get("parameter_longname", "")
    if not longname:
        continue
    group = _classify_parameter(longname)
    groups.setdefault(group, []).append(box)
```

### Setting Presentation Rect (Whole Pixels)
```python
# Source: D-10 whole-pixel enforcement
def _set_pres_rect(box: dict, x: float, y: float, w: float, h: float) -> None:
    """Set presentation_rect with whole-pixel enforcement."""
    box["presentation"] = 1
    box["presentation_rect"] = [int(x), int(y), int(w), int(h)]
```

### Adding a Group Label (live.comment)
```python
# Source: D-02, sizing.py (verified)
def _add_group_label(boxes: list, name: str, x: int, y: int) -> dict:
    """Add a live.comment group header label."""
    label = {
        "box": {
            "maxclass": "live.comment",
            "id": f"obj-layout-label-{name.lower()}",
            "numinlets": 1,
            "numoutlets": 0,
            "text": name,
            "patching_rect": [x, y, 150, 18],
            "presentation": 1,
            "presentation_rect": [x, y, 150, 18],
            "textjustification": 0,  # left-aligned
        }
    }
    boxes.append(label)
    return label
```

### Tab Switching Wiring (Script Hide/Show)
```python
# Source: Cycling74 docs + forums (verified pattern)
# thispatcher + scripting_name (varname) pattern for tab switching
# This shows the JSON structure, not Patcher API

# 1. live.tab at top of device
tab_box = {
    "box": {
        "maxclass": "live.tab",
        "id": "obj-layout-tab",
        "numinlets": 1,
        "numoutlets": 3,
        "outlettype": ["", "", "float"],
        "patching_rect": [20, 20, 200, 20],
        "presentation": 1,
        "presentation_rect": [4, 4, 200, 20],
        "livemode": 1,  # Pixel snapping per production guidelines
        "num_lines_patching": 1,
        "num_lines_presentation": 1,
        "parameter_enable": 1,
        "saved_attribute_attributes": {
            "valueof": {
                "parameter_longname": "Page",
                "parameter_shortname": "Page",
                "parameter_type": 2,  # ENUM
                "parameter_enum": ["Filter", "Amp", "FX"],
            }
        },
    }
}

# 2. thispatcher receives script commands
thispatcher_box = {
    "box": {
        "maxclass": "thispatcher",
        "id": "obj-layout-thispatcher",
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", ""],
        "patching_rect": [20, 100, 100, 22],
    }
}

# 3. Each tab page's controls get varname for scripting
# e.g., a panel wrapping a group's controls:
# {"box": {..., "varname": "_layout_page_filter", "hidden": 1, ...}}
#
# Messages wired: "script show _layout_page_filter, script hide _layout_page_amp"
```

### Control Dimension Lookup
```python
# Source: sizing.py (verified from codebase)
from src.maxpat.sizing import UI_SIZES

def _get_control_size(maxclass: str) -> tuple[int, int]:
    """Get (width, height) for a live.* control."""
    size = UI_SIZES.get(maxclass)
    if size is None:
        return (100, 22)  # text-based fallback
    return (int(size[0]), int(size[1]))
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| 4-per-row grid layout | Semantic column packing | This phase | Controls grouped by function instead of arbitrary grid |
| No M4L-specific layout | Dedicated m4l_layout.py | This phase | 169px height constraint properly handled |
| Manual presentation_rect | Auto-computed from grouping + sizing | This phase | Consistent professional-looking device layouts |
| Patcher inspector tabs | live.tab + script hide/show | Standard M4L practice | More control over tab appearance and behavior |

**Deprecated/outdated:**
- `_apply_presentation_layout()` grid fallback in layout.py: Still needed for non-M4L patches, but M4L devices should delegate to m4l_layout.py

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | Individual control hiding via varname is simpler than panel wrapping for tab pages | Architecture Patterns, Pattern 3 | If panel approach is needed, implementation changes but API stays same |
| A2 | Group ordering priority (Pitch -> Filter -> Amp -> Envelope -> Mod -> FX -> Mix -> Main) reflects typical synth signal flow | Anti-Patterns | If wrong order, trivial to change priority dict |
| A3 | `_layout_` prefix prevents varname collision with parameter scripting names | Pitfall 3 | If collision, change prefix convention |
| A4 | live.tab `num_lines_patching` and `num_lines_presentation` attributes exist for controlling tab row count | Code Examples | If attributes don't exist, tab sizing may need different approach |
| A5 | `"hidden": 1` attribute works in M4L presentation mode to hide controls without affecting their presentation_rect | Pitfall 2 | If hidden doesn't work in presentation, need script hide/show approach at save time |

## Open Questions

1. **Exact tab threshold constants**
   - What we know: D-05 says >8 controls per group OR total exceeds what fits
   - What's unclear: Exact devicewidth threshold for tab trigger
   - Recommendation: Start with 8+ total controls OR >3 groups as tab trigger. Tune after testing with real devices.

2. **Popup panel implementation**
   - What we know: D-06b mentions hidden panels that slide over device
   - What's unclear: Exact mechanism for "slide over" in M4L (animation? instant show?)
   - Recommendation: Start with instant show/hide via `hidden` attribute. Slide animation is cosmetic polish, not functional.

3. **Group ordering validation**
   - What we know: ROADMAP.md flags "layout heuristics need validation against 3-5 real devices"
   - What's unclear: Whether the assumed group order matches commercial devices
   - Recommendation: Build the engine with configurable group priority. Validate against real devices after implementation.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml or pytest.ini (existing) |
| Quick run command | `python3 -m pytest tests/test_m4l_layout.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements -> Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| LAYOUT-01 | Groups controls by function within 169px | unit | `python3 -m pytest tests/test_m4l_layout.py::TestGroupLayout -x` | Wave 0 |
| LAYOUT-01 | Each group is a vertical column with label | unit | `python3 -m pytest tests/test_m4l_layout.py::TestColumnPacking -x` | Wave 0 |
| LAYOUT-01 | devicewidth auto-expands | unit | `python3 -m pytest tests/test_m4l_layout.py::TestDeviceWidth -x` | Wave 0 |
| LAYOUT-02 | Single-page layout for small control counts | unit | `python3 -m pytest tests/test_m4l_layout.py::TestSinglePage -x` | Wave 0 |
| LAYOUT-02 | Tabbed layout when controls exceed threshold | unit | `python3 -m pytest tests/test_m4l_layout.py::TestTabbedLayout -x` | Wave 0 |
| LAYOUT-02 | Overlay readout pattern | unit | `python3 -m pytest tests/test_m4l_layout.py::TestOverlay -x` | Wave 0 |
| LAYOUT-03 | All coordinates are whole integers | unit | `python3 -m pytest tests/test_m4l_layout.py::TestWholePixels -x` | Wave 0 |
| LAYOUT-03 | Preserves existing presentation_rect (D-14) | unit | `python3 -m pytest tests/test_m4l_layout.py::TestPreserveExisting -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_m4l_layout.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd-verify-work`

### Wave 0 Gaps
- [ ] `tests/test_m4l_layout.py` -- all layout tests (file does not exist yet)
- [ ] Test helpers: `_make_m4l_patch()` fixture creating minimal M4L patch_dict with live.* controls

## Security Domain

Security enforcement is not applicable to this phase. This is a pure layout computation module operating on in-memory Python dicts. No user input, no network, no file I/O beyond the existing patch pipeline. No ASVS categories apply.

## Sources

### Primary (HIGH confidence)
- `src/maxpat/sizing.py` -- all live.* control dimensions verified from codebase
- `src/maxpat/m4l_polish.py` -- _classify_parameter, _collect_live_controls verified from codebase
- `src/maxpat/patcher.py` -- Box.presentation, Box.presentation_rect, extra_attrs behavior verified from codebase
- `src/maxpat/m4l_export.py` -- standalone module pattern verified from codebase
- [Cycling74 M4L User Interfaces docs](https://docs.cycling74.com/userguide/m4l/live_userinterfaces/) -- 169px height constraint confirmed
- [Ableton M4L Production Guidelines](https://github.com/Ableton/maxdevtools/blob/main/m4l-production-guidelines/m4l-production-guidelines.md) -- whole-pixel requirement, Live mode for live.tab, Ableton Sans font, fold-out/tabbed/overlay patterns

### Secondary (MEDIUM confidence)
- [Cycling74 forums: Show/Hide a BPatcher](https://cycling74.com/forums/showhide-a-bpatcher) -- script hide/show + scripting_name pattern
- [Cycling74 forums: hide/show objects in presentation mode](https://cycling74.com/forums/hideshow-objects-dynamically-in-presentation-mode) -- hidden attribute vs @presentation toggle
- [Cycling74 forums: using tabs inside M4L device](https://cycling74.com/forums/using-tabs-inside-a-max4live-device) -- patcher inspector tab approach (not recommended for production)
- [Cycling74 live.tab reference](https://docs.cycling74.com/reference/live.tab) -- live.tab attributes including livemode

### Tertiary (LOW confidence)
- Tab page container approach (individual vs panel wrapping) -- based on training knowledge, not verified with commercial device inspection [ASSUMED]

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all internal modules, verified from codebase
- Architecture: HIGH -- follows established m4l_polish.py/m4l_export.py patterns
- Layout math: HIGH -- computed directly from sizing.py constants
- Tab switching mechanism: MEDIUM -- verified from multiple Cycling74 sources but not tested in M4L context
- Pitfalls: HIGH -- identified from codebase inspection and official docs

**Research date:** 2026-04-07
**Valid until:** 2026-05-07 (stable domain, no external deps to go stale)
