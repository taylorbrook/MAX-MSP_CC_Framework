---
phase: 31-layout-ux-builders
reviewed: 2026-04-30T00:00:00Z
depth: standard
files_reviewed: 10
files_reviewed_list:
  - src/maxpat/patcher.py
  - src/maxpat/layout.py
  - tests/test_overlay_readout.py
  - tests/test_labeled_param_bank.py
  - tests/test_m4l_gen_synth.py
  - tests/test_companion_role_layout.py
  - tests/test_agent_skills.py
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
  - CLAUDE.md
findings:
  critical: 1
  warning: 5
  info: 4
  total: 10
status: issues_found
---

# Phase 31: Code Review Report

**Reviewed:** 2026-04-30
**Depth:** standard
**Files Reviewed:** 10
**Status:** issues_found

## Summary

Phase 31 adds three high-level builders (`add_overlay_readout`,
`add_labeled_param_bank`, `add_m4l_gen_synth`) plus a role-driven companion
dispatch (`_ROLE_COMPANION_MAP` + db threading through `_identify_companions`)
that codify CLAUDE.md recipes. Tests are thorough for the happy path and the
documented invariants (16-test M4L coverage including a Pitfall 4 round-trip
assertion for `param_connect` placement, byte-identical SKILL.md sections).

The implementation has one critical correctness gap and several layout/contract
defects worth addressing before we lean on these builders heavily:

1. **`add_overlay_readout(format=...)` is non-functional on `flonum`** — the
   default `type='flonum'` has no `format` attribute in the MAX object DB.
   `numdecimalplaces` is the real attribute. The docstring promises printf-style
   formatting (`'%.2f'`, `'%.1f Hz'`), but MAX silently ignores the unknown
   key. This is the most impactful finding because it affects the headline
   builder's API contract. (CR-01)
2. **`_ROLE_COMPANION_MAP['status']['placement'] = 'overlay'` is advertised
   but never honored** — `_place_companions` only ever places to the right.
   So a `flonum` claimed as a `status` companion is laid out as if it were an
   `audio→meter~` pair. Either implement the overlay branch or drop the field
   from the map. (WR-01)
3. **Pass A in `_identify_companions` lacks the "single parent" guard that
   Pass B requires** — a meter~ with two upstream sources will be silently
   claimed by whichever source's line iterates last. (WR-02)
4. **`add_m4l_gen_synth` doesn't enforce its documented invariants** —
   non-symbol param names, duplicate param names within a call, and duplicate
   `gen_varname` across calls all produce broken patches without any
   exception. (WR-03)
5. **`add_overlay_readout` does not track the target through `apply_layout`**
   — calling the builder before layout runs leaves the readout stranded at
   the target's pre-layout position; calling it after layout works. The
   docstring is silent on ordering. (WR-04)
6. **Label positioning in `add_labeled_param_bank` uses a too-tight width
   estimate (6 px/char vs. the 7 px/char + 16 px padding actually applied by
   `add_comment`)** — names ≥ 9 chars overlap the multislider's left edge;
   names ≥ 14 chars push the label to negative x. (WR-05)

## Critical Issues

### CR-01: `add_overlay_readout(format=...)` writes a non-existent attribute on flonum

**File:** `src/maxpat/patcher.py:739`
**Issue:**
The default `type='flonum'` has no `format` attribute in
`.claude/max-objects/max/objects.json` (lines 12417–12498). The docstring
promises `format` is "stored as `extra_attrs['format']`" with examples
`'%.2f'`, `'%.1f Hz'`. The closest real attribute is `numdecimalplaces`
(int), and even on `number` (line 22285) the `format` attribute is `int`-typed
(an enum: 0=int, 1=float, 2=octal, …), not a printf string. Result: every
caller passing a printf-style format gets it silently dropped at MAX load.

The current behaviour also cannot be salvaged with `type='number'` because the
caller's string format would be coerced/rejected by MAX's int parser.

**Fix:** Translate the format spec to the right attribute(s) per type. Minimum
fix:

```python
# In add_overlay_readout, replace:
readout.extra_attrs["format"] = format

# With type-aware mapping:
if type == "flonum":
    # Parse "%.Nf" → numdecimalplaces=N. Other format atoms are not
    # supported by flonum; raise so callers don't silently lose info.
    import re
    m = re.fullmatch(r"%\.(\d+)f", format.strip())
    if m is None:
        raise ValueError(
            f"flonum only supports '%.Nf' format strings (no unit "
            f"suffixes); got {format!r}. Use type='comment' + a "
            f"prepend chain for unit display."
        )
    readout.extra_attrs["numdecimalplaces"] = int(m.group(1))
elif type == "number":
    # number's format is an int enum (0=int, 1=float, ...). For now,
    # only accept '%.Nf' → format=1 (float), and stash decimals.
    ...
elif type == "comment":
    # comment has no native formatting; the prepend-chain is required.
    # Either ignore format silently or raise; ignoring silently was the
    # previous behavior and is acceptable here.
    pass
```

Also update the docstring to explicitly list which format atoms each `type`
supports, and update `test_format_string_baked` (currently asserts
`extra_attrs.get("format") == "%.1f Hz"` which is the bug-confirming test).

## Warnings

### WR-01: `_ROLE_COMPANION_MAP` advertises `placement: 'overlay'` but `_place_companions` always places right

**File:** `src/maxpat/layout.py:61` (map declaration), `src/maxpat/layout.py:666-694` (placer)
**Issue:**
The role map says `status -> {companion: 'flonum', placement: 'overlay'}`,
but `_place_companions` reads only the position (right of parent, same y)
and never branches on the placement field. So a curated `status` outlet
that wires to a `flonum` will be positioned beside the source rather than
overlaid on top — exactly the opposite of what `_ROLE_COMPANION_MAP`
documents and what the SKILL.md tables advertise to agents. The mismatch
between the data structure and the code is also a source of confusion for
future maintainers: looking at the map, you'd reasonably believe overlay
is implemented.

**Fix:** Either implement the overlay branch in `_place_companions` (using
`bring_to_front` + `ignoreclick=1` like `add_overlay_readout` does), or
remove the `placement` field from the map and document that companion
placement is always right-of-parent in Phase 31. Recommended (small):

```python
# In _place_companions:
for parent_id, comp_ids in parent_companions.items():
    parent = box_map.get(parent_id)
    if parent is None:
        continue

    cursor_x = parent.patching_rect[0] + parent.patching_rect[2] + _COMPANION_GAP
    for comp_id in comp_ids:
        comp_box = box_map.get(comp_id)
        if comp_box is None:
            continue
        # Look up placement from the role map; default to "right".
        placement = "right"
        # NOTE: _identify_companions doesn't currently propagate the
        # placement spec, so we'd need to either re-derive role here from
        # (parent.name, outlet) or extend the result dict to carry the
        # spec. Either approach works; both require a small refactor.
        if placement == "overlay":
            comp_box.patching_rect[0] = parent.patching_rect[0]
            comp_box.patching_rect[1] = parent.patching_rect[1]
            comp_box.extra_attrs.setdefault("ignoreclick", 1)
            # Z-order: caller has access to patcher; bring_to_front needs it.
        else:
            comp_box.patching_rect[0] = cursor_x
            comp_box.patching_rect[1] = parent.patching_rect[1]
            cursor_x += comp_box.patching_rect[2] + _COMPANION_GAP
```

If implementing overlay is out of scope for Phase 31, drop the `placement`
field from `_ROLE_COMPANION_MAP` to avoid encoding a contract the code
doesn't honor.

### WR-02: Pass A in `_identify_companions` claims companions with multiple parents

**File:** `src/maxpat/layout.py:631-648`
**Issue:**
Pass A iterates `lines` and unconditionally writes
`result[dst.id] = src` whenever `src` has a curated audio role and `dst`
is `meter~`. If a single `meter~` sums two audio sources (a perfectly
ordinary patch), the last source visited wins — silently and order-
dependent on `lines` insertion order. Pass B (legacy) explicitly skips
companions with `len(parents) != 1`, so the new role pass *weakens* the
invariant the legacy heuristic enforces.

This will manifest as a meter~ being placed under one source and a
disconnected-looking meter~ tag appearing far from the other source.

**Fix:** Apply the same single-parent guard before claiming a role-pass
companion:

```python
if companion_name and dst.name == companion_name:
    if len(incoming.get(dst.id, [])) != 1:
        # Don't auto-place a meter~ that fans in from multiple sources;
        # let the caller decide.
        continue
    result[dst.id] = src
```

The `incoming` dict is already built earlier in the function, so this
is a one-line addition.

### WR-03: `add_m4l_gen_synth` doesn't validate documented invariants

**File:** `src/maxpat/patcher.py:2059-2173`
**Issue:**
The docstring says param `name` "MUST be a valid MAX symbol" and
`gen_varname` "must be unique within a patcher (Pitfall 7)". Neither is
enforced. Concrete failure modes:

1. A param named `"freq cutoff"` (with space) writes
   `Param freq cutoff(...)` into GenExpr (compile fails with a warning,
   not an error), `varname=freq cutoff` (illegal MAX symbol, MAX may
   silently strip), and `param_connect=synth::freq cutoff` (Live binding
   broken).
2. Two param tuples sharing `name` produce two `live.dial`s with the same
   `varname` and the same `param_connect`. Live's binding behavior with
   duplicates is undefined.
3. Two calls to `add_m4l_gen_synth` on the same patcher with default
   `gen_varname='synth'` produce two gen~ boxes with identical
   `varname=synth`, breaking `param_connect` resolution for whichever
   wins.

The docstring acknowledges (1) and (3) as "caller responsibilities" but
the cost of a silent failure here is high (broken Live device that loads
without an obvious error), and the validation cost is small.

**Fix:** Add cheap pre-condition checks at the top of the method:

```python
import re
SYMBOL_RE = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")

if not params:
    raise ValueError("params must not be empty")

names = [p[0] for p in params]
for n in names:
    if not SYMBOL_RE.match(n):
        raise ValueError(
            f"param name {n!r} is not a valid MAX symbol "
            f"(must match [A-Za-z_][A-Za-z0-9_]*)"
        )
if len(set(names)) != len(names):
    dups = [n for n in names if names.count(n) > 1]
    raise ValueError(f"duplicate param names: {sorted(set(dups))}")

# Detect varname collision with existing gen~ in this patcher
existing_varnames = {
    b.extra_attrs.get("varname")
    for b in self.boxes
    if b.name == "gen~"
}
if gen_varname in existing_varnames:
    raise ValueError(
        f"gen_varname={gen_varname!r} collides with an existing gen~ "
        f"in this patcher; pass a unique gen_varname when adding "
        f"multiple skeletons"
    )
```

### WR-04: `add_overlay_readout` doesn't track target through `apply_layout`

**File:** `src/maxpat/patcher.py:688-744`
**Issue:**
`add_overlay_readout` copies `target.patching_rect` at call time and adds
the readout with `skip_overlap_check=True`. If the builder is called
before `finalize_patch` / `apply_layout` (the typical flow per Output
Protocol in both SKILL.md files), the target is at (0, 0) and the
overlay is also at (0, 0). When layout runs, it moves the target to its
final row position but the overlay stays at (0, 0) because:
- `flonum` is in `_UI_CONTROL_NAMES` (layout.py:41), so layout *would*
  reposition it — but only if it has *outgoing* connections to a target
  in the row graph. A pure overlay readout has only an incoming
  connection (e.g., from `snapshot~`), so `_identify_ui_controls` skips
  it.

Worse, if the caller wires the readout's outlet onward (e.g., to a
preset object), `_identify_ui_controls` would *re-position the readout
above its outgoing target*, defeating the overlay entirely.

**Fix:** At minimum, document the ordering requirement in the docstring
(call AFTER `apply_layout` / `finalize_patch`, or explicitly position
the target first). Better: mark overlay readouts with a sentinel that
`_identify_ui_controls` and `_place_ui_controls` respect:

```python
# In add_overlay_readout, after creating readout:
readout.extra_attrs["_overlay_target_id"] = target.id  # internal hint

# In layout._identify_ui_controls, skip readouts with an overlay hint:
if box_map[src].extra_attrs.get("_overlay_target_id"):
    continue
```

And in `_place_companions` / a new pass, re-anchor overlays to their
target's *current* position. Phase 31 plan should pick one of: (a)
contract documentation, (b) sentinel + re-anchor, (c) auto-call layout
inside the builder (rejected — layering violation per the M4L polish
note).

### WR-05: Label width formula in `add_labeled_param_bank` overlaps multislider for names ≥9 chars

**File:** `src/maxpat/patcher.py:826-835`
**Issue:**
Builder uses `approx_w = len(name) * 6.0 + 14.0` to position labels, but
`add_comment` calls `calculate_box_size(text, "comment")` which uses
`CHAR_WIDTH = 7.0` and `PADDING = 16.0` (defaults.py:11-12). For
`name = "frequency"` (9 chars), x=100, label_gap=8:

  - approx_w used for placement: 9*6 + 14 = 68
  - actual rect width set by `add_comment`: 9*7 + 16 = 79
  - label x = 100 - 68 - 8 = 24
  - label right edge = 24 + 79 = 103 (multislider x=100, **overlaps by 3px**)

For `name = "modulation_depth"` (16 chars):
  - label x = 100 - 110 - 8 = -18 (off-screen)
  - label right edge = -18 + 128 = 110 (overlaps by 10px)

The `test_label_x_left_of_multislider` only asserts `label.x < ms.x`; it
doesn't catch overlap because the comment rect width isn't checked.

**Fix:** Use the actual rect width from `add_comment`, not an estimate.
The cleanest version creates the comment first, then positions it:

```python
for i, (name, _mn, _mx) in enumerate(params):
    ly = y + i * 24.0
    # Create at temporary x; reposition after we know the actual width.
    c = self.add_comment(name, x=0.0, y=ly)
    actual_w = c.patching_rect[2]
    c.patching_rect[0] = x - actual_w - label_gap
    c.patching_rect[3] = 18.0
    c.fontsize = 10.0
    labels.append(c)
```

If the goal is to use fontsize=10 metrics throughout, also recompute the
patching_rect[2] manually using `len(name) * 6.0 + 14.0` so the layout
engine and visual rendering agree. Add a regression test that checks
`label.patching_rect[0] + label.patching_rect[2] <= ms.patching_rect[0]`
for a long-name parameter (≥12 chars).

## Info

### IN-01: `add_overlay_readout` `format` parameter accepts unit-bearing strings the docstring acknowledges aren't auto-rendered

**File:** `src/maxpat/patcher.py:708-713`
**Issue:**
The docstring explicitly notes: "Format strings with literal text (e.g.
`'%.1f Hz'`) are accepted but the unit suffix is NOT auto-rendered". So
the API accepts strings it doesn't honor. This is a UX trap — no error,
no warning, just silently truncated display. Combined with CR-01 (the
attribute isn't even read), this is two layers of nothing happening.

**Fix:** When CR-01 is fixed, raise on format strings with literals if
`type='flonum'/'number'`, pointing the caller at `type='comment'` +
prepend chain.

### IN-02: `add_labeled_param_bank` overrides `fontsize=10` without recomputing patching_rect

**File:** `src/maxpat/patcher.py:832-834`
**Issue:**
`add_comment` sized the box at default fontsize=12. The builder then
sets `c.fontsize = 10.0` and `c.patching_rect[3] = 18.0` (height) but
doesn't shrink the width. Since CLAUDE.md `Multislider as Labeled
Parameter Bank` § says "for fontsize=10 labels: use height=18",
shrinking width to match the smaller font is the consistent thing to do.
This is also the underlying issue causing WR-05.

**Fix:** Recompute width using fontsize-10 metrics:

```python
# Approximate fontsize-10 width: 6 px/char + 14 px padding (matches the
# label_gap formula already in use).
c.patching_rect[2] = len(name) * 6.0 + 14.0
```

### IN-03: `add_m4l_gen_synth` hard-codes layout coordinates that the layout engine will overwrite

**File:** `src/maxpat/patcher.py:2129, 2135, 2141-2143`
**Issue:**
`add_gen(gen_code, ..., x=200.0, y=200.0)`, `plugout~ at (200, 400)`,
dial row starting at `(50, 100)` — these are baked positions that
`apply_layout` will re-derive based on connectivity anyway. The hardcoded
coordinates will only matter if `apply_layout` is *not* run, in which
case the layout still won't be Live-ready (tiny dials, plugout~ not in
presentation mode, etc.).

**Fix:** Either drop the explicit positions (let layout handle them) or
add a comment that explains they're sentinel values for pre-layout
inspection. Defaults of `x=0.0, y=0.0` would be more honest.

### IN-04: Generic `except Exception` swallows real DB errors

**File:** `src/maxpat/layout.py:638-641`
**Issue:**
```python
try:
    role = db.get_signal_role(src.name, line.source_outlet)
except Exception:
    role = None
```

`get_signal_role` is documented to return `None` for unknown objects /
out-of-range outlets / unaudited outlets. It doesn't raise on those
paths. So this `except Exception` is catching real bugs (e.g., DB
state corruption, refactoring breakage) and converting them to silent
"role=None" fall-through. That's exactly the kind of regression-friendly
swallow the user has flagged before.

**Fix:** Either drop the try/except entirely (let exceptions surface)
or narrow it to a specific exception class with a comment explaining
which path raises and why fallback is correct:

```python
# get_signal_role returns None for unknown/uncurated outlets; no
# exception path documented. Keep narrow if Phase 28 ever raises.
role = db.get_signal_role(src.name, line.source_outlet)
```

If Phase 28 has documented exceptions, catch only those.

---

_Reviewed: 2026-04-30_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
