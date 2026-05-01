# Phase 31: Layout & UX Builders - Research

**Researched:** 2026-04-30
**Domain:** MAX/MSP Patcher API extensions — overlay readouts, multislider param banks, role-driven companion placement, M4L gen synth scaffolding
**Confidence:** HIGH

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions

#### Builder Home & Layering (LAYOUT-01..05)
- **D-01:** All four builders live as `Patcher` class methods in `patcher.py`. Single discoverable API (`p.add_overlay_readout`, `p.add_labeled_param_bank`, `p.add_m4l_gen_synth`, plus a passive companion-pair hook in `apply_layout`). The `m4l_gen_synth` body MAY delegate to a helper in `m4l_polish.py` to keep `patcher.py` shorter, but the public entry point is `p.add_m4l_gen_synth(...)`. `patcher.py` growing ~300–500 LOC against the FINDINGS PATCHER-SPLIT goal is explicitly accepted (PATCHER-SPLIT is future-bucket, not Phase 31 scope).
- **D-02:** LAYOUT-05 wired via per-agent SKILL.md updates. `.claude/skills/max-patch-agent/SKILL.md` and `.claude/skills/max-ui-agent/SKILL.md` each get a "Builder API" section listing the four builders, their kwargs, and "when to call each" guidance. CLAUDE.md gets a brief pointer + the canonical recipe-removal note. No auto-generated reference doc this phase.

#### Overlay Readout API (LAYOUT-01)
- **D-03:** `format=` accepts a printf-style string (e.g. `'%.2f'`, `'%.1f Hz'`). Single arg, declarative.
- **D-04:** Default produces a flonum overlay; `type=` kwarg overrides (`'flonum'` default, `'comment'`, `'number'`).
- **D-05:** Auto-overlap target rect by default; `offset_x=`/`offset_y=` for fine-tuning.
- **D-06:** `ignoreclick=1` baked in by default; `editable=True` opts out. `bring_to_front` is unconditional.

#### Labeled Param Bank API (LAYOUT-02)
- **D-07:** `params=[(name, min, max), ...]` — list of `(str, float, float)` tuples.
- **D-08:** Labels left-aligned, vertically centered with each bar (`x = ms.x - label_width - gap`, `y = ms.y + i * 24`). `label_side='left'` is the default.
- **D-09:** Builder returns `(multislider, list[comment])` only — no prepend/route chain.
- **D-10:** Recipe attributes baked in; `extra_attrs={}` deep-merges overrides. Hard-coded: `size=len(params)`, `height=size*24`, `orientation=0`, `contdata=1`, `setstyle=1`, `setminmax` derived from params.

#### Companion-Pair Semantics (LAYOUT-03)
- **D-11:** Lazy: companion placement decided at `apply_layout` time, not at `add_box`. No new boxes auto-created.
- **D-12:** Role→companion mapping = module-level constant in `layout.py` (`_ROLE_COMPANION_MAP`).
- **D-13:** Augment `_COMPANION_NAMES`, don't replace it. Role-driven mapping fires first; on `None` fall through to existing heuristic.
- **D-14:** Conservative role mapping:
  ```python
  _ROLE_COMPANION_MAP = {
      "audio":   {"companion": "meter~", "placement": "right"},
      "status":  {"companion": "flonum", "placement": "overlay"},
      "trigger": {"companion": None,     "placement": None},
      "float":   {"companion": None,     "placement": None},
      "data":    {"companion": None,     "placement": None},
      "list":    {"companion": None,     "placement": None},
  }
  ```

#### M4L Gen Synth Skeleton (LAYOUT-04)
- **D-15:** Minimum-viable skeleton: gen~ + live.dials + plugout~. No DSP body, no MIDI input, no preset chunk. Each `live.dial` gets `param_connect: "<gen~_varname>::<param_name>"` + full `saved_attribute_attributes.valueof` block. gen~ gets a stable `varname` matching the prefix. NO `gain~`/`live.gain~`/`ezdac~` between gen~ and `plugout~`.

#### Tests
- **D-16:** Unit tests per builder + one integration test for companion placement.
  - `tests/test_overlay_readout.py`
  - `tests/test_labeled_param_bank.py`
  - `tests/test_m4l_gen_synth.py`
  - `tests/test_companion_role_layout.py` (integration)

### Claude's Discretion
- Plan boundaries — natural split: 31-01 overlay readout, 31-02 labeled param bank, 31-03 companion-pair logic, 31-04 m4l_gen_synth, 31-05 SKILL.md updates. Planner may bundle 31-01/31-02 if they ship cleanly together. 31-03 should land after 31-01 (overlay readout used by status-role companion path).
- Internal helper placement — m4l_gen_synth body in `patcher.py` or delegated to a helper in `m4l_polish.py`.
- Format-string parsing depth in `add_overlay_readout` — auto-detect unit suffix vs always treat as `flonum.format`.
- Whether `apply_layout` reads `signal_role` per-call or caches at first call.
- Per-bar `setminmax` instead of envelope — locked decision is envelope; per-bar deferred if real cases demand.
- Whether to ship a tiny `examples/` patch — nice-to-have.

### Deferred Ideas (OUT OF SCOPE)
- `Patcher.add_with_companion(name, ...)` explicit eager builder.
- `subpatcher_name=` kwarg on `add_labeled_param_bank` for prepend/route encapsulation.
- `anchor='below'`/`'right'` modes on `add_overlay_readout`.
- `label_side='right'` and `'above'` on `add_labeled_param_bank`.
- Per-bar `setminmax` ranges.
- Per-object `companion_hint` field in `overrides.json` (would breach Phase 28 schema cap).
- Auto-generated `.planning/codebase/builders.md`.
- Richer m4l_gen_synth (preset chunk, MIDI input, polyphony, Push banks).
- `live.dial` parameter banks via `polish_m4l_device` Push-banking pass.
- Splitting `patcher.py` into `builders/` submodule (PATCHER-SPLIT — future bucket).
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| LAYOUT-01 | `add_overlay_readout(target, format=...)` — flonum/comment readout overlapping target with `bring_to_front` + `ignoreclick=1` baked in | `Patcher.bring_to_front` (patcher.py:688), `add_box`/`add_comment` patterns (patcher.py:405,446), UI_MAXCLASSES contains `flonum`/`number`/`comment` (maxclass_map.py:12-26), z-order rule from CLAUDE.md §"Rule #6" |
| LAYOUT-02 | `add_labeled_param_bank(params, ...)` — multislider sized `size×24` with `contdata=1`/`setstyle=1` plus aligned comment labels | `add_panel`/`add_step_marker` baked-attrs pattern (patcher.py:570,639), CLAUDE.md §"Multislider as Labeled Parameter Bank" recipe, `multislider` in UI_MAXCLASSES |
| LAYOUT-03 | Companion-pair layout uses `signal_role` to place gain~/meter~ side-by-side, dial+flonum overlay etc. | `db.get_signal_role(name, outlet)` (db_lookup.py:582), existing `_COMPANION_NAMES`/`_identify_companions`/`_place_companions` (layout.py:50,568,606), Phase 30's curated roles in `overrides.json` |
| LAYOUT-04 | `m4l_gen_synth(params=[...])` — Live-ready M4L device with gen~ + `live.dial`s bound via `param_connect`, no `gain~` before `plugout~` | `add_gen` (patcher.py:1742), `ensure_parameter_enable` (m4l_polish.py:149), bassoon-model.maxpat live.dial reference shape, `ParamType`/`UnitStyle` enums (m4l_constants.py) |
| LAYOUT-05 | Builders reachable from `max-patch-agent` and `max-ui-agent` via documented entry points | `.claude/skills/max-patch-agent/SKILL.md` (244 lines), `.claude/skills/max-ui-agent/SKILL.md` (139 lines) — existing "Capabilities" sections to extend |
</phase_requirements>

## Project Constraints (from CLAUDE.md)

These directives bind every plan in this phase:

- **Rule #1: Never Guess Objects.** All builder-emitted boxes (`flonum`, `number`, `comment`, `multislider`, `gen~`, `live.dial`, `plugout~`, `meter~`) MUST be valid DB entries with non-empty I/O. The builders use `add_box` (which goes through `Box(name, ..., db=...)` and validates) — already enforced.
- **Rule #2: Verify Before Connect.** `add_labeled_param_bank` returns boxes but does not auto-wire; caller is responsible. `add_m4l_gen_synth` connects gen~→plugout~ — must verify outlet/inlet counts (gen~ outlet 0 = signal, plugout~ inlet 0 = signal). The existing `add_connection` already raises on out-of-bounds (patcher.py:798-808).
- **Rule #3: Hot/Cold Inlet Ordering.** Not directly relevant — these builders create UI/scaffold structures, not message-fanout chains. `add_m4l_gen_synth` produces no patch cords between dials and gen~ (D-15: `param_connect` IS the binding, no message routing).
- **Rule #4: Patch Style.** Companion gap of 5px (already `_COMPANION_GAP` in layout.py:55). 24px label spacing (Memory: `feedback_layout_spacing.md` confirms tight spacing matches user expectation; CLAUDE.md §"Multislider as Labeled Parameter Bank" specifies 24px for fontsize=10).
- **Rule #5: No Generator Scripts.** Builders are class methods on `Patcher`; agents construct in-memory and save via `save_patch_roundtrip`. No standalone generator script.
- **Rule #6: Z-Order Awareness.** `add_overlay_readout` MUST call `bring_to_front` AFTER creating the readout (CLAUDE.md recipe steps 1-4 codified). Caller-provided readout overlapping a control needs `ignoreclick=1` so the control underneath remains interactive.
- **Rule #7: Commit After Every Save.** Tests use in-memory Patchers; not relevant to the builders themselves but plan tasks MUST commit changes.
- **Rule #8: `replace_box()` Orphans Connections.** Not directly invoked by these builders, but if any internal logic path uses `replace_box`, callers must rewire. Prefer `replace_box_safe`.

**MSP/M4L domain rules that bind LAYOUT-04:**
- M4L: NO `gain~`/`live.gain~`/`ezdac~` between gen~ and `plugout~` (already locked as D-15).
- M4L: `live.dial` binds to gen~ Params via `param_connect`, NOT message-box patching.
- M4L: `param_connect` requires gen~ to have a `varname` matching the prefix.

**`maxclass` field rule:** Most MAX objects use `maxclass: "newobj"` with `text` = object name. Only true UI widgets (in `UI_MAXCLASSES` frozenset) use their own name. The builders rely on `add_box` / `Box.__new__` patterns which already invoke `resolve_maxclass(name)` (maxclass_map.py:60-74). [VERIFIED: read maxclass_map.py:12-57 — `flonum`, `number`, `comment`, `multislider`, `live.dial`, `meter~` all in UI_MAXCLASSES; `gen~` and `plugout~` are NOT, so they go through `text="gen~ ..."` / `text="plugout~ ..."` with maxclass `newobj`.]

## Summary

Phase 31 ships four user-facing builder methods on `Patcher` plus a passive role-driven hook inside `apply_layout`. All decisions are locked (D-01..D-16). The builders sit on top of well-established existing patterns: `add_panel`/`add_step_marker` (baked extra_attrs + z-order), `bring_to_front`/`send_to_back`/`set_z_index` (z-order primitives), `add_gen` (gen~ skeleton creation), `_identify_companions`/`_place_companions` (companion placement), `db.get_signal_role(name, outlet)` (the Phase 28 single getter that companion dispatch calls).

**Three risks to flag for the planner:**
1. **`add_panel`/`add_step_marker` use `Box.__new__(Box)` and manually populate every Box attribute** rather than going through the normal `Box(name, args, ...)` constructor. The new builders should choose: (a) `Box.__new__` for non-DB structural boxes (matches panel pattern), or (b) `add_box` for DB-validated UI widgets (cleaner, validates via DB). For `add_overlay_readout`, `add_labeled_param_bank`, and the live.dial creation inside `add_m4l_gen_synth`, **prefer `add_box` because flonum/number/comment/multislider/live.dial are all in the DB and in `UI_MAXCLASSES`** — `add_box` Just Works and avoids re-implementing the 15-line manual Box init. Only fall back to `Box.__new__` if `add_box`'s overlap-avoidance nudge or DB validation gets in the way (use `skip_overlap_check=True` if so).
2. **`apply_layout` calls `_identify_companions` per-component, NOT globally.** [VERIFIED by reading layout.py:117-122] — the role-driven hook must integrate inside that per-component pass, not as a separate top-level pass. Recommended: extend `_identify_companions` to take the patcher's `db` and consult `_ROLE_COMPANION_MAP` first, falling through to `_COMPANION_NAMES` on `None`.
3. **`m4l_polish.py` operates on raw `patch_dict` (JSON), not on `Patcher` instances.** [VERIFIED by reading m4l_polish.py:149-171] `add_m4l_gen_synth` is a `Patcher` method that builds Box objects; if it delegates to a helper in `m4l_polish.py`, that helper takes `Patcher`/`Box`, NOT `patch_dict`. Don't conflate the two layers — `polish_m4l_device(patch_dict)` runs AFTER `to_dict()` serialization, separately. The skeleton can be polish-ready (correct `parameter_enable`, valid valueof block) without invoking `polish_m4l_device` from inside the builder.

**Primary recommendation:** Each plan task adds a single builder method, mirrors the existing `add_panel` pattern for baked-attr defaults + extra_attrs deep-merge, builds Box instances via `add_box` where the object is in the DB (almost all cases) or `Box.__new__` for structural/non-DB cases. The companion-role plan task extends `_identify_companions` (NOT `apply_layout`'s top loop) to consult `_ROLE_COMPANION_MAP` first. SKILL.md updates are mechanical insertions of a "Builder API" section.

## Standard Stack

### Core (already in repo, no new dependencies)

| Module | Where | Purpose | Why Standard |
|--------|-------|---------|--------------|
| `src.maxpat.patcher.Patcher` | patcher.py (2178 lines) | Class hosting all four builders as methods | D-01 locks builder home; existing `add_panel`/`add_step_marker` are the closest precedent |
| `src.maxpat.patcher.Box` | patcher.py:129 | The data class every builder produces | Box constructor validates against `ObjectDatabase` (Rule #1), `Box.__new__(Box)` is the bypass for non-DB structural boxes |
| `src.maxpat.layout` | layout.py (1216 lines) | Hosts `_COMPANION_NAMES`, `_identify_companions`, `_place_companions` | LAYOUT-03 hooks into these |
| `src.maxpat.db_lookup.ObjectDatabase` | db_lookup.py:582 | `get_signal_role(name, outlet)` is the single DB call companion dispatch needs | Phase 28 D-02: returns `Optional[Literal['audio','trigger','status','float','data','list']]`. `None` means unaudited → fall through to legacy heuristic |
| `src.maxpat.m4l_polish` | m4l_polish.py (516 lines) | Optional helper home for `add_m4l_gen_synth` body; `ensure_parameter_enable` / `polish_m4l_device` already exist | D-15 says skeleton should be polish-ready; the polish pipeline can run on the resulting `to_dict()` afterwards |
| `src.maxpat.m4l_constants` | m4l_constants.py | `ParamType.FLOAT = 1`, `UnitStyle.FLOAT = 1` enums for `valueof` block | Already used by `ensure_parameter_enable` (m4l_polish.py:168-169) |
| `src.maxpat.maxclass_map.UI_MAXCLASSES` | maxclass_map.py:12-57 | Frozenset of all UI widgets that use own-name maxclass | Authoritative — the DB's `maxclass` field is NOT (CLAUDE.md). Verify before setting maxclass directly |
| `pytest` | tests/ | Class-based test pattern (`TestOverlayReadout`, `TestLabeledParamBank`, ...) | Mirrors `tests/test_schema_extensions.py:108` (`class TestSchemaValidation`) |
| `tests/conftest.py` fixtures | conftest.py:24,48,72 | `all_objects`, `objects_by_domain`, `object_by_name` for DB-backed fixtures | Phase 28/30 tests reuse these |

### No New Dependencies Required

This phase adds zero new pip/npm packages. Everything uses repo-internal modules. [VERIFIED by reading patcher.py imports lines 17-23, layout.py imports 22-35, m4l_polish.py imports 23-26.]

## Architecture Patterns

### Recommended File Layout

```
src/maxpat/
├── patcher.py           # +300-500 LOC: 4 new methods on Patcher
│   ├── add_overlay_readout()       # NEW (LAYOUT-01)
│   ├── add_labeled_param_bank()    # NEW (LAYOUT-02)
│   └── add_m4l_gen_synth()         # NEW (LAYOUT-04) — may delegate to m4l_polish helper
├── layout.py            # +20-60 LOC
│   ├── _ROLE_COMPANION_MAP         # NEW dict constant (LAYOUT-03)
│   └── _identify_companions()      # MODIFIED — consult role first, fall through to _COMPANION_NAMES
└── m4l_polish.py        # OPTIONAL +50-100 LOC
    └── _build_gen_synth_skeleton() # OPTIONAL helper if Patcher method delegates

tests/
├── test_overlay_readout.py         # NEW unit
├── test_labeled_param_bank.py      # NEW unit
├── test_m4l_gen_synth.py           # NEW unit
└── test_companion_role_layout.py   # NEW integration

.claude/skills/
├── max-patch-agent/SKILL.md        # MODIFIED — add "Builder API" section
└── max-ui-agent/SKILL.md           # MODIFIED — add "Builder API" section

CLAUDE.md                           # MODIFIED — brief pointer + recipe-removal note
```

### Pattern 1: Baked-Attrs + extra_attrs Merge (mirrors `add_panel`)

**What:** A builder bakes the "essential" attributes into `box.extra_attrs`, then layers caller-supplied `extra_attrs={}` over them so callers can customize.

**When to use:** `add_overlay_readout` (`ignoreclick`, `bgcolor`, `format`), `add_labeled_param_bank` (`size`, `height`, `orientation`, `contdata`, `setstyle`, `setminmax`).

**Example (from `add_panel`, patcher.py:570-637):**
```python
def add_panel(self, x, y, width, height, gradient=True) -> Box:
    panel = Box.__new__(Box)
    panel.name = "panel"
    # ... manually populate every Box field ...
    panel.extra_attrs = {
        "background": 1,
        "ignoreclick": 1,
        "border": 0,
        "rounded": 7,
        "mode": 0,
    }
    if gradient:
        panel.extra_attrs["bgfillcolor"] = {...}
    else:
        panel.extra_attrs["bgcolor"] = list(AESTHETIC_PALETTE["panel_fill"])
    self.boxes.insert(0, panel)  # z-order via insert position
    return panel
```

**For new builders, prefer the `add_box` route (DB-validated):**
```python
def add_overlay_readout(self, target, *, format='%.2f', type='flonum',
                       editable=False, offset_x=0, offset_y=0):
    rect = list(target.patching_rect)  # copy
    readout = self.add_box(type, x=rect[0]+offset_x, y=rect[1]+offset_y,
                           skip_overlap_check=True)  # explicit position
    readout.patching_rect = [rect[0]+offset_x, rect[1]+offset_y,
                             rect[2], rect[3]]
    readout.extra_attrs["format"] = format
    if not editable:
        readout.extra_attrs["ignoreclick"] = 1
    self.bring_to_front(readout)  # always — z-order always applies
    return readout
```

### Pattern 2: Box.__new__ Bypass for Non-DB Structural Cases

**What:** When the box is structural (panels, step markers, codeboxes, subpatchers) and not in the DB, bypass the `Box.__init__` DB validation by using `Box.__new__(Box)` and manually populating every field.

**When to use:** `add_step_marker` (textbutton with custom number), in `add_m4l_gen_synth` only if `gen~` requires special construction (it doesn't — `add_gen` already exists; reuse it).

**Anti-pattern:** Don't use `Box.__new__` for objects that are in the DB. `add_box` provides DB validation, overlap-avoidance nudging, and proper id generation — re-implementing those 15 lines is busywork.

### Pattern 3: Z-order via Array Position

**What:** In .maxpat JSON, objects EARLIER in the `boxes` array render on top. `bring_to_front` moves to index 0; `send_to_back` moves to end.

**Critical for LAYOUT-01:** The overlay readout MUST be at index 0 in the parent's `boxes` array (or earlier than the target dial) so it renders on top. `Patcher.bring_to_front(box)` (patcher.py:688-704) does exactly this.

**Reference:** patcher.py:688-748 — three primitives: `bring_to_front`, `send_to_back`, `set_z_index`. Already exposed.

### Pattern 4: Role-First Dispatch with Fallback (mirrors Phase 29 D-02)

**What:** Look up `signal_role`. If it returns a known role, use the role-driven branch. If `None`, fall through to legacy boolean/heuristic.

**When to use:** Companion-pair logic in `_identify_companions`.

**Example skeleton:**
```python
def _identify_companions(boxes, lines, rows, db):  # add db param
    box_map = {b.id: b for b in boxes}
    incoming = ...  # existing
    result = {}
    for box in boxes:
        # NEW: role-driven dispatch first
        for outlet_idx in range(box.numoutlets):
            role = db.get_signal_role(box.name, outlet_idx) if db else None
            if role and _ROLE_COMPANION_MAP.get(role, {}).get("companion"):
                # find children matching the companion type, mark for placement
                ...
        # FALLBACK: existing _COMPANION_NAMES heuristic (unchanged)
        if box.name not in _COMPANION_NAMES:
            continue
        # ... existing logic
    return result
```

The exact integration shape is the planner's call — but the dispatch order (role first, heuristic second) is locked by D-13.

### Pattern 5: live.dial param_connect Binding (canonical M4L shape)

**What:** A `live.dial` binds to a gen~ Param via two pieces:
1. Top-level `param_connect: "<gen~_varname>::<param_name>"`
2. `parameter_enable: 1`
3. `saved_attribute_attributes.valueof` block with all parameter metadata
4. Top-level `varname: <param_name>` (matches the suffix in param_connect)

The gen~ itself MUST have a stable `varname` matching the prefix.

**Verified shape from bassoon-model.maxpat:18-198** (an actual working M4L device):

```json
{
  "id": "obj-13",
  "maxclass": "live.dial",
  "numinlets": 1,
  "numoutlets": 2,
  "outlettype": [ "", "float" ],
  "param_connect": "gen~_AA::reed_stiff",
  "parameter_enable": 1,
  "patching_rect": [ 192.0, 110.0, 44.0, 48.0 ],
  "presentation": 1,
  "presentation_rect": [ 40.0, 390.0, 50.0, 48.0 ],
  "saved_attribute_attributes": {
    "valueof": {
      "parameter_initial": [ 0.5 ],
      "parameter_initial_enable": 1,
      "parameter_longname": "reed_stiff",
      "parameter_mmax": 1.0,
      "parameter_modmode": 3,
      "parameter_shortname": "reed_stiff",
      "parameter_type": 0,
      "parameter_unitstyle": 1
    }
  },
  "varname": "reed_stiff"
}
```

And the gen~:

```json
{
  "text": "gen~ bassoon",
  "varname": "gen~_AA"
}
```

(The `param_connect: "gen~_AA::reed_stiff"` prefix matches the gen~'s `varname`.)

**Note:** `parameter_mmin` is omitted when min is 0 (Live default); only `parameter_mmax` always present. `parameter_type=0` corresponds to `ParamType.INT`, BUT `parameter_unitstyle=1` is `UnitStyle.FLOAT` — the bassoon-model uses int param_type with float unitstyle (an idiosyncrasy; cleaner default for new code is `parameter_type=ParamType.FLOAT=1` + `parameter_unitstyle=UnitStyle.FLOAT=1`, matching `ensure_parameter_enable`'s defaults at m4l_polish.py:168-169). `parameter_modmode=3` is `ModMode.ABSOLUTE` per m4l_constants.py:51.

[VERIFIED: read patches/bassoon-model/generated/bassoon-model.maxpat:43-225 and m4l_constants.py:13-52.]

### Anti-Patterns to Avoid

- **Don't replicate `_LIVE_NO_PARAM` exclusions in the new builder.** `ensure_parameter_enable` already handles that filter (m4l_polish.py:25,133). Builder produces `live.dial` instances which are not in `_LIVE_NO_PARAM`, so polish runs cleanly.
- **Don't auto-call `polish_m4l_device` inside `add_m4l_gen_synth`.** D-15 says skeleton should be polish-ready, NOT polish-baked. `polish_m4l_device` operates on `patch_dict` (post-`to_dict()`), not the Patcher; calling it from a Patcher method is a layering violation. Caller invokes `polish_m4l_device(patcher.to_dict())` separately if desired.
- **Don't pre-wire prepend/route chains in `add_labeled_param_bank`.** D-09 locks: builder returns `(multislider, list[comment])` only. Caller wires `fetch $1` themselves and reads from outlet 1 (Memory: `feedback_multislider_fetch.md`).
- **Don't overwrite `target.patching_rect` in `add_overlay_readout`.** Copy it (`list(target.patching_rect)`) before applying offsets.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Z-order manipulation | Manual `self.boxes.remove(box); self.boxes.insert(0, box)` | `self.bring_to_front(box)` (patcher.py:688) | Already wraps remove + insert + ValueError on missing |
| gen~ skeleton with codebox | Box.__new__ + manual codebox/in/out object construction | `self.add_gen(code, num_inputs, num_outputs)` (patcher.py:1742) | Already auto-detects I/O, runs `validate_genexpr`, reorders declarations |
| `signal_role` lookup | Reaching into `obj["outlets"][i]["signal_role"]` | `self.db.get_signal_role(name, outlet)` (db_lookup.py:582) | Handles aliases + reverse derivation from `signal: bool` per Phase 28 D-02 |
| live.dial creation | Box.__new__ with manual saved_attribute_attributes | `add_box("live.dial", ...)` + set `extra_attrs` and `param_connect` (top-level via `extra_attrs`? — see assumption below) | DB-validated, in UI_MAXCLASSES |
| `parameter_enable` bookkeeping | Manual valueof.setdefault chain | After building, run `ensure_parameter_enable(patcher.to_dict())` if dict-level guarantees needed | Already does the work (m4l_polish.py:149-171) |
| Comment label sizing | Manual width = `len(text) * 6.0 + 14.0` | `add_comment(text, x, y)` (patcher.py:446) — already calls `calculate_box_size(text, "comment")` | Existing helper; matches existing aesthetic |
| Box ID generation | Manual `f"obj-{i}"` | `self._gen_id()` (patcher.py:399-403) | Atomic increment, already in use everywhere |

**Key insight:** Almost every primitive needed by these builders already exists. The phase is mostly about composition + baked defaults, not net-new infrastructure.

## Common Pitfalls

### Pitfall 1: Forgetting to copy `target.patching_rect`

**What goes wrong:** `readout.patching_rect = target.patching_rect` aliases the same list. Mutating one mutates the other.
**Why it happens:** Python list assignment is reference-binding.
**How to avoid:** Always `list(target.patching_rect)` or `target.patching_rect.copy()`.
**Warning signs:** Tests pass for the readout's position but the dial's position changes too.

### Pitfall 2: Z-order applied before vs after offset_x/y

**What goes wrong:** Caller passes `offset_y=4`; builder calls `bring_to_front(readout)` which removes-and-reinserts at index 0. If position math depends on box already being in `self.boxes`, calling `bring_to_front` mid-build corrupts state.
**Why it happens:** `bring_to_front` raises `ValueError` if box not in patcher (patcher.py:702). Calling it AFTER `add_box` is appended is correct; calling it before is broken.
**How to avoid:** Always: (1) `add_box` to add, (2) set position/extra_attrs, (3) `bring_to_front` last.
**Warning signs:** `ValueError: Box {id!r} not in this patcher`.

### Pitfall 3: `apply_layout` recurses into subpatchers — companion logic must too

**What goes wrong:** Role-driven companion dispatch only fires at the top level. Companions inside a subpatcher (e.g., a `p osc` containing `cycle~` + `meter~`) get the legacy heuristic only.
**Why it happens:** `apply_layout` recurses (layout.py:165-170: `for box in patcher.boxes: if box._inner_patcher is not None: apply_layout(box._inner_patcher, options)`). The recursion hits `_identify_companions` again — so as long as that function takes `db` (and the recursive call passes the same db), the role logic fires inside subpatchers automatically.
**How to avoid:** Pass `db` (or `patcher.db`) into `_identify_companions` and ensure the recursive call carries it through. Verify by integration test with a subpatcher containing role-stamped objects.
**Warning signs:** Test shows companion placement works at top level but not inside `add_subpatcher`.

### Pitfall 4: live.dial `param_connect` is a TOP-LEVEL box attribute, not inside extra_attrs

**What goes wrong:** Setting `box.extra_attrs["param_connect"] = "..."` may not serialize to top-level `param_connect` field — depends on the `to_dict` flattening order.
**Why it happens:** Box's `to_dict()` flattens `extra_attrs` last (patcher.py:355: `d.update(self.extra_attrs)`). [VERIFIED by reading patcher.py:355.] Since the panel's `bgcolor` and `ignoreclick` go through `extra_attrs` and DO surface at top level, `param_connect` should work too. BUT existing `m4l_polish.py` reads top-level box fields (e.g., `box.get("param_connect")` would work either way after serialization). Confirm with a serialization round-trip test.
**How to avoid:** Always `extra_attrs["param_connect"] = "gen~_synth::freq"` AND verify with a `to_dict()` round-trip test that `patch_dict["patcher"]["boxes"][i]["box"]["param_connect"]` is at the top level.
**Warning signs:** `param_connect` ends up nested or missing; live.dial doesn't bind in actual MAX.

### Pitfall 5: Multislider `setminmax` envelope vs per-bar

**What goes wrong:** Caller passes `params=[("freq", 20, 20000), ("gain", 0, 1)]`. Envelope is `[0, 20000]`. Both bars now allow 0..20000 — gain bar can drag to 19000 with no clamp.
**Why it happens:** Multislider has one `setminmax` for all bars; per-bar ranges require runtime config messages, not attrs (Deferred in CONTEXT.md).
**How to avoid:** Document the limitation in the builder docstring; encourage callers to use the bank only for params with similar ranges, or supply per-bar via runtime messages outside the builder. CONTEXT.md "Claude's Discretion" allows escalating per-bar `setminmax` as a deferred follow-up if real cases demand.
**Warning signs:** Caller surprised that `(name, min, max)` per-tuple isn't actually enforced per-bar.

### Pitfall 6: `_LIVE_NO_PARAM` overlap

**What goes wrong:** If `add_m4l_gen_synth` ever needs a `live.thisdevice` or other non-parameterizable live object, `ensure_parameter_enable` skips it (m4l_polish.py:133). The builder's inventory should match: only `live.dial` instances need `parameter_enable + valueof`.
**Why it happens:** D-15's skeleton is `gen~ + live.dials + plugout~` — no live.thisdevice or other live.* objects. Stay within scope.
**How to avoid:** Builder produces ONLY `live.dial`, `gen~`, and `plugout~`. Don't add `live.thisdevice` automatically (could be a future enhancement; not D-15 scope).
**Warning signs:** Test fails because a live object the builder added doesn't get parameter_enable, breaking the test's assertion.

### Pitfall 7: gen~ varname collision

**What goes wrong:** `add_m4l_gen_synth` defaults `gen_varname='synth'`. Caller adds two `add_m4l_gen_synth` calls in the same patcher (test integration scenario, or a layered device). Both gen~s have `varname='synth'`. MAX errors on duplicate varname.
**Why it happens:** No varname uniqueness check in `add_box` or `add_gen`.
**How to avoid:** Either (a) document that caller must pass distinct `gen_varname` per call, or (b) in builder, append `_<id>` if collision detected. Simpler: document the constraint.
**Warning signs:** Tests pass with one synth call but fail when multiple are present.

### Pitfall 8: Phase 30's curated roles are MSP-only

**What goes wrong:** Integration test expects role-driven companion placement on a `live.dial` (M4L). `live.dial` is in m4l/objects.json, NOT in msp/objects.json — Phase 30's coverage is MSP+MC only (per CONTEXT.md "Out of Scope" line in REQUIREMENTS.md: "Non-MSP outlet coverage sweep"). `db.get_signal_role("live.dial", 1)` likely returns `None` (no curation), so legacy fallthrough applies.
**Why it happens:** Role coverage is intentionally bounded to MSP/MC for v5.0. Other domains use the heuristic.
**How to avoid:** Integration test should construct an MSP-flavored chain (`cycle~` → `gain~` → `meter~`) where `gain~` outlet 0 is role-stamped `audio` (verified in Phase 30). Use `cycle~` outlet 0 (audio) feeding `meter~` (companion) — the canonical case the role map targets.
**Warning signs:** Integration test passes by accident through the heuristic, not by the role logic. To detect: assert that the role path was hit (e.g., spy on `db.get_signal_role` calls or check via a helper function).

## Code Examples

### Skeleton: `add_overlay_readout`

```python
# In src/maxpat/patcher.py, near add_panel/add_step_marker
def add_overlay_readout(
    self,
    target: Box,
    *,
    format: str = '%.2f',
    type: str = 'flonum',
    editable: bool = False,
    offset_x: float = 0.0,
    offset_y: float = 0.0,
) -> Box:
    """Create a flonum/comment/number readout overlapping a target dial/control.

    Bakes in `bring_to_front` (overlays render on top) and `ignoreclick=1`
    (clicks pass through to underlying control). Codifies the CLAUDE.md
    Rule #6 overlay-readout recipe.
    """
    if type not in ('flonum', 'comment', 'number'):
        raise ValueError(f"type must be 'flonum'|'comment'|'number', got {type!r}")
    rect = list(target.patching_rect)  # COPY — don't alias
    x = rect[0] + offset_x
    y = rect[1] + offset_y
    readout = self.add_box(type, x=x, y=y, skip_overlap_check=True)
    readout.patching_rect = [x, y, rect[2], rect[3]]
    readout.extra_attrs["format"] = format
    if not editable:
        readout.extra_attrs["ignoreclick"] = 1
    self.bring_to_front(readout)
    return readout
```

### Skeleton: `add_labeled_param_bank`

```python
def add_labeled_param_bank(
    self,
    params: list[tuple[str, float, float]],
    x: float,
    y: float,
    *,
    label_side: str = 'left',
    extra_attrs: dict | None = None,
) -> tuple[Box, list[Box]]:
    """Build a multislider parameter bank with aligned comment labels.

    Codifies the CLAUDE.md "Multislider as Labeled Parameter Bank" recipe:
    size×24 px height, contdata=1, setstyle=1, orientation=0 (horizontal bars
    stacked vertically). Returns (multislider, [comment, ...]); caller wires
    `fetch $1` and reads from outlet 1.
    """
    if not params:
        raise ValueError("params must not be empty")
    if label_side != 'left':
        raise ValueError("only label_side='left' supported in Phase 31")
    size = len(params)
    height = size * 24.0
    mins = [p[1] for p in params]
    maxes = [p[2] for p in params]
    setminmax = [min(mins), max(maxes)]
    # Width: pick something sensible; CLAUDE.md doesn't lock it
    ms_width = 200.0
    ms = self.add_box("multislider", x=x, y=y, skip_overlap_check=True)
    ms.patching_rect = [x, y, ms_width, height]
    baked = {
        "size": size,
        "setminmax": setminmax,
        "orientation": 0,
        "contdata": 1,
        "setstyle": 1,
    }
    if extra_attrs:
        # Deep-merge: caller wins on conflicts
        baked.update(extra_attrs)
    ms.extra_attrs.update(baked)

    # Place labels left of bars, vertically centered with each bar
    label_gap = 8.0
    labels: list[Box] = []
    for i, (name, _, _) in enumerate(params):
        # Estimate label width; let add_comment compute the actual size
        approx_w = len(name) * 6.0 + 14.0
        lx = x - approx_w - label_gap
        ly = y + i * 24.0
        c = self.add_comment(name, x=lx, y=ly)
        c.fontsize = 10.0
        # Re-tighten: comment height to 18 per CLAUDE.md fontsize=10 spacing
        c.patching_rect[3] = 18.0
        labels.append(c)

    return ms, labels
```

### Skeleton: `_ROLE_COMPANION_MAP` integration in layout.py

```python
# In src/maxpat/layout.py, after _COMPANION_NAMES
_ROLE_COMPANION_MAP: dict[str, dict[str, str | None]] = {
    "audio":   {"companion": "meter~", "placement": "right"},
    "status":  {"companion": "flonum", "placement": "overlay"},
    "trigger": {"companion": None,     "placement": None},
    "float":   {"companion": None,     "placement": None},
    "data":    {"companion": None,     "placement": None},
    "list":    {"companion": None,     "placement": None},
}

def _identify_companions(
    boxes: list[Box],
    lines: list,
    rows: list[list[Box]],
    db=None,                       # NEW PARAM
) -> dict[str, Box]:
    box_map = {b.id: b for b in boxes}
    comp_ids = {b.id for b in boxes}
    incoming: dict[str, list[str]] = {}
    for line in lines:
        if line.source_id in comp_ids and line.dest_id in comp_ids:
            incoming.setdefault(line.dest_id, []).append(line.source_id)

    result: dict[str, Box] = {}

    # Pass A: role-driven dispatch (NEW — D-13: fires first)
    if db is not None:
        for box in boxes:
            for child_id, parent_ids in incoming.items():
                if box.id not in parent_ids:
                    continue
                child = box_map.get(child_id)
                if child is None:
                    continue
                # Find which outlet of `box` connects to `child` to look up role
                for line in lines:
                    if line.source_id != box.id or line.dest_id != child.id:
                        continue
                    role = db.get_signal_role(box.name, line.source_outlet)
                    spec = _ROLE_COMPANION_MAP.get(role or "", {})
                    companion_name = spec.get("companion")
                    if companion_name and child.name == companion_name:
                        result[child.id] = box
                        break

    # Pass B: legacy _COMPANION_NAMES heuristic (UNCHANGED — fall-through)
    for box in boxes:
        if box.name not in _COMPANION_NAMES:
            continue
        if box.id in result:    # role pass already handled this companion
            continue
        parents = incoming.get(box.id, [])
        if len(parents) != 1:
            continue
        parent = box_map.get(parents[0])
        if parent is not None:
            result[box.id] = parent

    return result
```

(The exact threading of `db` into `apply_layout`'s call to `_identify_companions` — the planner decides; cleanest is `_identify_companions(... , patcher.db)` with the recursive `apply_layout(box._inner_patcher, options)` call already carrying `db` via the inner patcher's own attribute.)

### Skeleton: `add_m4l_gen_synth`

```python
def add_m4l_gen_synth(
    self,
    params: list[tuple[str, float, float]],
    *,
    gen_varname: str = 'synth',
    gen_code: str | None = None,
) -> tuple[Box, list[Box], Box]:
    """Build a Live-ready M4L gen synth skeleton.

    Layout:  gen~ <varname=gen_varname>  →  plugout~
             |
             [live.dial]s with param_connect: "<gen_varname>::<param_name>"

    NO gain~/live.gain~/ezdac~ between gen~ and plugout~ (CLAUDE.md M4L rule).
    Caller fills in DSP via gen_code or by editing the gen~ inner patcher.
    """
    from src.maxpat.m4l_constants import ParamType, UnitStyle, ModMode

    # Default empty body so gen~ compiles
    code = gen_code or "\n".join(
        f"Param {n}({(mn+mx)/2}, min={mn}, max={mx});" for n, mn, mx in params
    ) + "\nout1 = 0;"

    gen_obj, _gen_inner = self.add_gen(code, num_inputs=0, num_outputs=1,
                                       x=200.0, y=200.0)
    gen_obj.extra_attrs["varname"] = gen_varname

    plugout = self.add_box("plugout~", args=["1"], x=200.0, y=400.0)
    self.add_connection(gen_obj, 0, plugout, 0)  # gen~ → plugout~ direct

    dials: list[Box] = []
    dial_x = 50.0
    dial_y = 100.0
    for i, (name, mn, mx) in enumerate(params):
        d = self.add_box("live.dial", x=dial_x + i * 60.0, y=dial_y,
                         skip_overlap_check=True)
        # Top-level box attributes (extra_attrs serialize to top level via to_dict flattening)
        d.extra_attrs["varname"] = name
        d.extra_attrs["param_connect"] = f"{gen_varname}::{name}"
        d.extra_attrs["parameter_enable"] = 1
        d.extra_attrs["saved_attribute_attributes"] = {
            "valueof": {
                "parameter_initial": [(mn + mx) / 2.0],
                "parameter_initial_enable": 1,
                "parameter_longname": name,
                "parameter_shortname": name,
                "parameter_mmin": mn,
                "parameter_mmax": mx,
                "parameter_modmode": int(ModMode.ABSOLUTE),
                "parameter_type": int(ParamType.FLOAT),
                "parameter_unitstyle": int(UnitStyle.FLOAT),
            }
        }
        dials.append(d)

    return gen_obj, dials, plugout
```

[ASSUMED] The exact handling of `parameter_initial: [...]` as a list vs scalar — bassoon-model.maxpat shows `[ 0.5 ]` as a 1-element list. The above skeleton matches; verify in test that the round-trip preserves it.

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Caller writes overlay readout recipe inline (5-step CLAUDE.md prose) | `p.add_overlay_readout(target, format='%.2f')` | Phase 31 | Single line replaces 5-step recipe; agents stop restating |
| `signal_role` curation flat / non-existent | Phase 28 schema + Phase 30 MSP coverage <20 gaps | Phases 28-30 (this milestone) | Role-driven companion dispatch becomes viable |
| Manual companion placement via callers | `_COMPANION_NAMES` heuristic in apply_layout | Pre-Phase 31 | Worked for `meter~`/`scope~`/`number~`/`spectroscope~` but doesn't generalize |
| Heuristic-only companion dispatch | Role-first with heuristic fallback (D-13) | Phase 31 | Generalizes to any audio/status outlet, gracefully degrades on `None` |

**Deprecated/outdated (per CONTEXT.md deferred list):**
- Eager `add_with_companion(name, ...)`: rejected as magical.
- `subpatcher_name=` kwarg on `add_labeled_param_bank`: deferred to follow-up.
- Per-bar `setminmax`: deferred (multislider feature requires runtime config).

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| A1 | `extra_attrs["param_connect"] = "..."` flattens to top-level `param_connect` field via Box.to_dict (pattern matches existing `bgcolor`/`ignoreclick` flattening) | Pitfall 4, Pattern 5 | If false: live.dial fails to bind in MAX. Mitigation: round-trip test in test_m4l_gen_synth.py |
| A2 | `parameter_initial` as 1-element list `[0.5]` is the correct serialization (matches bassoon-model.maxpat ground truth) | Skeleton: add_m4l_gen_synth | If false: Live.dial loads with default mid-point, ignoring `parameter_initial`. Mitigation: copy from bassoon-model exactly |
| A3 | The integration test patch can use `cycle~ → gain~ → meter~` with gain~ outlet 0 role-stamped `audio` to exercise the role-driven path | Pitfall 8 | If gain~ outlet 0 isn't role-stamped in current overrides.json, test falls through to heuristic and accidentally passes. Mitigation: spy on `db.get_signal_role` calls or inspect overrides.json at plan time |
| A4 | `add_box` works for `live.dial` (it's in UI_MAXCLASSES and in m4l/objects.json) | Code Examples | If live.dial's DB entry has empty I/O (CLAUDE.md warning), `add_connection` will still work since builder doesn't connect dial→gen~ (param_connect IS the binding). Mitigation: verify `db.lookup("live.dial")` returns non-empty I/O before plan execution |
| A5 | The planner can fit the four builders + tests + skill updates into 4-5 plans without exceeding plan size budget | Plan Boundaries (CONTEXT.md Discretion) | Plans may need bundling/splitting. Mitigation: planner judgment, not blocking |
| A6 | gen~ inner patcher works with `num_inputs=0` for a pure synthesizer (no MIDI, no signal in) | Skeleton: add_m4l_gen_synth | If `add_gen` requires at least one input, default code needs adjustment. [VERIFIED partial] add_gen takes `num_inputs: int | None`, auto-detects from code; `out1 = 0` has no `in1` reference so detection should yield 0 |

## Open Questions (RESOLVED)

1. **Should `add_m4l_gen_synth` also add a `live.thisdevice`?**
   - What we know: D-15 explicitly says "minimum-viable" and lists `gen~ + live.dials + plugout~` only.
   - What's unclear: A polished M4L device usually has `live.thisdevice` somewhere; without it, some Live integration features may not work.
   - RESOLVED: Stick with D-15 (no `live.thisdevice`). Phase 31 ships the minimum-viable skeleton; if a real Live integration test surfaces a gap, capture as a deferred follow-up rather than expanding scope here.

2. **How does `_identify_companions` get access to `patcher.db`?**
   - What we know: `apply_layout` receives `patcher` (which has `.db`); it currently passes only `boxes, lines, rows` to `_identify_companions`.
   - What's unclear: Cleanest threading is to add a `db` parameter to `_identify_companions` and pass `patcher.db`. Recursive call (line 170) already passes `box._inner_patcher`, which has its own `.db` set in `add_subpatcher` (patcher.py:1491-1492 — `Patcher(db=self.db, ...)`).
   - RESOLVED: Add `db: ObjectDatabase | None = None` parameter to `_identify_companions`; `apply_layout` threads `patcher.db`. Subpatcher recursion already carries its own `db` via the inner patcher's `.db` attribute, so the role-driven dispatch fires at every nesting level.

3. **Does the format string for `add_overlay_readout` need prepend-chain support?**
   - What we know: D-03 allows `'%.1f Hz'` to map to a prepend chain emitting `set %.1f Hz` to a comment.
   - What's unclear: Whether to ship that auto-detection now (parses format for unit suffix) or only set `flonum.format` (CONTEXT.md "Claude's Discretion": ship simple version first, escalate if real case demands).
   - RESOLVED: Phase 31 ships only the `flonum.format` attribute path. Docstring notes that format strings with literal text (e.g. `'%.1f Hz'`) are accepted but the unit suffix is not rendered without a separate prepend chain — caller can pass `type='comment'` and feed via a prepend chain if needed. Auto-detection is a deferred follow-up, not a Phase 31 deliverable.

4. **Does `multislider.add_box` produce a box with the right default I/O?**
   - What we know: `multislider` is in UI_MAXCLASSES (maxclass_map.py:20). DB lookup should provide I/O counts.
   - What's unclear: Whether the DB entry's I/O is non-empty (CLAUDE.md "verify lookup results have non-empty I/O" warning).
   - RESOLVED: Plan 31-02 Wave-0 task includes a precondition verification step that runs `db.lookup("multislider")` and asserts `len(inlets) > 0 and len(outlets) > 0`. If the entry is empty (none expected based on Phase 30 audit results), the plan halts and `overrides.json` must be populated before the builder lands. Use `db.audit_empty_io()` to confirm.

## Environment Availability

| Dependency | Required By | Available | Version | Fallback |
|------------|-------------|-----------|---------|----------|
| Python (pytest) | All test files | ✓ | 3.14 (per __pycache__) | — |
| `src.maxpat.patcher.Patcher` | All builders | ✓ | repo-internal | — |
| `src.maxpat.layout` | LAYOUT-03 | ✓ | repo-internal | — |
| `src.maxpat.db_lookup.ObjectDatabase` | LAYOUT-03 | ✓ | repo-internal | — |
| `src.maxpat.m4l_polish` | LAYOUT-04 (optional helper) | ✓ | repo-internal | Inline body in patcher.py |
| `src.maxpat.m4l_constants.ParamType/UnitStyle/ModMode` | LAYOUT-04 | ✓ | repo-internal | — |
| Phase 30 curated `signal_role` overrides | LAYOUT-03 integration test | ✓ | committed in `.claude/max-objects/overrides.json` | If a target outlet isn't role-stamped, integration test passes through heuristic (test must avoid this) |
| `pytest` | Test execution | ✓ (existing tests run) | per local install | — |

**No external services, network calls, databases, or compiled binaries.** This is a pure Python phase.

**Missing dependencies with no fallback:** None.

## Validation Architecture

### Test Framework

| Property | Value |
|----------|-------|
| Framework | pytest (class-based, no pytest.ini/pyproject.toml — uses defaults) |
| Config file | none — pytest discovers `tests/test_*.py` automatically |
| Quick run command | `pytest tests/test_overlay_readout.py tests/test_labeled_param_bank.py tests/test_m4l_gen_synth.py tests/test_companion_role_layout.py -x` |
| Full suite command | `pytest tests/` |
| Shared fixtures | `tests/conftest.py` provides `all_objects`, `objects_by_domain`, `object_by_name`, `extraction_log`, `db_root` (session-scoped) |

### Phase Requirements → Test Map

| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|--------------|
| LAYOUT-01 | `add_overlay_readout(target, format='%.2f')` returns flonum at index 0 with `ignoreclick=1` | unit | `pytest tests/test_overlay_readout.py -x` | ❌ Wave 0 |
| LAYOUT-01 | `editable=True` flips `ignoreclick=0` | unit | `pytest tests/test_overlay_readout.py::TestOverlayReadout::test_editable_disables_ignoreclick -x` | ❌ Wave 0 |
| LAYOUT-01 | Three `type=` variants all produce z-ordered overlay | unit | `pytest tests/test_overlay_readout.py::TestOverlayReadout -k type_variant -x` | ❌ Wave 0 |
| LAYOUT-01 | `offset_x`/`offset_y` shifts readout relative to target | unit | `pytest tests/test_overlay_readout.py::TestOverlayReadout::test_offset_applied -x` | ❌ Wave 0 |
| LAYOUT-02 | Returns `(multislider, list[comment])` with `len(labels) == len(params)` | unit | `pytest tests/test_labeled_param_bank.py::TestLabeledParamBank::test_returns_pair_shape -x` | ❌ Wave 0 |
| LAYOUT-02 | Baked attrs: `size`, `height = size*24`, `orientation=0`, `contdata=1`, `setstyle=1` | unit | `pytest tests/test_labeled_param_bank.py::TestLabeledParamBank::test_baked_attrs -x` | ❌ Wave 0 |
| LAYOUT-02 | `setminmax` envelope = `[min(mins), max(maxes)]` across params | unit | `pytest tests/test_labeled_param_bank.py::TestLabeledParamBank::test_setminmax_envelope -x` | ❌ Wave 0 |
| LAYOUT-02 | Label x/y alignment formula: `x = ms.x - label_w - gap`, `y = ms.y + i*24` | unit | `pytest tests/test_labeled_param_bank.py::TestLabeledParamBank::test_label_alignment -x` | ❌ Wave 0 |
| LAYOUT-02 | `extra_attrs={'bgcolor': [...]}` deep-merges over baked defaults | unit | `pytest tests/test_labeled_param_bank.py::TestLabeledParamBank::test_extra_attrs_merge -x` | ❌ Wave 0 |
| LAYOUT-03 | `_ROLE_COMPANION_MAP` covers exactly the 6-role enum | unit | `pytest tests/test_companion_role_layout.py::TestRoleMap::test_six_role_keys -x` | ❌ Wave 0 |
| LAYOUT-03 | Audio outlet → meter~ companion placed to right of parent | integration | `pytest tests/test_companion_role_layout.py::TestRoleDrivenCompanions::test_audio_role_meter_right -x` | ❌ Wave 0 |
| LAYOUT-03 | `None` role → fall-through to `_COMPANION_NAMES` heuristic | integration | `pytest tests/test_companion_role_layout.py::TestRoleDrivenCompanions::test_none_role_falls_through -x` | ❌ Wave 0 |
| LAYOUT-03 | Recursive into subpatchers — companion dispatch fires on inner patcher | integration | `pytest tests/test_companion_role_layout.py::TestRoleDrivenCompanions::test_recursive_subpatcher -x` | ❌ Wave 0 |
| LAYOUT-04 | gen~ has `varname` matching `param_connect` prefix on every dial | unit | `pytest tests/test_m4l_gen_synth.py::TestM4LGenSynth::test_varname_consistency -x` | ❌ Wave 0 |
| LAYOUT-04 | Each `live.dial` has full `saved_attribute_attributes.valueof` block | unit | `pytest tests/test_m4l_gen_synth.py::TestM4LGenSynth::test_saved_attribute_block -x` | ❌ Wave 0 |
| LAYOUT-04 | gen~ → plugout~ connection direct (no `gain~` boxes between) | unit | `pytest tests/test_m4l_gen_synth.py::TestM4LGenSynth::test_no_gain_in_path -x` | ❌ Wave 0 |
| LAYOUT-04 | `ensure_parameter_enable(patch_dict)` invariants hold post-build | unit | `pytest tests/test_m4l_gen_synth.py::TestM4LGenSynth::test_polish_ready -x` | ❌ Wave 0 |
| LAYOUT-04 | `to_dict()` round-trip surfaces `param_connect` at top level | unit | `pytest tests/test_m4l_gen_synth.py::TestM4LGenSynth::test_param_connect_top_level -x` | ❌ Wave 0 |
| LAYOUT-05 | `max-patch-agent/SKILL.md` contains "Builder API" section listing 4 builders | static | `pytest tests/test_agent_skills.py -k builder_api -x` (extend existing test) | ⚠️ Extend existing |
| LAYOUT-05 | `max-ui-agent/SKILL.md` contains "Builder API" section | static | same | ⚠️ Extend existing |

### Sampling Rate

- **Per task commit:** `pytest tests/test_<file>.py -x` (single new test file)
- **Per wave merge:** `pytest tests/test_overlay_readout.py tests/test_labeled_param_bank.py tests/test_m4l_gen_synth.py tests/test_companion_role_layout.py tests/test_layout.py tests/test_m4l_polish.py tests/test_schema_extensions.py -x` — covers new tests + existing tests that touch the same modules
- **Phase gate:** `pytest tests/` green before `/gsd-verify-work`

### Wave 0 Gaps

- [ ] `tests/test_overlay_readout.py` — covers LAYOUT-01 (NEW)
- [ ] `tests/test_labeled_param_bank.py` — covers LAYOUT-02 (NEW)
- [ ] `tests/test_m4l_gen_synth.py` — covers LAYOUT-04 (NEW)
- [ ] `tests/test_companion_role_layout.py` — covers LAYOUT-03 integration (NEW)
- [ ] Extend `tests/test_agent_skills.py` (already exists at `tests/test_agent_skills.py` — verify with planner) for LAYOUT-05 (MODIFIED)

No new framework/dependency installs needed. All fixtures available via `tests/conftest.py`. Class-based pattern mirrors `tests/test_schema_extensions.py:108` (`class TestSchemaValidation`).

## Security Domain

`security_enforcement` is not explicitly disabled in `.planning/config.json`, so the section is included for completeness. **This phase has no auth, network, crypto, secrets, or untrusted-input surface** — it's a pure Python builder API consumed by trusted agents inside the repo. The risk surface is correctness/regression, not security.

### Applicable ASVS Categories

| ASVS Category | Applies | Standard Control |
|---------------|---------|------------------|
| V2 Authentication | no | — |
| V3 Session Management | no | — |
| V4 Access Control | no | — |
| V5 Input Validation | yes — minimal | Builder kwargs validated by Python type hints + explicit `raise ValueError` for bad enums (`type` in {flonum, comment, number}; `label_side` in {left}). `params` tuples checked for non-empty. |
| V6 Cryptography | no | — |

### Known Threat Patterns for this stack

| Pattern | STRIDE | Standard Mitigation |
|---------|--------|---------------------|
| Builder produces invalid `.maxpat` JSON that crashes MAX | Tampering (corrupt output) | Existing `validate_patch(patch_dict, db=db)` pipeline (Phase 29) catches role/domain/install errors; round-trip tests catch JSON shape regressions |
| `param_connect` typo causes silent live.dial → gen~ binding failure (no error, dial just doesn't bind) | Repudiation (silent failure) | Test asserts `param_connect.startswith(f"{gen_varname}::")` for every dial in `add_m4l_gen_synth` |
| Caller's `extra_attrs` dict overrides safety-critical baked attrs (e.g., `setstyle=0` defeats the bar display) | Tampering (caller error) | Document deep-merge order explicitly; baked attrs win on critical keys (`size`, `setminmax` derived) by setting them AFTER the merge — re-evaluate the order in `add_labeled_param_bank` skeleton above |

## Sources

### Primary (HIGH confidence)

- **`/Users/taylorbrook/Dev/MAX/src/maxpat/patcher.py`** lines 405 (`add_box`), 446 (`add_comment`), 570 (`add_panel`), 639 (`add_step_marker`), 688 (`bring_to_front`), 706 (`send_to_back`), 725 (`set_z_index`), 750 (`add_message`), 773 (`add_connection`), 1456 (`add_subpatcher`), 1742 (`add_gen`)
- **`/Users/taylorbrook/Dev/MAX/src/maxpat/layout.py`** lines 50 (`_COMPANION_NAMES`), 68 (`apply_layout`), 568 (`_identify_companions`), 606 (`_place_companions`), 942 (`_route_companion_cable`)
- **`/Users/taylorbrook/Dev/MAX/src/maxpat/db_lookup.py`** lines 582 (`get_signal_role` with full Phase 28 D-02 docstring on None semantics), 660 (`compute_io_counts`), 765 (`get_outlet_types`)
- **`/Users/taylorbrook/Dev/MAX/src/maxpat/m4l_polish.py`** lines 33 (`_ABBREVIATIONS`), 149 (`ensure_parameter_enable`), 495 (`polish_m4l_device`)
- **`/Users/taylorbrook/Dev/MAX/src/maxpat/m4l_constants.py`** lines 13-52 (`ParamType`, `UnitStyle`, `ModMode` enums)
- **`/Users/taylorbrook/Dev/MAX/src/maxpat/maxclass_map.py`** lines 12-57 (`UI_MAXCLASSES` frozenset — confirms flonum/number/comment/multislider/live.dial all qualify)
- **`/Users/taylorbrook/Dev/MAX/patches/bassoon-model/generated/bassoon-model.maxpat`** lines 43-225 — actual working M4L device; canonical shape for `live.dial` + `param_connect` + `varname` + `saved_attribute_attributes.valueof`
- **`/Users/taylorbrook/Dev/MAX/.claude/skills/max-patch-agent/SKILL.md`** (244 lines)
- **`/Users/taylorbrook/Dev/MAX/.claude/skills/max-ui-agent/SKILL.md`** (139 lines)
- **`/Users/taylorbrook/Dev/MAX/CLAUDE.md`** §"Rule #6: Z-Order Awareness", §"Multislider as Labeled Parameter Bank", §"Domain-Specific Rules → Max for Live"
- **`/Users/taylorbrook/Dev/MAX/tests/conftest.py`** — fixture inventory
- **`/Users/taylorbrook/Dev/MAX/tests/test_schema_extensions.py:108`** — class-based test pattern reference
- **`/Users/taylorbrook/Dev/MAX/tests/test_layout.py:25`** — class-based pytest, `from src.maxpat.patcher import Patcher, Box`, `from src.maxpat.layout import apply_layout`
- **`/Users/taylorbrook/Dev/MAX/tests/test_m4l_polish.py`** — `saved_attribute_attributes.valueof` shape examples

### Secondary (MEDIUM confidence)

- **`/Users/taylorbrook/Dev/MAX/.planning/phases/28-schema-foundation/28-CONTEXT.md`** D-01..D-15 — Phase 28 schema decisions
- **`/Users/taylorbrook/Dev/MAX/.planning/phases/29-validator-depth/29-CONTEXT.md`** D-02 — role-first dispatch precedent
- **`/Users/taylorbrook/Dev/MAX/.planning/phases/30-msp-outlet-coverage-sweep/30-CONTEXT.md`** — confirms MSP+MC role coverage <20 gaps
- **Memory: `feedback_multislider_fetch.md`** — `fetch` not `fetchindex`, outlet 1
- **Memory: `feedback_layout_spacing.md`** — confirms tight 24px spacing matches user expectation
- **Memory: `feedback_m4l_no_gain.md`** — confirms NO `gain~` before `plugout~` in M4L

### Tertiary (LOW confidence — flagged in Assumptions Log)

- A1: `param_connect` flattening to top level (Pitfall 4) — high probability based on existing extra_attrs flattening behavior, but a serialization round-trip test confirms before lock-in.
- A2: `parameter_initial: [0.5]` 1-element list — pattern from bassoon-model.maxpat; confirm no MAX-version regressions.
- A3: gain~ outlet 0 role-stamped in current overrides.json — verify before integration test design.

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — every module/function read directly from repo source
- Architecture patterns: HIGH — patterns derived from existing `add_panel`/`add_step_marker`/`_identify_companions`
- Pitfalls: HIGH for #1-#4 (verified via code reading), MEDIUM for #5-#8 (logical inferences from locked decisions)
- Code examples: MEDIUM — skeletons compile mentally but are not executed; planner should treat as templates
- M4L `live.dial` shape: HIGH — extracted from actual working device (bassoon-model.maxpat)
- Testing strategy: HIGH — mirrors existing `test_schema_extensions.py` / `test_layout.py` conventions

**Research date:** 2026-04-30
**Valid until:** 2026-05-30 (30 days — repo-internal, low drift risk; key dependencies are versioned in git)
