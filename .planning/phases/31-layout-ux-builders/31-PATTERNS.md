# Phase 31: Layout & UX Builders — Pattern Mapping

**Mapped:** 2026-04-30
**Phase directory:** .planning/phases/31-layout-ux-builders/

For each NEW or MODIFIED file in Phase 31, the closest existing analog in the
codebase, the pattern excerpt the planner should mirror, and any caveats.

---

## File 1: `src/maxpat/patcher.py` — `add_overlay_readout()` (NEW, LAYOUT-01)

**Role:** Factory builder method on `Patcher` that creates a flonum/comment/number
overlay sized to a target's `patching_rect`, bakes `ignoreclick=1` (unless
`editable=True`), and unconditionally calls `bring_to_front()` so it renders on top.

**Closest analogs:**
1. `add_panel` (`src/maxpat/patcher.py:570`) — baked `extra_attrs` defaults +
   z-order via `boxes.insert(0, panel)`.
2. `bring_to_front` (`src/maxpat/patcher.py:688`) — z-order primitive
   `add_overlay_readout` calls after construction.

### Pattern excerpt — `add_panel` (signature + baked-attrs + z-order)

```python
# src/maxpat/patcher.py:570-637
def add_panel(self, x, y, width, height, gradient=True) -> Box:
    panel = Box.__new__(Box)
    panel.name = "panel"
    # ... 14 lines manually populating every Box attribute ...
    panel.extra_attrs = {
        "background": 1,
        "ignoreclick": 1,
        "border": 0,
        "rounded": 7,
        "mode": 0,
    }
    if gradient:
        panel.extra_attrs["bgfillcolor"] = {...}
    self.boxes.insert(0, panel)   # z-order via insert position
    return panel
```

### Pattern excerpt — `bring_to_front` (the z-order call)

```python
# src/maxpat/patcher.py:688-704
def bring_to_front(self, box: Box) -> None:
    try:
        self.boxes.remove(box)
    except ValueError:
        raise ValueError(f"Box {box.id!r} not in this patcher")
    self.boxes.insert(0, box)
```

### Caveats

- **Prefer `self.add_box(type, ...)` over `Box.__new__(Box)`.** `flonum`, `number`,
  and `comment` are in the DB and in `UI_MAXCLASSES` (per RESEARCH risk #1). Going
  through `add_box` gets DB validation, overlap-avoidance nudge, and id generation
  for free. Pass `skip_overlap_check=True` when the overlay is meant to overlap.
- **`bring_to_front` raises `ValueError` if the box isn't yet in `self.boxes`.**
  Order: (1) `add_box` first, (2) set position/extra_attrs, (3) `bring_to_front`
  last. RESEARCH Pitfall 2 documents this trap.
- **Copy `target.patching_rect` before mutating.** `list(target.patching_rect)` —
  list assignment aliases the same list (RESEARCH Pitfall 1).
- `add_panel` writes through `self.boxes.insert(0, panel)`, NOT `add_box`. The
  new builder should use `add_box` then `bring_to_front` — equivalent end state
  but goes through validation.

---

## File 2: `src/maxpat/patcher.py` — `add_labeled_param_bank()` (NEW, LAYOUT-02)

**Role:** Factory builder that creates a `multislider` with size = len(params),
height = size×24, baked `orientation=0`, `contdata=1`, `setstyle=1`, `setminmax`
envelope across params, plus per-bar comment labels left of the multislider.
Returns `(multislider, list[comment])`.

**Closest analogs:**
1. `add_step_marker` (`src/maxpat/patcher.py:639`) — closest match for builders
   that bake multiple `extra_attrs` (rounded corners, custom colors, custom text).
2. `add_panel` (`src/maxpat/patcher.py:570`) — same pattern for `extra_attrs={}`
   defaults baked at construction.

### Pattern excerpt — `add_step_marker` (baked extra_attrs with custom values)

```python
# src/maxpat/patcher.py:639-686
def add_step_marker(self, number: int, x: float, y: float) -> Box:
    marker = Box.__new__(Box)
    marker.name = "textbutton"
    # ... manual Box population ...
    marker.patching_rect = [x, y, 24.0, 24.0]
    marker.extra_attrs = {
        "background": 1,
        "ignoreclick": 1,
        "rounded": 60.0,
        "text": str(number),
        "textcolor": list(AESTHETIC_PALETTE["step_marker_text"]),
        "bgcolor": list(AESTHETIC_PALETTE["step_marker_bg"]),
        "fontface": FONTFACE_BOLD,
        "parameter_enable": 0,
    }
    self.boxes.insert(0, marker)   # background z-order
    return marker
```

### Caveats

- **`multislider` is in `UI_MAXCLASSES` and the DB.** Use `add_box("multislider", ...)`
  rather than `Box.__new__`. Set `patching_rect[3] = size * 24` and
  `extra_attrs["size"] = len(params)` after construction.
- **`extra_attrs` deep-merge order:** baked defaults FIRST, then merge caller's
  `extra_attrs={}` over them. Caller wins on collisions. RESEARCH Pattern 1.
- **Comment labels should use `add_comment(text, x, y)`** (`patcher.py:446`) —
  it already calls `calculate_box_size()` and yields the standard widget.
- **D-09 locks the return shape:** `(multislider, list[comment])`. No prepend/route
  chain. Caller wires `fetch $1` → multislider input themselves and reads from
  outlet 1 (per memory `feedback_multislider_fetch.md`).
- **`setminmax` envelope only.** `[min(all_mins), max(all_maxes)]` — multislider
  does NOT support per-bar ranges via attrs (RESEARCH Pitfall 5).
- **Label y-formula:** `ms.y + i * 24` — matches CLAUDE.md fontsize=10 spacing.

---

## File 3: `src/maxpat/layout.py` — `_ROLE_COMPANION_MAP` + modified
`_identify_companions()` (NEW + MODIFIED, LAYOUT-03)

**Role:** Module-level dict constant placed next to `_COMPANION_NAMES`. The
existing `_identify_companions` is extended to take a `db` parameter, dispatch
on role first via `_ROLE_COMPANION_MAP`, and fall through to the legacy heuristic
when role is `None`.

**Closest analogs:**
1. `_COMPANION_NAMES` (`src/maxpat/layout.py:50`) — exact dict shape and module
   placement the new constant mirrors.
2. `_identify_companions` (`src/maxpat/layout.py:568`) — dispatch hook to extend.
3. `_place_companions` (`src/maxpat/layout.py:606`) — placement consumer; should
   keep working unchanged once the role-driven map points to the same `parent`
   relationship the legacy path produces.

### Pattern excerpt — `_COMPANION_NAMES` (dict shape and placement)

```python
# src/maxpat/layout.py:49-55
# Companion objects placed beside their parent (monitoring/display sinks)
_COMPANION_NAMES = frozenset({
    "meter~", "levelmeter~", "scope~", "number~", "spectroscope~",
})

# Gap between a parent and its companion object placed beside it
_COMPANION_GAP = 5.0
```

### Pattern excerpt — `_identify_companions` (the dispatch hook)

```python
# src/maxpat/layout.py:568-603
def _identify_companions(
    boxes: list[Box],
    lines: list,
    rows: list[list[Box]],
) -> dict[str, Box]:
    box_map = {b.id: b for b in boxes}
    comp_ids = {b.id for b in boxes}
    incoming: dict[str, list[str]] = {}
    outgoing: dict[str, int] = {}
    for line in lines:
        if line.source_id in comp_ids and line.dest_id in comp_ids:
            incoming.setdefault(line.dest_id, []).append(line.source_id)
            outgoing[line.source_id] = outgoing.get(line.source_id, 0) + 1

    result: dict[str, Box] = {}
    for box in boxes:
        if box.name not in _COMPANION_NAMES:    # <-- legacy filter; role check goes BEFORE this
            continue
        parents = incoming.get(box.id, [])
        if len(parents) != 1:
            continue
        parent = box_map.get(parents[0])
        if parent is not None:
            result[box.id] = parent
    return result
```

### Caveats

- **Signature change is the load-bearing diff.** `_identify_companions` currently
  takes `(boxes, lines, rows)`; LAYOUT-03 adds `db: ObjectDatabase | None`. Every
  caller in `apply_layout` (and the recursive subpatcher pass) must pass `db`
  through. RESEARCH Pitfall 3 documents the recursion.
- **Role lookup is per-outlet, not per-box.** `db.get_signal_role(name, outlet_id)`
  takes an outlet index; the dispatch must iterate `range(box.numoutlets)` to
  find the role-implying outlet (per RESEARCH Pattern 4).
- **`None` falls through to legacy `_COMPANION_NAMES`** — D-13 locked. Don't
  replace the heuristic, augment it.
- **`_place_companions` already places the companion to the right of the parent
  with `_COMPANION_GAP`** — the role map's `placement: "right"` for `audio`
  reuses this code path. `placement: "overlay"` for `status` is the new branch
  that calls the LAYOUT-01 overlay logic (z-order + rect copy).
- **Phase 30 only role-stamped MSP/MC outlets.** Tests should target
  `cycle~ → gain~ → meter~` (audio role) — not `live.dial` (no role coverage,
  falls through). RESEARCH Pitfall 8.

---

## File 4: `src/maxpat/patcher.py` — `add_m4l_gen_synth()` (NEW, LAYOUT-04)

**Role:** Build a minimum-viable M4L device skeleton: a `gen~` with stable
`varname`, one `live.dial` per param with full `param_connect` +
`saved_attribute_attributes.valueof` block, and a `plugout~` directly connected
to gen~'s outlet. NO `gain~`/`live.gain~`/`ezdac~` between gen~ and plugout~.
Returns `(gen_obj, live_dials, plugout_obj)`.

**Closest analogs:**
1. `add_gen` (`src/maxpat/patcher.py:1742`) — gen~ skeleton creation; auto-detects
   I/O, runs `validate_genexpr`, reorders declarations. **Reuse this; don't
   re-implement.**
2. `ensure_parameter_enable` (`src/maxpat/m4l_polish.py:149`) — the polish pass
   the skeleton must be compatible with (parameter_enable + valueof block).
3. `polish_m4l_device` (`src/maxpat/m4l_polish.py:495`) — the composer the caller
   runs after `to_dict()`; the skeleton should be polish-ready.

### Pattern excerpt — `add_gen` (signature + delegation + return tuple)

```python
# src/maxpat/patcher.py:1742-1795
def add_gen(
    self,
    code: str,
    num_inputs: int | None = None,
    num_outputs: int | None = None,
    x: float = 0.0,
    y: float = 0.0,
) -> tuple[Box, "Patcher"]:
    """Add a gen~ object with embedded codebox.

    Creates a parent gen~ box with an inner Gen patcher containing
    in objects, a codebox with GenExpr code, out objects, and
    patchlines connecting in -> codebox -> out.

    Returns:
        (parent_box, inner_patcher) tuple.
    """
    from src.maxpat.codegen import parse_genexpr_io, reorder_genexpr_declarations
    code = reorder_genexpr_declarations(code)
    if num_inputs is None or num_outputs is None:
        detected_in, detected_out = parse_genexpr_io(code)
        # ...
    box_id = self._gen_id()
    inner = Patcher(db=self.db, is_subpatcher=True, ...)
    # ... build inner patcher (in -> codebox -> out) ...
```

### Pattern excerpt — `ensure_parameter_enable` (the valueof shape)

```python
# src/maxpat/m4l_polish.py:149-171
def ensure_parameter_enable(patch_dict: dict) -> dict:
    """Set parameter_enable=1 and saved_attribute_attributes on live.* controls.

    Fills gaps only -- never overrides existing values (D-05).
    """
    patcher = patch_dict.get("patcher", {})
    boxes = patcher.get("boxes", [])
    controls = _collect_live_controls(boxes)

    for box in controls:
        if not box.get("parameter_enable"):
            box["parameter_enable"] = 1
        saa = box.setdefault("saved_attribute_attributes", {})
        valueof = saa.setdefault("valueof", {})
        valueof.setdefault("parameter_type", int(ParamType.FLOAT))
        valueof.setdefault("parameter_unitstyle", int(UnitStyle.FLOAT))
    return patch_dict
```

### Pattern excerpt — `polish_m4l_device` (composition order)

```python
# src/maxpat/m4l_polish.py:495-515
def polish_m4l_device(patch_dict: dict) -> dict:
    """Apply full M4L polish pipeline to a device patch.
    Composes all five polish passes in correct order:
    1. ensure_parameter_enable -- sets parameter_enable=1 + saa defaults
    2. ensure_m4l_prefixes -- adds --- prefix to named objects
    3. derive_parameter_names -- fills longname/shortname/varname gaps
    4. organize_push_banks -- groups params into semantic Push banks
    5. populate_info_text -- sets annotation/annotation_name
    """
    ensure_parameter_enable(patch_dict)
    ensure_m4l_prefixes(patch_dict)
    derive_parameter_names(patch_dict)
    organize_push_banks(patch_dict)
```

### Caveats

- **`ensure_parameter_enable` and `polish_m4l_device` operate on `patch_dict`
  (post-`to_dict()`), NOT on `Patcher`/`Box`.** Don't call them from inside
  `add_m4l_gen_synth` — that's a layering violation. Caller invokes
  `polish_m4l_device(patcher.to_dict())` separately. RESEARCH risk #3.
- **`gen~` requires a stable `varname`** that matches the prefix in
  `live.dial`'s `param_connect: "<varname>::<param_name>"`. Default
  `gen_varname='synth'` per D-15. Document varname collision risk if caller
  creates two skeletons in one patcher (RESEARCH Pitfall 7).
- **`add_gen` returns `(parent_box, inner_patcher)`** — `add_m4l_gen_synth`
  needs to set the gen~'s `varname` on the parent_box (`gen_box.extra_attrs["varname"] = gen_varname`)
  AND ensure the inner patcher exposes a signal output. Skeleton may pass an
  empty/no-op codebox body since D-15 says "no DSP body".
- **`live.dial` is in `UI_MAXCLASSES` and the DB.** Use `add_box("live.dial", ...)`,
  then set `extra_attrs["param_connect"]` (RESEARCH Pitfall 4 — verify with
  round-trip that it surfaces as a top-level field; `to_dict()` flattens
  `extra_attrs` last).
- **NO `gain~`/`ezdac~` between gen~ and `plugout~`.** CLAUDE.md M4L rule. Direct
  `add_connection(gen_box, 0, plugout_box, 0)`.
- **`plugout~` is NOT in `UI_MAXCLASSES`** — uses `maxclass: "newobj"` with
  `text: "plugout~"`. `add_box("plugout~")` handles this via `resolve_maxclass`.
- **`saved_attribute_attributes.valueof` block needs:** `parameter_initial`,
  `parameter_initial_enable`, `parameter_longname`, `parameter_mmax`
  (`parameter_mmin` omitted when 0), `parameter_modmode=3` (ABSOLUTE),
  `parameter_shortname`, `parameter_type=1` (FLOAT), `parameter_unitstyle=1` (FLOAT).
  Verified shape from `bassoon-model.maxpat:43-225` per RESEARCH Pattern 5.

---

## File 5: `.claude/skills/max-patch-agent/SKILL.md` and
`.claude/skills/max-ui-agent/SKILL.md` — "Builder API" section
(MODIFIED, LAYOUT-05)

**Role:** Documentation update. Each SKILL.md gets a new "Builder API" section
listing the four builders, signatures, kwargs, and "when to call each" guidance.
CLAUDE.md gets a brief pointer + recipe-removal note (D-02).

**Closest analog:** No code analog — these are markdown additions to existing
agent definition files. Reference patterns come from:

- The existing "Capabilities" sections of both SKILL.md files (244 LOC and 139 LOC
  respectively, per RESEARCH).
- The CLAUDE.md prose recipes the builders codify:
  - "Rule #6: Z-Order Awareness" (overlay readout recipe → LAYOUT-01)
  - "Multislider as Labeled Parameter Bank" (→ LAYOUT-02)
  - "Domain-Specific Rules → Max for Live (M4L)" (`param_connect`, no `gain~`
    before `plugout~` → LAYOUT-04)

### Caveats

- **Both SKILL.md files get the same "Builder API" section verbatim** — single
  source of truth, copy-paste once. Skills differ in their existing content but
  the builder reference is identical for both agents.
- **CLAUDE.md edit is small:** add a pointer near the existing recipe sections
  noting "this recipe is now codified as `Patcher.<builder_name>(...)`". Do NOT
  delete the prose recipes wholesale (they are still useful narrative).
- **No auto-generated reference doc.** D-02 explicitly defers
  `.planning/codebase/builders.md`. Markdown insertion only.

---

## File 6: `tests/test_overlay_readout.py` (NEW, D-16)

**Role:** Unit tests for `add_overlay_readout`: shape of returned box,
`bring_to_front` index 0, `ignoreclick` value, format string baked,
`editable=True` flips ignoreclick, all three `type=` variants.

**Closest analogs:**
1. `tests/test_schema_extensions.py:108` — class-based pytest pattern
   (`class TestSchemaValidation:` + parametrize).
2. `tests/test_layout.py:25` — class-based pytest with `Patcher`/`Box` import
   precedent.

### Pattern excerpt — `tests/test_layout.py` (Patcher/Box test setup)

```python
# tests/test_layout.py:1-40
import pytest
from src.maxpat.patcher import Patcher, Box
from src.maxpat.layout import apply_layout
from src.maxpat.defaults import V_SPACING, H_GUTTER, LayoutOptions


class TestRowAssignment:
    """Test that topological sort assigns objects to correct rows."""

    def test_linear_chain_y_increases(self):
        """Linear chain A -> B -> C: y increases at each stage."""
        p = Patcher()
        a = p.add_box("cycle~", ["440"])
        b = p.add_box("*~", ["0.5"])
        c = p.add_box("ezdac~")
        p.add_connection(a, 0, b, 0)
        p.add_connection(b, 0, c, 0)

        apply_layout(p)

        assert a.patching_rect[1] < b.patching_rect[1]
```

### Pattern excerpt — `tests/test_schema_extensions.py` (class structure)

```python
# tests/test_schema_extensions.py:108-135
class TestSchemaValidation:
    """Plan 01 fail-fast behavior: validator rejects each malformed value
    at load time, naming the offending object and field in the error.
    """

    def test_unknown_signal_role_raises(self, tmp_path):
        """Unknown signal_role enum value raises ValueError naming object + field."""
        # ...

    @pytest.mark.parametrize("role", sorted(_SIGNAL_ROLE_ENUM))
    def test_each_known_signal_role_accepted(self, tmp_path, role):
        """All six values in _SIGNAL_ROLE_ENUM are accepted by the validator."""
        # ...
```

### Caveats

- **Class-based pattern, not module-level functions.** Mirror
  `class TestOverlayReadout:` with one method per assertion (returned-shape,
  z-order, ignoreclick, format, editable opt-out, type variants).
- **Use `Patcher()` directly with no fixtures** — the `add_box` route loads its
  own `ObjectDatabase` lazily, no extra setup required.
- **z-order assertion:** check `p.boxes[0] is readout` after `add_overlay_readout`
  (or `p.boxes.index(readout) == 0`).

---

## File 7: `tests/test_labeled_param_bank.py` (NEW, D-16)

**Role:** Unit tests for `add_labeled_param_bank`: returned `(ms, list[comment])`
shape, locked attrs (`size`, `height = size*24`, `orientation=0`, `contdata=1`,
`setstyle=1`), label x/y alignment formula, `setminmax` envelope across params,
`extra_attrs` deep-merge.

**Closest analog:** Same as File 6 — class-based pytest pattern from
`tests/test_layout.py:25` and `tests/test_schema_extensions.py:108`.

### Caveats

- **Test the deep-merge by passing a colliding `extra_attrs={'contdata': 0}`** —
  caller value should win (D-10 locks deep-merge order).
- **Label y assertion:** `comments[i].patching_rect[1] == ms.patching_rect[1] + i * 24`
  for each i.
- **`setminmax` envelope assertion:** `params=[("a", 0, 1), ("b", -5, 5)]` →
  `ms.extra_attrs["setminmax"] == [-5, 5]`.

---

## File 8: `tests/test_m4l_gen_synth.py` (NEW, D-16)

**Role:** Unit tests for `add_m4l_gen_synth`: gen~ has `varname`; each
`live.dial` has matching `param_connect` and full `saved_attribute_attributes.valueof`;
plugout~ wired directly to gen~ (no `gain~` in path); `ensure_parameter_enable`
invariants hold after `to_dict()` round-trip.

**Closest analog:** Same as File 6 — class-based pytest pattern.

### Caveats

- **Assert via `to_dict()` round-trip** for `param_connect` — RESEARCH Pitfall 4.
  `patch_dict["patcher"]["boxes"][i]["box"]["param_connect"]` must be at the top
  level, not nested.
- **Assert no `gain~` between gen~ and plugout~** — iterate `p.lines`, find the
  cable from gen~, assert dest is plugout~.
- **Check `ensure_parameter_enable`-readiness** by running it on `to_dict()` and
  asserting it doesn't change `parameter_enable` (already 1) — i.e., the skeleton
  is already polish-compliant.

---

## File 9: `tests/test_companion_role_layout.py` (NEW integration test, D-16)

**Role:** Integration test for role-driven companion placement on a representative
MSP patch using Phase 30's curated `signal_role` data.

**Closest analog:** `tests/test_layout.py:25` (full `Patcher` + `apply_layout` flow).

### Pattern excerpt — `tests/test_layout.py` integration shape

```python
# tests/test_layout.py:28-40
def test_linear_chain_y_increases(self):
    """Linear chain A -> B -> C: y increases at each stage."""
    p = Patcher()
    a = p.add_box("cycle~", ["440"])
    b = p.add_box("*~", ["0.5"])
    c = p.add_box("ezdac~")
    p.add_connection(a, 0, b, 0)
    p.add_connection(b, 0, c, 0)

    apply_layout(p)

    assert a.patching_rect[1] < b.patching_rect[1]
```

### Caveats

- **Build with role-stamped objects:** `cycle~ → gain~ → meter~`. `cycle~`
  outlet 0 is `audio` per Phase 30 curation; `meter~` is the canonical
  `audio→meter~ right` companion in `_ROLE_COMPANION_MAP`.
- **Assert role path was hit, not heuristic.** Add an assertion that
  `meter~` is to the right of `gain~` AND that the placement happens BEFORE
  `_COMPANION_NAMES` would have caught it (e.g., test with a non-`_COMPANION_NAMES`
  companion type that the role map adds — `flonum` for `status` outlets).
- **Test fall-through:** build a chain whose source has no role-stamping
  (look up an unaudited object), assert legacy `_COMPANION_NAMES` heuristic
  still places `meter~`. RESEARCH Pitfall 8.
- **Test subpatcher recursion:** put the chain inside `add_subpatcher`, assert
  companion placement still fires (RESEARCH Pitfall 3).

---

## Summary: New API Surface vs Existing Patterns

| New deliverable                          | Mirrors                                       | New LOC est. | Key trap                                          |
|------------------------------------------|-----------------------------------------------|--------------|---------------------------------------------------|
| `add_overlay_readout`                    | `add_panel` baked-attrs + `bring_to_front`    | ~40          | Copy `target.patching_rect` (Pitfall 1)           |
| `add_labeled_param_bank`                 | `add_step_marker` baked-attrs                 | ~60          | `setminmax` is envelope only (Pitfall 5)          |
| `_ROLE_COMPANION_MAP` + `_identify_companions` extension | `_COMPANION_NAMES` + role-first dispatch | ~30 | Pass `db` through subpatcher recursion (Pitfall 3) |
| `add_m4l_gen_synth`                      | `add_gen` + `ensure_parameter_enable` shape   | ~120         | `param_connect` top-level via `extra_attrs` (Pitfall 4) |
| SKILL.md "Builder API" sections          | Existing "Capabilities" prose                 | ~80 markdown | Both files get the same section verbatim          |
| 4 unit + 1 integration test files        | `test_layout.py` + `test_schema_extensions.py` class style | ~250 | Round-trip `to_dict()` for M4L attribute placement |

---

## PATTERN MAPPING COMPLETE

Five new builders/tests + two SKILL.md updates have direct existing analogs in
`patcher.py` (`add_panel`, `add_step_marker`, `bring_to_front`, `add_gen`),
`layout.py` (`_COMPANION_NAMES`, `_identify_companions`, `_place_companions`),
`m4l_polish.py` (`ensure_parameter_enable`, `polish_m4l_device`), and
`tests/test_layout.py` + `tests/test_schema_extensions.py` for class-based test
structure. All four builders are net-new compositions on top of existing
primitives — no new infrastructure required.
