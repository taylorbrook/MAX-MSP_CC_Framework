# MAX Development Framework

This file defines how Claude works with MAX/MSP patches and code in this project. Every rule here is mandatory. When generating patches, writing GenExpr, creating RNBO exports, or scripting with Node for Max / js objects, follow these rules exactly. Each rule is a one-line imperative; where detail moved out, the rule names its home.

Reference docs:
- `.claude/skills/references/db-maintenance.md` -- object-DB internals: override merging, refpage authority, empty-I/O audits, re-sync after a Max update
- `.claude/skills/references/genexpr-rules.md` -- full gen~ rules with derivations and per-version evidence (max-dsp-agent loads it)
- `.claude/skills/references/ui-presets.md` -- UI presets, Max 9 theme defaults and the "Text Contrast Resolution" algorithm
- `.claude/skills/references/severity-contract.md` -- what validator and critic findings mean, and which block a save
- `.claude/skills/references/troubleshooting.md` -- MAX console error -> cause -> fix
- `.claude/skills/references/proven-forms.md` -- forms confirmed in MAX, with evidence tiers
- `.claude/skills/references/max-9.2-changes.md` -- Max 9.2 objects, messages, attributes and v8 APIs
- `.claude/skills/references/shared-capabilities.md` -- capabilities every specialist agent shares (styling, layout, editing)

## Object Database

The object knowledge base lives at `.claude/max-objects/`: one `objects.json` per domain (`max`, `msp`, `jitter`, `mc`, `gen`, `m4l`, `rnbo`) plus `packages/<Package>/objects.json`. Each entry is keyed by object name: `name`, `maxclass`, `module`, `domain`, `inlets` (id/type/signal/hot), `outlets` (id/type/signal), `arguments`, `messages`, `min_version`, `verified`, `rnbo_compatible`, `variable_io`.

### Supplementary Files

- **`overrides.json`** -- expert corrections that take precedence over extracted data (merged per port; semantics in `db-maintenance.md`).
- **`aliases.json`** -- shortcuts mapped to canonical names (`t` -> `trigger`, `b` -> `bangbang`, `sel` -> `select`); also the bundle's `max objectfile` shortcuts (`mc.times~`, `hslider`, `list.*` -> `zl.*`, `jit.+`, Vizzie short names).
- **`relationships.json`** -- common pairings and companions (`tapin~`/`tapout~`, `notein`/`stripnote`).
- **`pd-blocklist.json`** -- Pure Data objects that do NOT exist in MAX, with their MAX equivalents.
- **`extraction-log.json`** -- extraction metadata and statistics.
- **`groups.json`** -- inherited group names (mc wrapper, shared Jitter, thispatcher selectors); written only by `tools/sync_max_bundle.py --apply groups`, merged at call time by `ObjectDatabase`, never copied into domain files.
- **`idioms.json`** -- cords the bundle's own help patches ship; validation Layer 3 never type/role-checks a listed cord (bounds always); written only by `--apply idioms`.
- **`version_io.json`** -- per-version I/O changes mined from help boxes saved by different Max builds; written only by `--apply version-io`.

### How to Use the Database

**Primary method -- `ObjectDatabase`:** use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups. It loads all 8 domain files, resolves aliases, applies overrides, and checks the PD blocklist.

```python
from src.maxpat.db_lookup import ObjectDatabase

db = ObjectDatabase()
obj = db.lookup("cycle~")                          # Returns object dict or None, auto-resolves aliases
db.exists("t")                                     # True (resolves alias to "trigger")
db.is_pd_object("osc~")                            # True (PD object, not MAX)
db.get_pd_equivalent("osc~")                       # "cycle~"
db.compute_io_counts("trigger", ["b", "i", "f"])   # (1, 3)
db.get_outlet_types("cycle~")                      # ["signal"]
```

`lookup()` returns only an object's own messages/attributes. For message or attribute questions use `db.messages(name)`, `db.attributes(name)` (typed) or `db.selectors(name)` (every accepted selector); they add inherited `groups.json` names (e.g. `applyvalues`/`setvalue` on mc.* wrappers).

**Browse by domain:** read `.claude/max-objects/{domain}/objects.json` only for bulk browsing; for companions look the name up in `relationships.json`.

DB rules (detail and evidence: `db-maintenance.md`):
- **Verify lookup results have non-empty I/O.** Treat `inlets: []` + `outlets: []` entries as missing (check inlet/outlet lengths, not just `exists()`) and fill them via `overrides.json`; `db.audit_empty_io()` and `db.audit_half_empty_io()` list gaps (one-side-empty sinks/sources are legitimate). Search `packages/`, `overrides.json` and existing `patches/` before adding an object.
- **The `maxclass` field in the DB is NOT authoritative.** `UI_MAXCLASSES` in `src/maxpat/maxclass_map.py` is; most objects are `newobj` with the name in `text`, and a non-UI `maxclass` causes "invalid attribute maxclass" at load.
- **The authoritative object name is the refpage's `<c74object name>` attribute, never the filename** (define-mapped aliases excepted); `python3 tools/audit_db.py` recomputes the drift.
- **Refpages are authoritative for I/O counts far more than for types, and must never overwrite expert overrides.** When a refpage and a shipped help box disagree on types, the help box wins.
- **After a Max update, re-sync the DB from the installed bundle:** `python3 tools/audit_db.py`, then a `python3 tools/sync_max_bundle.py` dry-run, then explicit `--apply` steps.

## Rules

### Rule #1: Never Guess Objects

THE cardinal rule. If an object is not in the database, DO NOT use it. Do not hallucinate object names, inlet counts, outlet counts, or behaviors from training data: look it up, and if it is not there it does not exist for our purposes. Flag the gap with a comment: `// UNKNOWN OBJECT: [name] -- not in database, verify manually`. Being in the database is not enough: check `lookup()['domain']` — an object whose only entries are RNBO or Gen (`expr~`, `wrap~`, `counter~`, `history`) is "No such object" in a Max/MSP patcher. `db.get_effective_restrictions(name)` says where it may go (`[]` means anywhere; the RNBO-domain entries `rnbo~` and `rnbo.remote` are real Max objects marked `[]`, and the `list.*` names are aliases of their `zl.*` objects); `Patcher.add_box` raises outside those contexts, and `validate_patch` errors on it in every Max scope. An unknown name blocks a save unless an abstraction (`NAME.maxpat`/`.js`/`.gendsp`) sits beside the patch or in its project: save abstractions first.

This applies to everything: object names, argument formats, message names, attribute names, inlet/outlet counts. The database is the single source of truth.

### Rule #2: Verify Before Connect

Before creating any connection between objects, verify:
- Source outlet and destination inlet indices are within bounds (accounting for `variable_io` rules): never connect outlet index 2 on an object that only has 2 outlets. Always count from the database.
- Signal type compatibility: signal outlets connect to signal inlets, control outlets to control inlets. Exception: signal/float inlets accept both signal and control connections.

What validator and critic findings mean, and which ones block a save: `.claude/skills/references/severity-contract.md`.

### Rule #3: Hot/Cold Inlet Ordering

When sending multiple values to an object:
- Send to cold inlets FIRST (right to left)
- Send to hot inlet LAST (leftmost, inlet 0) -- this triggers computation
- Use `trigger` (t) for explicit fan-out ordering when timing matters; wrong order makes objects compute with stale values. Always use `trigger` for explicit ordering.
- Signal inlets are all "hot" in the audio domain -- ordering does not apply for MSP signal connections

### Rule #4: Patch Style

- Top-to-bottom signal flow (audio and control flow down)
- Use explicit `trigger` objects for fan-out instead of connecting one outlet to multiple inlets
- Add `comment` objects on non-obvious connections
- Prefer named `send`/`receive` (and `send~`/`receive~`) over long patch cords that cross the patch
- Use `patcher` (subpatchers) to organize complex logic into named sections
- Standard object spacing: ~20px vertical, ~15px horizontal gutter (matches defaults.py)
- Companion pairs (e.g. `meter~` beside `gain~`) sit side-by-side at ~5px horizontal gap, not stacked below
- Message boxes render wider than their stored `patching_rect` width: estimate rendered width as `len(text) * 8 + 25` px and keep at least 8px between boxes

#### Text Contrast: Resolve Against the Displayed Surface

Judge text color by WCAG contrast ratio (minimum 4.5:1, `MIN_CONTRAST_RATIO` in `defaults.py`) against the surface it is displayed on, never by a `luminance > 0.5` flip or the editing background alone. Precedence: the box's own `bgcolor` > panels under its `presentation_rect` when the box is in presentation > panels under its `patching_rect` > patcher background as fallback. Panels encode their fill three ways and all three must be read.

`ensure_text_contrast(patcher)` runs automatically only for new patches (`finalize_patch(is_new=True)`). Edits recolour only added boxes that carry an explicit `textcolor`, never a comment without one; whole-patch `repair_text_contrast(patcher)` only when the user asks. Algorithm: `.claude/skills/references/ui-presets.md` "Text Contrast Resolution".

#### Multislider as Labeled Parameter Bank

> Codified: `Patcher.add_labeled_param_bank(params, x, y)` (Phase 31). Its docstring holds the full recipe (alignment formula, attributes, 14-param example); prefer the builder.

Manual banks: `orientation: 0`, `contdata: 1`, `setstyle: 1`, height = size * 24 for 24px label spacing; put utility/routing objects (prepend chains, init messages, js engines) in named subpatchers.

**Reading values by index:** send `fetch $1` (NOT `fetchindex` -- it does not exist). The fetched value emerges from the **right** outlet (outlet 1); outlet 0 is for direct-edit/drag interaction. Don't insert `split` between multislider and the consumer -- multislider already emits the correct values, and `split` filters out valid step data.

### Rule #5: No Generator Scripts

Never create `generate.py` or similar scripts that regenerate `.maxpat` files from scratch (regeneration overwrites manual edits). The Patcher API (`src.maxpat`) is the only sanctioned way to create and edit patches: build in memory during `/max-build`, edit with `edit_patch(path)` during `/max-iterate`, write via `save_patch_roundtrip()`. Saves keep the file's JSON layout and spellings (any Max version, CRLF too), so a no-op save is byte-identical; `write_gendsp()` edits an existing `.gendsp` in place (codebox code and in/out ports; ports are removed only with explicit `num_inputs`/`num_outputs`) instead of regenerating it. `finalize_patch(is_new=True)` raises `LayoutRefusedError` on MAX-saved or large patchers (`force_layout=True` for a large new build).

`Patcher.from_dict` -> `Patcher.to_dict()` round-trips are lossless; the standalone `Box.to_dict()` is lossy -- never serialize a single Box. **Edits to loaded boxes and cords reach disk**: `from_dict` deep-copies its input and snapshots each box's `extra_attrs` and font and each cord's order, hidden, midpoints, color and `extra_attrs`; `to_dict` writes back every field that changed, in-place list edits included. A direct `box._raw` key write still lands while its field is unchanged; verify the attribute on disk after save. Investigate a suspected `.maxpat` regression by diffing committed objects (`git show A:file` vs `git show B:file`), never the working tree.

### Rule #6: Z-Order Awareness

> Codified: `Patcher.add_overlay_readout(target, format='%.2f')` (Phase 31). Its docstring holds the manual recipe; prefer the builder.

Objects earlier in the `boxes` array render on top (index 0 = topmost). Backgrounds: `add_panel()` / `add_step_marker()` set `background=1`. Overlays: `add_overlay_readout` does `bring_to_front` + `ignoreclick=1` (omit for editable readouts) with the readout overlapping the dial. Explicit control: `bring_to_front(box)`, `send_to_back(box)`, `set_z_index(box, index)`. Detail: `shared-capabilities.md` "Z-Order Manipulation".

### Rule #7: Commit After Every Save

Every patch save MUST be committed to git: `save_patch_roundtrip()`, `write_gendsp()` and `write_js()` auto-commit via `auto_commit_patch()`, path-scoped to `patches/<project>/` (any other path, a git failure or a no-op save warns and returns None). Never rely on disk-only saves. Detail: `severity-contract.md` §5.

- `StaleFileError` means MAX saved the file after you read it: re-read with `read_patch()`, re-apply the edit, and re-read after every save before saving the same file again.
- **Save gate:** a save that introduces a blocker or changes the x-rank order of a subpatcher/abstraction inlet or outlet raises `PatchValidationError` without writing (pre-existing blockers still save; a new file refuses every blocker); removed cords emit a `SaveGateWarning` -- confirm the removal was intended. Fix the findings: `force=True` (overwrites a stale file and skips the gate) only when the user confirms.
- **Prohibited:** `git stash` during any patch workflow -- commit your current work first. To test whether a change caused a failure, use a temp worktree or `git show HEAD~N:path`; after any worktree merge, check `git stash list` for orphaned stashes.
- **Multi-instance safety:** commit only files within your active project directory; never use `git add .` or `git add -A` during patch work.

### Rule #8: `replace_box()` Orphans Connections — Always Rewire

`Patcher.replace_box(old, new_name, args=...)` does NOT preserve connections: every line touching the old box is returned in `EditResult.orphaned` and removed. After every `replace_box` call, iterate `result.orphaned` and re-add each connection via `add_connection(...)`, mapping indices through when the I/O layout matches and rewiring by hand when it differs. **Never assume connections survive a replace.**

**Prefer `Patcher.replace_box_safe(old, new_name, args=..., rewire="auto")` for new code.** It rewires every cord whose outlet/inlet index still exists on the new box (midpoints, order and colour kept) and returns the rest in `result.orphaned`: indices the new box lacks, and signal cords that would land on a control-only inlet. `rewire="manual"` opts out. Both calls keep the box's identity: its id, size, place in the boxes list (z-order), presentation rect, `varname`, colours and parameter blocks. An embedded patcher moves only for the same name or `gen~` <-> `mc.gen~`; any other replace of such a box raises `ValueError`. Use plain `replace_box` when you need to inspect or transform orphans.

### Rule #9: Presentation Mode Parity

If the target patch uses presentation mode (any box has `presentation: 1`), every interactive control added or made user-facing by an edit MUST be added to presentation in the same edit, with its label comment: `Patcher.add_to_presentation(box, rect)` with an explicit `presentation_rect` matching the section's column/row rhythm (audit neighbors' `presentation_rect`s). Treat the layout critic's "Presentation coverage" warnings as must-fix before save; record deliberate exclusions (e.g. a slaved stereo `gain~`) in the project's `context.md`.

**Presentation parity includes contrast parity.** A control or label promoted into presentation must be readable against its presentation-mode background: treat "Low contrast text" warnings on the promoted boxes as must-fix before save.

Set the patcher-level **`bgcolor`** key, not just `editing_bgcolor`/`locked_bgcolor`: MAX honors `bgcolor` in locked and presentation mode and otherwise falls back to its light default. `set_canvas_background()` writes all three.

## Domain-Specific Rules

### MSP (Audio/Signal)

- Always terminate signal chains with `dac~` or `*~ 0.` (multiply by zero to mute)
- Use `*~ 0.5` or `*~` with `line~` for gain control -- never connect raw oscillators to `dac~` at full volume
- Gain safety: values feeding the gain input of `*~` / `mc.*~` (including `line~` ramps) MUST be 0.0-1.0. Normalize raw MIDI ints with `scale 0 127 0. 1.` or `/ 127.`, float sources (flonum, float-output dial/slider/live.dial) with `scale 0. 127. 0. 1.` (all-int arguments make `scale` truncate floats). Validation and the DSP critic block raw 0-127 sources.
- `gain~` is different: its left inlet takes int slider positions 0 to size-1 (default 0-157); drive `gain~` with slider position values, never 0-1 gains.
- Signal objects (names ending in `~`) process at audio rate and are always on once connected. Use `snapshot~` for control-rate display values, `meter~` or `levelmeter~` for level monitoring.
- Multichannel: `mc.` objects carry multiple channels; convert with `mc.pack~`/`mc.unpack~`.
- `line~` replaces the active ramp on every new message: send a multi-segment envelope as one space-delimited list (`$1 $2 0. $3`, no comma) -- comma segments arrive in one tick and only the last takes effect (validation errors on a comma after a ramp; a leading jump `0, 1 500` is fine). Control-rate `line` queues comma segments correctly.
- `buffer~` has no `info` query and bare `sizeinsamps`/`samplerate` are setters: read contents/size via `fluid.buf2list` (`buffer <name>` then `bang`), `jit.buffer~` + `jit.matrixinfo`, or `peek~` driven by `uzi N`. The right outlet emits state only after operations like `read`.
- `buffer~` `replacechannel` / `replacechannel_samples`, `trim` / `trim_samples` and `url` are 9.2-only (argument forms in `max-9.2-changes.md`); the `setsize` / `sizeinsamps` retain-contents argument is untested -- do not generate it.
- If validation flags a control cord from an MSP object's non-primary outlet, the DB likely mis-marks that outlet as signal: fix the outlet type in `overrides.json`, don't reroute (`db-maintenance.md`).
- `expr`, `vexpr` and `if` do NOT have a `clip()` function ("function clip not found"): use `min(max(x, lo), hi)`. `expr~` is RNBO-only ("No such object" in MSP); use a gen~ codebox for per-sample expressions.
- `floor~` is RNBO-only: use `trunc~` for non-negative input (`phasor * N`), Gen~ `floor` for signed input. Always check `domain` on DB lookups before using a tilde object at the top level.
- `umenu` items use comma-as-element format, `"items": ["LP", ",", "HP", ",", "BP", ",", "Notch"]` (plain arrays and comma strings render as one entry), or populate at runtime via `loadbang -> "clear, append X, append Y, ..."`.

### Gen~ (GenExpr DSP Code)

Full text, derivations and per-version evidence: `.claude/skills/references/genexpr-rules.md` (max-dsp-agent loads it).

- Codebox I/O is `in1`, `in2` / `out1`, `out2` (no space; `in 1`/`out 1` is for gen~ patcher objects). `Param` = user parameter, `History` = single-sample delay/state, `Buffer` and `Data` = sample data. Everything runs once per sample, and both branches always execute.
- Delay lines: declare `Delay myDelay(max_samples);` and use `myDelay.write(x)` / `myDelay.read(t)`; the `delay()` function is NOT supported in codebox (use Delay.read and Delay.write).
- Variables used inside `if`/`else` must be initialized before the block.
- Codebox objects embed GenExpr in `.maxpat` patches; `.gendsp` files are standalone Gen~ patchers.
- **Declaration ordering**: functions first, then ALL declarations before ANY expression -- `Param`, then `Delay`, `History`, `Buffer`/`Data` (a function after a statement is an error; `add_gen` reorders).
- **Setting Param values from MAX:** send `param_name $1` to the gen~ inlet (NO `@` prefix); `attrui` connected to gen~ gives an all-params interface.
- **Waveguide loop filters:** resonant filters (Q >= ~1.5) go POST-LOOP, never inside the feedback loop (this includes "source-side" filters between a driver nonlinearity and the delay-line injection); low-Q in-loop filters must subtract analytic **phase delay**, never group delay, from the target period.
- **mc.gen~ via `add_gen()` + rename:** build with `add_gen(code, ...)`, then set the box's `name` and `text` to `"mc.gen~"`.
- **Pre-flight any new in-loop waveguide filter with a numpy simulation** before committing: sweep its controlling Param; pitch moving more than a few cents means the architecture is wrong.
- **In-loop saturation: normalize by the drive gain, never by `1/tanh(drive)`:** use `tanh(x*g)/g`.
- **No local aliases in Param-only expressions.** Write `samplerate` and literal constants directly; prefer range tests over `==` in `if`.
- **Hoisted temps can be emitted out of order — de-hoist any Param-only setup chain:** `History one(1);`, then `srs = samplerate * one;` and `k_<param> = <param> * one;` at the top of the per-sample body.
- **Never use GenExpr built-in constant names as variable names** (`e`, `pi`, `twopi`, `halfpi`, `invpi`, `ln2`, `ln10`, `log10e`, `log2e`, `sqrt2`, `sqrt1_2`, `degtorad`, `radtodeg`, `phi`, and their upper-case `PI`, `E`, ...): the constant wins silently.
- **Codebox safe-construct rules** (treat the full set as the proven-safe pattern): spaces only, NEVER tab characters (error in new code, warning in a loaded codebox); no `else if` chains (nest `else { if ... }`); `peek(buf, idx, 0)` / `poke(buf, val, idx, 0)` with explicit channel; for loops single, non-nested, CONSTANT bounds with a variable inner guard; Amortize heavy scans across samples with a `History` cursor.
- **Max 9.2's Gen compiler fixes do NOT retire any rule above**; each workaround stays until individually re-verified in MAX.

### Jitter

- **`jit.expr` that reads a named matrix (`name.p[N]`, an `@out_name` matrix) needs `@cache 0`:** with the default `@cache 1`, sub-expressions without `in[N]` are computed once and stay constant, silently (proven-forms.md "Jitter").

### Subpatcher Inlet/Outlet Access

Inside a subpatcher from `add_subpatcher()`, get inlet/outlet boxes by index with `inner.get_inlets()` / `inner.get_outlets()`, never by `box.text` (every inlet's text is `"inlet"`, every outlet's `"outlet"`).

**No `inlet~` / `outlet~` objects exist in MAX.** Always use `inlet` / `outlet` (maxclass `"inlet"` / `"outlet"`); what connects to them makes them signal or control. A `newobj` with text `inlet~` or `outlet~` fails with "No such object".

**Label inlets/outlets via the `comment` attribute** (MAX's "Assistance" tooltip), NOT freestanding `comment` objects: `extra_attrs={"comment": "Audio Input Left"}`.

### RNBO (Export-Ready Patches)

**Experimental:** not yet confirmed in MAX.

- ONLY use objects with `rnbo_compatible: true` in the database; some differ from their MAX counterparts (e.g. outlet count), so check the `rnbo/` domain for RNBO-specific definitions.
- RNBO uses `rnbo~` as the container object (like `gen~` but for full patches). Patches must be self-contained -- no external file dependencies for export targets (VST3/AU plugin, Web Audio, C++).
- `param` objects in RNBO map to plugin parameters for VST3/AU export.

### Node for Max (N4M / node.script)

- **`node.script` and `node.codebox` are in the object database** and usable under Rule #1, with a fixed 1 inlet / 2 outlets. Node code uses `const maxAPI = require('max-api')` and sends with `maxAPI.outlet(value)`. Use for file I/O, network requests and heavy data processing.
- Handlers, Dict access, the dump outlet and the build-time data-tool alternative: `.claude/skills/max-js-agent/SKILL.md`.

### js / v8 (JavaScript inside MAX)

- `js` / `jsui` run on the **Legacy Engine** (ECMAScript 5): write ES5 only (`var`, `function`; no `const`/`let`, arrow functions, template literals, classes, destructuring, default parameters or `async`/`await`). `js` is the default (`Patcher.add_js()`, `generate_js_script()`). Use `v8` / `v8ui` / `v8.codebox` (Modern Engine) only for modern syntax or a Max 9.2 API; there is no `add_v8()` builder, and a first use is untested until confirmed in MAX.
- `anything()` takes no named parameters: read the selector from `messagename` and the arguments with `arrayfromargs(arguments)`.
- Max 9.2 `v8` timers and `toJSON()` are untested -- keep using `Task` for timing; generate `v8` network clients/servers only when the task asks for them.
- API detail: `.claude/skills/max-js-agent/SKILL.md`; 9.2 evidence: `max-9.2-changes.md`.

### Max for Live (M4L / .amxd)

**Experimental:** not yet confirmed in MAX or Live.

> Codified (EXPERIMENTAL, unconfirmed in Live): `Patcher.add_m4l_device(kind, params)` (kind `instrument` / `audio_effect` / `midi_effect`) builds the skeleton: Live-template wiring, the `live.thisdevice` init chain, `live.dial` params with unit/type inferred from range and name (explicit keys win), unique short names and Push `parameterbanks`. `Patcher.add_m4l_gen_synth(params)` (Phase 31) is built on it. Save the .maxpat (the source of truth), then `export_amxd(maxpat_path)` from `src.maxpat.m4l_device` writes the .amxd next to it. It reuses existing device I/O and refuses taken parameter names; `export_amxd` refuses a `live.thisdevice`-only helper abstraction without `kind=`. The rules below still apply.

- **No `gain~` / `live.gain~` / `ezdac~` before `plugout~`.** Route the final stage directly to `plugout~`; Ableton's mixer handles volume, pan and mute (`gain~` defaults to 0, silence on load).
- **`live.dial` / `live.slider` bind to gen~ Params via `param_connect`, not message-box patching:** `param_connect: "<gen~_varname>::<param_name>"`, `parameter_enable: 1` and the `saved_attribute_attributes.valueof` block (keys in the `add_m4l_gen_synth` docstring). The gen~ needs a stable `varname` matching the prefix; no patch cord -- `param_connect` IS the binding.
- Without `param_connect`, the dial is not in Live's parameter list and is not Live-automatable.
- **Slider -> line~ -> gen~ signal-rate exception:** `param_connect` binds only Params, so keep the `slider -> line~ -> gen~` path and add `parameter_enable: 1` + `saved_attribute_attributes.valueof` to the slider itself so Live can still automate it.

### bach (package)

Before using any bach object, read `.claude/skills/references/shared-capabilities.md` "bach (package) Rules" (missing `bach.llll2list` / `bach.list2llll`, `bach.nth` extraction, `@out t` toward plain MAX objects).

## PD Confusion Guard

Check `.claude/max-objects/pd-blocklist.json` before using any unfamiliar object. Common confusions (PD -> MAX): `osc~` -> `cycle~`, `lop~` -> `onepole~`, `hip~` -> `onepole~` (with inversion), `bp~` -> `reson~`, `tabread~` -> `index~` / `play~` / `wave~`, `throw~`/`catch~` -> `send~`/`receive~`. If a `~` object is not in the database, check the PD blocklist for the MAX equivalent.

## Version Compatibility

All patches target MAX 9 -- do not ask users to choose a version.

- Check `min_version` field before using objects: MAX 9 objects (`array.*`, `string.*`, `abl.*`) need MAX 9+; MC objects (`mc.*`) need MAX 8.1+.
- The 12 Max 9.2 objects (`min_version: 9.2`) and the 9.2 messages/attributes (NOT version-tagged in the DB) are listed in `.claude/skills/references/max-9.2-changes.md`. A patch meant to open on an older 9.x build must avoid both.
- `validate_patch(patch, target_version="9.0")` warns (layer `version`) when a box needs a newer Max or uses a port an older build lacks; use it for collaborators on older 9.x builds.
- Vision package objects (`jit.vis.*`, Cycling '74 Vision 1.0.2) need Max 9.2+ and are unverified until confirmed in MAX.

## Bpatcher and Abstraction Arguments (`#N` Substitution)

When a `.maxpat` is loaded as a bpatcher or abstraction, MAX substitutes `#1`, `#2`, ... with the arguments in the bpatcher's `args` attribute.

- **Critical rule: `#N` must be a standalone token in the object text, never embedded in a compound string:** WRONG `buffer~ slot-#1`, RIGHT `buffer~ #1` with `"slot-1"` passed as the arg.
- Pass each distinct name as a separate argument (`"args": [ "slot-1", "slot-1-out" ]`, then `buffer~ #1` and `send~ #2` inside). This applies equally to newobj boxes and message boxes (`set #1`, `setbuffer #1`).
- **Numeric bpatcher args must be serialized as JSON numbers, not strings** (`args=[slot, 0]`, not `args=[slot, "0"]`): a string `"0"` substitutes as a quoted symbol and `-~ #2` fails with "bad arguments creating object". `add_bpatcher` coerces them and validation errors on numeric strings. To fix an existing patch, convert numeric strings in `box._raw["args"]` (post-round-trip `box.args` is empty) and `save_patch_roundtrip`.
- **Comment boxes do NOT perform `#N` substitution** (only `newobj` and `message` boxes do): for dynamic labels use `loadbang` -> `message "set Label #1"` -> `comment`.

## Variable I/O Objects

Some objects change inlet/outlet count with their arguments (`variable_io: true`). Counts come from `overrides.json` → `variable_io_rules` and the text-aware resolvers in `src/maxpat/io_resolvers.py` (`IO_RESOLVERS`: select, route, expr, ...). Always get counts from `db.compute_io_counts(name, args)`: `trigger b i f` has 3 outlets, `pack 0 0 0 0` has 4 inlets, `route foo bar baz` has 4 outlets (3 match + 1 unmatched). Always compute actual I/O count from arguments when generating connections; DB defaults are the no-argument case.

## File Conventions

- Patches: `.maxpat` (JSON format)
- Gen~ patches: `.gendsp` (JSON format, similar structure to .maxpat)
- Node for Max: `.js` files referenced by `node.script` object
- js object: `.js` files referenced by `js` object
- Externals: `.mxo` bundles (macOS)
- Projects: `.maxproj` (project container)
