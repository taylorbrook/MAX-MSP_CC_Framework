# Shared Agent Capabilities

> Referenced by specialist agent SKILL.md files. Load this file alongside SKILL.md for full capability context.
> Path: `.claude/skills/references/shared-capabilities.md`

## Max 9.2

The installed Max is 9.2.0 and the object database was synced against it (2026-10-01).

- **What changed for generation:** `.claude/skills/references/max-9.2-changes.md` — the 12 new objects (`min_version: 9.2`), 9.2-only messages and attributes on existing objects (`buffer~`, `udpsend` / `udpreceive`, `coll`, `pattrstorage`, ...), the `v8` additions, and what is still untested. Every claim there carries an evidence tier; `[notes]` items must not be relied on without a test in MAX.
- **Compatibility:** 9.2-only messages and attributes are not version-tagged in the DB. If a patch must open on an older 9.x build, avoid them and the 12 new objects.
- **Gen~:** 9.2's compiler fixes retire none of CLAUDE.md's gen~ rules.
- **After a Max update:** `python3 tools/audit_db.py` (read-only drift report), then `python3 tools/sync_max_bundle.py` (dry-run), then `--apply` with explicit `--names`. Never hand-write a DB entry for a new object. Full procedure: `.claude/skills/references/db-maintenance.md`.

## Reference Docs

- **`.claude/skills/references/severity-contract.md`** — read when a validator or critic finding comes back, before deciding to fix, report or save: what each level means and which findings block `save_patch_roundtrip` / `write_gendsp`.
- **`.claude/skills/references/troubleshooting.md`** — read when the user reports a MAX console message (No such object, doesn't understand, gen~ compile errors, FluCoMa errors): cause and fix per message.
- **`.claude/skills/references/proven-forms.md`** — read before generating trigger / arithmetic chains, MC per-channel data, FluCoMa, poly~ voices, `waveform~` / `flonum` UI, or before moving boxes inside subpatchers: forms confirmed in MAX, with evidence tiers.
- **`.claude/skills/references/genexpr-rules.md`** — read before writing or editing GenExpr (codebox, `.gendsp`, `mc.gen~`): the full gen~ rule set with derivations and per-version evidence.
- **`.claude/skills/references/db-maintenance.md`** — read before editing `.claude/max-objects/` data or re-syncing after a Max update: override merge semantics, refpage authority, empty-I/O audits, the sync procedure.

## Assistance Comments on Inlets/Outlets

- When calling `add_subpatcher()`, ALWAYS provide `inlet_comments` and `outlet_comments` with descriptive labels
- Example: `p.add_subpatcher("audio_proc", inlets=2, outlets=1, inlet_comments=["Audio Input Left", "Audio Input Right"], outlet_comments=["Processed Output"])`
- If you forget or cannot determine comments at creation time, call `patcher.populate_assistance_comments()` after building all connections -- it auto-infers from connection context
- Comments appear as mouseover tooltips in MAX when hovering over the parent object's inlets/outlets
- **Direct JSON edits:** When editing .maxpat JSON directly (not via the Python API), you MUST manually include a `"comment"` attribute on any inlet or outlet box dictionary being added or modified. Example: `{"maxclass": "inlet", "comment": "Audio Input Left", ...}`. The auto-populate method only works via the Patcher API, so direct JSON manipulation requires explicit comment attributes.

## Patch Finalization

- `finalize_patch(patcher, is_new=True, *, force_layout=False)` -- single-call layout cleanup hook. For new patches (`is_new=True`): applies auto-styling, layout, assistance comments, midpoints. It first checks the layout guard: a MAX-saved patcher, or one over the box limit, raises `LayoutRefusedError` (a `ValueError`, from `src.maxpat.layout`) before anything is restyled or moved; pass `force_layout=True` for a large new build. For edited patches (`is_new=False`): never moves objects, never restyles and never clears existing midpoints; it routes only cords that have no midpoints and are new or touch an added or moved box, and fills empty assistance comments. Use `is_new=False` (or `edit_patch`) for anything read from disk.
- Import from `src.maxpat`: `from src.maxpat import finalize_patch`
- Replaces manual `_apply_auto_styling()` + `apply_layout()` + `populate_assistance_comments()` calls

## Z-Order Manipulation

In `.maxpat` files, z-order is implicit: objects **earlier** in the `boxes` array render **on top** (index 0 = topmost).

**Patcher methods:**
- `patcher.bring_to_front(box)` -- move box to index 0 (renders on top of everything)
- `patcher.send_to_back(box)` -- move box to end of array (renders behind everything)
- `patcher.set_z_index(box, index)` -- place box at specific array position (0 = front)

**Overlay readout pattern** (flonum/number displayed on top of dial/slider):
1. Create the interactive control (dial, slider, etc.)
2. Create the readout (flonum, number)
3. Call `patcher.bring_to_front(readout)` to move it to index 0 (renders on top of dial)
4. Set `extra_attrs["ignoreclick"] = 1` on the readout so mouse events pass through (omit for editable readouts)
5. Position readout overlapping the control

**Background elements** (panels, markers) use `background=1` attribute -- `add_panel()` and `add_step_marker()` set this automatically to force behind all objects regardless of array position.

## Control-Rate Fan-Out Rule (MUST)

When a control-rate outlet connects to 2+ destinations, you **MUST** use a `trigger` (t) object. Direct multi-connect from one outlet to multiple inlets is **NEVER** acceptable for control-rate connections.

**Signal-rate exemption:** MSP signal (~) fan-out is safe and does NOT require trigger. All signal inlets process simultaneously at audio rate, so execution order is not a concern for signal connections.

### Before/After Example

**WRONG -- direct fan-out (undefined execution order):**
```
[button]
  |  \
  |   \
  v    v
[counter] [toggle]
```
The outlet of button connects to both counter inlet 0 and toggle inlet 0. Execution order is undefined -- MAX may fire them in any order.

**RIGHT -- trigger for explicit ordering:**
```
[button]
  |
  v
[t b b]
  |   \
  v    v
[counter] [toggle]
```
trigger fires right-to-left: toggle gets bang first, then counter. Order is explicit and predictable.

### Enforcement

The structure critic (`src/maxpat/critics/structure_critic.py`) detects fan-out without trigger and flags it. Agents must not produce patterns that trigger this finding.

**This applies to ALL control-rate fan-out, even when execution order "does not matter." Always use trigger -- no exceptions for control-rate.**

## Aesthetic Capabilities

**Aesthetic auto-styling (call explicitly for new patches):**
- `from src.maxpat import _apply_auto_styling; _apply_auto_styling(patcher)` -- sets canvas background, highlights dac~/loadbang
- Existing user-set bgcolor is never overwritten

**Patcher methods for explicit styling:**
- `add_section_header(text)` -- 16pt bold colored header with background (for patch sections)
- `add_subsection(text)` -- 12pt bold dark gray label (for subsection grouping)
- `add_annotation(text, target=box)` -- 10pt italic light gray note (for inline documentation)
- `add_bubble(text, bubbleside=1)` -- comment with arrow pointer (for callout notes)
- `add_panel(x, y, w, h, gradient=True)` -- background panel for visual grouping
- `add_step_marker(number, x, y)` -- numbered amber circle (for step-by-step patches)

**Aesthetics helpers (from `src.maxpat.aesthetics`):**
- `set_canvas_background(patcher, color=None)` -- override default canvas color
- `set_object_bgcolor(box, palette_key=None, color=None)` -- highlight specific objects
- `auto_size_panel(boxes, padding=18)` -- compute panel rect to enclose a group of boxes

## Layout Options

`from src.maxpat import LayoutOptions`

- `apply_layout(patcher, options=LayoutOptions(...))` -- customize layout
- `v_spacing` (default 20.0) -- vertical gap between rows in pixels
- `h_gutter` (default 15.0) -- horizontal gap between sibling objects
- `patcher_padding` (default 40.0) -- padding around content for auto-sized patcher rect
- `grid_size` (default 15.0) -- grid cell size in pixels (when grid_snap enabled)
- `grid_snap` (default True) -- snap box positions to grid_size grid
- `inlet_align` (default True) -- adjust child x-position to straighten cables to parent inlets
- `comment_gap` (default 10.0) -- horizontal offset for associated comment placement

## Builder API (Phase 31)

High-level builders on `Patcher` codify recipes that previously lived as
prose in CLAUDE.md. Prefer these over restating the recipes per patch.

### `Patcher.add_overlay_readout(target, *, format='%.2f', type='flonum', editable=False, offset_x=0, offset_y=0) -> Box`

Create a flonum/comment/number readout overlapping a target dial or numeric
control. Codifies the CLAUDE.md §"Rule #6: Z-Order Awareness" overlay
recipe — bakes in `bring_to_front` (overlay renders on top) and
`ignoreclick=1` (clicks pass through to underlying control).

- `target`: The Box to overlay (typically `dial` or another numeric control).
- `format`: printf-style format string (e.g. `'%.2f'`). For
  `type='flonum'`/`type='number'`, the builder translates `'%.Nf'` to
  `extra_attrs["numdecimalplaces"]=N` (flonum/number have no `format`
  attribute — MAX would silently drop a literal `format` key). Format
  strings with literal text or non-`%.Nf` patterns (e.g. `'%.1f Hz'`,
  `'%d'`, `'%.2g'`) raise `ValueError` on flonum/number; use
  `type='comment'` + a separate prepend chain for unit text display. For
  `type='comment'`, the format kwarg is informational only (comments
  display literal text — no native formatting attribute exists).
- `type`: `'flonum'` (default), `'comment'`, or `'number'`.
- `editable`: Default False bakes `ignoreclick=1`. Pass `True` for the rare
  M4L case where the readout itself is editable.
- `offset_x` / `offset_y`: Fine-tune position relative to target's rect.

**When to call:** Anytime you create a dial-with-flonum-readout pattern.
Replaces the 5-step manual recipe in "Z-Order Manipulation" above and in the `add_overlay_readout` docstring.

### `Patcher.add_labeled_param_bank(params, x, y, *, label_side='left', extra_attrs=None) -> tuple[Box, list[Box]]`

Build a `multislider` parameter bank with aligned comment labels. Codifies
the "Multislider as Labeled Parameter Bank" rules below — bakes in
`size=len(params)`, `height=size*24`, `orientation=0`, `contdata=1`,
`setstyle=1`, `setminmax=[min(mins), max(maxes)]`.

- `params`: List of `(name, min, max)` tuples — one bar per tuple.
- `x` / `y`: Multislider position. Labels start at the same y.
- `label_side`: Only `'left'` is supported in Phase 31.
- `extra_attrs`: Optional dict deep-merged over baked defaults (caller wins
  on collision).

Returns `(multislider, [comment, ...])`. **Caller wires `fetch $1` to the
multislider input themselves and reads values from the multislider's RIGHT
outlet (outlet 1)** — see "Reading values by index" below.

**When to call:** Anytime you need a vertical bank of N labeled parameter
bars with shared range. For widely-varying ranges, prefer individual
`dial`+`flonum` overlays (the multislider envelope `setminmax` does not
enforce per-bar limits).

#### Multislider as Labeled Parameter Bank

> Codified: `Patcher.add_labeled_param_bank(params, x, y)` (Phase 31). Its docstring holds the full recipe (alignment formula, attributes, 14-param example); prefer the builder.

Manual banks: `orientation: 0`, `contdata: 1`, `setstyle: 1`, height = size * 24 for 24px label spacing; put utility/routing objects (prepend chains, init messages, js engines) in named subpatchers.

**Reading values by index:** send `fetch $1` (NOT `fetchindex` -- it does not exist). The fetched value emerges from the **right** outlet (outlet 1); outlet 0 is for direct-edit/drag interaction. Don't insert `split` between multislider and the consumer -- multislider already emits the correct values, and `split` filters out valid step data.

### `Patcher.add_m4l_gen_synth(params, *, gen_varname='synth', gen_code=None) -> tuple[Box, list[Box], Box]`

`add_m4l_gen_synth` and `polish_m4l_device`: **Experimental:** not yet confirmed in MAX or Live.

Build a Live-ready M4L gen synth skeleton: `gen~` (with stable `varname`),
one `live.dial` per param (bound via `param_connect`), and `plugout~`
directly fed by gen~'s outlet (NO `gain~`/`live.gain~`/`ezdac~` between —
"Max for Live Device Rules" below).

- `params`: List of `(name, min, max)` tuples — one `live.dial` per param.
  Names MUST be valid MAX symbols.
- `gen_varname`: gen~'s `varname` (default `'synth'`). Must be unique per
  patcher when adding multiple skeletons.
- `gen_code`: Optional GenExpr body. If None, an empty body
  (`Param` declarations + `out1 = 0;`) is emitted so gen~ compiles. Caller
  replaces with real DSP.

Returns `(gen, [live_dial, ...], plugout)`. Each `live.dial` has the full
`param_connect: "<gen_varname>::<name>"` + `parameter_enable=1` +
`saved_attribute_attributes.valueof` block. The skeleton is polish-ready;
run `polish_m4l_device(patcher.to_dict())` afterward if desired (do NOT
call from inside the builder — layering violation).

**When to call:** Starting a new M4L `.amxd` device with a synth/effect
body. Replaces the manual `param_connect` setup recipe.

### `Patcher.add_m4l_device(kind, params=None, *, audio_source=None, midi_source=None, midi_in=True, init_chain=True, banks=True, presentation=True, modmode=None, info_text=None)`

**Experimental:** not yet confirmed in Live (the combined Q15/Q40 Live check is pending).

Build the device skeleton for `kind` `instrument` / `audio_effect` / `midi_effect`: Live-template wiring (`plugin~` / `plugout~`, `midiin` / `midiout`), the `live.thisdevice` init chain, one `live.dial` per param (unit and type inferred from range and name; explicit keys win), unique short names and Push `parameterbanks`. `add_m4l_gen_synth` is built on it.

- **Reuse:** an existing top-scope `plugin~`, `plugout~`, `midiin`, `midiout` or `live.thisdevice` is reused, never duplicated, and the pass-through feeds only output inlets nothing feeds yet, so a `plugin~ -> fx -> plugout~` chain never gets a dry path. Two boxes of one of those names raise `ValueError` before anything is built.
- **Names:** a param long name equal to an existing `parameter_longname`, or an explicit short name already taken, raises `ValueError`; auto short names avoid the existing ones.
- **Info text:** new dials get `annotation` / `annotation_name` when `info_text` is True (None follows `presentation`).
- **Layout:** when a new box would overlap a pre-existing one, all new boxes shift right together.

### `export_amxd(patcher_or_path, out_path=None, kind=None) -> Path`

From `src.maxpat.m4l_device`. **Experimental.** Save the `.maxpat` first (it is the source of truth), then write the `.amxd` next to it. The kind is detected from the patch (`detect_m4l_device_type`); an explicit `kind` that disagrees warns, and an unknown kind raises. A `live.thisdevice`-only patch is a helper abstraction, not a device: it raises unless `kind=` is given.

### Role-driven companion-pair placement (passive — applied by `apply_layout`)

`apply_layout` consults a `_ROLE_COMPANION_MAP` in `layout.py` that maps
`signal_role` → companion placement using the Phase 28/30 `signal_role`
schema. Mapping (Phase 31 D-14):

| Source outlet role | Companion | Placement |
|--------------------|-----------|-----------|
| `audio`            | `meter~`  | right of source |
| `status`           | `flonum`  | overlay (on top, ignoreclick=1) |
| `trigger`/`float`/`data`/`list` | (none) | (caller decides) |

Falls through to the legacy `_COMPANION_NAMES` heuristic when a source
outlet's role is `None` (unaudited). **What this means for agents:** when
you add a `meter~` connected to an audio outlet, you don't need to position
it manually — `apply_layout` does it via the role map. Same for `flonum`
overlays on `status` outlets. For other roles, position the companion
yourself or use `add_overlay_readout` explicitly.

### Quick reference

| Use case | Builder | Replaces (CLAUDE.md) |
|----------|---------|----------------------|
| dial+flonum readout overlay | `add_overlay_readout(dial)` | §"Rule #6: Z-Order Awareness" recipe |
| N-parameter labeled multislider | `add_labeled_param_bank([(name, mn, mx), ...], x, y)` | §"Multislider as Labeled Parameter Bank" recipe |
| M4L gen synth skeleton | `add_m4l_gen_synth([(name, mn, mx), ...])` | §"Domain-Specific Rules → Max for Live (M4L)" recipe |
| M4L device skeleton (any kind) + `.amxd` | `add_m4l_device(kind, params)`, then `export_amxd(maxpat_path)` | §"Max for Live (M4L / .amxd)" |
| Auto-place meter~ on audio outlet / flonum on status outlet | (none — `apply_layout` does it via `_ROLE_COMPANION_MAP`) | manual companion positioning |

## Max for Live Device Rules

**Experimental:** not yet confirmed in MAX or Live.

> Codified (EXPERIMENTAL, unconfirmed in Live): `Patcher.add_m4l_device(kind, params)` (kind `instrument` / `audio_effect` / `midi_effect`) builds the skeleton: Live-template wiring, the `live.thisdevice` init chain, `live.dial` params with unit/type inferred from range and name (explicit keys win), unique short names and Push `parameterbanks`. `Patcher.add_m4l_gen_synth(params)` (Phase 31) is built on it. Save the .maxpat (the source of truth), then `export_amxd(maxpat_path)` from `src.maxpat.m4l_device` writes the .amxd next to it. It reuses existing device I/O and refuses taken parameter names; `export_amxd` refuses a `live.thisdevice`-only helper abstraction without `kind=`. The rules below still apply.

- **No `gain~` / `live.gain~` / `ezdac~` before `plugout~`.** Route the final stage directly to `plugout~`; Ableton's mixer handles volume, pan and mute (`gain~` defaults to 0, silence on load).
- **`live.dial` / `live.slider` bind to gen~ Params via `param_connect`, not message-box patching:** `param_connect: "<gen~_varname>::<param_name>"`, `parameter_enable: 1` and the `saved_attribute_attributes.valueof` block (keys in the `add_m4l_gen_synth` docstring). The gen~ needs a stable `varname` matching the prefix; no patch cord -- `param_connect` IS the binding.
- Without `param_connect`, the dial is not in Live's parameter list and is not Live-automatable.
- **Slider -> line~ -> gen~ signal-rate exception:** `param_connect` binds only Params, so keep the `slider -> line~ -> gen~` path and add `parameter_enable: 1` + `saved_attribute_attributes.valueof` to the slider itself so Live can still automate it.

## bach (package) Rules

- `bach.llll2list` and `bach.list2llll` do NOT exist in the installed bach package (stale DB entries; "No such object" at load). Extract sub-llll values with `bach.nth N` (1-based, one call per index), adding `@unwrap 1` when the element is itself a sublist. Flat MAX lists connect directly; use `bach.flat`, `bach.iter` or `bach.pack` for complex conversions.
- Every bach object's `@out` defaults to `n` (native), which plain MAX objects (`f`, `select`, `unpack`, `expr`) reject with "wrong message or type": set `@out t` (one char per llll outlet) on any bach object feeding a non-bach consumer. Flat sublists then arrive as regular lists (`unpack f f` works).

## Editing Functions

- `with edit_patch(path) as patcher:` -- edit session on an existing patch (Q36): re-reads the file on entry; a clean exit routes touched cords, sets contrast on added boxes that carry an explicit textcolor and saves through the gate (keep `session = edit_patch(path)` to read `session.diff`, `session.saved`, `session.commit_hash`)
- `patcher.diff(other)` -- semantic diff from this Patcher to `other` (boxes added/removed/moved/resized, text, attrs, presentation, cords, nested paths); `.render()` gives the compact text
- `read_patch(path)` -- load .maxpat into (Patcher, original_text) tuple (analysis, or the manual path)
- `patcher.analyze()` -- structured 7-facet summary of patch contents
- `patcher.find_box(name=..., maxclass=..., text=...)` -- search for a single object
- `patcher.find_boxes(name=..., maxclass=..., text=...)` -- search for multiple objects
- `patcher.modify_box(box, args=..., position=..., color=..., extra_attrs=...)` -- in-place attribute editing. `args` sets the text of a newobj (name kept), a message or comment, or a text-bearing UI box (textbutton, live.text, live.comment, textedit: no name prefix, size kept); `args` on any other UI box raises `ValueError` before any change -- use `extra_attrs`. `extra_attrs` keys `patching_rect`, `text` and `saved_object_attributes` set the model fields (`text` on a newobj raises: use `args`); the structural keys `id`, `maxclass`, `numinlets`, `numoutlets`, `outlettype` and `patcher` raise
- `patcher.insert_into_connection(src, dst, name, args)` -- insert a new object between two connected boxes (returns an EditResult)
- `patcher.replace_box_safe(box, new_name, args=[...])` -- swap object type keeping the box's identity (id, list position, presentation rect, varname, colours, parameter blocks, and the size for the same fixed-size UI class or unchanged text); an embedded patcher moves to the new box only for the same name or `gen~` <-> `mc.gen~` (I/O and outlettype follow, `signal` <-> `multichannelsignal`), and any other replace of a box with an embedded patcher raises `ValueError` with the patch untouched; rewires every cord whose outlet/inlet index still exists on the new box and returns the rest in `result.orphaned` (CLAUDE.md Rule #8). Plain `replace_box(box, new_name, args=...)` keeps the identity too but orphans every connection.
- `patcher.remove_box(box)` -- remove object and clean up connections
- `patcher.connected_components()` -- identify groups for section rebuild scope
- `save_patch_roundtrip(patcher.to_dict(), path, original_text)` -- save preserving positions (manual path; the session calls it for you)

## Edit Workflow

One Python script, one session (a `with` block cannot span separate tool calls):

```python
session = edit_patch(path)
with session as patcher:
    summary = patcher.analyze()                        # analyze
    box = patcher.find_box(name="target_object")       # find targets
    result = patcher.modify_box(box, args=["new_value"])  # make changes
    results = validate_patch(patcher)                  # validate; raise here to discard
print(session.diff.render())                           # show the user what changed
```

Leaving the block saves: touched-cord routing, contrast on added boxes that carry an explicit textcolor, stale check + save gate, atomic write in the file's own layout, path-scoped commit. A no-op session writes nothing. `StaleFileError` / `PatchValidationError` propagate with the file untouched -- re-run the session after fixing; `edit_patch(path, force=True)` only with user confirmation.

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove, inside one session: `with edit_patch(path) as patcher:`
3. Validate via `validate_patch(patcher)` inside the block (raise to discard on blockers)
4. Return for critic review
5. Leave the block to save: exit routes touched cords (never clears existing midpoints), sets text contrast only on added boxes that carry an explicit textcolor (moved, presentation-changed and replaced boxes keep their colour; a comment without a textcolor is never given one) and saves through the gate with `save_patch_roundtrip()`; show `session.diff.render()` to the user
6. Manual path (no session): `finalize_patch(patcher, is_new=False)` then `save_patch_roundtrip(patcher.to_dict(), path, original_text)` -- finalize also fills empty inlet/outlet assistance comments, which the session does not

Moving or adding a panel does not recolour existing text over it: treat the layout critic's "Low contrast text" warnings on boxes with an explicit textcolor as must-fix (Rule #9), and fix them by hand. A warning on a comment without a textcolor is a critic false positive (MAX renders it in the theme text colour). Never run whole-patch `repair_text_contrast` unless the user asks.

## Version Comment

- `from src.maxpat.project import update_version_comment`
- `update_version_comment(patcher, version_string)` -- adds or updates a `vX.Y.Z` comment in top-right of patch
- Existing version comments are updated in place (no duplicates)
- Called automatically by `/max-iterate` after version bump, before save

## Patch Safety -- Auto-Commit and Isolation

Every `save_patch_roundtrip()`, `write_gendsp()`, and `write_js()` call automatically commits the saved file to git via `auto_commit_patch()`. This prevents work loss from stash operations, branch switches, or concurrent Claude instances.

Before writing, `save_patch_roundtrip()` and `write_gendsp()` (and the `edit_patch` session exit, which calls `save_patch_roundtrip()`) also run a save gate (validation + critics against the `original_text` / HEAD / on-disk baseline): a save that introduces a blocker or reorders a subpatcher's inlets/outlets raises `PatchValidationError` and nothing is written or committed; removed cords emit a `SaveGateWarning`. The gate validates with the file's path, so an unknown object that no abstraction beside the patch (or in its `patches/<project>/` tree) resolves is a blocker: save abstractions before the patch that uses them. Fix the findings; `force=True` bypasses only with user confirmation. See CLAUDE.md Rule #7. All writers write atomically (temp file + fsync + `os.replace`), so a crash never leaves a partial file.

### Rules

1. **Never use `git stash`** during patch work. Stash operations have caused orphaned work in the past (3 stashes with significant patch changes were found abandoned). If you need to switch context, commit first.
2. **Commit scope isolation** -- `auto_commit_patch()` only stages files within the specific project directory. This allows multiple Claude instances to work on different patches simultaneously without conflicts.
3. **Version entries track files** -- `bump_version()` accepts `files_changed` to record which files were modified in each version entry.
4. **Manual commit for multi-file saves** -- if a build/iterate produces multiple files saved via separate calls, run one explicit `auto_commit_patch()` at the end with all file paths to create a single clean commit (the per-file auto-commits are fine too, just noisier). Called directly, `auto_commit_patch()` raises `RuntimeError` on any git failure (the save wrappers catch it and warn).

### Multi-Instance Safety

Multiple Claude instances can work on different patches concurrently because:
- Each instance commits only files under its active project's directory
- `auto_commit_patch()` uses `git add {specific files}`, not `git add .`
- No stash/merge/rebase operations are used during patch work
- If a merge conflict occurs (unlikely with project isolation), the instance should stop and alert the user rather than attempting resolution
