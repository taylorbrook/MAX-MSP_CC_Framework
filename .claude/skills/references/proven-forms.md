# Proven Forms

> General MAX knowledge learned while building and testing real patches: forms that work, and traps the object database and the validator do not catch. Read it before generating control logic, MC, FluCoMa, poly~, Jitter matrix maths or waveform~ / flonum UI, and before editing subpatcher layouts.
> Path: `.claude/skills/references/proven-forms.md`. `C74/` below means `/Applications/Max.app/Contents/Resources/C74/`. Console errors are in `troubleshooting.md`; finding severities in `severity-contract.md`.

## Evidence tiers

Every entry carries one or more tiers. Nothing here is copied from a private path; source projects are named only.

- **[confirmed]** — confirmed working in MAX by the user in the named project and version.
- **[bundle]** — read from a Max app or package refpage or help file (`C74/...`, or `~/Documents/Max 9/Packages/<package>/docs`).
- **[code]** — follows from this repo's source and tests.
- **[observed]** — seen in a project, but the fix was not independently confirmed in MAX.

Every object, message and attribute named below resolves in `ObjectDatabase` or in a package refpage. FluCoMa messages are not in the database; they were checked against the FluidCorpusManipulation refpages.

## Control and data

### trigger types

- **Rule:** give `trigger` only the types `b i f l s` (plus number or symbol constants). Never write `t a`.
- **Form:** `t b i f`, `t l l`, `t s s`. For an anything message where order does not matter, fan out directly; where order matters for a symbol, use `t s s`.
- **Why:** any other symbol is output as a constant, so `t a a` sends the literal symbol `a` (console: `umenu: doesn't understand a`).
- Evidence: [bundle] `C74/docs/refpages/max-ref/trigger.maxref.xml` (types i, f, b, l, s; other values output as constants); [observed] Ambire v0.5.0 (2026-10-01).

### shared namespace

- **Rule:** give each named object its own name per class. Named objects (`coll`, `sflist~`, `buffer~`, `dict`, `table`, ...) share one global name namespace across classes.
- **Form:** `coll sf.files` and `sflist~ sf.cues`, never `coll sf.files` plus `sflist~ sf.files`.
- **Why:** a second class registering the same name fails (`sflist~: sf.files: already in use`, `object_register: ... cannot reregister`). The database does not model this.
- Evidence: [observed] Ambire v0.5.0 (2026-10-01).

### int truncation

- **Rule:** in any float chain, give arithmetic objects a float argument, and give `scale` float input arguments.
- **Form:** `+ 0.`, `- 0.`, `* 0.`, `/ 1.`; `scale 0. 127. 0. 1.` (not `scale 0 127 0. 1.`). For N equal integer bands use `expr $i1 * N / 128`, not an int-output `scale`.
- **Why:** an arg-less `+ - * /` runs in int mode and truncates; `scale` with all-int input arguments truncates float input (63.5 becomes 63). Nothing errors; values just flatline or snap to 0/1.
- Evidence: [bundle] `C74/docs/refpages/max-ref/plus.maxref.xml` (int unless the object has a float argument) and `scale.maxref.xml` (integer arguments truncate); [observed] TCI (2026-09-27) for arg-less `-` and `*`; [observed] minitaur v0.1.9 (2026-09-24) for `scale`. CLAUDE.md "MSP (Audio/Signal)" states the `scale` rule for gain inputs.

## MC

### bare lists vs applyvalues / setvalue

- **Rule:** to send one value per channel to an `mc.*` object, use the MC wrapper messages. A bare list goes to every instance.
- **Form:** `list` -> `prepend applyvalues` -> `mc.sig~ @chans N` (value k to instance k; extra instances unaffected). One channel: `setvalue <chan> <msg>` (1-based; `0` = all). `replicatevalues` wraps when it runs out of values. Example lane mask: `applyvalues 0 0 0 0 0 0 0 0`, then `setvalue 3 1`.
- **Why:** every instance received the same values, collapsing a 12-note chord into one tone. The database's own `messages` list for an `mc.*` object omits these; `db.selectors(name)` includes them from the MC wrapper group.
- Evidence: [bundle] `C74/docs/refpages/msp-ref/mcwrapper-group.maxref.xml`; [confirmed] barnett-dbap v0.2.0 (2026-09-19) for `applyvalues` and `setvalue` into `mc.sig~ @chans 8`; [observed] ji-harmonizer v0.0.2 for the bare-list bug.

## FluCoMa

### read is defer_low: chain dump off the completion message

- **Rule:** never sequence `read` and then `dump` with `trigger`. Chain `dump` off the `read` completion message.
- **Form:** `read <file>` -> `fluid.dataset~` (also `fluid.labelset~`, `fluid.kdtree~`, `fluid.standardize~`, ...); on the rightmost (dump) outlet, `route dump read`, and the `read` outlet triggers the `dump` message.
- **Why:** `read` and `write` are `defer_low`'d (the lowest priority on the main thread; the refpage says "deferlow") while `dump` runs at once, so `t b b` dumps an empty object first (`fluid.plotter` then reports `Please provide a valid dictionary...`). On success `read` sends a bare `read` message out of the dump outlet.
- Evidence: [bundle] `fluid.dataset~.maxref.xml` (`read`: "always executed at the lowest priority on the main thread, using deferlow internally"); [observed] Traces (2026-09-20), FluCoMa 1.0.9.

### conformpath paths

- **Rule:** convert dialog paths to POSIX before building FluCoMa `read` / `write` paths. After a completion `route` that can carry arguments, put `t b` before chaining.
- **Form:** `opendialog fold` -> `conformpath max boot` (gives `/<path>/folder/`) -> build the file path. `route transform` -> `t b` -> next step.
- **Why:** `opendialog fold` returns an HFS-style path (`Macintosh HD:/<path>/folder/`, trailing slash included), which `buffer~` and `dict` accept but FluCoMa rejects (`Could not open file for writing` / `... not found`). `route` strips the selector and passes the arguments on (`transform <destname>`), which can clobber a `zl.reg` and reach `fluid.dataset~` (`doesn't understand <name>`).
- Evidence: [bundle] `C74/docs/refpages/max-ref/conformpath.maxref.xml` (pathstyle `max`, pathtype `boot`); [confirmed] TCI corpus snapshot (2026-09-26) for `conformpath max boot`; [observed] TCI for the `t b` guard.

### fluid.list2buf: pre-size and @autosize 0

- **Rule:** never rely on `fluid.list2buf` autosize. Pre-size the buffer and turn autosize off.
- **Form:** internal buffer `fluid.list2buf <frames> 1 @autosize 0` (frames, then channels; `fluid.list2buf 2 1 @autosize 0` for 2-D query points). Named destination: `fluid.list2buf @destination <buf> @autosize 0` with `buffer~ <buf> @samps N` matching the list length.
- **Why:** a list arriving on the scheduler thread (metro, line, cue, or `fluid.*` analysis output) cannot resize the buffer, so it keeps the wrong length and `fluid.kdtree~ knearest` reports `Wrong Point Size`. A `defer` in front did not fix it in Max 9.1.5.
- Evidence: [bundle] `fluid.list2buf.maxref.xml` (`autosize` "only applies when invoking from the main thread"); [confirmed] Traces (2026-09-20).

### kmeans fitpredict

- **Rule:** to get cluster labels from `fluid.kmeans~`, use `fitpredict`, not `fit`.
- **Form:** `fitpredict <dataset> <labelset>` -> `fluid.kmeans~`; route the reply with `route fitpredict`.
- **Why:** `fit` trains the model but writes no labels; `fitpredict` trains and writes the clustering to the labelset in one pass.
- Evidence: [bundle] `fluid.kmeans~.maxref.xml` (`fit`, `fitpredict`); [observed] intelligent-corpus-remixer v0.2.1 (2026-09-23).

## poly~ voices

### voice forms

- **Rule:** build poly~ voices from these forms. Check new voice idioms against the shipped `C74/help/msp/` voices (for example `adsr-synth.maxpat`), not against other repo patches.
- **Form:**
  - `midinote <pitch> <vel>` arrives as ONE list on the voice's `in 1`: `in 1` -> `unpack 0 0` -> `swap` (right outlet -> `mtof`, left -> `/ 127.` -> `adsr~`). Waiting for velocity on `in 2` gives flat output and a clean console.
  - Voice stealing: `adsr~` outlet 2 (mute messages) -> `t l l`; right -> `route mute` -> `== 0` -> `thispoly~` (busy); left -> `thispoly~` (mute).
  - Heavy `buffer~` data lives once in the main patch; voice code reads it by name (gen~ `Buffer x("name")`). Never put a large `buffer~` in the voice abstraction.
  - Global voice params: `receive` + `route` inside the voice. After `up N` reloads the instances, re-send every control value (`deferlow` -> `send resend` -> `receive` into each control).
  - Plain gen~ `Param` messages (`<name> <value>`) work inside `poly~ ... up 2` when the gen~ sits in an abstraction with its own message inlet. Smoothed per-voice controls as signals (`$1 20` -> `line~` -> gen~ `inN`) also work.
  - Signals pass through plain `p` subpatcher inlets and outlets inside a voice. `validate_patch` proposes removing that cord as "control-only"; that is a false positive, so keep the cord.
  - A new inlet on a shared abstraction goes RIGHTMOST, so existing hosts keep their inlet indices (see "subpatcher port x-order").
- **Why:** each form fixed a silent failure (no voice output, stuck voices, per-voice buffer copies, params lost after `up N`, inlet indices shifting).
- Evidence: [confirmed] terrain-synth v0.4.1–v0.4.2 (2026-09-21) for `midinote`, `adsr~` -> `thispoly~`, shared buffers and `receive` params; v0.6.1 for signal-rate per-voice controls; v0.7.0 / v0.8.0 for `Param` messages in abstraction voices; v0.10.0 for signals through `p` and the rightmost inlet. [bundle] `C74/help/msp/adsr-synth.maxpat`.

## UI

### waveform~ setmode 1

- **Rule:** set `setmode 1` on a `waveform~` that the user clicks or drags.
- **Form:** `"setmode": 1` in the box JSON (select). `3` is move. For symbolic mouse output send the message `mouseoutput up` (none / down / up / downup / continuous); `outmode` is an int attribute, so `outmode up` silently sets it to none. Selection start and end come out of outlets 2 and 3 (0-based), in ms.
- **Why:** with no `setmode` the box is display-only (setmode 0) and clicks do nothing.
- Evidence: [bundle] `C74/help/msp/waveform~.maxhelp` (uses `setmode` 1 and 3); [confirmed] timestretch v0.6.1 (2026-09-30).

### flonum numdecimalplaces 0 = auto

- **Rule:** set `numdecimalplaces` to 1 or more for fixed decimals; use a `number` box for integer display.
- **Form:** `"numdecimalplaces": 2` on a `flonum`.
- **Why:** `0` means AUTO (shows `9.77857`), not zero decimals, and MAX drops the key on re-save.
- Evidence: [confirmed] terrain-synth v0.5.0 (2026-09-21).

## Subpatchers and layout

### subpatcher port x-order

- **Rule:** keep the x-order of `inlet` and `outlet` boxes inside a subpatcher or abstraction unchanged, or renumber the parent cords to match. Add new ports rightmost.
- **Form:** `get_inlets()` / `get_outlets()` return ports sorted left to right; connect by that index. Any code that moves boxes inside a subpatcher (layout, JSON edits, repositioning scripts) must preserve each port class's x-rank.
- **Why:** MAX numbers a subpatcher's ports by the x-position of the port boxes inside it, not by creation or array order. Reordering them silently remaps every parent cord (a "dump" message hit a number box). When messages hit the wrong object across a subpatcher boundary, diff the inner port x-order against the parent's cord indices first.
- Evidence: [code] `Patcher.get_inlets` / `get_outlets` sort by x; `apply_layout` captures and restores port order; the save gate refuses a save that changes a port's x-rank (`severity-contract.md`). [observed] ji-harmonizer v0.0.1.

### no global apply_layout on large existing patches

- **Rule:** never run `apply_layout()` over a large existing or hand-arranged patch. Preserve the user's macro arrangement and make only local fixes.
- **Form:** local alignment and spacing within a section, `send` / `receive` for long cords. `finalize_patch(patcher, is_new=False)` and `edit_patch` sessions never move boxes and never clear existing midpoints: they route only cords that have no midpoints and are new or touch an added or moved box, so they are safe on large MAX-saved patches. `finalize_patch(is_new=True)` refuses a MAX-saved or large patcher with `LayoutRefusedError` before anything moves.
- **Why:** the row-based layout maps depth to rows and spreads each row sideways: about 200 objects became a ~7900 px wide band, stacked co-targeted controls, and illegible flow. User arrangements encode grouping the engine cannot see. Even on a new build with large UI boxes, hand-place sections.
- Evidence: [observed] ji-harmonizer v0.7.1 (the user rejected it; reverted in v0.7.2); [observed] barnett-dbap v0.1.0 and v0.5.0 (2026-09-19).

## Jitter

### jit.expr @cache 0 when the expression reads a named matrix

- **Rule:** add `@cache 0` to every `jit.expr` whose expression reads a named matrix (`name` or `name.p[N]`), whether the name comes from `jit.matrix name`, `@out_name` or `jit.slide @out_name`.
- **Form:** `jit.expr @adapt 0 @type float32 @dim 8 @planecount 3 @cache 0 @expr in[0]*(rgstate.p[6]==0) ...`.
- **Why:** `@cache` defaults to 1, which caches intermediate values. In MAX, any sub-expression built only from named matrices, with no `in[N]` in it, was computed on the first frame and then stayed constant. A bare `name.p[N]` operand still updated, so positions moved while masks, colours and ripple rings stayed at their first-frame values. There was no Console message. Changing `==` to arithmetic masks and splitting planes into 1-plane named matrices changed nothing.
- **Debug:** probe the failing object's own output with `jit.spill @plane N` -> `prepend set` -> a message box. A constant output that equals the expression's first-frame value means caching.
- Evidence: [bundle] `C74/docs/refpages/jit-ref/jit.expr.maxref.xml` (`cache`: "Cache intermediary values", default 1); [confirmed] Resonant Garden objects version, MUSC420 (2026-11-09).

## Framework workflow

### validate a deepcopy; remove only via apply_fixes

- **Rule:** validate a `copy.deepcopy`, treat every `proposed_removal` as "inspect, don't save", and remove cords only with an explicit `apply_fixes(patch, results)`.
- **Form:** `results = validate_patch(copy.deepcopy(patch_dict))`; inspect `[r.proposed_removal for r in results if r.proposed_removal]`; for a confirmed defect call `apply_fixes(patch_dict, results)` and validate again.
- **Why:** `validate_patch` never mutates its input today, but it once stripped valid cords (`*~` -> `p motion` in terrain-synth v0.16.0), which only showed up as broken audio in MAX. A proposed removal can be a validator false positive (signals through `p` inlets in poly~ voices), and then the checker is fixed, never the committed patch.
- Evidence: [code] `src/maxpat/validation.py` (`validate_patch`, `apply_fixes`, `has_blocking_errors`); the current code is authoritative. See `severity-contract.md`.

### enum values: check the bundle maxref / help, not the database

- **Rule:** before using an enum-valued attribute or an argument form on a `jit.*`, `mc.*` or unfamiliar object, check the value in the bundle refpage and copy forms from the shipped help patch.
- **Form:** refpage `C74/docs/refpages/<domain>-ref/<object>.maxref.xml` (the attribute `<description>` lists the values); help `C74/help/<domain>/<object>.maxhelp`; examples `/Applications/Max.app/Contents/Resources/Examples/`. Example: `jit.bfg @basis noise.gradient` is valid; `noise.perlin` is not a basis.
- **Why:** the database stores attribute names only, not values. MAX accepted `@basis noise.perlin` silently and output zeros, which cost two debugging rounds.
- Evidence: [bundle] `C74/docs/refpages/jit-ref/jit.bfg.maxref.xml` (noise bases: `noise.cell`, `noise.checker`, `noise.distorted`, `noise.gradient`, `noise.simplex`, `noise.sparse`, `noise.value`, `noise.voronoi`); [observed] terrain-synth v0.2.x.
