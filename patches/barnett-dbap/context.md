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
