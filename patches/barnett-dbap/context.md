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
