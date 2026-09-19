# barnett-dbap

8-channel DBAP spatializer for the Roy Barnett Recital Hall (UBC School of Music) rig.
MAX port of the O-Octagon VST (`/Users/taylorbrook/Dev/VST-development/plugins/O-Octagon`,
v1.13.0). v0.1 is a deliberately reduced core; later versions layer the plugin's features back on.

## Kickoff (2026-09-18)

**What it does:** takes a mono source and renders it to 8 discrete speaker feeds using
Distance-Based Amplitude Panning (Lossius / Baltazar / de la Hogue, ICMC 2009, 2011-04-14 revised
equations) over the measured, non-flat Barnett array. Per-speaker weights are the compositional
"spatial orchestration" control; DBAP normalisation keeps perceived level constant as weights and
position change.

**Audio/MIDI requirements**
- Audio in: mono source from BOTH `sfplay~` (desk testing) and `adc~` (live, selectable channel),
  summed to mono. No MIDI in v0.1.
- Audio out: 8 channels, `mc.dac~ 1 2 3 4 5 6 7 8`, speaker N on interface output N. Remapping
  is done in MAX Audio Status if the hall's patch differs. No configurable per-speaker map yet.

**Signal flow (v0.1)**
```
sfplay~ / adc~  ->  +~ (mono sum)  ->  gain~ (input trim)
      -> mc.*~ (8 gains, from mc.line~ ramped targets)
      -> mc.*~ master gain (0-1, from live.dial/dial scaled)
      -> mc.dac~ 1 2 3 4 5 6 7 8
Control:  pictslider (srcX, srcY 0-1) + flonum srcZ + dial rolloff + dial blur
          + multislider 8 weights  ->  js dbap.js  ->  8-gain list  ->  mc.line~
Meters:   mc.snapshot~ on the 8 output lanes -> multislider (8 bars)
```

**UI / presentation mode:** yes. Presentation layout with puck (pictslider), Z readout,
rolloff, blur, 8 weight bank, 8 meters, master gain, source selector, DSP toggle. Dark canvas,
high contrast, legible at a distance in a dark hall.

**Position units:** normalised 0-1 (srcX, srcY) over the speaker bounding box, matching the
plugin; js converts to metres against the venue. srcZ in metres above the sloped audience plane.

**Objects / techniques:** `js` for all geometry and the DBAP solve at control rate (event-driven
recompute on any parameter change, like the plugin's 64-sample control grid); `mc.line~` for
zipper-free gain smoothing (plugin uses 5 ms linear SmoothedValue); `dict` for the venue.

## Venue data (from O-Octagon defaults, section OQ4 — traced layout, NOT measured)

Metres. Origin front-left corner, x = left to right (audience view), y = front (stage) to rear.
Numbered clockwise from front-left.

| # | position | x | y | z |
|---|----------|------|-------|------|
| 1 | front-left | 0.50 | 4.50 | 4.50 |
| 2 | front-right | 12.50 | 4.50 | 4.50 |
| 3 | right-2nd | 12.50 | 9.85 | 4.70 |
| 4 | right-3rd | 12.50 | 16.00 | 5.10 |
| 5 | back-right | 9.80 | 19.50 | 5.40 |
| 6 | back-left | 3.20 | 19.50 | 5.40 |
| 7 | left-3rd | 0.50 | 16.00 | 5.10 |
| 8 | left-2nd | 0.50 | 9.85 | 4.70 |

Rake: front-row ear height 1.10 m, rear-row 3.20 m (linear in y across the speaker bounding box,
extrapolated outside it). Speaker heights are graded 4.50 to 5.40 on purpose; do not flatten.

## DBAP math (port these exactly)

```
d_i   = sqrt((x_i-x_s)^2 + (y_i-y_s)^2 + (z_i-z_s)^2 + r_s^2),  floored at 0.05 m
a     = R / (20 * log10(2))              R = rolloff dB per doubling, 3..12, default 4
t_i   = d_i ^ (-a)
denom = sum(w_i^2 * t_i^2)               if denom < 1e-20: all gains 0 (silence, never NaN)
k     = 1 / sqrt(denom)
v_i   = k * w_i * t_i                    sum v_i^2 = 1
r_s   = blur^2 * 6 * rigScale,  capped at 200 m    blur 0..1, default 0.03
rigScale = sqrt(mean(|spk_i - centroid|^2)), 3D, centroid = mean of the 8 speaker positions
z_s   = earHeight(y_s) + srcZ,  earHeight = rakeFront + (rakeRear-rakeFront) * (y_s - bbMinY)/(bbMaxY-bbMinY)
(x_s, y_s) = bbMin + norm * (bbMax - bbMin)
```

## Deliberately out of v0.1

Convex hull + hull trim, air LPF, stereo width + sub-points, decorrelator, motion engine,
scenes, verify ping, per-speaker trim, alignment delays, `.venue` import. See roadmap in
"Versions" below.

## Versions (planned)

| Version | Adds |
|---|---|
| v0.1 | venue dict, js solve, mc gain path, mc.dac~, puck, weights, meters, presentation |
| v0.2 | verify ping, per-speaker trim, scenes via pattrstorage |
| v0.3 | stereo width with sub-points, decorrelator in gen~ (integer delay reads only) |
| v0.4 | air filter, hull projection and trim |
| v0.5 | motion engine, alignment delays, .venue importer |

## Decisions (discuss, 2026-09-19)

| # | Decision | Rationale |
|---|----------|-----------|
| D1 | Room plan is an `lcd`; `js` draws the 8 speakers (numbered circles), the bounding box, and the puck. lcd mouse output drives the puck. | Real geometry visible on the surface; no image assets needed (pictslider would need background/knob pictures). |
| D2 | 8 `meter~` objects sit at the speaker positions on top of the lcd in presentation, fed by `mc.unpack~ 8`. Meters must be brought to front (z-order) and are ignoreclick. | Level reads where the sound is. |
| D3 | Solve is event-driven: any control change into `js` recomputes and emits the 8-gain list. No metro polling. Gains ramp via `mc.line~` over 20 ms. | Matches the plugin's recompute-on-change control grid; 20 ms covers mouse-event spacing (~16 ms) without audible zipper. |
| D4 | Position puck stored normalised 0-1 in js; lcd pixels <-> normalised via the bounding box, readouts shown in metres. | Plugin parity, venue-portable positions. |
| D5 | Master gain: `live.dial` in dB (-70..0, default 0) -> `dbtoa` -> `mc.*~` right inlet. Input trim is a mono `gain~` before the spatializer. | Keeps every gain multiplier in 0..1 (CLAUDE.md gain safety); dB fader feel like the plugin's outputGain, boost handled by input trim. |
| D6 | Source select: `umenu` (File / Live) -> `selector~ 2`. File via `sfplay~` + `opendialog`/`dropfile`; live via `adc~` with a channel number box. Both summed to mono before the trim. | Desk testing and live use in one patch. |
| D7 | Weights: one 8-bar `multislider` (0..1, default all 1.0) via `add_labeled_param_bank`, labels "1..8". | Single list into js, one object to automate later. |
| D8 | Venue lives in an embedded `dict venue @embed 1` (speakers x/y/z, rakeFront, rakeRear). js reads it on loadbang and on a `venue` bang. Later versions swap dicts for other halls. | Separate venue store, as in the plugin; editable without touching js. |
| D9 | Everything downstream of the gain list is mc: `mc.*~` (8 ch gains) -> `mc.*~` (master) -> `mc.dac~ 1 2 3 4 5 6 7 8`, with `mc.unpack~ 8` tapped for meters. | Two objects between source and hardware; speaker map is the dac channel list. |
| D10 | All DBAP constants (0.05 m floor, blur square law x6 rigScale, 200 m cap, 1e-20 denom epsilon, all-zero-weight silence) ported verbatim from DbapSolver.cpp. | Same numbers as the verified plugin so results are comparable in the hall. |

## Research (2026-09-19)

Sources: `.claude/max-objects` DB, Max 9 app-bundle maxref XML and help patches
(`/Applications/Max.app/Contents/Resources/C74/docs/refpages`, `.../help`). No existing repo patch
uses `mc.*` or `lcd`, so the forms below are doc-verified rather than repo-proven.

### Gain lane: js -> mc.sig~ -> mc.rampsmooth~ -> mc.*~ (R1)

- A bare 8-element list into an mc wrapper does NOT distribute per channel (memory
  `feedback_mc_applyvalues`). js emits `applyvalues g1 g2 ... g8` into `mc.sig~ @chans 8`
  (mcwrapper-group.maxref: value k -> instance k).
- Smoothing: `mc.rampsmooth~ 1024 1024` (args = ramp-up / ramp-down SAMPLES; linear ramp on every
  value change, like the plugin's SmoothedValue). 1024 samples = 21 ms at 48 kHz. Chosen over
  `mc.line~` because line~ consumes its ramp time after each target, which would need 8
  `setvalue k g 20` messages per update instead of one `applyvalues`.
- `mc.*~`: mono signal in left inlet, 8-ch mc signal in right inlet; wrapper auto-adapts to 8
  (chans 0 = max of connected mc signals) and the mono input broadcasts.
- Master: `live.dial` (-70..0 dB) -> `dbtoa` -> right inlet of a second `mc.*~`.
- Output: `mc.dac~ 1 2 3 4 5 6 7 8` (args = logical output channel per mc channel, doc-verified).
  Tap `mc.unpack~ 8` before it for the 8 `meter~` objects.

### lcd room plan (R2)

- Outlets (maxref): 0 = `x y` list while mouse button held (drag), 1 = idle position (only if
  `idle 1`), 2 = button state 1/0, 3 = `penloc`/`update` replies. Use outlet 0 -> js `mouse x y`.
- Attributes: `local 0` (disable freehand pen drawing), `idle 0`, `border 0`, `bgtransparent 0`.
- Drawing messages (help-patch verified forms): `clear`; `brgb r g b` background; `frgb r g b`
  pen colour; `paintoval left top right bottom [r g b]`; `frameoval ...`; `paintrect l t r b [r g b]`;
  `framerect l t r b`; `linesegment x1 y1 x2 y2`; `pensize w h`; `font Arial 11`;
  `moveto x y, write text` (commas inside text must be escaped `\,`). Coordinates are ints,
  local to the lcd top-left.
- js redraws the whole plan on every puck move (clear + 8 ovals + labels + puck): trivially cheap.
- lcd size: hall bounding box 12 x 15 m -> 240 x 300 px (20 px/m) plus a 20 px margin each side.
  js maps norm 0..1 <-> px through the same margin/scale constants.

### Meters on the plan (R3)

- 8 x `meter~` (vertical, ~12 x 40 px) placed just right of each speaker circle in BOTH patching
  and presentation rects. `bring_to_front` each meter so it renders over the lcd (Rule #6);
  `ignoreclick 1` so drags pass to the lcd. `interval 50` default is fine.
- `mc.meter~` is NOT in the DB; do not use it.

### Source section (R4)

- `sfplay~` (1 channel): `open` (dialog) or `open <path>` from `dropfile`; `1` play, `0` stop;
  `loop 1` attribute-message enables looping (attr `loop` in DB).
- `adc~ 1`: single outlet on logical input 1; `set 1 $1` from a `number` box re-targets the
  outlet to input channel N (maxref: `set <outlet> <channel>`).
- `selector~ 2`: inlet 0 = int selector (0 = silence, 1 = file, 2 = live), inlets 1-2 = signals.
  `umenu` (items File, Live) -> `+ 1` -> selector~. Then `gain~` input trim (mono).
- DSP toggle: `toggle` -> `mc.dac~` inlet (`1`/`0` start/stop). Note `gain~` defaults to 0 —
  send an initial value via `loadbang`.

### js engine `dbap.js` (R5)

- One inlet, three outlets: 0 = `applyvalues ...` gains, 1 = lcd draw messages, 2 = readouts
  (`x_m`, `y_m`, `z_abs`, per-speaker gain list for later use).
- Handlers: `mouse x y` (lcd outlet 0), `srcxy nx ny`, `srcz f`, `rolloff f`, `blur f`,
  `weights l1..l8` (multislider outlet 0 list), `venue` (bang: re-read dict), `loadbang`/`bang`
  (initial draw + solve).
- Venue read via the js `Dict` API (`new Dict("venue")`, `d.get("speakers::1::x")`) from an
  embedded `dict venue @embed 1`. The Dict API is not in the local refpages; it is the standard
  Max 6+ JS API. Fallback if it misbehaves in V8: hardcode the default venue in js and treat the
  dict as a later feature.
- Recompute is event-driven (D3); `speedlim 15` on the lcd mouse stream keeps redraw + solve
  under ~70 Hz during fast drags.

### Alternatives considered

- gen~ codebox for the solve: sample-accurate, but the hull work in later versions needs
  sorting/variable loops that codebox forbids; keep the solve in js and revisit only if
  signal-rate motion is wanted.
- `nodes` for the puck: has its own distance weighting and no numbered speakers; rejected.
- `mc.line~` per-channel ramps: workable via `setvalue`, superseded by rampsmooth (R1).

### Version notes

All objects are Max 8.1+ (`mc.*`) or core; nothing Max 9-only is used. Target remains MAX 9.

## Build v0.1.0 (2026-09-19)

Files: `generated/barnett-dbap.maxpat` (89 boxes, 65 lines, opens in presentation),
`generated/dbap.js` (solver + lcd renderer), `config.json` (core-only, `{"packages": []}` --
written during the build because the project had none; every object used is core or `mc.*`).

Deviations from research/decisions, all deliberate:
- `mc.meter~` is not in the DB, so the 8 meters are `meter~` fed from `mc.unpack~ 8` (D2 stands).
- Gain smoothing is `mc.rampsmooth~ 1024 1024` per R1 (not the `mc.line~` named in D3).
- Master fader: `live.dial` (-70..0 dB) -> `dbtoa` -> `$1 20` -> `line~` -> `mc.*~` right inlet, so the
  master itself is zipper-free; the dial is a Live parameter (unitstyle dB) in a plain Max patch.
- Weights bank uses `add_labeled_param_bank`; the multislider's LEFT outlet (list on change) feeds
  `prepend weights` -> js. No `fetch` needed because js wants the whole list.
- Venue dict keys are `speakers::s1..s8::{x,y,z}` and `rake::{front,rear}` (symbol keys, not
  numeric, so the js `Dict` path lookups are unambiguous). js falls back to a built-in copy of the
  same table and posts a console line either way.
- lcd is 300x360 with a 30 px margin at 20 px/m; meters sit 12 px right of each speaker circle in
  BOTH patching and presentation (same constants live in dbap.js `MARGIN`/`LCD_W`/`LCD_H`).
- Patching layout is hand-placed by section (source / plan+position / weights / gain lane / init).
  `apply_layout` put the whole signal chain in one row and pushed presentation-only boxes 3000 px
  right, so it was not used. Every interactive control is in presentation (no exclusions).
- Init: `loadbang` -> `t b b b b b b b` fires right to left: weights list, trim `127` (unity),
  rolloff `4.`, blur `0.03`, master `0.`, source menu `0` (File), then `bang` -> js (venue read,
  solve, draw). js also implements `loadbang()`.

Verify in MAX (not yet load-tested): `Dict` API reads of the embedded dict, `applyvalues` into
`mc.sig~ @chans 8`, the lcd draw message forms (`paintoval l t r b r g b`, `write`, `font Arial 10`),
`set 1 $1` retargeting `adc~ 1`, and that the meters render over the lcd in presentation.

## Decisions (2026-09-19, post-build)

| # | Decision | Rationale |
|---|----------|-----------|
| D11 | Per-speaker trims (v0.2) live in the scene store (pattrstorage), not the venue dict. | User call: trims are recalled per scene. |
| D12 | The spatializer MUST work as multiple instances inside one host patch, one instance per sound source, each spatialized independently. This is a v0.2 requirement and reshapes v0.1: the instance becomes an abstraction (`dbap-source.maxpat`) loaded as a `bpatcher` with `#1` = instance name; `mc.dac~`, the shared `dict venue`, the verify ping and any host master move to a host patch; each instance outputs its 8-ch mc signal through an `outlet` and the host sums instances into `mc.dac~ 1 2 3 4 5 6 7 8` (multiple mc connections to one signal inlet sum). Per-instance state (puck, Z, rolloff, blur, weights, trims, source, master) is scene-stored under `pattrstorage #1`. | Multiple sources in one piece; the hall is shared, the source is per-instance. |
| D13 | Packaging: one abstraction file `dbap-source.maxpat` loaded N times as `bpatcher` with `@args <name>`; `#1` names the instance's `pattrstorage`. The abstraction is saved with `openinpresentation 1` so each bpatcher shows its plan/controls in the host. | Fix once, every instance updates; per-instance UI stays visible. |
| D14 | Source input per instance: signal `inlet` from the host PLUS the built-in sfplay~/adc~ selector (`selector~ 3`: File / Live / Inlet). | Host can feed any signal; desk testing stays self-contained. |
| D15 | v0.2 host: `barnett-dbap.maxpat` becomes the host with the shared `dict venue @embed 1`, two side-by-side instances, verify ping (host-level, hall property), and `mc.dac~ 1 2 3 4 5 6 7 8` summing the instances. | Proves the multi-instance path immediately. |

## Build v0.2.0 (2026-09-19)

Files: `generated/dbap-source.maxpat` (the instance, 115 boxes, presentation 660x500),
`generated/barnett-dbap.maxpat` (now the HOST: shared venue dict, instances A and B, verify ping,
`mc.dac~ 1 2 3 4 5 6 7 8`), `generated/dbap.js` (adds `trims`, `nxy`, scene-safe `srcxy`).
The v0.1 single-patch layout is superseded; its content lives on in the abstraction.

How the pieces fit:
- Host loads the instance twice: `bpatcher @name dbap-source.maxpat @args A` / `@args B`. Each
  instance's `pattrstorage #1 @savemode 0` becomes `pattrstorage A` / `B`; a loadbang `set #1` message
  writes the instance name into the title comment (comments do not substitute `#N` themselves).
- Instance I/O: inlet 0 = mono signal from the host (selector option "Inlet"); outlet 0 = the
  8-channel mc signal after the instance master. The host connects both outlets and the ping chain to
  the single `mc.dac~` inlet, which sums them.
- Trims (D11): 8-bar signed multislider, -24..+12 dB, `prepend trims` -> js, applied AFTER DBAP
  normalisation as 10^(dB/20) per speaker. Init message `0 0 0 0 0 0 0 0`.
- Scenes: `autopattr` + `pattr srcpos` under `pattrstorage #1`. Stored: srcz, rolloff, blur, master,
  weights, trims, srcpos. NOT stored (no varname on purpose): source menu, play/loop, adc channel, trim
  gain~, readouts, scene number. UI: number = slot, buttons store/recall (`pack store 1` /
  `pack recall 1`, slot on the cold inlet, bang on the hot inlet), `read`/`write` messages for files.
  autorestore is left at default 1, so `A.json`/`B.json` next to the host reload at open.
- Puck position round trip: mouse -> js emits `nxy nx ny` (outlet 2) -> `route pos nxy` -> `pattr srcpos`
  -> `prepend srcxy` -> js. js `srcxy` never emits `nxy` and is a no-op when unchanged, so there is no
  feedback loop; a recall drives the same path.
- Verify ping (host): button -> `t b b b`: `applyvalues 0 0 0 0 0 0 0 0` into an `mc.sig~ @chans 8`
  mask, then `setvalue N 1` from `pack setvalue 1 1` (N from the number box), then `1 0 0 80` into
  `line~` gating `noise~` -> `*~ 0.25` -> `mc.*~` (mask on the right inlet) -> `mc.dac~`.
- Plan is 240x300 at 15 px/m (MARGIN 30) so two instances fit side by side (host presentation
  1380x630). Meters are 10x36 at speaker px + (11, -18) in both patching and presentation.
- Weights and trims banks are vertical bars (`orientation 1`) with "1".."8" labels under each bar.

Verify in MAX (neither version has been loaded yet): everything listed under v0.1.0 plus: bpatcher
shows the instance's presentation view (relies on the abstraction's `openinpresentation 1`); `#1`
substitution in `pattrstorage #1` and the `set #1` message; `pattr srcpos` echo path; multislider
`signed 1` bipolar display; `selector~ 3` inlet order (0 = int, 1 File, 2 Live, 3 Inlet); the ping
mask via `applyvalues` + `setvalue` on `mc.sig~`. Critic warnings left as-is: the two scene `pack`
objects get hot/cold "no trigger" warnings by design (slot is set cold, button fires hot).

## Verified (2026-09-19)

v0.2.0 confirmed working in MAX by the user: two bpatcher instances render their presentation in the
host, `#1` naming, `Dict` reads of the embedded venue, `applyvalues` into `mc.sig~ @chans 8`, lcd draw
messages, meters over the lcd, `set 1 $1` on `adc~`, `selector~ 3`, the `pattr srcpos` echo path,
scenes via `pattrstorage #1`, signed trim bars, and the `applyvalues` + `setvalue` ping mask. All the
"verify in MAX" items under v0.1.0 and v0.2.0 are closed. Next: v0.3 (stereo width + sub-points,
gen~ decorrelator) per the roadmap.

## Decisions (2026-09-19, v0.3 scoping)

| # | Decision | Rationale |
|---|----------|-----------|
| D16 | ONE abstraction for mono and stereo. `bpatcher @args <name> <chans>` with `#2` = 1 or 2 (JSON number) seeding a mono/stereo `umenu` in the SOURCE panel via `loadmess #2`; the menu can still be flipped live. Two signal inlets (L, R); `sfplay~ 2` and `adc~ 1 2` always; a `selector~` picks the right feed = R input (stereo) or a copy of L (mono) before the decorrelator. | Two files would double every future fix; the variant is one selector and one flag. A stereo-only file would silently put a mono stem on the left sub-point. |
| D17 | Width visualisation: the plan draws the spread axis as a short bar through the puck with a tick at each sub-point labelled L and R; ticks collapse onto the puck as the centroid fade takes effective width to zero. | Shows the geometry and the fade, not just the parameter. |
| D18 | v0.3 ports the plugin's width + decorrelator verbatim: two DBAP solves (left/right sub-points, `SourceShaper.cpp` steps 1-6, kFadeFraction 0.05, centroid bearing, per-sub-point ear height), per-speaker output `vL*sL + vR*sR` with each feed at 0.5; decorrelator = 4 Schroeder all-passes per feed, g 0.7, bases L {113,199,317,449} / R {139,233,359,521} samples at 48 kHz scaled by samplerate, depth scales delay length (integer reads, clamp >= 1), applied depth = decorr * min(wEff / 2 m, 1), bypassed at wEff 0. Width 0..12 m default 0; decorr 0..1 default 0. Both scene-stored. | Same numbers as the verified plugin (D10 principle). |

## v0.3 build brief (for /max-build in a fresh context)

Start from the v0.2.0 files in `generated/` (all confirmed working in MAX). Edit the abstraction and
host via the Patcher API (`read_patch` -> edit -> `finalize_patch(is_new=False)` -> `ensure_text_contrast`
-> `save_patch_roundtrip`); do NOT re-run `apply_layout` (see "Build v0.1.0" notes). Keep every
existing varname and the instance presentation size (660x500) so scenes and the host layout survive.

Reference source (read before writing the js/gen code, port the numbers verbatim, D18):
- `/Users/taylorbrook/Dev/VST-development/plugins/O-Octagon/Source/DSP/SourceShaper.cpp` (sub-points)
- `/Users/taylorbrook/Dev/VST-development/plugins/O-Octagon/Source/DSP/Decorrelator.h` (all-pass chains)
- `/Users/taylorbrook/Dev/VST-development/plugins/O-Octagon/Source/DSP/GainStage.cpp` lines ~570-630
  (wEff gate, depth ramp) and ~820-870 (per-sample `vL*sL + vR*sR`, feeds at 0.5)

Deliverables:
1. `dbap.js`: `width f` and `decorr f` handlers; `shape()` port (bearing from centroid, rFade =
   0.05*rigScale, wEff, nHat, per-sub-point ear height); two solves per update -> outlet 0 emits
   `applyvalues` for the L lane and a NEW outlet for the R lane (or `gainsL`/`gainsR` prefixes into
   `route`); readouts add `weff`; plan draws the axis bar + L/R ticks (D17). Trims apply to both lanes.
2. `dbap-source.maxpat`: second `inlet` (R) placed to the RIGHT of the existing inlet box (port
   x-order rule); `sfplay~ 2`, `adc~ 1 2`; `selector~` for the right feed (stereo = R, mono = copy of
   L) driven by a mono/stereo `umenu` seeded by `loadmess #2` (D16); a `gen~` codebox decorrelator
   (2 in, 2 out, `Param depth`, 8 `Delay`s, integer `read` with `interp="none"`, delays =
   `round(base * depth * samplerate/48000)` clamped >= 1, g 0.7, CLAUDE.md codebox rules: declarations
   first, spaces only, no else-if, no `delay()`); second `mc.sig~ @chans 8` + `mc.rampsmooth~` +
   `mc.*~` lane for the R feed, `mc.+~` before the master; `live.dial` width (0..12 m, unitstyle 9
   custom "m" or 1) and decorr (0..1) in the POSITION panel; both scene-stored (varnames).
   Depth sent to gen~ = `decorr * min(wEff/2, 1)` computed in js and emitted as `depth $1`.
3. `barnett-dbap.maxpat` host: bpatcher args become `["A", 1]` and `["B", 2]` (ints as JSON
   numbers), `numinlets 2`.
4. Numpy pre-flight BEFORE committing the codebox: simulate the 4-section chain at depths
   {0, 0.1, 0.25, 0.5, 0.75, 1.0}; assert chain gain within 0.05 dB of unity and L/R cross-correlation
   < 0.15 at depth 1; assert the two chains are identical at depth 0.
5. Bump to 0.3.0, build notes in this file, commit, verify list for MAX.

## Build v0.3.0 (2026-09-19)

Files: `generated/dbap-source.maxpat` (142 boxes; presentation still 660x500, every v0.2 varname kept),
`generated/barnett-dbap.maxpat` (host: bpatcher args `["A", 1]` / `["B", 2]`, `numinlets 2`, title v0.3),
`generated/dbap.js` (sub-point shaper, two solves, 5 outlets). Edited in place via `read_patch` ->
`finalize_patch(is_new=False)` -> `save_patch_roundtrip`; no `apply_layout`.

Port (D18, numbers verbatim from O-Octagon v1.13.0):
- `dbap.js` `shape()` = `SourceShaper::shapeAt` steps 2-6: bearing from the rig centroid, rFade =
  0.05 * rigScale (kFadeFraction), fallback bearing (0, -1) at |b| < 1e-6, n^ = (-b^.y, b^.x), wEff =
  width * fade, each sub-point at its own ear height. `solveAt()` runs the unchanged DBAP solve twice
  (L, R); trims apply to both lanes. Outlets: 0 = `applyvalues` L lane, 3 = `applyvalues` R lane,
  4 = `depth d` with d = decorr * clamp(wEff / 2 m, 0, 1) while decorr > 0 AND wEff > 0, else 0
  (GainStage.cpp gate + kFullDepthWidthMetres). Readouts add `weff w` and `gainsr g1..g8`.
- gen~ decorrelator (2 in / 2 out codebox): 4 Schroeder all-passes per feed, g 0.7, bases L
  {113,199,317,449} / R {139,233,359,521} samples at 48 kHz scaled by `samplerate / 48000`,
  delay = clamp(floor(base * scale * depth + 0.5), 1, 4095), read-before-write, `Delay(4096)` x 8.
  `depth` has a 5 ms linear slew and a 5 ms 0/1 lerp crossfade (the plugin's decorrMix gate) so the
  dry path is bit-exact once depth is 0. Feeds leave the gen~ at 0.5 (`sL`/`sR` level convention).
  `History one(1)` hoist guard per CLAUDE.md. Plain `read(n)` on an integer n (bit-exact; the
  `interp="none"` form is not repo-proven so it was not used). Chains run continuously instead of
  being reset on the engage edge (all-pass, always fed: no stale-state click possible).
- Signal path: `selector~ 3` (L) and a second `selector~ 3` (R) share the source menu via `t i i` ->
  two `+ 1`; `sfplay~ 2`, `adc~ 1 2`, inlets L and R (R inlet box placed right of L, port x-order).
  L -> `gain~` (trim, presentation); R -> a second `gain~` slaved from the L fader's right outlet
  (patching only: deliberate presentation exclusion, single master trim). `selector~ 2` picks the R
  feed: 1 = copy of L (mono), 2 = R (stereo), driven by the chans `umenu` (mono / stereo) seeded by
  `loadmess #2` -> `- 1` -> umenu -> `+ 1`. gen~ out1 -> L `mc.*~` lane, out2 -> new R lane
  (`mc.sig~ @chans 8` -> `mc.rampsmooth~ 1024 1024` -> `mc.*~`), lanes summed by `mc.+~` before the
  master `mc.*~`. Speaker output = vL_i * sL + vR_i * sR.
- UI: `live.dial` width (0..12, unitstyle 1 float, "m" not shown: unitstyle 9 custom units is not
  repo-proven) and decorr (0..1) in the POSITION panel at presentation x 500 / 565; src Z label +
  flonum narrowed to 62 px (x 430) to make room. Both dials have varnames (scene-stored via
  autopattr) and loadbang init `0.` (init trigger grown to 11 outlets). chans umenu at SOURCE row 3
  (290, 124) with a "chans" label. Plan (D17): a 2 px axis bar through the puck between the two
  sub-points with a perpendicular tick at each end, drawn UNDER the puck so the ticks collapse onto
  it as the centroid fade takes wEff to 0; L / R labels appear once the half-spread clears the puck,
  and "w N.N m" (wEff) is written beside the puck. No wEff flonum: the readout row under the plan is
  full, so wEff lives in the plan text and on the readouts outlet.

Pre-flight (`scratchpad/preflight_decorr.py`, numpy, 131072 samples of noise, 48 kHz), mirroring the
codebox difference equations exactly, depths {0, 0.1, 0.25, 0.5, 0.75, 1.0}:
chain gain within 0.003 dB of unity at every depth (spec 0.05 dB); L/R correlation at lag 0 = 0.062 at
depth 1 (spec < 0.15; max over |lag| <= 2000 samples 0.071); the two chains are sample-identical at
depth 0; coherent sum of the two feeds at 0.5 sits at -2.75 dB (incoherent addition, no comb). Longest
delay at 192 kHz = 2084 < 4096. Node smoke test of `dbap.js`: sum v^2 = 1 per lane, depth 0.5 at
width 1 m, lanes identical at width 0, wEff 0 at the exact centroid, downstage puck puts R at +x.

Validator / critic notes: one non-blocking `trigger outlet -> signal inlet` error on `sfplay~ 2`
outlet 1 -> `selector~ 3` (R): the DB curates sfplay~ outlet 1 as the bang outlet of the 1-channel
form, but `sfplay~ 2` has outlets (sig, sig, bang). The connection is correct in MAX and is kept;
a `variable_io_rules` entry for `sfplay~` (outlets = first_arg + 1) was added to `overrides.json`
so I/O counts compute correctly, but per-outlet roles are not arg-aware so the false positive stays.
Two pre-existing `pack` hot/cold warnings (scenes) remain by design. Section headers keep the orange
accent (`repair_text_contrast` had recoloured them grey; restored).

Verify in MAX (v0.3.0 not yet load-tested): gen~ codebox compiles (8 `Delay(4096)`, `clamp`,
`floor`, History-one guard); `depth $1` messages from js reach the Param; `loadmess #2` seeds the
chans menu per instance (A mono, B stereo) and `- 1` / `+ 1` land on `selector~ 2` inputs 1 / 2;
`sfplay~ 2` outlet 1 and `adc~ 1 2` outlet 1 feed the R selector; the slaved R `gain~` follows the L
fader; width/decorr dials recall with scenes; plan axis bar, ticks, L/R labels and "w" text render;
with width 0 the output is identical to v0.2 (lanes equal, depth 0, dry bit-exact); with width > 0
and decorr 1 the spread widens without comb colouration; host bpatchers show 2 inlets.

## Verified (2026-09-19, v0.3.0)

v0.3.0 confirmed working in MAX by the user with no errors: gen~ codebox decorrelator compiles and
runs (8 x `Delay(4096)`, `clamp`/`floor`, History-one hoist guard, plain integer `read(n)`), `depth $1`
messages from js reach the Param, `loadmess #2` seeds the chans menu per instance (A mono, B stereo),
`sfplay~ 2` / `adc~ 1 2` second outlets feed the R selector, the slaved R `gain~` follows the L fader,
width/decorr dials, plan axis bar + L/R ticks, R gain lane + `mc.+~` sum, host bpatchers with 2 inlets
and JSON-int args. Every "verify in MAX" item under v0.3.0 is closed. Next: v0.4 (air filter, hull
projection and trim) per the roadmap.

## Decisions (2026-09-19, v0.4 scoping)

| # | Decision | Rationale |
|---|----------|-----------|
| D19 | v0.4 adds TWO scene-stored `live.dial`s in the POSITION panel and NO on/off toggles: `air` 0..1 (plugin default 0.35) and `hull` 0..3 dB/m (plugin default 1.0). Zero on either dial is the plugin's exact no-op branch (air: filter skipped, bit-transparent; hull: `pow(10, -0) = 1`), so a toggle would only duplicate the dial's endpoint. The z-cue (level scale of the srcZ solve against the ear-height solve) stays implicit, no control, as in the plugin. Hull trim is expected to be near-inert on the Barnett rig (only the two rear-corner triangles lie outside the octagon) and is included for plugin parity and venue portability. | User call over "air only" and "toggles": parity with the verified plugin at the cost of one extra dial; a scene can carry "off" without a second control. |

v0.4 port targets (read before building): `HullProcessor.h` (`hullTrimGain`: -hullAtten * dHull dB floored at
-24 dB; `airCutoffHz`: 20 kHz ceiling, 500 Hz floor, dRef = 0.2 rigScale, near field 0.1 rigScale,
Nyquist margin 0.45 fs, driven by the sub-point's planar distance from the centroid), `ConvexHull2D`
(hull of the 8 speakers, distance outside), `GainStage.cpp` step 6 (per sub-point: trim, z-cue, air
cutoff; one-pole TPT lowpass per feed, skipped inside the near field, reset only on the air -> 0
transition, seeded s = x on the engage edge). Filter goes in the existing gen~ (two more Params:
air cutoff L / R in Hz from js), trim and z-cue multiply into the js gain vectors.

| D20 | v0.4 layout: instance stays 660x500. POSITION grows to two dial rows; WEIGHTS and TRIMS merge into ONE panel with 42 px bars and a single shared "1".."8" label row between the two banks. | User call over growing the instance to 660x576 (recommended) and over 44 px dials: the host layout and instance footprint stay fixed; coarser trim bars (about 1.2 px/dB) accepted. |

D20 presentation coordinates (right column only; the left column and SOURCE panel do not move):

| Box | v0.3 presentation_rect | v0.4 presentation_rect |
|---|---|---|
| POSITION panel `obj-4` | 280 170 360 100 | 280 170 360 170 |
| row 1 (rolloff, blur, src Z, width, decorr) | y 192 | unchanged |
| NEW `air` live.dial (0..1, initial 0.35, varname `air`) | - | 290 266 60 70 |
| NEW `hull` live.dial (0..3, initial 1.0, varname `hull`) | - | 360 266 60 70 |
| bank panel `obj-5` (now WEIGHTS + TRIMS) | 280 280 360 108 | 280 348 360 148 |
| TRIMS panel `obj-6` | 280 396 360 100 | removed from presentation (keep in patching) |
| WEIGHTS header `obj-37` | 290 286 75 20 | 290 352 75 20 |
| weights multislider `obj-38` | 290 306 340 60 | 290 370 340 42 |
| shared labels `obj-39`..`obj-46` | y 368 | y 413 (x unchanged, 14 x 16) |
| trims labels `obj-50`..`obj-57` | y 474 | removed from presentation (columns align with the shared row) |
| TRIMS header `obj-48` | 290 402 93 20 | 290 429 93 18 |
| trims multislider `obj-49` | 290 422 340 50 | 290 448 340 42 |

Build notes for D20: these are round-tripped boxes, so set `box.presentation_rect` (model field, overlaid
at serialize) and use `box.presentation = False` for the removed ones; do not touch patching rects.
Both new dials get loadbang inits (`0.35`, `1.`), `prepend air` / `prepend hull` into js, and the init
trigger grows from 11 to 13 outlets. Keep the orange section-header textcolor; do not run
`repair_text_contrast` blindly (it greyed the headers in v0.3.0 and had to be reverted).

## Build v0.4.0 (2026-09-19)

Files: `generated/dbap-source.maxpat` (149 boxes; presentation still 660x500, every earlier varname
kept), `generated/dbap.js` (hull, hull trim, z-cue, air cutoff), `generated/barnett-dbap.maxpat` (title
v0.4 only; semantic diff against the MAX-saved host is that one string), `test-results/preflight_air.py`.
Edited in place via `read_patch` -> `finalize_patch(is_new=False)` -> `save_patch_roundtrip`; no
`apply_layout`, no `repair_text_contrast` (orange headers untouched).

Port (D19, numbers verbatim from O-Octagon v1.13.0):
- `dbap.js` `buildHull()` = `ConvexHull2D::build`: dedup 1e-4, sort (x, y), Andrew's monotone chain with
  the `<= epsCross` pop (epsCross = 1e-6 * spanX * spanY), CCW winding check. On the Barnett rig the hull
  is the 6-vertex polygon 1-2-4-5-6-7 (speakers 3 and 8 are on-edge and popped, as in the plugin).
  `hullInside` / `hullProject` = `hull::isInside` / `hull::project` including the 1- and 2-point cases.
- `solveSubPoint()` = GainStage `solveSubPoint` + step 6: a sub-point outside the hull is solved at its
  nearest boundary point; trim = 10^(max(-hull * dHull, -24)/20); z-cue = clamp((invK_z / invK_0)^2.5,
  -6 dB, +6 dB) with invK = sqrt(denom) and invK_0 the same solve with srcZ stripped (exactly 1 at
  srcZ 0, and 1 on the all-zero-weights path). trim * z-cue folds into the lane gains BEFORE the
  per-speaker trims. `solveAt` now returns invK and no longer applies the speaker trims itself.
- Air: dAir = max(|subpoint - centroid|_xy - 0.1 rigScale, 0) from the UNPROJECTED sub-point;
  fc = clamp(20000 * 2^(-air * dAir / (0.2 rigScale)), 500, 20000); js sends `fcl` / `fcr` in Hz on
  outlet 4 (same cord as `depth`), and sends 0 for "skip" (air 0 or dAir 0 = the plugin's bit-transparent
  branch). The 0.45 fs Nyquist ceiling is applied in the gen~, which knows the sample rate.
- gen~: `Param fcl`, `Param fcr`; one-pole TPT lowpass per feed (g = tan(pi fc / fs), G = g/(1+g),
  v = G(x - s), y = v + s, s = y + v = juce FirstOrderTPTFilter) placed BEFORE the decorrelator, as in
  GainStage. Engage edge seeds s = x (y = x exactly on the edge sample). Filter math is branch-free;
  the `if`s only select (no nested ifs, no else-if, History-one hoist guard on both new Params).
  `fixnan` on the state replaces the plugin's per-block NaN guard.
- Deviations, both deliberate: (1) the cutoff has a 10 ms one-pole slew (snapped on the engage edge)
  because js updates arrive at mouse rate, not on the plugin's 64-sample control grid; (2) the plugin's
  "reset state on air -> 0" is omitted because every re-engage seeds s = x, which makes the reset
  unobservable.
- UI (D19/D20): `live.dial` `air` (0..1, initial 0.35) at presentation 290 266 and `hull` (0..3, initial
  1.0) at 360 266, both with varnames (scene-stored via autopattr), `prepend air` / `prepend hull` -> js,
  loadbang inits `0.35` / `1.` on trigger outlets 11 / 12 (init trigger now 13 outlets). D20 rects applied
  exactly as tabled; `obj-6` and the trims label row `obj-50`..`obj-57` left presentation (patching kept).
- Plan: the hull polygon is drawn inside the bounding box (grey-blue), and a status line under the plan
  shows `air 6.7k` while the filter runs and `hull -1.5 dB` while a sub-point is outside the hull.
  Readouts outlet adds `airhz fL fR`, `dhull dL dR`, `zcue cL cR`.

Pre-flight (`test-results/preflight_air.py`, numpy, mirrors the codebox equations): -3.01 dB at fc within
0.02 dB for fc {500, 2k, 6.7k, 15k} at 44.1 / 48 / 96 kHz; fc 0 is sample-identical to the input; the
engage-edge sample equals the input exactly and adds no slew (ratio 1.000 on a 1 kHz sine); a 20 kHz ->
500 Hz cutoff step mid-signal stays at slew ratio 1.11 (no click); stable at 22.05 kHz (ceiling 9.9 kHz);
the state recovers after an inf sample. Node smoke test of `dbap.js`: max dHull on the reachable plane
2.138 m (plugin doc: 2.14 m), rear-corner trim -2.14 dB at hull 1, sum v^2 = 1 inside the hull and with
hull 0, 6.7 kHz at the rig radius at air 0.35 (plugin doc figure), 500 Hz floor at the rear corners at
air 1, z-cue exactly 1 at srcZ 0 and +5.2 / -3.0 / -2.1 dB at srcZ +3 / -2 / +8 m near front-left.

Validator / critic: unchanged from v0.3.0 (the `sfplay~ 2` outlet-role false positive and the two scene
`pack` hot/cold warnings); nothing new. Known framework issue, NOT introduced here: `finalize_patch`
regenerates patch-cord midpoints with long zigzag paths in patching mode (already true of the v0.2 /
v0.3 files); presentation is unaffected.

Verify in MAX (v0.4.0 not yet load-tested): gen~ compiles with the air block (`tan`, `exp`, `fixnan`,
`&&` in `if`, 8 Histories); `fcl $1` / `fcr $1` from js reach the Params; with air 0 OR the puck within
about 0.8 m of the rig centroid the output is identical to v0.3; dragging the puck to a rear corner at
air 1 darkens the source to about 500 Hz with no clicks or zipper while dragging; the `air` / `hull` dials
load at 0.35 / 1.0 and recall with scenes; rear-corner puck drops level by about 2 dB at hull 1 and not
at hull 0; src Z now changes level (louder toward +3 m, quieter below 0 and far above); hull outline and
the `air` / `hull` status text draw on the plan; D20 layout: two dial rows in POSITION, merged
WEIGHTS + TRIMS panel with one shared 1..8 label row, nothing clipped at 660x500 in the host.

## v0.5 open questions (2026-09-19, not yet decided; run /max-discuss)

The roadmap line for v0.5 (motion engine, alignment delays, `.venue` importer) has no decisions yet, and
v0.4.0 is not MAX-verified, so v0.5 was NOT built in the v0.4 session. What needs a call first:
1. Motion UI: the plugin's engine (`MotionPath.h`, `MotionClock.h`, `PerlinNoise.h`) has six paths
   (orbit, figure-8, sweep, drift, pendulum, spiral) and about eight controls (on, path, size m, ratio,
   rate, phase, angle, height). The instance is full at 660x500 (D20). Options: a pop-out motion panel
   per instance (recommended), grow the instance, or a reduced control set (path, size, rate).
2. Motion clock: js `Task` / `metro`-driven at about 60 Hz into the existing event-driven solve
   (recommended, matches D3 and the 21 ms gain ramp), or signal-rate motion in gen~.
3. Alignment delays: host-level (hall property, one 8-channel delay stage before `mc.dac~`, values in
   the venue dict; recommended, matches D12's "the hall is shared") or per instance.
4. `.venue` importer: `node.script` is not in the object DB (CLAUDE.md), so the sanctioned route is a
   build-time Python tool that converts a `.venue` file into a `dict`-loadable JSON; the alternative is
   adding `node.script` to the DB with verified I/O first.

## User edit in MAX 9.1.5 (2026-09-19, after the v0.4.0 build)

`generated/dbap-source.maxpat` re-saved from MAX with six encapsulations (142 top-level boxes). Checked
against the v0.4.0 commit: wiring-equivalent, gen~ codebox byte-identical, all varnames kept.
- `p speedlim` (`speedlim 15` -> `prepend mouse`): lcd outlet 0 -> js.
- `p mc` / `p mcramp` (`mc.sig~ @chans 8` -> `mc.rampsmooth~ 1024 1024`): L lane (js outlet 0) and R lane
  (js outlet 3) into the right inlets of the two `mc.*~`.
- `p gaininterp` (`dbtoa` -> `$1 20` -> `line~`): master dial -> master `mc.*~` right inlet.
- `p scenespack` (4 in: recall bang, recall slot, store bang, store slot; x-order verified) -> pattrstorage.
- `p pattr` (`pattr srcpos` -> `prepend srcxy`): MAX gave this subpatcher box the varname `patcher`, so
  the pattrstorage client path for the puck is now `patcher::srcpos`, not `srcpos`. Scene files written
  by v0.2-v0.4 builds before this edit would not recall the puck position; none exist in the project dir.
- The gain lane moved up in patching (`mc.*~` 597, `mc.+~` 638, master `mc.*~` 698); SCENES block shifted
  24 px right. Presentation rects unchanged apart from MAX's own normalisation (live.dial 60x48,
  meter~ 12x58, comment heights 19-20).
Future edits: these objects now live INSIDE subpatchers (`box._inner_patcher`), not at top level; ids
obj-60/61/70/71/73/74/81/82/83/99/100/131/132 are no longer top-level boxes.

## Verified (2026-09-19, v0.4.0)

v0.4.0 confirmed working in MAX 9.1.5 by the user, on the file as re-saved with the six encapsulations:
gen~ codebox compiles with the air block (`tan`, `exp`, `fixnan`, `&&` inside `if`, branch-free TPT
one-pole, 8 Histories, History-one hoist guard on three Params); `fcl $1` / `fcr $1` / `depth $1` from js
reach the Params on one cord; air filter darkens toward the rear corners without clicks or zipper; hull
trim and z-cue audible; `air` / `hull` dials load at 0.35 / 1.0 and recall with scenes; hull outline and
status text draw on the plan; D20 two-row POSITION and merged WEIGHTS + TRIMS panel fit at 660x500.
Every "verify in MAX" item under v0.4.0 is closed. Next: v0.5 scoping via /max-discuss (see "v0.5 open
questions").
