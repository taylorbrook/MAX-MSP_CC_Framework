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

## v0.5 open questions (2026-09-19) -- RESOLVED by D21-D24 below

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

## Decisions (2026-09-19, v0.5 scoping)

| # | Decision | Rationale |
|---|----------|-----------|
| D21 | Motion is a SEPARATE abstraction, `dbap-motion.maxpat`, loaded as its own bpatcher and patched into a source only when wanted. Two cords: (1) motion outlet -> a NEW third inlet on `dbap-source` (placed right of the L / R audio inlets, port x-order) carrying `motion dx dy dz`, an anchor-relative offset in METRES that `dbap.js` adds to the puck position before shaping / hull / air (the plugin's insertion point); (2) a NEW control outlet on `dbap-source` (right of the mc outlet) emitting its `store N` / `recall N` messages -> the motion module's inlet, so one scene recall restores position AND motion. The motion module keeps its own `pattrstorage #1` and its own store / recall buttons, so it also works with the scene cord unpatched. `dbap-source` stays 660x500 (D20 untouched); with no motion cord there is no clock and no cost. | User proposal, chosen over a pop-out panel, a reduced in-panel set and growing the instance. The plugin's path generator already outputs anchor-relative metres, so the module needs no venue knowledge. Scene sync chosen because scenes are used as cues: an unsynced recall would move the anchor while the old motion keeps running. |
| D22 | Motion clock: the motion module's own js runs a `Task` at about 60 Hz and evaluates the plugin's path equations from elapsed time (`cycles = rate * t + phaseBase`, with the plugin's re-base `phaseBase += (oldRate - newRate) * t` on a rate change so the path never jumps). Free-running Hz only, 0.01..10 Hz, default 0.1. No transport sync, no signal-rate clock. | User call. Matches D3 (event-driven solve) and the 21 ms gain ramp already smooths 60 Hz position steps; no transport dependency in a hall patch. |
| D23 | Alignment delays are a HOST stage fed from the shared venue dict: one 8-channel delay just before `mc.dac~`, after the sources and the verify ping are summed. Values come from a `delayMs` key per speaker (`speakers::sN::delayMs`, default 0) in `dict venue`. No visible delay bank in v0.5; edit the dict or import a venue. | User call over a visible 8-bar bank and per-source delays. The plugin stores delayMs in the venue and D12 says the hall is shared. |
| D24 | `.venue` import is a build-time Python converter (`tools/` style command-line script, NOT a patch generator, so Rule #5 does not apply): `.venue` XML -> JSON in the exact shape of the embedded `dict venue`. The host gets a `read` control that loads that JSON into `dict venue` and re-bangs every source (`venue` message). | User call over js File API parsing and adding `node.script` to the DB. Only verified objects in the patch. |

## v0.5 build brief (for /max-build in a fresh context)

Start from the verified v0.4.0 files in `generated/`. NOTE the user's MAX re-save: six groups now live in
subpatchers (`p speedlim`, `p mc`, `p mcramp`, `p gaininterp`, `p scenespack`, `p pattr`); see "User edit
in MAX 9.1.5". Edit via `read_patch` -> `finalize_patch(is_new=False)` -> `save_patch_roundtrip`; no
`apply_layout`, no blind `repair_text_contrast`. Keep every varname and the 660x500 instance.

Reference source (port the numbers verbatim, D10 principle), all under
`/Users/taylorbrook/Dev/VST-development/plugins/O-Octagon/Source/`: `DSP/MotionPath.h` (six paths, fold,
rotation, z), `DSP/MotionClock.h` (free-run cycles and the rate re-base), `DSP/PerlinNoise.h` (seeded fbm
for Drift), `PluginProcessor.cpp` ~lines 188-214 (ranges and defaults: rate skewed 0.01..10 Hz default
0.1, size 0..24 m default 6, ratio 0..1 default 1, angle 0..360, height 0..8 m default 0, phase 0..360,
seed 1..64 int), `Data/VenueModel.h` (VENUE @rakeFront @rakeRear, SPEAKER x8 @index @x @y @z @trimDb
@delayMs @label), `DSP/GainStage.cpp` (where the motion offset is added, and the alignment-delay stage:
zero delay is bypassed outright).

Deliverables:
1. NEW `generated/motion.js` + NEW `generated/dbap-motion.maxpat` (D21, D22). js: `Task` at 16 ms started
   by `on 1`, stopped by `on 0`; handlers `path i` (0..5 orbit, figure8, sweep, drift, pendulum, spiral),
   `rate`, `size`, `ratio`, `angle`, `height`, `phase`, `seed`; emits `motion dx dy dz` (metres) each
   tick and `motion 0 0 0` once when switched off; emits `trace x1 y1 x2 y2 ...` (32 points, metres,
   cyclic paths only) when a shape parameter changes, so the source's plan can draw the path. Patch:
   `bpatcher`-ready abstraction, `openinpresentation 1`, `#1` = instance name for its own
   `pattrstorage #1 @savemode 0` + `autopattr`; controls = on toggle, path `umenu` (comma-as-element
   items), seven `live.dial`s / number for seed, all with varnames; its own slot number + store / recall;
   inlet 0 accepts `store N` / `recall N` from the source and forwards them to its pattrstorage; outlet
   0 = motion messages. Presentation about 360x150, same dark panel / orange header styling as the source.
2. `dbap-source.maxpat`: third `inlet` placed RIGHT of the two audio inlets (port x-order) -> js;
   `dbap.js` handlers `motion dx dy dz` (offset added to the puck metres before `shape()`; the stored
   anchor `srcpos` is NOT changed; z offset adds to srcZ for both the solve and the z-cue) and
   `trace ...`; the plan draws the anchor as a hollow ring, the moving puck solid, and the trace polyline.
   New control `outlet` placed RIGHT of the mc outlet: tap the `store N` / `recall N` messages leaving
   `p scenespack` (fan out through a `trigger`) to it. A mouse drag moves the anchor as before.
3. Host `barnett-dbap.maxpat`: bpatchers get `numinlets 3`, `numoutlets 2`; add one `dbap-motion` instance
   (`@args Am`) patched to source A both ways as the demo; alignment stage (D23): 8-channel delay before
   `mc.dac~` driven from `speakers::sN::delayMs` read by a small host js or `dict` `get` chain at load and
   on venue read. `mc.delay~` is in the DB (2 inlets, 1 outlet) but its per-channel delay-setting form is
   NOT repo-proven: verify the maxref first (per-channel values need `applyvalues` / `setvalue`, memory
   `feedback_mc_applyvalues`), delay in SAMPLES = ms * sr / 1000, and all-zero must be bit-transparent.
   Add `delayMs: 0` to each speaker in the embedded dict. Venue `read` control: `dict` has `read` and
   `import` messages in the DB; after a load, send `venue` to every source (named send / receive).
4. NEW Python converter (D24), e.g. `patches/barnett-dbap/tools/venue_to_json.py`: parse the XML with
   `xml.etree`, map `@index` 1..8 -> `s1`..`s8`, write `name`, `units`, `speakers::sN::{x,y,z,delayMs}`,
   `rake::{front,rear}`; ignore `@trimDb` (D11: trims live in scenes) but print it so the user can copy
   values; test against `tests/fixtures/cr-b-permuted.venue` in the plugin repo.
5. Pre-flight before committing: node test of `motion.js` (each cyclic path closes after one cycle, max
   |offset| = size / 2, a rate change mid-cycle produces no position jump, Drift is deterministic per
   seed); node test of `dbap.js` (`motion 0 0 0` gives bit-identical gains to no motion).
6. Bump to 0.5.0, build notes here, commit, verify list for MAX.

## Build v0.5.0 (2026-09-19)

Files: NEW `generated/dbap-motion.maxpat` (56 boxes, presentation 360x150) + NEW `generated/motion.js`;
`generated/dbap-source.maxpat` (147 boxes, still 660x500, every varname kept), `generated/dbap.js` (motion +
trace), `generated/barnett-dbap.maxpat` (host: alignment stage, venue read, one motion instance `Am` on
source A), NEW `generated/venue-align.js` (host), NEW `tools/venue_to_json.py` (D24),
`test-results/preflight_motion.js` + `motion_ref.cpp` / `motion_ref.txt`.

Motion module (D21, D22), numbers verbatim from O-Octagon v1.13.0:
- `motion.js` = `MotionPath.h` `evaluate()` (six paths, `fold`, rotation skipped exactly at angle 0, z =
  height sin t, Drift = seeded fbm at n / n + 1000 / n + 2000), `MotionClock.h` `freeRunCycles`
  (`cycles = rate * t + phaseBase`, re-base `phaseBase += (oldRate - newRate) * t` observed at the next
  tick), `PerlinNoise.h` (uint32 LCG shuffle; the double product stays below 2^53 so it is exact, fbm 4
  octaves). `Task` at 16 ms; position comes from ELAPSED time (`Date`), never an accumulator, so Task jitter
  cannot bend the path. `on 1` restarts at phase 0 (the plugin's re-prepare); `on 1` while running is
  ignored so a scene recall does not restart the phase; `on 0` emits `motion 0 0 0` and a bare `trace` once.
  `trace` = 32 points of one cycle, sent on start and on path / size / ratio / angle / phase changes, only
  while on; Drift sends a bare `trace` (clear).
- Ranges: rate 0.01..10 Hz (D22; the plugin stops at 4), `live.dial` unitstyle Hz with
  `parameter_exponent 4` (0.63 Hz at the dial centre); size 0..24 m (6), ratio 0..1 (1), angle 0..360,
  height 0..8 m, phase 0..360, seed 1..64 (`number`), path `umenu` (orbit, figure-8, sweep, drift, pendulum,
  spiral, comma-as-element items). Varnames `on path rate size ratio angle height phase seed` -> `autopattr`
  -> `pattrstorage #1 @savemode 0`; own slot / store / recall; inlet 0 feeds `store N` / `recall N` straight
  into that pattrstorage; outlet 0 = motion messages. Loadbang init row on top (every cord runs down).
- Face: header + title (`set #1`), on, path / rate, size, ratio, angle + slot, store, recall / height,
  phase, seed. Same panel 0.19 / orange header / grey text as the source.

Source (D21):
- THIRD `inlet` at patching x 850 (audio inlets are x 630 / 663, port x-order) -> `js dbap.js`. It sits
  beside the js, not at the top, so no cord crosses the lcd.
- `dbap.js`: `motion dx dy dz` adds metres to the anchor AFTER norm -> metres and BEFORE `shape()` (no
  clamp, the hull projection handles a path that leaves the rig, as in the plugin); `zEff = srcZ + dz` is
  computed once and read by BOTH the sub-point heights and the z-cue reference solve (GainStage.cpp Risk 6).
  The anchor (`srcNX/srcNY`, `pattr srcpos`) is never touched and `motion` never emits `nxy`. Each tick
  solves; the plan redraws at most every 30 ms. Plan: trace polyline around the anchor, anchor as a hollow
  ring, moving puck solid; with no closed trace (Drift) a 48-point tail of recent positions is drawn. With no
  motion cord the plan is pixel-identical to v0.4. The `pos` readouts follow the moving puck.
- Scene cord: `t l l` added INSIDE the user's `p scenespack` (left outlet -> the existing outlet ->
  `pattrstorage #1`, right outlet -> a new second subpatcher outlet placed right of the first). `p scenespack`
  outlet 1 -> a new top-level `outlet` at patching x 1840 (right of the mc outlet at x 700). Both fire in the
  same scheduler tick, order is immaterial. This is the ONLY pre-existing box that changed (numoutlets 1 -> 2).
- `r dbap-venue` -> js: the host broadcasts `venue` after a dict read.

Host (D23, D24):
- Sources get `numinlets 3`, `numoutlets 2`. `bpatcher @name dbap-motion.maxpat @args Am` under source A
  (presentation 20 630 360 150, caption beside it); A outlet 1 -> motion inlet, motion outlet -> A inlet 2.
  Host window height 752 -> 840 so the module is visible.
- Alignment: sources + verify ping now sum at `mc.delay~ 9600 @chans 8` -> `mc.dac~` (the DSP toggle still
  goes straight to `mc.dac~`). `venue-align.js` reads `speakers::sN::delayMs` (missing = 0), clamps to the
  plugin's 0..50 ms rail, and sends `setvalue N <int samples>` (round(ms * sr / 1000)) through
  `s dbap-align` / `r dbap-align` into the delay's RIGHT inlet. Research: the mc wrapper maxref says
  `setvalue` works in any inlet; `applyvalues` in a right inlet is not documented, so it was not used. Int
  delay times keep `delay~` on its non-interpolating path: delay 0 = "no delay" (maxref), so the default
  venue is bit-transparent. A signal-driven delay time was rejected: the maxref says it interpolates and adds
  one sample of latency. 9600 samples = 50 ms at 192 kHz. `dspstate~` outlet 1 -> `prepend sr` re-sends the
  sample counts whenever DSP starts. A status comment in the bottom panel shows the venue name and
  `align off` / `align on, max N ms`.
- Embedded `dict venue` now carries `delayMs: 0.0` on all 8 speakers.
- Venue read: `read` (presentation, VENUE section of the bottom panel) -> a second `dict venue` box (same
  named dictionary as the embedded one, so the embedded box saves whatever was read) -> outlet 4
  (`read <file> 0/1`) -> `route read` -> `t b` -> `venue` -> `s dbap-venue` -> every source's `dbap.js` and
  `venue-align.js`.
- `tools/venue_to_json.py`: `xml.etree`, speakers located by `@index`, per-attribute fallback to the OQ4
  defaults like the plugin's loader (the `cr-b-permuted.venue` fixture carries only index + label and
  converts to exactly the embedded dict), writes `name / units / speakers::sN::{x,y,z,delayMs} /
  rake::{front,rear}`, prints `trimDb` (not written, D11) and notes for bad / missing / out-of-rail values.
  Usage: `python3 patches/barnett-dbap/tools/venue_to_json.py hall.venue` -> `hall.json`.

Pre-flight (`node patches/barnett-dbap/test-results/preflight_motion.js`, 36 checks, all pass):
- `motion.js` against the plugin's OWN headers: `motion_ref.cpp` compiles `MotionPath.h` / `PerlinNoise.h`
  and prints 324 points (6 paths x 3 seeds x 2 parameter sets x 9 cycle values). The five cyclic paths match
  to 7.7e-7 m (float32 precision); Drift matches to 2.1e-4 m, the residue being the plugin's float32 noise
  argument at cycles = 123 (the js is double).
- Each cyclic path closes after one cycle (gap 0), max |x| = size / 2, |y| <= ratio * size / 2, Drift stays
  inside size / 2; rate 0.1 -> 2 Hz mid-cycle moves the point by 1e-14 m and the next tick advances at the
  new rate; Drift is identical per seed and differs across seeds; on / off / re-on behaviour as above.
- `dbap.js`: `motion 0 0 0` after a real offset is BIT-IDENTICAL to never having had motion (both gain
  lanes, fcl / fcr, depth, z-cue, pos); `motion (2.4, -1.5)` equals moving the anchor by the same metres
  (4e-16); `dz` equals the same change on srcZ including the z-cue; no `nxy` is emitted; a 30 m offset stays
  finite; NaN is ignored.
- `venue-align.js`: default venue -> eight `setvalue N 0`; sample counts at 48 / 96 / 192 kHz; the 50 ms rail;
  a venue without `delayMs` keys -> all 0.

Deviations from the brief, all deliberate:
- `finalize_patch(is_new=False)` was NOT run on the source or host. Its midpoint generator produced a
  pathological route for a long new cord (about 150 bends) and would have re-routed every cord the user
  arranged in MAX. Existing cords keep their midpoints; new cords are straight, plus three hand-routed ones
  in the host. The critic's only new findings are cosmetic "Missing midpoints" warnings on those cords.
  The new motion patch did get `finalize_patch(is_new=False)` (its layout is a simple top-down grid).
- The scene tap is a second outlet on `p scenespack`, not a top-level `trigger`: there is no room between
  the subpatcher and `pattrstorage` without moving the user's boxes.
- The trace is only sent while motion is on (the brief did not say); off means no path on the plan.
- Motion has six dials + a seed number box (the brief said "seven dials / number for seed").

Validator / critic: no errors. New warnings are the two scene `pack` hot/cold warnings in the motion patch
(same by-design pattern as the source) and the cosmetic midpoint warnings above. Pre-existing warnings
unchanged.

Verify in MAX (v0.5.0 not yet load-tested):
1. Host opens with no console errors; source A / B look and sound exactly as v0.4 with motion off; the
   bpatchers show 3 inlets / 2 outlets; the motion module renders under source A.
2. `mc.delay~ 9600 @chans 8` instantiates with 8 channels and passes the sources and the ping unchanged
   with the default venue (status reads `align off`).
3. `setvalue N <samples>` in the RIGHT inlet of `mc.delay~` sets one channel's delay: load a venue json with
   a `delayMs` on one speaker and check that speaker is late, the others not, status `align on`.
4. `read` opens a dialog; after loading a json from `venue_to_json.py` both plans redraw with the new
   geometry and the console shows `venue loaded from dict`. Cancelling the dialog changes nothing.
5. The second `dict venue` box shares data with the embedded one (item 4 proves it).
6. Motion: toggle on -> the puck orbits the anchor on the plan of A, the trace is drawn, levels move around
   the rig without zipper; off -> puck returns to the anchor, trace clears, output equals v0.4.
7. Each path looks right: orbit / figure-8 / sweep / drift (tail, no trace) / pendulum / spiral. Ratio
   flattens, angle rotates, size scales in metres, phase shifts, height changes level via the z-cue.
8. Sweeping the rate dial while running never makes the puck jump. The rate dial shows Hz and has useful
   travel below 1 Hz (`parameter_exponent`).
9. Dragging the anchor while motion runs moves the whole path; `pattr srcpos` still recalls the anchor.
10. Scenes: store slot 1 on A with motion on, change path / size and move the anchor, recall slot 1 on A ->
    anchor AND motion settings come back (scene cord). The motion module's own store / recall also work.
11. CPU / UI: two sources with one motion module at 60 Hz stay smooth (plan redraw is capped at ~33 fps).
12. Closing the patch or deleting the motion module leaves no running Task (no console errors).

## Decision + build v0.5.1 (2026-09-19): spiral is a real spiral

| # | Decision | Rationale |
|---|----------|-----------|
| D25 | The `spiral` path DEVIATES from the plugin: the angle makes 6 turns per cycle (`K_SPIRAL_TURNS`, hard-coded) with continuous rotation, 3 turns winding out and 3 winding back in; the inward arm mirrors the outward arm. Radius law (`fold(u + phase / 360)`), phase, rotation, ratio and z are unchanged. Its trace is 120 points (20 per turn, 241 atoms); every other path keeps 32. | User report from MAX: the plugin's equation (ONE turn per cycle while the radius folds out and back) draws a single heart-shaped lobe, r = theta / pi, not a spiral. User chose continuous rotation over retracing one arm, which would reverse direction abruptly at full radius. No dial: the 360x150 face is full. This is the first deliberate break of the D10 verbatim principle; the other five paths still match `MotionPath.h`. |

Build: `generated/motion.js` only (no patch changed). Pre-flight now 42 checks, all pass: the plugin
cross-check covers the five verbatim paths (270 points); the spiral is checked on its own for 6.0 turns of
winding, a strictly positive angular step (no reversal), a monotonic radius 0 -> size / 2 over the first
half cycle, mirror symmetry of the two arms, closure, and the 120-point trace.

Note for use: at a given rate the spiral turns 6x faster than the orbit (one turn every 1.67 s at the
default 0.1 Hz; about 11 m/s at the rim of a 6 m spiral), so it wants a lower rate than the other paths.

Verify in MAX: spiral draws three visible turns each way on the plan with a smooth trace, the puck never
reverses direction, and switching between spiral and another path swaps the trace without console errors
(the 241-atom `trace` message passes through the bpatcher cord into `dbap.js`).

## User feedback (2026-09-20, v0.5.1 in MAX)

User: "it works well" after the v0.5.1 spiral fix, having run the motion module in the host (the spiral
report itself came from watching the plan in MAX). Taken as confirmed: host loads, motion module patched
to source A runs, paths and trace draw, `venue-align.js` reads the shared dict at load (the MAX-saved host
carries the venue name in the align status comment). NOT individually confirmed, still open from the
v0.5.0 list: item 3 (a non-zero `delayMs` audibly delays one speaker via `setvalue` in the `mc.delay~`
right inlet), item 4 (`read` of a converted venue json redraws both plans), item 10 (scene cord recall
restores motion), item 12 (no Task left running after close). Ask before writing these into the
proven-forms memory.

## Decisions (2026-09-20, v0.6 scoping: gesture recorder)

New feature with no plugin counterpart (nothing to port; D10 does not apply).

| # | Decision | Rationale |
|---|----------|-----------|
| D26 | The recorder lives IN the `dbap-motion` bpatcher as a seventh path, `recorded` (path index 6). `rec` toggle, stored gesture and playback clock are all in the motion module; an unpatched source gains nothing and costs nothing. Rate, size, ratio, angle, phase and height apply to the recorded path like any other. | User confirmed ("it would be part of the motion bpatcher, yes?"). Keeps D21's split: the source stays 660x500. |
| D27 | No new inlets, outlets or host cords. Position OUT of the source rides the existing scene outlet (source outlet 2 -> motion inlet) as `anchorm x_m y_m`, emitted by `dbap.js` from the mouse handler only. Anchor INTO the source rides the existing motion cord as `setanchor x_m y_m`. A `recstate 0/1` message on the same cord lets the plan show "REC". | The mouse lives on the source's lcd and the motion module cannot see it. Both cords already exist in the host. |
| D28 | Gesture format: resampled on stop to 120 points, uniform in time, stored as offsets from the gesture's own centroid and NORMALISED so the largest radius is 1. On stop the module sets its own dials for 1:1 playback (size = 2 x largest radius, rate = 0.9 / duration, ratio 1, angle 0, phase 0), sets path = recorded, sends `setanchor` with the centroid, and switches motion on. Height is untouched (the mouse is 2D; z stays `height sin t`). | 120 points x 2 floats + selector = 241 atoms, the same sub-256-atom size already proven for the spiral trace, so the gesture IS the trace. Centroid-relative means rotate / scale act about the gesture's centre and dragging the anchor moves the whole gesture. |
| D29 | End of gesture: GLIDE BACK. The first 90% of each cycle plays the gesture at recorded speed; the last 10% eases (raised cosine) from the last point to the first. One loop mode, no menu, face stays 360x150. ASSUMED from the recommendation: the user was offered glide / palindrome / one-shot / menu twice and asked for the plan without choosing. Confirm at build time; palindrome is a two-line change in `evaluate()`. | Never jumps, always moves forward, needs no extra control. |
| D30 | Scene storage: a `pattr gesture` in the motion module holds the 240-float list, same echo pattern as `pattr srcpos` (js emits only on record stop; the `gesture` handler never re-emits). Each scene slot carries its own gesture. `rec` has no varname (not scene-stored). | Proven pattern (memory: mc-lcd-bpatcher-proven-forms). |

Recording rules: `rec 1` arms; if motion is on it is switched off first (so the hand is what is heard)
and `recstate 1` is sent. The clock starts at the FIRST `anchorm` and the gesture ends at the LAST
`anchorm` before `rec 0` (pauses mid-gesture are kept; the tail while the user reaches for the toggle
is not). Auto-stop at 100 s (rate floor 0.01 Hz x 0.9). Fewer than 2 points, duration under 0.1 s, or a
largest radius under 0.05 m: discard, post one console line, restore the previous on / path state.

## v0.6 build brief (for /max-build in a fresh context)

Start from the v0.5.1 files in `generated/`. `dbap-motion.maxpat` and `dbap-source.maxpat` have NOT been
re-saved from MAX since the v0.5.0 build; the host HAS (commit 59e5998). The host needs NO change in
v0.6 (D27). Edit via `read_patch` -> edit -> `populate_assistance_comments()` -> `save_patch_roundtrip`.
Do NOT call `finalize_patch` or `_generate_midpoints` on the source (see "Build v0.5.0" deviations and
memory `no-global-autolayout-on-large-patches`); new cords straight or hand-routed. Keep every varname,
the 660x500 source and the 360x150 motion face. Read `generated/motion.js`, `generated/dbap.js` and
`test-results/preflight_motion.js` first; the node harness (vm context with stub `outlet` / `Task` /
`Dict`, overridable `nowMs`) is reused.

Deliverables:
1. `generated/motion.js`:
   - `outlets = 2`. Outlet 0 unchanged (to the source) plus `setanchor x y` and `recstate 0/1`. NEW
     outlet 1 = UI feedback: `on i`, `path i`, `rate f`, `size f`, `ratio f`, `angle f`, `phase f`,
     `gesture f x 240`. The js never changes its own parameter state on record stop: it drives the UI
     and the UI drives the js through the existing `prepend` boxes (one source of truth, scenes stay
     consistent).
   - `K_NUM_PATHS = 7`, `PATH_RECORDED = 6`, `isCyclic(6)` true. State: `recArmed`, `recPts` (t, x, y),
     `recT0`, `gesture` (240 floats or empty), `prevOn`, `prevPath`.
   - Handlers: `rec v`, `anchorm x y` (ignored unless armed; first call starts the clock; 100 s
     auto-stop calls the same stop routine and emits nothing further until `rec 0`), `gesture ...`
     (pattr echo / scene recall: validate 240 finite numbers else clear; never re-emits; if on and
     path is recorded, `emitTrace()`).
   - Stop routine: resample `recPts` to 120 points uniform in time by linear interpolation, centroid,
     subtract, largest radius `rmax`, normalise. Emit on outlet 1 in this order: `gesture`, `ratio 1.`,
     `angle 0.`, `phase 0.`, `size 2 * rmax`, `rate 0.9 / duration`, `path 6`; then outlet 0
     `recstate 0`, `setanchor cx cy`; then outlet 1 `on 1`. Discard path per "Recording rules".
   - `evaluate()` path 6 (D29): `uu = frac(u + phase / 360)`; `uu < 0.9`: position = gesture at
     `uu / 0.9 * 119` with linear interpolation; else `k = (uu - 0.9) / 0.1`,
     `w = 0.5 - 0.5 cos(pi k)`, position = last + w (first - last). `x = R gx`, `y = R ratio gy`,
     `z = height sin t`, then the common rotation. Empty gesture: 0 0 0 and a bare `trace`.
   - Trace for path 6: 120 points of `evaluate(k / 120)` (includes the glide segment).
2. `generated/dbap-motion.maxpat` (ids from the v0.5.0 build: js `obj-25`, inlet `obj-30`, pattrstorage
   `obj-41`, path umenu `obj-7`, init trigger `obj-45`):
   - `obj-25` numoutlets 1 -> 2 (new box in a saved file: it is round-tripped now, so set the model
     field `numoutlets` and `outlettype`, which ARE overlaid; verify on disk).
   - umenu `obj-7`: append `",", "recorded"` to `box._raw["items"]` (round-tripped box: `extra_attrs`
     is dropped at serialize, CLAUDE.md Rule #5 note).
   - Inlet split: remove `obj-30 -> obj-41`; add `route anchorm` (2 outlets): outlet 0 ->
     `prepend anchorm` -> js, outlet 1 (unmatched: `store N` / `recall N`) -> `obj-41`.
   - js outlet 1 -> `route on path rate size ratio angle phase gesture` (9 outlets) -> the `on` toggle
     `obj-4`, umenu `obj-7`, dials `obj-9 / 11 / 13 / 15 / 19`, and `pattr gesture`. `pattr gesture`
     (varname `gesture`) outlet 0 -> `prepend gesture` -> js. Check in the pattr maxref that a
     240-float list is stored and recalled whole; if not, fall back to two pattrs of 120.
   - `rec` toggle (no varname) -> `prepend rec` -> js. Presentation: toggle `[196, 92, 20, 20]`, label
     "rec" `[218, 93, 30, 19]` (row 2, above the "drift only" label at y 114; nothing else moves).
     `checkedcolor` red `[0.9, 0.2, 0.2, 1]` (toggle attribute, in the DB). Loadbang init `0` to it:
     grow the init trigger `obj-45` by one outlet with `modify_box(args=['b'] * 12)` (keeps existing
     connections, proven in v0.4.0) and add the message box in the same row.
   - Rule #9: `rec` and its label are in presentation. Contrast: grey label on the 0.19 panel as the
     rest; do not run `repair_text_contrast` blindly (it greys the orange headers).
3. `generated/dbap.js`:
   - `mouse()`: after the existing `nxy` emit, `outlet(2, "anchorm", xm, ym)` (anchor metres, no
     motion offset).
   - `setanchor xm ym`: metres -> norm against the bounding box, `clamp01`, set `srcNX / srcNY`,
     `solveAndDraw()`, then emit `nxy` so `pattr srcpos` stores it (the echo returns as `srcxy`, a
     no-op when unchanged: no loop).
   - `recstate v`: flag; `draw()` writes "REC" in red at the plan's top-right while set.
4. `generated/dbap-source.maxpat`: `route pos nxy` (`obj-68`, outlets 0 and 1 used, outlet 2 unused)
   -> `modify_box(args=["pos", "nxy", "anchorm"])`; new outlet 2 -> `prepend anchorm` -> the scene
   outlet box `obj-189` (it already receives `p scenespack` outlet 1; two cords into one outlet are
   fine). Place `prepend anchorm` near `obj-68` (860, 540) and hand-route or leave straight. Cleanup
   while there: the v0.5.0 `inlet` `obj-186` and `outlet` `obj-189` were written with DB I/O counts
   (1/1 and 2/0); set them to MAX's 0/1 and 1/0.
5. Pre-flight, extend `test-results/preflight_motion.js`: a synthetic gesture (e.g. an L-shape with a
   mid pause, 3 s) through `rec 1` / `anchorm` / `rec 0` with the fake clock gives 240 floats, centroid
   at 0 within 1e-9, largest radius exactly 1; emitted order and values (`size` = 2 rmax, `rate` =
   0.9 / duration, `setanchor` = centroid, `on 1` last); playback at the emitted rate and size
   reproduces the recorded positions within 1 cm at the recorded times over the first 90%; the glide
   is continuous at both joins (step under one tick of travel) and closes the loop; `gesture` echo
   does not re-emit; a scene-style `gesture` + `path 6` + `on 1` plays without a recording; discard
   cases restore the previous state; `anchorm` while unarmed does nothing; 100 s auto-stop. `dbap.js`:
   `setanchor` round-trips metres -> norm -> metres within 1e-9, emits exactly one `nxy`, and the
   echoed `srcxy` does not emit again; `mouse` emits `anchorm`; all v0.5 checks still pass
   (42 today).
6. Bump to 0.6.0, build notes in this file, commit (js + patches + tests + context + status +
   versions), verify list for MAX: arm, draw, stop -> playback sits where drawn at the drawn speed;
   glide back is smooth; rate / size / angle / phase transform the gesture; dragging the anchor moves
   it; REC shows on the plan; store / recall per slot restores different gestures; a recall on source A
   restores gesture + anchor through the scene cord; recording with motion already on; discard cases;
   no console errors from `anchorm` reaching the motion inlet when no recording is armed.

Open point to confirm before building: D29 (glide back assumed).

## Build v0.6.0 (2026-09-20)

Files: `generated/motion.js`, `generated/dbap-motion.maxpat` (56 -> 67 boxes, 50 -> 68 lines, face still
360x150), `generated/dbap.js`, `generated/dbap-source.maxpat` (147 -> 148 boxes, 117 -> 119 lines, still
660x500, all 14 varnames kept, 67 presentation boxes unchanged), `test-results/preflight_motion.js`. The host
is untouched (D27). D29 was built as assumed (glide back); nobody confirmed it, see "Open" below.

`motion.js`:
- `outlets = 2`, `K_NUM_PATHS = 7`, `PATH_RECORDED = 6`. Handlers `rec`, `anchorm`, `gesture`. The state
  array is `gestPts`, NOT `gesture` as the brief said: a global named `gesture` would shadow the `gesture`
  message handler.
- Stop routine and emit order exactly as the brief: outlet 1 `gesture` (240 floats), `ratio 1`, `angle 0`,
  `phase 0`, `size 2 rmax`, `rate 0.9 / duration`, `path 6`; outlet 0 `recstate 0`, `setanchor cx cy`;
  outlet 1 `on 1`. The js sets NOTHING itself: the gesture comes back through `pattr gesture`, the rest
  through the toggle / umenu / dials and their `prepend` boxes.
- `evaluate()` path 6 and the 120-point trace per the brief. No gesture: `0 0 0` and a bare `trace`. A
  `gesture` that arrives while on + path 6 re-sends the trace, so the recall order does not matter.
- Discard (under 2 points, under 0.1 s, largest radius under 0.05 m): one console line, `recstate 0`, then
  `path prevPath` and `on prevOn` on outlet 1.

Deviations from the brief, all deliberate:
- AUTO-STOP AT 90 s, NOT 100 s. The brief's "100 s (rate floor 0.01 Hz x 0.9)" is inverted: the longest gesture
  the 0.01 Hz floor plays 1:1 is 0.9 / 0.01 = 90 s. At 100 s the rate would clamp and play 11 % fast.
- HOLDS. The lcd only reports while the mouse moves, so plain linear interpolation would turn a pause into
  a slow drift towards the next point. A gap over 0.1 s between reports inserts a hold point (previous
  position, 16 ms before the next report). This is what makes "pauses mid-gesture are kept" true.
- The 1 cm criterion holds AWAY from stops / starts (measured 0.000 mm on the straight runs). At a velocity
  kink, 120 points cut the corner in TIME by at most v dt / 4 (test gesture: 11 mm at 1.5 m/s, a 9 ms
  slip), always along the drawn line, never off it. Inherent to D28's 120 points; not audible.
- Patching layout of the motion module: the feedback `route on path rate size ratio angle phase gesture`
  sits in the free row ABOVE the controls (y 150, 9 outlets 125 px apart) so its cords run down into them;
  one cord climbs from js outlet 1 along x 20. The `MOTION` / `#1` header comments moved up to y 22 in
  PATCHING view to clear that row (presentation rects untouched). `rec` lives in its own REC column at
  x 1540 (toggle, label, `prepend rec`, init `0`); the init trigger grew to 12 outlets and 1483 px so the 11
  old outlets stay where their cords start. `route anchorm` sits at x 1176 (not under the inlet) to clear
  `pack recall`. `pattr gesture` (varname `gesture`) at (996, 242), `prepend gesture` / `prepend anchorm`
  in a new row at y 300; the three new cords into the js run as buses at y 318 / 323 / 326.
- Source: `route pos nxy anchorm` widened to 151 px so `pos` / `nxy` keep their outlet positions.
  `prepend anchorm` at (1040, 570), NOT the brief's (860, 540), which is where `obj-68` itself sits. Its
  cord to the scene outlet is hand-routed: along y 598, up x 1832 (between `autopattr` and the outlet;
  checked clear of every non-panel box). `obj-186` / `obj-189` I/O counts fixed to 0/1 and 1/0 and their
  assistance text updated. `populate_assistance_comments()` was not run on the source (nothing new to label).
- `dbap.js` REC mark: a red dot + "REC" (Arial 10, 230 51 51) at the plan's top right, y 3..11, above the
  speaker-2 meter which starts at y 12.

Research: the `prepend` maxref caps a constructed message at 256 items; `gesture` + 240 floats is 241, the
same size as the proven spiral trace. The `pattr` maxref documents no list limit (its 256 is the `initial`
attribute, unused). Two pattrs of 120 remain the fallback if MAX truncates.

Pre-flight (`node patches/barnett-dbap/test-results/preflight_motion.js`): 77 checks, all pass (42 before).
New: unarmed `anchorm` ignored; `rec 1` with motion on switches off through the UI; 240 finite floats,
centroid 0 (1e-9), largest radius exactly 1; emit order; `rate = 0.9 / duration` with the tail after the last
report dropped; state returns through the UI loop; 120-point trace; playback accuracy (above); the corner
pause is a hold; glide continuous at both joins, closes, raised-cosine midpoint; size / angle / phase act
about the centroid; `gesture` echo emits nothing on outlet 1; scene-style `path 6` + `on 1` + `gesture` in
any order; invalid / NaN gesture clears; four discard cases; 90 s auto-stop and a silent `rec 0` after it.
`dbap.js`: `mouse` emits `nxy` then `anchorm` (anchor, never the motion offset); `setanchor` round-trips to
1e-9, emits one `nxy`, solves exactly like `srcxy`, the echo emits nothing, clamps, ignores NaN; `recstate`
draws / removes REC and leaves the gains bit-identical.

Validator / critic: no errors, no new warnings of substance. Motion: the two pre-existing scene `pack`
hot/cold warnings plus cosmetic "Missing midpoints" on short new cords. Source: one cosmetic midpoint
warning on the existing `p scenespack` -> outlet cord.

Open:
- D29 (glide back) is still the ASSUMED loop mode. Note the glide takes 10 % of the cycle whatever the
  distance: an open gesture whose ends are far apart snaps back fast (the 4.5 s test L: 3.5 m in 0.5 s, peak
  11 m/s). Ending a gesture near its start makes the glide negligible. Palindrome is a two-line change.
- After an auto-stop the `rec` toggle stays red until clicked off (that click is silent). A `rec` entry on
  the feedback route would clear it; not in the brief, not built.

Verify in MAX (v0.6.0 not yet load-tested):
1. Host opens with no console errors; the motion module shows `rec` (red when on) at row 2, `recorded` is the
   seventh path menu entry; everything else looks and behaves as v0.5.1.
2. Arm `rec`, drag the puck on source A's plan, un-arm: REC shows top right on the plan while armed; on stop
   the dials jump (size, rate, ratio 1, angle 0, phase 0), path reads `recorded`, `on` lights, the anchor ring
   moves to the gesture's centre and the puck retraces the drawing where and as fast as it was drawn.
3. A pause while drawing plays back as a pause.
4. The glide back to the start is smooth, with no jump at either join (D29: say if palindrome is preferred).
5. Rate / size / ratio / angle / phase transform the gesture about its centre; dragging the anchor moves it.
6. Scenes: record gesture 1, store slot 1; record gesture 2, store slot 2; recall 1 / 2 on the motion module
   restores each gesture (the 240-float `pattr gesture` stores and recalls whole). Recall on source A
   restores gesture + anchor through the scene cord.
7. Arming while motion is already on: motion stops first, the hand is heard, playback starts on stop.
8. Discards: a click without a drag, or `rec` on / off with no mouse, posts one console line and restores the
   previous path / on state.
9. Dragging the puck with `rec` off causes no console errors (the `anchorm` reaching the motion inlet is
   ignored); source B (no motion module) is unaffected.
10. The three still-open v0.5.0 items: 3 (`delayMs`), 4 (venue `read`), 12 (no Task left after close).

## User feedback (2026-09-20, v0.6.0 in MAX)

User: "it works well" after running the v0.6.0 gesture recorder in the host. Taken as confirmed: host and
motion module load, `rec` arms, a drawn gesture plays back as the `recorded` path, the dials / anchor are set
on stop, the 241-atom `gesture` message passes `route` -> `pattr gesture` -> `prepend gesture` -> js. NOT
individually confirmed: per-slot gesture store / recall (item 6), discard cases (item 8), D29 glide-back as
the preferred loop mode (no objection raised), and the three v0.5.0 leftovers (item 10). Ask before writing
these into the proven-forms memory.

## Decisions (2026-09-20, v0.7: wander, loop modes, cue)

User request after v0.6.0: "add drift on top of a whole gesture as well as the loop and cues one-shots".
Built without a discuss round; D31-D34 are the builder's choices, review them in MAX.

| # | Decision | Rationale |
|---|----------|-----------|
| D31 | A `loop` menu (`loop`, `palindrome`, `one-shot`; varname `loop`, scene-stored) applies to EVERY cyclic path; Drift ignores it. `loop` is v0.6 behaviour (recorded: gesture + glide back, D29 stays the default). Palindrome folds the path clock; the recorded path folds at the END OF THE GESTURE (0.9 cycle) and never glides. | Palindrome / one-shot were the D29 alternatives the user now asked for. The gesture takes 0.9 cycle in every mode, so the rate set on record stop plays 1:1 whatever the menu says and changing the menu never changes the speed. |
| D32 | One-shot ARMS: `on 1`, selecting one-shot, a new path or a NEW gesture park the puck at the path's start; `cue` plays once; it then holds at the end (recorded: the last drawn point; closed paths: back at their start). A re-sent identical `loop` / `path` / `gesture` (scene recall) does not re-arm a running shot. After a recording in one-shot mode the module is on and armed. | Cue-driven pieces: recall a scene, the source waits where the gesture begins, fire it on the cue. |
| D33 | `cue` = a button on the face, or a `cue` message into the module's existing inlet (`route anchorm` -> `route cue`; store / recall still pass). In the looping modes `cue` restarts the path from its start. `cue` while off switches the module on (through the UI) and fires. No host wiring was added: patch any bang -> `cue` message into the motion bpatcher's inlet. | No new inlet (D27 principle). |
| D34 | `wander` dial, metres of EXTENT 0..12 (varname `wander`, scene-stored, default 0): `dx += wander / 2 * fbm(cycles + 3000)`, `dy += wander / 2 * fbm(cycles + 4000)`, added in `tick()` after rotation, z untouched. Same seed and clock as Drift, so the rate dial sets its speed; the seed label now reads "drift + wander". It runs on the UNFOLDED clock: it keeps moving while a one-shot waits or holds. The trace shows the clean path. fbm rarely passes +-0.4, so the puck strays about 0.2 x wander. | "Drift on top of a gesture". Keeping it out of `evaluate()` leaves the plugin cross-check untouched; wander 0 is bit-identical to v0.6. |

## Build v0.7.0 (2026-09-20)

Files: `generated/motion.js`, `generated/dbap.js` (`traceopen` only), `generated/dbap-motion.maxpat` (67 -> 81
boxes, 68 -> 80 lines), `generated/barnett-dbap.maxpat` (host), `test-results/preflight_motion.js`. The source
patch is unchanged.

- THE MOTION FACE IS NOW 460x150 (was 360x150): a new right-hand column at x 366 holds the `loop` menu
  (row 0, beside the path menu), the `wander` dial (row 1) and the `cue` button + label (row 2). Nothing else
  moved. The host bpatcher is 460 wide and its two captions moved 100 px right, in both views. The host's
  only semantic changes are those six rect values (checked against the MAX-saved commit 59e5998); the large
  text diff is the round-trip writer's whitespace.
- `motion.js`: `warp()` / `position()` / `pathClock()`; the path clock is `cycles - cueC0`, so rate changes
  stay jump-free in every mode. `evaluate(cycles, uuRec)` gained an optional second argument and is
  otherwise untouched. In palindrome / one-shot the recorded path's `phase` is a start offset INSIDE the
  gesture, and z follows the folded / held clock. Recorded + palindrome / one-shot sends `traceopen`
  (gesture only, 120 points); `dbap.js` draws it without the closing segment.
- Patching view: WANDER / LOOP / CUE columns at x 1630 / 1763 / 1890 (right of REC); the init trigger grew to
  14 outlets (1749 px, old outlets unmoved); `route cue` at (1190, 300) between `route anchorm` and the
  pattrstorage; buses into the js at y 306 / 310 / 314. `route anchorm` widened 86 -> 93 px (v0.6 wrote it too
  narrow for its text).

Pre-flight: 101 checks, all pass (77 before). New: loop 0 + wander 0 bit-identical to v0.6; one-shot arms,
plays at the drawn speed on cue (12 mm, the same stop / start slip as v0.6), holds at the last point, re-cues,
is not re-armed by a re-sent scene value, IS re-armed by a new gesture, no jump on a rate change mid-shot;
cue while off; palindrome forward / backward symmetry, period 2 x duration, max step one tick (no glide),
z folds, phase offset; one-shot and palindrome orbit; Drift ignores loop and cue; wander bounded,
deterministic per seed, non-repeating, 0 = bit-identical, alive while armed, trace clean; `traceopen`.

Validator / critic: no errors, no new warnings beyond cosmetic "Missing midpoints".

Verify in MAX (v0.7.0 not yet load-tested):
1. Host opens with no console errors; the motion module is 460 wide with loop menu / wander dial / cue button
   in a new right-hand column; captions sit clear of it; everything else as v0.6.
2. `wander` up on an orbit and on a recorded gesture: the puck strays smoothly around the trace, the trace
   itself stays clean; rate changes the wander speed, seed changes its shape; 0 = exactly the old path.
3. `palindrome` on a recorded gesture: forward then backward at the drawn speed, no glide, open trace.
4. `one-shot`: the puck parks at the gesture's start; `cue` plays it once and it stays at the end; `cue`
   again replays. With wander up it keeps breathing while parked.
5. `cue` in `loop` / `palindrome` restarts from the start; `cue` with the module off switches it on.
6. A `cue` message patched into the motion bpatcher's inlet fires it; scene store / recall and `anchorm`
   still work through the same inlet.
7. Scenes store and recall `loop` and `wander`; slots stored before v0.7 leave them as they are.
8. Record a gesture while the menu is on one-shot: after stop the module is on and parked, waiting for a cue.

## Decision + build v0.7.1 (2026-09-20): parameter values into both bpatchers

| # | Decision | Rationale |
|---|----------|-----------|
| D35 | Both modules take `<control name> <value>` on an EXISTING inlet, delivered to the module's `pattrstorage` (maxref "Direct pattr access": a message whose first word is a client name sets that client; anything else is ignored). The control itself moves and drives the js through its `prepend`, so the UI stays the one source of truth and scenes store what was sent. No new inlets, no host change. | User asked for a way to receive parameter values inside the two bpatchers; chose the recommended route over host-side `pattrforward`. |

- Motion module: nothing to build, the inlet already ends at the pattrstorage (after `route anchorm` /
  `route cue`). Names: `on path rate size ratio angle height phase seed wander loop` (+ `cue`, `store N`,
  `recall N`). Only the inlet's assistance text changed.
- Source: NEW `p ctlsplit` at (850, 475) between the third inlet and `js dbap.js`. Inside:
  `routepass motion trace traceopen setanchor recstate` (DB: Max, min_version 8; it keeps the selector, so
  the js sees the messages exactly as before) -> outlet 0 -> js; unmatched -> outlet 1 -> `pattrstorage #1`
  (`obj-103`), cord hand-routed along y 504 and up x 1518 (checked clear of every non-panel box). Names:
  `rolloff blur srcz width decorr air hull master weights trims` (lists for the last two). Position:
  `setanchor x_m y_m` (metres, already there) or `patcher::srcpos nx ny` (normalised, the pattr's path).
  149 boxes, 121 lines, 14 varnames kept, face unchanged. Label reads "motion + control in".
- Caveats: the words pattrstorage itself understands (`store`, `recall`, `clear`, `read`, `write`,
  `delete`, ...) act on the scenes, so keep external senders to the control names. Messages that used to
  reach the js through the third inlet but are not in the routepass list (none are sent by anything today;
  `venue` arrives by `r dbap-venue`) now go to the pattrstorage instead.
- Pre-flight unchanged (101 checks pass; no js changed). Validator / critic: no errors, no new warnings.

Verify in MAX (v0.7.1 not yet load-tested):
1. Motion still drives source A exactly as before (puck, closed and open traces, REC mark, setanchor on
   record stop): the routepass is transparent, including the 241-atom `trace`.
2. A message box `width 3.` (or `air 0.8`, `master -12`) into source A's THIRD inlet moves that dial and
   changes the sound; storing a scene afterwards stores the new value.
3. `rate 0.5`, `size 4.`, `loop 2`, `wander 1.5`, `on 1` into the motion module's inlet move its controls.
4. An unknown word into either inlet does nothing and posts no error.

## User edit in MAX (2026-09-20, after the v0.7.0 build)

The host was re-saved from MAX at 10:06 with v0.7.0 loaded (its `parameters` block now lists the motion
module's `wander` dial, so the 460-wide module instantiated). User layout changes, keep them: source A
bpatcher presentation 609 wide (patching 599), source B at presentation x 635, 612 wide (patching 605x506),
bottom panel 1206 wide, one cord midpoint moved. Same 49 boxes and 31 lines. The source abstraction's own
face is still 660x500; the host simply crops it.

## Build v0.7.2 (2026-09-20): `control-demo.maxpat`

User: "make a new patch that is designed to show how this works" (the D35 control messages). NEW
`generated/control-demo.maxpat` (64 boxes, 37 lines), built with the Patcher API, hand-placed (no
`apply_layout`: the geometry IS the explanation). It opens in PATCHING view, locked, because the cords are
the point; it has no presentation layout (Rule #9 not applicable). Nothing else changed.

- One `dbap-motion` (`@args Dm`) above one `dbap-source` (`@args D 1`), wired as in the host: motion outlet
  -> source third inlet; source right outlet -> motion inlet (looped up the left edge at x 12). Instance names
  `D` / `Dm` keep its scene storages apart from the host's `A` / `B` / `Am` if both are open.
- Block 1, motion: 12 message boxes (`on`, `cue`, `path`, `rate`, `size`, `wander`, `loop`) -> `t l` -> the
  motion inlet. Block 2, source: `width`, `air`, `rolloff`, `master`, `srcz`, `weights` / `trims` lists,
  `setanchor`; plus live values: `slider` (float 0..1) -> `prepend air`, `flonum` 0..12 -> `prepend width`,
  `ctlin 1` -> `scale 0 127 0. 1.` -> `prepend decorr`; all -> `t l` -> the source's third inlet. Each column's
  cords share one gutter (hand midpoints), so the fan-in reads as a bus.
- A HOW IT WORKS panel beside the source lists every name with its range, the two inter-module cords, and the
  pattrstorage-word caveat. Output: source -> `mc.dac~ 1..8` with a DSP toggle; no alignment delay stage. A
  copy of the host's embedded `dict venue` keeps the console clean when the demo is opened alone.
- Validator: clean. Critic: the known toggle -> `mc.dac~` warning (the host's proven form) and cosmetic
  midpoint notes. No overlaps with message boxes measured at their rendered width (len x 8 + 25).

Verify in MAX (not yet load-tested; this is also the first MAX test of D35):
1. Opens with both modules showing and no console errors (`dbap.js: venue loaded from dict`).
2. Source block: each message moves the matching dial / multislider / puck; the slider, number box and a
   MIDI CC 1 move air / width / decorr continuously.
3. Motion block: `on 1` starts motion, `path` / `rate` / `size` / `wander` / `loop` move their controls, `cue`
   fires (`t l` must pass the bare word `cue`; if it does not, swap that `t l` for direct cords).
4. With `on 1`, the source still follows the motion module (the `routepass` in `p ctlsplit` is transparent),
   and a scene recall on the source still restores the motion module through the left-edge cord.
