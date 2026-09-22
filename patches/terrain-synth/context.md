# terrain-synth

Wave-terrain / geometry-derived wavetable synthesizer for MAX 9. Two oscillator engines
(baked wavetable + live terrain scan) behind one MIDI/poly~ front end, with a Jitter view of the
terrain and orbit.

## Source material

- Research doc: `/Users/taylorbrook/Dev/VST-development/research/wavetable-synthesis-3d-geometry.md`
- Prototypes: `/Users/taylorbrook/Dev/VST-development/research/wavetable-synthesis-3d-geometry-prototypes/`
  - `mesh-slice/mesh_slice_wavetable.py` (numpy: procedural meshes, OBJ loader, plane slicing -> loops,
    radial + arc-length unwrap, xcorr alignment, DC removal/normalisation, torus-SDF + 3D noise volume
    sampled along a torus-knot orbit, Serum-style WAV export)
  - `terrain-bench/` (C++ cost + aliasing numbers), `webgl-3d/` (WebGL view prototype, not needed in Max)
- Existing Max precedent in this repo: `patches/ji-harmonizer` -- mc.gen~ codebox wavetable oscillator
  reading one mono buffer~ per bank, layout `idx = mip*(256*2048) + frame*2048 + sample`,
  11 mipmap levels, `mip = clamp(floor(log2(max(f,1)/20)), 0, 10)`, bilinear frame morph,
  bank switching via umenu -> prepend replace -> buffer~. Render tool:
  `patches/ji-harmonizer/tools/render_wavetables.py` (see its context.md "slice 2" / "slice 4").

## Research doc findings (condensed)

Three paradigms:
1. **Wave terrain (live):** y = f(x(theta), y(theta)); orbit at pitch rate over a heightmap. Not
   bandlimited; 2x oversampling is enough for almost everything (4x HQ). Terrain spatial frequency MUST
   scale down with pitch ("terrain mip"). Image terrains alias hardest (pre-blur; keep orbit inside
   [-1,1]^2; Mitsuhashi edge constraints). ADAA is NOT viable for terrains.
2. **Scanned synthesis:** mass-spring mesh evolving at 0-15 Hz, scanned at pitch rate. Clamp + leak term.
3. **Baked geometry -> wavetable (RECOMMENDED FIRST):** mesh slicing / SDF-volume orbit -> 2048-sample
   frames -> FFT-truncation mipmaps. Exact anti-aliasing, no new audio-path code.

Level-3 verified results for the bake:
- Unwrap: arc-length x(s)/y(s) works on everything (circle -> pure sine); emit
  `cos(phi)*x(s) + sin(phi)*y(s)` with projection angle phi as a timbre knob. Radial r(theta) fails on
  non-star-shaped loops. d(s) needs a flatness floor (~0.02).
- Multi-loop policy: largest-area loop with hysteresis (track loop nearest previous centroid); sum as
  option; NEVER concatenate.
- Alignment: FFT cross-correlation with polarity test, chained frame-to-frame. Fixed-ray fails on twist.
- Normalisation: per-frame DC removal; global peak across all frames (per-frame peak = garbage).
- Chebyshev terrain + circular orbit = finite harmonic sum -> exactly bandlimited (but see Max note).
- Cost: bake is trivially background-friendly; live terrain osc ~ 4x the cost of a wavetable read at 2x.

## How this maps to Max

(All objects to be verified in `.claude/max-objects` DB with non-empty I/O during research.)

| Piece | Max implementation |
|---|---|
| Baked engine | Python bake tool writes the ji-harmonizer buffer layout; existing mc.gen~ oscillator reads it. Zero new DSP. |
| Live terrain osc | `phasor~` -> gen~ orbit codebox (x,y signals) -> `jit.peek~ @interp 1` on a float32 `jit.matrix` terrain, wrapped in `poly~ @up 2` (4x HQ) -> `tanh~`. Same pattern as the tmhglnd/wave-terrain-synthesis Max package. |
| Terrain sources | `jit.bfg` (noise), `jit.gen` / `jit.expr` (analytic), `jit.movie` / importmovie (PNG), `jit.gl.model` (OBJ). |
| Scanned synthesis | `jit.gen` mass-spring step on the same named jit.matrix at frame rate; it is a terrain SOURCE, not a third engine. |
| View | `jit.world` + `jit.gl.gridshape` / `jit.gl.mesh` displaced by the terrain matrix, orbit via `jit.gl.sketch`, `jit.gl.isosurf` for SDF volumes. Replaces the doc's WebGL section. |
| Mesh slicing | No Jitter object. Stays in Python at build time (prototype already does it). |

Max-specific notes:
- Chebyshev mode collapses into the bake: Clenshaw needs nested loops, which the repo's gen~ codebox
  safe-construct rules forbid. Don't evaluate it live.
- Audio-rate-feeling terrain modulation is cheap: `jit.peek~` reads a live matrix, so animating the
  terrain with `jit.gen` costs nothing on the audio thread.
- Only unverified item: CPU of `jit.peek~` inside upsampled `poly~` per voice. Load-test one voice at 4x early.
- Gen ops verified: peek, sample, nearest, wave, lookup, wrap, fold, mix, tanh, cartopol, poltocar,
  atan2, hypot, fastsin/fastcos, pow, dcblock, sah, latch, phasor. (Buffer/Data/Param/History are
  declarations, not DB entries.)

## Project structure (decided)

One project, one main patch, engines as separate abstractions, bake is a build-time tool:

- `generated/terrain-synth.maxpat` -- MIDI/voice front end, poly~ voices, mixer, presentation UI,
  jit.world view. Only patch a user opens.
- `generated/wt-osc.maxpat` -- baked wavetable oscillator: lift of the ji-harmonizer mc.gen~ engine + bank umenu.
- `generated/terrain-osc.maxpat` -- live oscillator: orbit gen~ (ellipse / epitrochoid / squarcle via
  Param), jit.peek~ in poly~ @up 2, tanh~, pitch-scaled terrain zoom.
- `p terrain-source` (subpatch in main) -- fills the named terrain matrix (noise / expression / image /
  mass-spring step).
- `tools/bake_geometry.py` -- mesh slice + SDF orbit -> bank WAVs in the ji-harmonizer layout
  (256 x 2048 x 11 mips, float32 mono).

Why split engines: different aliasing stories and CPU; per-osc-slot engine choice; each load-testable alone.
Why one project: engines share orbit definitions, terrain matrix, view, and voice front end.
Decision taken: copy the wavetable codebox into terrain-synth rather than extracting a shared
abstraction from ji-harmonizer (no cross-project abstraction precedent in this repo).

## Build order

1. wt-osc + bake tool with one torus-SDF bank (alias-free, no new DSP, proves the bake).
2. terrain-osc standalone + the poly~ @up CPU test.
3. Main patch composes both; view last.

## Kickoff answers (2026-09-07)

- **Audio/MIDI:** MIDI in, stereo audio out.
- **Signal flow:** MIDI -> poly~ voices -> per-voice osc slots (wt-osc | terrain-osc) -> filter/env ->
  mixer -> dac~. Shared named jit.matrix terrain feeds terrain-osc and the view.
- **UI/presentation:** yes. XY pad for orbit centre, dial for orbit radius/span, orbit-shape menu,
  lobe count, rotation/phase, terrain source menu, bank umenu + position dial for wt-osc, phi knob,
  oversampling 2x/4x toggle, jit.world view of terrain + orbit.
- **Techniques:** mc.gen~ codebox wavetable read (ji-harmonizer pattern), jit.peek~ terrain scanning,
  poly~ @up oversampling, jit.bfg / jit.gen terrain generation, build-time Python bake.

## Bake tool contract (to lock in discuss)

- Same buffer layout as ji-harmonizer banks (`idx = mip*524288 + frame*2048 + sample`, 11 mips,
  mip base freqs 20*2^k, partial cut at `baseFreq*2*ratio > 0.9*24000` -> for baked frames use FFT
  truncation per level with the same base-freq table).
- Arc-length x(s) projection with phi; largest-loop hysteresis; xcorr + polarity alignment;
  per-frame DC removal; global-peak normalisation; frame axis = slice height or orbit scale/knot phase.
- Output float32 mono WAV into `generated/` next to the .maxpat (patch-folder search path).

## First build command (after kickoff/discuss/research)

`/max-build wt-osc abstraction: mc.gen~ mipmapped wavetable oscillator lifted from ji-harmonizer,
plus bank umenu, plus tools/bake_geometry.py emitting one torus-SDF bank`

## Decisions (discuss, 2026-09-07)

- **Bake tool is self-contained.** `tools/bake_geometry.py` copies the needed functions from the
  prototype (`mesh_slice_wavetable.py`) rather than importing across repos. Repo works on clone.
  The prototype remains the research reference; divergence is acceptable.
- **First bank frame axis = orbit scale.** Torus-knot orbit radius grows monotonically across the
  256 frames: frame 0 tight (near-sine), frame 255 wide (hard SDF-surface crossings). Matches the
  ji-harmonizer convention (frame 0 ~ sine -> frame 255 full character). Knot-phase and
  noise-amount axes are later banks.
- **Voice slots: A = terrain-osc, B = wt-osc, mix dial** (swapped 2026-09-08 after the sonic review: the live oscillator is the identity; baked tables are the secondary source). Fixed roles, one instance of each engine
  per poly~ voice, crossfade dial (0 = A only, 1 = B only). No per-slot engine switching, no
  duplicate engine instances. Supersedes the handoff's "per-osc-slot engine choice" wording.
- **Terrain matrix: 256x256, 1-plane float32, single named jit.matrix.** Pitch-scaled zoom is done
  by shrinking the orbit inside the orbit codebox: `radius *= clamp(k / freq, lo, 1)`. One matrix,
  cheapest. A blurred mip pyramid is a later option only if aliasing demands it.
- **Bank WAVs committed to git** (ji-harmonizer precedent, ~23 MB float32 each). Patch works on clone.
- **Bake contract locked as written in "Bake tool contract"** above: ji-harmonizer buffer layout,
  arc-length unwrap with phi, largest-loop hysteresis, xcorr + polarity alignment, per-frame DC
  removal, global-peak normalisation, float32 mono WAV in `generated/`.

## Research (2026-09-07)

### Object verification (ObjectDatabase, all non-empty I/O unless noted)

| Object | in/out | Notes |
|---|---|---|
| `phasor~` | 2/1 | signal freq in inlet 0 |
| `gen~` / `mc.gen~` | 2/1 (grows with `in N`) | codebox via `add_gen()`; mc variant = rename per CLAUDE.md |
| `poly~` | 1/1 (+ per in/out~) | args: patcher-name, instances, `up N` / `down N`, `args ...`; messages incl. `target`, `note`, `midinote`, `mute`, `steal` attr |
| `thispoly~` | 1/2 | `mute`, `busy` handling inside voice |
| `in` / `out~` | 0/1, 1/0 | DB flags these as "empty I/O" but the counts are correct for the object |
| `jit.peek~` | 2/2 (out 0 signal) | args `matrix_name dim_inputcount plane`; attrs `interp`, `normalize`, `plane`, `matrix_name` -- `@interp 1 @normalize 1` gives [0,1] signal coords |
| `jit.matrix` | 1/2 | attrs `name`, `planecount`, `type`, `dim`; msgs `exprfill`, `importmovie`, `setall`, `clear`, `read`/`write` |
| `jit.bfg` | 1/2 | attrs `basis`, `scale`, `offset`, `seed`, `rotation`, `weight`, `precision` |
| `jit.gen` / `jit.expr` | 1/2, 2/2 | analytic terrains; jit.gen for mass-spring step |
| `jit.movie`, `jit.gl.model`, `jit.gl.texture`, `jit.noise`, `jit.op` | ok | image / OBJ / util sources |
| `jit.world` | 1/3 | view host; `jit.gl.gridshape` (attrs `shape`, `dim`, `gridmode`), `jit.gl.mesh` (9 inlets), `jit.gl.sketch`, `jit.gl.isosurf`, `jit.gl.camera`, `jit.gl.light`, `jit.gl.material` all present |
| `tanh~`, `svf~` (3/4), `lores~`, `biquad~`, `onepole~`, `adsr~` (5/4), `line~`, `*~`, `+~`, `selector~`, `gate~`, `downsamp~` | ok | voice DSP |
| `notein`, `stripnote`, `poly`, `mtof`, `mtof~`, `midiparse`, `kslider`, `ftom` | ok | MIDI front end |
| `mc.noteallocator~`, `mc.voiceallocator~`, `mc.target`, `mc.pack~`/`mc.unpack~`, `mc.mixdown~`, `mc.poly~`, `mc.sig~` | ok | alternative MC voice path |
| `buffer~`, `umenu`, `prepend`, `loadbang`, `loadmess`, `attrui`, `pattrstorage`, `autopattr`, `preset`, `dict`, `deferlow`, `snapshot~`, `number~`, `scope~`, `meter~`, `gain~`, `dac~`, `pictslider` | ok | UI / storage / monitoring |

**Gaps:**
- `pan2` NOT in DB -- do constant-power pan with `*~` pairs (cos/sin from a gen~ codebox or `expr`), or skip pan.
- `dcblock~` is RNBO-domain only -- use `dcblock` inside gen~ codebox instead (it is a verified gen op).
- `jit.matrix~` and `mc.midiin~` do not exist -- not needed.
- No Jitter precedent patch exists in this repo (`jit.*` appears in no `patches/*/generated/*.maxpat`), so terrain-osc and the view are first-of-kind here; keep them in their own abstraction so they are load-testable alone.
- tmhglnd `wave-terrain-synthesis` package is NOT installed (`~/Documents/Max 9/Packages`); not required, pattern only.

### poly~ precedent (scala-synth)

`scala-synth` uses a separate `generated/scala-synth-voice.maxpat` loaded by `poly~ scala-synth-voice 16`, global params via `target 0`, voice allocation via `poly` -> `note`/`midinote` messages. terrain-synth follows the same shape: `generated/terrain-voice.maxpat` loaded by `poly~ terrain-voice 8 up 2` in the main patch, with wt-osc and terrain-osc instantiated inside the voice as abstractions (patch-folder search path).

Oversampling: `poly~ ... up 2` upsamples the whole voice (both engines + filter). The wt-osc engine is already alias-free via mipmaps, so 2x on it is wasted CPU but harmless; if CPU becomes an issue, split into two poly~ objects (wt at 1x, terrain at 2x/4x). Decide after the slice-2 load test.

### wt-osc: lift from ji-harmonizer (verified against the live codebox)

Source: `mc.gen~` codebox in `patches/ji-harmonizer/generated/ji-harmonizer.maxpat`. The relevant core (single osc, no spacing/inversion groups):

```
Buffer wt("terrainbank");          // one mono buffer~ per bank
f = max(in1, 0.);                  // Hz
ph = wrap(phb + f / samplerate, 0., 1.);  phb = ph;
lev = clamp(floor(log2(max(f, 1.) / 20.)), 0., 10.);
mb = lev * 524288.;
sp = ph * 2048.;  s0 = floor(sp);  sf = sp - s0;  s1 = wrap(s0 + 1., 0., 2048.);
fp = pos * 255.;  f0 = floor(fp);  f1 = min(f0 + 1., 255.);  ff = fp - f0;
a00 = peek(wt, mb + f0*2048. + s0, 0); a01 = peek(wt, mb + f0*2048. + s1, 0);
a10 = peek(wt, mb + f1*2048. + s0, 0); a11 = peek(wt, mb + f1*2048. + s1, 0);
out1 = mix(mix(a00, a01, sf), mix(a10, a11, sf), ff);
```

Bank switching: `umenu` (items = WAV filenames, comma-element format) -> `prepend replace` -> `buffer~ <name> <default.wav>`. Buffer name is per-instance: inside the voice abstraction use `buffer~ #1`-style standalone-token args if per-voice buffers are ever needed; for a shared bank one global `buffer~ terrainbank` in the main patch is enough (gen~ `Buffer` reads by name across patchers).

Mip truncation table (verbatim from `render_wavetables.py`): `MIPMAP_BASE_FREQS = [20, 40, 80, ..., 20480]` (20*2^k), a harmonic `h` is kept at level `k` when `base_k * 2 * h <= 0.9 * 24000`, i.e. `h_max(k) = floor(10800 / base_k)`: 540, 270, 135, 67, 33, 16, 8, 4, 2, 1, 0. Level 10 is silence (verbatim VST behaviour). For baked frames: `rfft` each 2048-sample frame once, zero bins above `h_max(k)`, `irfft` per level.

### Bake tool design (tools/bake_geometry.py, self-contained)

Copy from the prototype (`mesh_slice_wavetable.py`, 518 lines, numpy-only except scipy WAV writer):
- `torus_sdf(p, R, r)`, `torus_knot(n, p, q, R, r, phase)`, `bake_volume(field, frames, scale_range, shape="tanh")` -- the SDF-orbit path (first bank).
- `align_xcorr(prev, cur)` (FFT cross-correlation + polarity), `condition(w, mode="peak")` (DC removal + normalise; **change** to per-frame DC removal only, then a single global peak normalise across all frames per the locked contract).
- `value_noise3` / `fbm3` for the later noise-volume bank; `slice_mesh`, `orient_ccw`, `loop_area`, `resample_arclength`, `unwrap_arclength`, `bake_mesh` for later mesh banks (copy now, keep unused code paths minimal or defer to slice 4).
- Replace scipy `write_wav` with `write_float32_wav` from `render_wavetables.py` (pure struct, IEEE-float WAV with fact chunk, 48 kHz header). Keep `N = 2048`, frames = 256.
- Output: `generated/bank00-torus-sdf.wav` (11 x 256 x 2048 float32 = 5,767,168 samples, ~23 MB), committed.
- Sanity report per bank: adjacent-frame RMS diff, harmonic census at frames 0/128/255, confirm level-10 silence, peak == 1.0.

First bank parameters: torus `R=1.0, r=0.4`, knot `p=2, q=3, r=0.5`, orbit scale sweep `0.3 -> 1.6` across 256 frames (prototype default), `tanh(3*f)` shaping. Frame 0 should be near-sinusoidal; verify with the harmonic census before committing.

### terrain-osc design notes (slice 2, for later)

- Orbit codebox (gen~): `in1` = phase (from `phasor~`) or compute phase internally from Hz; Params `shape` (0 ellipse / 1 epitrochoid / 2 squarcle -- use range tests, not `==`), `rx`, `ry`, `rot`, `cx`, `cy`, `lobes`, `zoomk`. Emit `out1 = x`, `out2 = y` in [0,1] (normalized matrix coords) with `radius *= clamp(zoomk / freq, lo, 1)`. Keep the orbit inside the matrix: `clamp` x/y to [0.02, 0.98].
- `jit.peek~ terrain 2 0 @interp 1 @normalize 1` reads plane 0 with normalized coords; output -> `dcblock` in a small gen~ -> `tanh~`.
- Wrap in `poly~ terrain-osc-core 1 up 2` for the standalone CPU test; in the full synth the voice itself is the poly~ patch.
- Terrain source subpatch: `jit.bfg @basis noise.perlin @scale ...` -> `jit.matrix terrain 1 float32 256 256`; `exprfill` for analytic; `importmovie` for PNG; `jit.gen` step for mass-spring.

### View notes (slice 3, last)

`jit.world terrainview` + `jit.gl.gridshape @shape plane @dim 256 256 @gridmode 1` displaced by the terrain matrix (send the matrix to a `jit.gl.mesh` vertex matrix built with `jit.gen`/`jit.expr` from xy grid + z=terrain), orbit drawn with `jit.gl.sketch` from a sampled orbit path (`snapshot~` of x/y or recompute in `expr`). Verify `jit.gl.mesh` inlet map (9 inlets) at build time.

### Risks to retire early

1. **jit.peek~ CPU inside upsampled poly~** -- unverified; slice 2 load test (1 voice at 4x, then 8 voices at 2x) before committing to the voice architecture.
2. **Bake tool frame coherence** -- xcorr alignment must be chained frame-to-frame; check `rms_xcorr` < `rms_raw` in the sanity report.
3. **Level-10 silence** above ~20 kHz fundamentals is verbatim ji-harmonizer behaviour; acceptable.

## Build slice 1 (2026-09-07, v0.1.0)

Files: `generated/wt-osc.maxpat` (abstraction), `generated/wt-osc-test.maxpat` (bpatcher harness:
flonum freq / flonum position / number bank -> wt-osc -> gain~ + meter~ + scope~ -> ezdac~),
`tools/bake_geometry.py`, `generated/bank00-torus-sdf.wav` (23.1 MB, committed),
`test-results/bake-bank00-torus-sdf.txt` (sanity report, ALL PASS).

wt-osc I/O: in1 Hz (signal/float), in2 position 0-1 (signal/float), in3 bank index -> umenu ->
`prepend replace` -> `buffer~ terrainbank bank00-torus-sdf.wav`; out1 signal. gen~ codebox is the
ji-harmonizer base group verbatim (phase acc, mip = clamp(floor(log2(f/20)),0,10), bilinear frame
morph via explicit lerps). Inlet x-rank verified (15 < 120 < 330). Patch built with explicit
coordinates -- `apply_layout` pushed comments to x=615+ and stacked both flonums at the same rect.

### Geometry finding: centred (p,q) knot on a torus SDF is degenerate

A torus is symmetric about its axis, so along a centred (2,3) knot the SDF only sees the meridian
motion (rho = R + r cos 3t, z = r sin 3t): the sampled field has exact period 2pi/3 and a full-cycle
bake gives a pure harmonic-3 series (frame 0 = "sine" at 3x pitch; harmonics 1, 2 absent). Tilting
the torus / offsetting the orbit centre in xy breaks the symmetry but harmonic 2 or 3 still
dominates (the knot's own x/y coordinates carry cos 2t; harmonic 1 only appears via r/2 cross
terms) -- no near-sine frame 0 is possible that way. Second degeneracy: at orbit scale 1.0 the
meridian circle is concentric with the tube, SDF is constant, frame is silent after DC removal.

Bake decisions (defaults in `bake_geometry.py`): `fold = q` (sample one field period, 2pi/3, per
cycle so harmonic 1 is the fundamental; auto when tilt == 0) and `zoff = 0.25` (orbit shifted along
the torus axis; removes the scale-1.0 dead zone, min frame RMS 0.10 vs median 0.36). `--tilt`
+ `--fold 1` remain available for rougher later banks. Result: frame 0 h2 -13 dB, 4 harmonics
> -60 dB; frame 255 h2 -3.8 dB, 9 harmonics > -60 dB (the spec's scale 0.3-1.6 / tanh(3f) gives
moderate rather than extreme top frames -- `--drive` and `--scale HI` are the knobs). xcorr
alignment halves adjacent-frame RMS diff (0.0064 -> 0.0031), no polarity flips. Global peak 1.0
at mip 0 frame 255; every mip's highest bin == h_max(k); level 10 silent.

Next: audition `wt-osc-test.maxpat` in MAX (bank load, pitch across mips, position sweep), then
slice 2 (terrain-osc + poly~ @up CPU test).

## Build slice 2 (2026-09-08, v0.2.0)

Files: `generated/terrain-osc.maxpat` (abstraction), `generated/terrain-osc-core.maxpat` (poly~ voice
wrapper: `in 1` Hz -> terrain-osc -> `out~ 1`, `in 2` param messages), `generated/terrain-osc-test.maxpat`
(CPU-test harness), `test-results/terrain-osc-cpu-test.md` (protocol + results table, to be filled in MAX).

terrain-osc I/O: in1 Hz (signal/float) -> orbit gen~; in2 param messages (`<name> <value>`) ->
`route drive` -> `prepend drive` -> shaper gen~ / everything else -> orbit gen~. out1 audio,
out2/out3 orbit x/y (0-1 signals, for the slice-3 view). Chain: orbit gen~ (Hz in, internal phase acc,
`shape` 0 ellipse / 1 epitrochoid / 2 squarcle via range tests, `rx ry rot cx cy lobes lobeamt`,
pitch zoom `radius *= clamp(zoomk / f, zoomlo, 1)`, outputs clamped 0.02-0.98) ->
`jit.peek~ terrain 2 0 @interp 1 @normalize 1` -> shaper gen~ `tanh(dcblock(in1) * drive)`.
No `phasor~` / `tanh~` objects: phase and dcblock/tanh live in the two codeboxes. All Params carry
min/max. Matrix name `terrain` is fixed (single shared matrix per the discuss decision).

Harness: `loadbang`-free init via `loadmess` per control; freq goes through `t f b` so `target 0`
always precedes the float (broadcast to all instances). Params fan into `send tosc-test-params` ->
`receive` -> poly~ in 2. `voices $1` / `up 1|2|4` (umenu -> `select 0 1 2`) messages into poly~
inlet 0; `adstatus cpu` polled by `metro 250`. Terrain: `jit.bfg @dim 256 256 @basis noise.perlin`
(+ `scale $1 $1 1.`, `seed $1`, regen button) -> `jit.matrix terrain 1 float32 256 256` -> `jit.pwindow`.
`jit.pwindow` is stored as `maxclass newobj` + text (validator rejects the UI maxclass; MAX
instantiates the UI class from the text). Explicit coordinates throughout with the add_box
auto-nudge disabled (it pushed rows into each other); `finalize_patch(is_new=False)` only for midpoints.

Framework fix: `poly~` outlet 0 was extracted as a control "status" outlet, so `validate_patch`
silently auto-removed every `poly~ -> gain~/scope~` line (also true for the committed scala-synth
main patch). Added an `overrides.json` entry marking outlet 0 `signal` / `signal_role: audio`.
Per-instance I/O still has to be set on the box (`numinlets`, `numoutlets`, `outlettype`).
`jit.bfg` `scale` arity (3 floats) is from the reference, not the DB -- verify the message in MAX.

Next: run the CPU protocol in MAX and fill the results table, then decide single vs split poly~
(decision rule in the test file); then slice 3 (main patch composing wt-osc + terrain-osc, view).

### v0.2.1 harness fix (2026-09-08): silent + 0 % CPU on first open

Three harness defects, none in the oscillator: `gain~` loads at 0 (silence at the dac even with a
live poly~), the CPU readout was an int `number` (sub-1 % truncates to 0), and the load-time
`voices 1` / `up 2` messages reload the poly~ instances, wiping whatever freq/params had already
arrived (loadmess order is not guaranteed). Fixes: `loadmess 100` -> `gain~`; CPU readout is a
`flonum`; voices/up inits are `loadmess set 1` (UI only, no reload); `receive tosc-test-params` ->
`t l b` -> `target 0` then the param list, so broadcast is guaranteed regardless of load order.
Rule of thumb for future harnesses: never send poly~ `voices`/`up` at load when the args already
say so, and always init `gain~`.

### v0.2.2 (2026-09-08): black terrain / silence root cause = invalid jit.bfg basis

`noise.perlin` is not a jit.bfg basis name (valid: noise.gradient, noise.simplex, noise.cell,
noise.checker, noise.distorted, noise.sparse.convolution, noise.value.*, noise.voronoi, fractal.*,
filter.*, transfer.*; from jit.bfg.maxref.xml). jit.bfg accepted it silently and output all zeros ->
black pwindow -> constant jit.peek~ read -> dcblock -> exact silence with DSP running (the symptom
set: loadmess fired, CPU > 0, scope flat). Fixed: `jit.bfg 1 float32 256 256 @basis noise.gradient`
(positional planecount/type/dim as in the shipped help patch), scale default 0.02 (jit.bfg grid
coordinates are cell indices x scale; the maxref lists the scale default as 0, so it must be set;
an integer scale lands gradient noise on its zero lattice). Display: `jit.expr @expr in[0]*0.5+0.5`
before the pwindow, terrain itself stays signed. Rule: DB attribute lists for jit.* generators do
not include enum values -- verify basis/mode names against the maxref before use.

### v0.2.3 (2026-09-08): white pwindow + one impulse then silence -> diagnostics added

Symptom set after the basis fix: pwindow white, scope shows a single impulse at DSP start, then
flat. Either the terrain is uniform (constant jit.peek~ read -> dcblock step) or the orbit is frozen
(freq never reached the instance). Harness now separates the two: `jit.matrix -> t l l ->` jit.3m
(min / mean / max flonums of the raw terrain) and jit.expr display; a click-message
`exprfill 0 sin(snorm[0]*PI*3.)*cos(snorm[1]*PI*3.), bang` fills the same matrix analytically
(bypasses jit.bfg); terrain-osc-core got `out~ 2` = orbit x, read in the harness by
`snapshot~ 50` -> flonum (must jitter). Params grid / CPU column moved +350 px right for room.

## Sonic review + plan re-weighting (2026-09-08, v0.3.0)

External review verdict: the baked path is "a wavetable with an unusual author"; the live terrain
oscillator with audio-rate terrain modulation and trajectory feedback is the sonic identity; mesh
slices are weak sources (near-sine, -12 dB/oct), noise volumes and orbit-radius sweeps are the
musical baked sources; centred symmetric orbits lose the fundamental (already fixed in slice 1:
`fold = q`, `zoff`); frame-to-frame travel is modest (drive/scale knobs). Decisions taken:

- **terrain-osc architecture switched to buffer~ + one gen~ codebox.** `jit.matrix terrain` stays
  the display/view matrix; `p matrix2buffer` copies it row by row into `buffer~ terrainbuf`
  (`uzi 256 0` -> `t b i i` -> `inputfirst y*256` / `offset 0 y` -> `jit_matrix terrain` ->
  `jit.submatrix @dim 256 1` -> `jit.buffer~ terrainbuf`; `sizeinsamps 65536` first). The codebox
  does phase, shape, rotation, zoom*(1+in4), feedback, 4-peek bilinear read, dcblock, tanh.
  Gains: single-sample trajectory feedback (`fb`), audio-rate x/y/radius modulation inlets
  (in2-in4), mc.gen~ per voice possible, no jit.peek~ inside poly~ (that risk is retired by
  construction). Cost: 256 message-rate row copies per terrain update (fine at frame rate).
- **Slot A = terrain-osc, slot B = wt-osc** (see Decisions).
- **Mesh slicing demoted** to one bake source among several; noise volumes and SDF orbit-radius
  sweeps lead. bake_geometry.py unchanged.
- **Chebyshev bandlimited terrain = v1.1.** Feasible under the codebox rules with two flat
  constant-bound loops (recurrence T_{n+1} = 2xT_n - T_{n-1} into a Data, then a flattened
  N*N sum) -- the earlier "needs nested loops" note was wrong.
- jit.peek~ CPU test superseded by: 1 voice 4x / 8 voices 2x / 8 voices 4x of the gen~ version
  (same protocol file). Slice-1 bank audition still pending.

terrain-osc v0.3 I/O: in1 Hz, in2 x mod, in3 y mod, in4 radius mod (signals; 0 = none), in5
param messages (shape rx ry rot cx cy lobes lobeamt zoomk zoomlo fb drive); out1 audio, out2/3
orbit x/y. terrain-osc-core: in 1 -> in1, in 2 -> in5, out~ 1 audio, out~ 2 orbit x.

## Slice 2 result (2026-09-21)

v0.3.0 confirmed in MAX: matrix2buffer bridge + single-gen~ terrain-osc produce audio (after the
analytic `exprfill`); ~3 % CPU at 8 voices, 48 kHz. Decision rule -> **single poly~ voice, 2x**.
The load-time `jit.bfg` fill did NOT give a usable terrain (needed the exprfill click); root cause
not isolated.

## Build slice 3 (2026-09-21, v0.4.0) -- voice + main patch, view deferred

Files: `generated/terrain-voice.maxpat` (poly~ voice), `generated/terrain-synth.maxpat` (main,
opens in presentation). The jit.world view is the next iteration.

**terrain-voice:** `in 1` pitch -> `mtof` -> `sig~`; `in 2` velocity -> `/ 127.` -> `adsr~` trigger.
Slot A = `terrain-osc` abstraction; slot B = the wt-osc codebox inlined in a gen~ that also does
the A/B crossfade (`Param pos`, `Param xfade`, `History one` de-hoist). **wt-osc.maxpat is not
instantiated per voice** because it carries its own `buffer~ terrainbank <23 MB wav>` -- 8 copies
would load the bank 8 times; the single `buffer~ terrainbank` lives in the main patch and the
voice gen~ reads it by name. Audio-rate terrain modulation: `f * modratio + modhz` -> quadrature
`cycle~` pair -> `xmod`/`ymod`/`rmod` depths -> terrain-osc in2-in4. Filter `svf~` LP, cutoff =
`line~` + env * `fenv`, `clip~ 20 18000`. `adsr~` mute outlet -> `t l l` -> busy (`route mute` ->
`== 0`) then mute -> `thispoly~`. Global params by `receive tsyn-osc` (terrain-osc param messages)
and `receive tsyn-voice` -> `route attack decay sustain release cutoff res fenv mix pos modratio
modhz xmod ymod rmod` (scala-synth receive precedent; no `target 0` ordering problem).

**terrain-synth main:** `notein` + `kslider`/`makenote 100 600` -> `pack i i` -> `prepend midinote`
-> `poly~ terrain-voice 8 up 2 @steal 1` -> `*~ 0.3` -> `gain~` (loadmess 110) -> `ezdac~`.
Oversample menu -> `up N` -> `t b l` (poly~ reload first, then `deferlow` -> `send tsyn-resend`);
every control also listens to `receive tsyn-resend` so reloaded voices get the current values.
Controls follow the reverse-delay pattern: `loadmess` -> `dial` (0-127) -> `expr` -> readout
`flonum` -> `prepend <name>` -> `send`. XY `pictslider` (0-1000, y flipped) = orbit centre.
`buffer~ terrainbank` + bank umenu here.

**p terrain-source** (inlet 0 source index, inlet 1 detail; outlet = display matrix): 0-3 analytic
`exprfill` terrains (default 0 at load via `loadmess 0` -> `deferlow`), 4 smooth noise
(`jit.noise 1 float32 N N` -> signed -> upscaled by `jit.matrix terrain ... @interp 1`), 5
`jit.bfg` rebuilt in the shipped help-patch form (basis by message, 3-value scale,
`jit.normalize`) -- still experimental, 6 image (`importmovie` dialog -> `jit.rgb2luma` -> float).
`p matrix2buffer` is a verbatim rebuild of the confirmed v0.3.0 bridge.

Presentation exclusions: none (every interactive control is in presentation).
Unverified in MAX: `adsr~` mute-outlet -> busy logic, smooth-noise upscale, bfg form, image path,
pictslider list init, `up N` + resend.

### v0.4.1 (2026-09-21): silent voices -- midinote list lands on `in 1`

Symptom: terrain fills, scope flat, console clean. Cause: `poly~` `midinote <pitch> <vel>` delivers
the pair as ONE LIST to the instance's first `in` (C74's shipped `help/msp/adsr-synth.maxpat` does
`in 1` -> `unpack 0 0` -> `swap`); it does not split across `in 1` / `in 2`. The voice waited for
velocity on `in 2`, so `adsr~` never triggered. Fix: `in 1` -> `unpack 0 0` -> `swap` (pitch ->
`mtof` first, then velocity -> `/ 127.` -> `adsr~`); `in 2` removed, main `poly~` box numinlets 1.
Rule: for `note` / `midinote` voices copy the adsr-synth input form; verify poly~ voice idioms
against the shipped msp help patches, not other repo patches.

### v0.4.1 confirmed in MAX (2026-09-21) + v0.4.2

User: "it all works" -- terrain fill at load, keyboard/voices, controls. Confirmed forms: `in 1` ->
`unpack 0 0` -> `swap` midinote input; `adsr~` mute outlet -> `t l l` -> (`route mute` -> `== 0` ->
busy) + mute -> `thispoly~`; abstraction + gen~ reading main-patch buffers by name inside
`poly~ ... up 2`; receive-based global params; dial -> expr -> flonum -> prepend -> send columns.
(Which terrain-menu entries were exercised -- bfg / image -- was not itemised.)

v0.4.2: MAX re-saves a `newobj`-form `jit.pwindow` as maxclass `jit.pwindow` and resets BOTH rects
to its 80x60 default -> terrain picture restored to 150x150 (now a true UI box, so it sticks).
`jit.pwindow` / `jit.cellblock` added to `UI_MAXCLASSES`; build future pwindows as UI boxes so the
size survives the first re-save. MAX also re-proportioned the kslider to 864x98 (fixed key aspect).

## Build slice 3b (2026-09-21, v0.5.0) -- jit.world terrain/orbit view

Main patch only. `p terrain-view` (in: terrain-changed bang | view on/off | rotate deg | tilt deg;
out: jit_gl_texture) -> second `jit.pwindow` (208x208) in a new VIEW presentation panel
(x 900-1128; fits the user's 1138-wide window) with ON toggle + ROTATE / TILT dials.

- **Context:** `jit.world tsynview @visible 0 @enable 1 @output_texture 1 @fsaa 1` -> texture ->
  `jit.pwindow` -- the form in the shipped jit.pwindow help ("texture" tab). No floating window.
- **Surface:** on each terrain change (`p terrain-source` outlet -> `t b l`), `t b b b` bangs, right
  to left: static z plane (`exprfill 0 snorm[1]`), a second `jit.matrix terrain` reference ->
  `jit.matrix 1 float32 64 64 @interp 1` -> `jit.op @op * @val 0.3`, static x plane (hot) ->
  `jit.pack 3` -> `jit.gl.mesh tsynview @draw_mode tri_grid @auto_normals 1 @lighting_enable 1`.
- **Orbit:** a helper `terrain-osc` instance at 110 Hz listening to `receive tsyn-osc` (so shape /
  radius / rotation / lobes / feedback / centre match the voices; pitch zoom only differs above
  ~zoomk Hz; per-voice audio-rate terrain mod is NOT shown) -> gen~ (x, nearest terrainbuf height
  * 0.3 + 0.03, z) -> `jit.catch~ 3 @mode 2 @framesize 512` banged by the jit.world draw bang ->
  `jit.gl.mesh tsynview @draw_mode line_strip @lighting_enable 0`.
- Rotate/tilt: `pak rotatexyz 35. 30. 0.` -> both meshes (`@scale 0.62` each; no extra camera).
- ob3d attrs (`color`, `scale`, `rotatexyz`, `lighting_enable`) are not in the DB attribute list
  for jit.gl.mesh; forms copied from the shipped jit.gl.mesh help. `line_width` skipped (glcore).

Unverified in MAX: everything GL (first GL patch in the repo): texture-to-pwindow embedding,
jit.pack plane order / tri_grid orientation vs the terrain picture, jit.catch~ mode 2 frame shape,
helper osc + DSP-off behaviour.

### v0.5.0 confirmed in MAX (2026-09-21) + v0.5.1 polish

User ran the v0.5.0 view checklist: "all pass" (surface + orbit, XY-pad orientation, live reshape,
terrain rebuild, rotate/tilt, ON toggle, CPU). Confirmed GL forms: invisible `jit.world <ctx>
@output_texture 1` -> texture -> `jit.pwindow`; static x/z planes + height -> `jit.pack 3` ->
`jit.gl.mesh @draw_mode tri_grid`; helper osc -> gen~ xyz -> `jit.catch~ 3 @mode 2 @framesize 512`
banged by the world draw bang -> mesh; `pak rotatexyz` -> meshes.

v0.5.1 (from the user's screenshot, not yet re-checked): jit.world renders 640x480 by default ->
squeezed in a square pwindow -> `@size 512 512 @dim 512 512`; meshes `@scale 0.45` (0.62 cropped);
orbit drawn as `@draw_mode points @point_size 4 @point_mode circle_depth` (help form) instead of a
1 px line_strip; flonum `numdecimalplaces 0` means AUTO in MAX (showed 9.77857) and MAX drops the
key on re-save -> all Hz/ms/deg readouts set to 1; clipped "orbit at 110 Hz" note moved under the
view dials; bank menu nudged off the WAVETABLE B header.

### v0.5.2 (2026-09-21): view reads as a skewed strip -> turntable

v0.5.1 screenshot: aspect fixed, orbit dots visible, readouts fixed, but the surface was too small
(0.45) and looked like a diagonal strip. Cause: TILT and ROTATE were both applied as mesh
`rotatexyz x y 0`; the combined Euler rotation is not a turntable (yaw about the vertical, then
elevation), so the square terrain skews as ROTATE changes. Fix: meshes only yaw
(`pak rotatexyz 0. <rot> 0.`), and `jit.gl.camera tsynview @locklook 1 @tripod 1 @lookat 0 0 0`
rides a 2.4-radius arc (`position 0 2.4*sin(tilt) 2.4*cos(tilt)`); mesh `@scale 0.6`.
Unverified in MAX: explicit jit.gl.camera alongside the invisible jit.world.

### v0.5.2 view confirmed (2026-09-21); main pushed to origin (893b5ed..1d463a8)

## Slot-B banks (2026-09-21, v0.6.0)

`tools/bake_geometry.py` gained `--field torus|noise|blend`, `--noise-freq`, `--octaves`,
`--noise-amt`, `--noise-offset` (the fBm code was already in the file). Default invocation still
re-bakes bank00 byte-identically. The fold trick is now only auto-applied for the symmetric case
(`--field torus`, tilt 0).

**Finding: the (2,3) knot is a bad orbit for non-symmetric fields.** Sampling a noise volume (or a
tilted torus) along it puts the energy in h2/h3 -- the orbit's own 2- and 3-fold sub-loops -- and
h1 sits 10-13 dB down at every frame ("frame 0 fundamental strongest" FAILS). A plain circle
(`--knot 1 0`, radius 1.5 x scale) fixes it: a small circle in a smooth field is a linear-gradient
read = near-pure h1, and harmonics grow with the radius sweep. Low end of `--scale` is chosen so
frame 0 is not ~20 dB quieter than the rest under the global-peak normalisation (0.1, not 0.03).

| bank | command (all `--knot 1 0`) | frame 0 -> 255 |
|---|---|---|
| bank01-noise-soft | `--field noise --noise-freq 1.0 --octaves 3 --scale 0.1 1.2 --drive 2` | 10 -> 75 harmonics > -60 dB, h1 strongest throughout |
| bank02-noise-rough | `--field noise --noise-freq 1.2 --octaves 4 --scale 0.1 2.0 --drive 4` | 21 -> 223 harmonics, top frames led by h3/h7 (h1 -5 dB) |
| bank03-torus-noise | `--field blend --tilt 0.5 --noise-amt 0.35 --noise-freq 1.5 --octaves 3 --scale 0.15 1.0 --drive 4` | 14 -> 73 harmonics; scale HI kept at 1.0 (1.3 saturates tanh into a dead frame) |

Reports: `test-results/bake-bank0N-*.txt`, all ALL PASS. WAVs committed (23 MB each, precedent).

Main patch: bank umenu now shows friendly names (`torus sdf / noise soft / noise rough / torus
noise`, fontsize 10) -> `select 0 1 2 3` -> `replace <file>` message boxes -> `buffer~ terrainbank`
(the old symbol -> `prepend replace` path is gone, since menu text no longer equals the filename).
`wt-osc.maxpat` (standalone abstraction) still lists only bank00. Unverified in MAX: bank switching
while notes sound, audition of the three banks.

### v0.6.1 (2026-09-21): A>B MIX / POSITION (and so the banks) had no audible effect

Split test: FILTER / ENVELOPE dials work (so send -> receive -> route is fine) but MIX at 1.0 sounded
identical to 0, console clean. The only thing on that path unique to MIX/POSITION was the voice
gen~'s Param messaging: `prepend xfade|pos` -> gen~ inlet 0 (which also carries the freq signal),
with `k = Param * one` (`History one(1.)` de-hoist) inside `poly~ ... up 2`. Root cause NOT
isolated (candidates: `one` reading 0 in a poly~ instance, or Param messages not applied).
Fix sidesteps both: Params and `one` removed; mix and position enter as signals --
`route` -> `$1 20` -> `line~` -> gen~ in3 / in4 (the same message->line~ form already confirmed for
cutoff in this voice), clamped 0-1 in the codebox. Since v0.4.0 slot B was therefore never
audible; the v0.6.0 banks are untested until this is confirmed.
If this works, treat "Param messages + History-one inside poly~ voices" as suspect and prefer
signal inlets for per-voice gen~ controls.

v0.6.1 confirmed in MAX (2026-09-21): user -- "mix works". Signal-inlet form for per-voice gen~
controls is the rule from here on. POSITION sweep and the three new banks were not explicitly
reported on yet.

## Slot B = second wave-terrain oscillator (2026-09-21, v0.7.0)

User request: replace the wavetable bank in slot B with a duplicate of the 3D terrain oscillator.
Decisions (multiple-choice discuss): **own terrain** for B, **full duplicate** orbit controls,
**ratio + fine detune** for B pitch, **terrain mod drives both**, **view A/B switch**. Supersedes the
"A = terrain-osc, B = wt-osc" decision above.

- **`generated/terrain-osc-b.maxpat`** -- twin of `terrain-osc.maxpat`; the only difference is
  `Buffer terrain("terrainbufB")`. A second file rather than a gen~ buffer-rebind message because the
  file copy is the proven form. **Keep the two codeboxes in sync by hand.**
- **terrain-voice:** wavetable gen~ removed. `sig~` Hz -> `*~` (x `bmul`, arriving as
  `route ... bmul` -> `$1 20` -> `line~`, `loadmess 1.` so B is never at 0 Hz) -> `terrain-osc-b`
  (in2-in4 = the same x/y/radius mod signals as A, in5 = `receive tsyn-oscB`). New gen~ is only the
  crossfade (`in1 + clamp(in3,0,1) * (in2 - in1)`, linear as before). The `pos` route slot became
  `bmul` (same outlet index), so the voice param list is otherwise unchanged.
- **Main:** `buffer~ terrainbank`, bank umenu + `replace` messages and the POSITION column are gone
  (bank WAVs, `wt-osc.maxpat`, `wt-osc-test.maxpat` and `tools/bake_geometry.py` stay in the repo,
  unused by the synth). Clones of the A sections with `tsyn-osc` -> `tsyn-oscB`: `p terrain-source-b`
  (`jit.matrix terrainB`, `jit.buffer~ terrainbufB`; default source 1 = fm warp so A != B at load),
  4.7 ORBIT B dial row, 4.8 shape + XY centre. 4.9 OSC B PITCH: B RATIO dial (`size 15` ->
  0.5 ... 4.0 in 0.25 steps, default 1.0) and B DETUNE (+/-50 cents) -> `expr $f1 * pow(2., $f2/1200.)`
  (cents on the cold inlet via `t b f`) -> `prepend bmul` -> `send tsyn-voice`.
- **p terrain-view:** 5th inlet = view select (umenu terrain A | terrain B) -> `t b i i`: `sig~` ->
  xyz gen~ in5, `+ 1` -> `gate 2 1` choosing which named matrix (`terrain` / `terrainB`) feeds the
  surface, then a rebuild bang. Second helper `terrain-osc-b` (110 Hz, `receive tsyn-oscB`); the xyz
  gen~ now takes both orbits + both buffers and `mix()`es by the select signal. Either terrain
  changing bangs a rebuild of whichever surface is selected. B ratio/detune is not shown in the view.
- **Presentation:** new B row at y 282-518 (TERRAIN B panel, ORBIT B panel, OSC B PITCH panel under
  it); FILTER / ENVELOPE / OUTPUT / keyboard moved down 242 px; window 1138x797 (top moved to y 60).
  Row A's old WAVETABLE B panel is now OSC MIX with A > B MIX in its first column. TERRAIN MOD is
  titled "A + B". Presentation exclusions: none.
- Edit mechanics: sections were cloned from the file's raw box JSON (new ids, shifted rects,
  text substitutions) and materialised through `Patcher.from_dict`, so nested subpatchers and all
  attributes carry over losslessly.

Unverified in MAX: everything in this version -- B terrain fill at load, B audible at MIX 1, B orbit
dials / XY pad / shape, ratio steps + detune beating, mod depths on B, view A/B switch (surface +
orbit dots), `dial @size 15`, CPU with two terrain oscillators per voice (expect ~2x the 3 %).

## 3D views replace the 2D terrain pictures (2026-09-21, v0.8.0)

User request: no separate view on the right; the 3D render sits where each terrain's 2D picture was.

- The v0.7.0 single A/B-switched `p terrain-view` is gone. Two dedicated views instead:
  `p terrain-view-a` = the v0.5.2 **confirmed** subpatch verbatim (context `tsynview`), and
  `p terrain-view-b` = the same with `tsynviewB` / `jit.matrix terrainB` / `terrainbufB` /
  `terrain-osc-b` + `receive tsyn-oscB`. One invisible `jit.world` per terrain -> texture -> the
  existing 150x150 TERRAIN A / TERRAIN B `jit.pwindow`s (the 2D `jit.expr` display output of
  `p terrain-source` is still produced but no longer connected to anything).
- ON / ROTATE / TILT are shared: `t i i` / `t f f` fan out to both views. In presentation they moved
  into a "3D VIEW  A + B" panel right of OSC B PITCH ([511,410,379,108]); the right-hand VIEW panel,
  its 208 px picture and the A/B menu are removed; window is 900 wide.
- Unverified in MAX: two offscreen `jit.world` contexts in one patch (each feeding its own
  `jit.pwindow` by texture), readability of the render at 150 px (mesh `@scale 0.6`), CPU/GPU of two
  worlds + two helper oscillators.

### v0.7.0 + v0.8.0 confirmed in MAX (2026-09-21)

User: "it works - all checks pass". Confirmed: slot B terrain oscillator (own terrain, orbit row, XY
pad, ratio/detune, shared terrain mod), plain Param messages into `terrain-osc` / `terrain-osc-b`
inside `poly~ ... up 2`, `dial @size 15` stepped ratio, two offscreen `jit.world` contexts each
feeding its own `jit.pwindow`, shared ON / ROTATE / TILT, per-terrain surface rebuild.

## Play marker (2026-09-21, v0.9.0)

User request: a point moving across the 3D terrain as the note plays. The audio orbit runs at pitch
rate (hundreds of laps/s), so the marker is a **slowed stand-in**, not the literal read head.

- **Main, section 6:** `prepend midinote` -> `t l l` (poly~ first) -> `route midinote` -> `unpack 0 0`
  -> velocity `> 0` opens a `gate` so only note-ons pass the pitch -> `mtof` ->
  `expr min($f1 / 220., 6.)` (A3 = 1 lap/s, capped at 6) -> `prepend hz` -> `send tsyn-mark`.
  Sound gate: voice sum (`*~ 0.3`, pre-volume) -> `peakamp~ 50` -> `> 0.0005` -> `change` ->
  `prepend on` -> `send tsyn-mark` (so the marker stays through the release tail and hides in silence;
  polyphony = speed of the most recent note).
- **Each view:** `receive tsyn-mark` -> `route hz on`. `hz` drives a third `terrain-osc` /
  `terrain-osc-b` instance (B: `* bmul` via `receive tsyn-voice` -> `route bmul`; `loadmess 0.5`
  default) following the same `tsyn-osc` / `tsyn-oscB` params -> xyz gen~ (height + 0.07) ->
  3 x `snapshot~` banged z, y, x by the jit.world draw bang (`t b b`: jit.catch~ first, then
  `t b b b`) -> `pack f f f` -> `setcell 0 val $1 $2 $3, bang` -> `jit.matrix 3 float32 1` ->
  `jit.gl.mesh <ctx> @draw_mode points @point_size 14 @point_mode circle_depth @color 1. 1. 1. 1.
  @scale 0.6 @enable 0`; `on` -> `enable $1`. The rotate `t l l` became `t l l l` so the marker
  mesh turns with the surface.
- Known limitation: with FEEDBACK != 0 the marker drifts off the dotted path -- trajectory feedback
  is an audio-rate effect a ~1 Hz copy cannot reproduce. B speed picks up a new `bmul` on the next note.
- Unverified in MAX: 1-cell matrix into a points mesh, `enable` on jit.gl.mesh, float Hz < 1 into
  terrain-osc in1, peakamp~ threshold feel.

### v0.9.0 confirmed in MAX (2026-09-21)

User: "it works". Confirmed: 1-cell `jit.matrix 3 float32 1` via `setcell` into a points mesh,
`enable $1` on jit.gl.mesh, sub-1 Hz float into terrain-osc in1, `peakamp~` sound gate,
`route midinote` tap after `prepend midinote`.

## Per-voice motion: LFO + ENV 2 -> orbit (2026-09-21, v0.10.0)

User request: one LFO and a second ADSR inside terrain-voice, bipolar depths to orbit RADIUS / ROTATE /
CENTRE X / Y, as signals into the terrain-osc mod inlets.

Decisions (multiple-choice discuss):
- **Own depth set per slot, two rows** -- 16 depth dials (LFO > A, LFO > B, ENV 2 > A, ENV 2 > B), chosen
  over shared depths (8 dials, one row) and over an A/B edit tab. Window grows 797 -> 1029 px.
- **All four targets** (radius, rotate, centre x, centre y) for both sources.
- **Display:** LFO shown on the 110 Hz orbit dots AND the play marker; ENV 2 (per note) not shown.
- **ENV 2 level is fixed** (note-on = 1.0, not velocity-scaled) so a depth always means the same excursion.

Build:
- **`generated/terrain-lfo.maxpat`** (new abstraction, one codebox): in1 rate Hz, in2 shape (0 sine /
  1 triangle / 2 S&H), in3 note gate -- all signals; rising gate edge resets phase to 0 (sine / tri start at
  the zero crossing, rising) and draws a new S&H value. S&H has a 2 ms one-pole so centre / radius steps do
  not click. Gate left open = free-running.
- **`terrain-osc` / `terrain-osc-b` v0.4:** new **inlet 6** = rotation mod (signal, turns, adds to `rot`);
  gen~ `in5`, `rotm = (rot + in5) * twopi` with one cos / sin pair per sample (rotation is no longer a
  hoisted Param-only expression). Added as the RIGHTMOST inlet so the param-message inlet keeps index 5 and
  no existing host wiring shifts. Codeboxes still differ only in header + buffer name.
- **terrain-voice `p motion`** (5 in / 8 out): terrain-mod x / y / radius signals + velocity + the voice
  route's unmatched outlet in; slot A x / y / radius / rotate and slot B x / y / radius / rotate out ->
  osc inlets 2, 3, 4, 6. Inside: `route lforate lfoshape env2a env2d env2s env2r` -> unmatched ->
  `route lfoArad lfoArot lfoAx lfoAy lfoBrad ... envBy`; every LFO / depth control is
  `route -> "$1 20" -> line~` (v0.6.1 rule); the four ENV 2 times go to `adsr~` as floats exactly like the
  confirmed amp envelope (adsr~ is not a gen~ Param). Gate = `expr ($f1 > 0.) * 1.` -> `t f f` -> `sig~`
  (LFO restart) + second `adsr~`. One 21-in / 8-out matrix codebox does
  `out = terrain mod + LFO * depth + ENV 2 * depth` (radius floored at -1). With all depths at 0 the old
  terrain-mod signals pass through unchanged. Top level: `/ 127.` -> new `t f f` -> amp `adsr~` (left) and
  `p motion` gate (right); everything from the oscillator row down moved 45 px.
- **Main:** sections 4.10 (LFO rate / shape + 8 LFO depths) and 4.11 (ENV 2 ADSR + 8 ENV 2 depths), cloned
  from the confirmed FEEDBACK / ENVELOPE / shape-menu columns (loadmess + `receive tsyn-resend` re-bang ->
  dial -> expr -> flonum -> prepend -> `send tsyn-voice`). Depth scaling: radius and rotate +/-1
  (`max(($f1 - 64.) / 63., -1.)`), centre x / y +/-0.5; rate `0.05 * pow(400., $f1 / 127.)` (dial 64 = 1 Hz).
- **Presentation:** two MOTION rows at y 524 / 640 between the B block and FILTER / ENVELOPE / OUTPUT
  (that row and the keyboard moved down 232 px): panels [10, 312] source, [330, 276] > ORBIT A,
  [614, 276] > ORBIT B on the 64 px column rhythm.
- **Views:** each view gets `receive tsyn-voice` -> `route lforate lfoshape lfo<A|B>rad rot x y` -> line~ ->
  `terrain-lfo` -> 4 x `*~` -> BOTH helper oscillators (orbit dots + marker). The marker's `route hz` now
  goes through `t f b`; the bang fires a `1 1 0 5` line~ pulse that restarts the view LFO, so the display is
  in phase with the most recent note. Helper sections moved 250 px down to make room.
- Tooling note: `validate_patch` reports "Signal outlet to control-only inlet" for signals into a `p`
  subpatcher inlet (false positive; the saved file keeps the connection).

Not shown: ENV 2 and the audio-rate terrain mod in the 3D views. Known limit: S&H / LFO phase in the view is
the last note's, not each voice's.

Unverified in MAX: everything in this version -- 6-inlet terrain-osc / -b (param inlet still index 5),
21-inlet gen~ matrix, signals through `p motion` inlets inside `poly~ ... up 2`, terrain-lfo retrigger from
a `sig~` gate edge, second `adsr~` at fixed level, umenu item "S&H", depth feel / ranges, `1 1 0 5` restart
pulse in the views, CPU (one extra cos / sin pair per oscillator per sample + LFO + matrix per voice),
window height 1029 on the user's display.

### v0.10.0 confirmed in MAX (2026-09-21)

User: "all pass" on the full checklist. Confirmed: v0.9.0 behaviour unchanged at depth 0 (terrain mod, marker),
all 16 depth dials audible incl. the new ROTATE path (terrain-osc / -b inlet 6, param inlet still index 5),
LFO restart from the `sig~` gate edge, S&H without clicks, ENV 2 (second `adsr~`, fixed level) sweeping the
orbit, LFO visible on orbit dots + marker (`1 1 0 5` line~ restart pulse), clean console with the 21-inlet
gen~ matrix and signals through `p motion` inlets inside `poly~ ... up 2`, CPU acceptable, umenu item "S&H".

## Animated terrain: MORPH + RIPPLE (2026-09-21, v0.11.0)

User request: animated terrain for A and B -- (a) morph between two sources, (b) jit.gen wave-equation ripple,
one qmetro, audio follows every animated frame, 3D surfaces rebuild per frame, window <= 900 wide.

Decisions (multiple-choice discuss):
- **Bridge: `jit.scanwrap` + bench.** Animated frames go `jit.scanwrap 1 float32 65536 1` -> a second
  `jit.buffer~ terrainbuf` (ONE write, row-major = idx y*256 + x) instead of the 256-row uzi loop. The confirmed
  `p matrix2buffer` uzi path is untouched and still serves static changes (menu / REGEN / DETAIL / morph dial while
  animation is off). `cpuclock` pairs measure both copies -> `send tsyn-bench` -> section 4.14 readouts
  (static A / anim A / static B / anim B ms) + a frame-ms readout on `p animate`. A 128x128 fallback is NOT built;
  decide from the numbers.
- **Ripple = displacement layer.** Own 64x64 field `trip<A|B>` (+ `trip<A|B>p` = previous frame);
  terrain = clip(xfade(source 1, source 2) + upsampled ripple, -1, 1). Leak decays the field to 0, so the terrain
  always relaxes to its source. 64x64 (upsampled with the proven `jit.matrix ... @interp 1` form) because at one
  step per frame a wave crosses 64 cells in ~3 s; at 256 it would take ~12 s.
- **Source 2 = full clone** of the confirmed generator block (all 7 entries incl. image), raw-JSON copy, own store
  `tsrc<A|B>2`; DETAIL shared; REGEN re-rolls both menus (`t b b`).
- **Layout: one 108 px ANIMATE strip** at y 524 (ON + FPS | ANIMATE A | ANIMATE B); MOTION / FILTER / keyboard
  rows moved down 116 px; window 900 x 1048.
- Defaults taken without asking: excite point = that slot's orbit centre (cx / cy -> `param ex_x / ex_y`);
  NOTE toggle = excite on every note-on; AUTO overrides the MORPH dial (dial + readout follow via `set`);
  animation OFF clears the ripple and does one static recompose.

Build:
- **`p terrain-source` / `-b`:** `obj-6` renamed `jit.matrix tsrc<A|B>1 ...` (source 1 store). New third inlet
  (rightmost, x 4000) -> `route tick morph amorph src2 excite rclear` (+ unmatched `param ...` -> jit.gen).
  Compose `t b b b` (right to left): ripple reader -> upsample -> `jit.op @op +` right | source 2 reader ->
  `jit.xfade` right | source 1 reader -> `jit.xfade` -> `+` -> `jit.clip @min -1. @max 1.` ->
  `jit.matrix terrain 1 float32 256 256` -> existing `t l l` -> `gate 2 1` (1 = uzi, 2 = scanwrap) -> bridge.
  Outlet 0 still fires per compose, so the 3D view rebuilds per frame through the existing terrain-changed bang.
- **Ripple step (`jit.gen`, embedded codebox, `classnamespace: jit.gen`, built with `add_gen()` + rename):**
  u_prev reader -> in2 (cold), u reader -> in1 (hot); `out2 = u` -> `trip p` store, `out1 = u_next` -> `trip`
  store (outlets fire right to left, both are jit.gen's own output matrices, so no named-matrix aliasing).
  `nxt = (u + (1-damp)(u-up) + c2 * lap) * (1-leak)`, c2 clamped <= 0.48 (2D stability limit 0.5), output
  clamped -1..1, fixed leak 0.003. Excite = gaussian bump `ex_amp` for exactly one frame (`param ex_amp 0.7`,
  reset to 0 after each step). Neighbours via `sample(in1, norm +/- del.xz / del.zy, boundmode="clamp")`
  (form from the shipped unsharp.mask / sampling.modes examples). Spaces only.
- **`p animate` (6 in / 7 out):** ON -> `qmetro` (interval = 1000 / FPS, FPS 5-30, default 25) ->
  `t b b b b b b`: clock | auto A | tick A | auto B | tick B | clock -> frame ms. Auto-morph: phase += rate * dt,
  morph = 0.5 - 0.5 cos(2 pi phase) -> `amorph` + `set` to the dial / readout; moving the dial re-seeds the phase.
  User morph goes out as `morph` (static recompose) when OFF and `amorph` (value only) when ON.
- **Main:** sections 4.13 (controls), 4.14 (bench), 4.15 (presentation panels). Everything reaches the sources by
  `send tsyn-animA / -B` -> `receive` -> inlet 2. Note-on tap: section 6 `gate` -> `t b i` -> `send tsyn-noteon`.
  Existing cords that gained a second destination were split through triggers (REGEN `t b b`, cx / cy `t f f`).
  Ranges: TENSION `0.02 + 0.46 * d/127`, DAMP `0.002 * 150^(d/127)`, AUTO `0.005 * 200^((d-1)/126)` Hz (0 = off).
- Deliberate presentation exclusions: the five bench / frame-ms flonums (patching view diagnostics).

Verified against DB + maxref / shipped patches: jit.xfade (2 in, `xfade`), jit.scanwrap (args = matrix spec, mode 0
fill), jit.buffer~ (`inputfirst` default 0 on the new instance), jit.gen (`param <name> <v>` messages, embedded
codebox form from jit.gen.maxhelp), jit.clip min / max floats, cpuclock, qmetro. `expr` has no confirmed `fmod` ->
phase wrap is `x - int(x)`.

Unverified in MAX: everything -- jit.gen compile (sample + boundmode in a 2-inlet codebox, swizzles on `concat(1/dim, 0)`),
right-to-left outlet order of a 2-out jit.gen, a second `jit.buffer~` instance on the same buffer~, jit.scanwrap
256x256 -> 65536x1 ordering (audio must sound identical with animation ON and everything at rest), 65536-frame single
write cost, per-frame 3D rebuild cost x 2, ripple feel (tension / damp ranges, bump size 0.07, amp 0.7), audible zipper
at 25 fps (the buffer is rewritten under the playing oscillators), window height 1048 on the user's display.

### v0.11.0 confirmed in MAX (2026-09-21)

User: "ok it works". Confirmed: `jit.gen` ripple codebox compiles (2-inlet `sample(..., boundmode="clamp")`, swizzles on
`concat(1. / dim, 0.)`, `param <name> <v>` messages), two-store u / u_prev feedback via right-to-left jit.gen outlets,
`jit.xfade` morph of two named source matrices, `jit.scanwrap 1 float32 65536 1` -> second `jit.buffer~` instance as the
per-frame bridge, per-frame 3D rebuild, EXCITE / NOTE, ANIMATE strip layout. Bench numbers not reported (no complaint
about cost at 25 fps), so no 128x128 fallback.

## Chebyshev bandlimited terrain core (2026-09-21, v0.12.0)

User request: alternative oscillator core for slots A and B, `terrain = sum c[m][n] T_m(x) T_n(y)`, N = 8, per-slot
TERRAIN / CHEBY switch (signal-rate), coefficient buffer + presets + BRIGHTNESS from the main patch, pitch-scaled order
limiting, numpy pre-flight first, views keep working.

### Research (`tools/cheby_preflight.py` -> `test-results/cheby-preflight.md`)

- **Why it is bandlimited:** with x, y = first-harmonic sinusoids (ellipse; any radius, centre offset, rotation) a degree-d
  term is a degree-d polynomial in cos / sin theta = partials <= d. At full radius, centred: `T_m(cos) T_n(sin)` = partials
  m + n and |m - n| only, i.e. the terrain is **2D Chebyshev waveshaping and the orbit RADIUS is the index**.
- **Measured (non-harmonic energy / total, f on an odd FFT bin, MIDI 24-120):** cheby core <= -154 dB (double-precision
  floor) for every preset at 48 k and 96 k, centred or off-centre / rotated / unequal radii. The same polynomial read by
  today's TERRAIN core (256 x 256 bilinear table) reaches -1 ... -15 dB at the top of the keyboard.
- **Order limiter:** gain of a total-degree-d term = `clamp((1 - d * fh / fmax) * 10, 0, 1)`, `fmax = min(0.45 sr, 21.6 k)`
  (fade 19.4 -> 21.6 kHz; 21.6 k = ji-harmonizer's 0.9 * 24000). Highest partial stays < 21.1 kHz over the whole sweep.
  Removing a degree-d term also removes its lower partials (d - 2, d - 4 ...), so the timbre thins with pitch rather than
  just losing its top -- inherent to limiting in the polynomial domain.
- **Epitrochoid IS a finite harmonic sum when LOBES is an integer** (highest orbit partial = lobes -> limiter uses
  `fh = f * lobes`; measured <= -154 dB at lobes = 3). But the LOBES dial is continuous (`1 + d/127 * 15`, default 3.008):
  the phase wrap then breaks `cos(lobes * theta)` -> -44 dB at 3.008, -12 dB at 3.5. **Squarcle is never bandlimited**
  (-10 ... -15 dB worst case, about as bad as the table). Orbit pushed into the 0-1 clamp: -14 ... -21 dB.
- **Also outside the guarantee (not simulated, by construction):** FEEDBACK != 0 (nonlinear trajectory feedback, and it is
  fed from the TERRAIN core's output, not the cheby core's), audio-rate TERRAIN MOD x / y / radius (finite sum, but the
  partials sit at combinations of f and the mod frequency, which the limiter does not know about), LFO S&H steps.
- **Decision:** document rather than hard-restrict. Turning CHEBY on snaps that slot's SHAPE menu to ellipse once; the
  other shapes stay selectable.
- **Cost / amortisation:** loop 1 = 16 iterations (limiter gains + recurrence), loop 2 = 64 x (3 Data peeks, 2 mul, add).
  A History cursor updates one effective coefficient per sample (`ce[k] = smoothed c[k] * limiter gain`), so the inner sum
  never touches buffer~ and preset / brightness moves are de-clicked (one-pole, ~11 ms at 96 k). The 64-sample refresh is
  fade LAG, not a step: worst case in a 2-octave / 100 ms glide a stale weight still passes a partial at 21.8 kHz
  (< Nyquist at every rate). With mode = 0 the sum is skipped by the inner `if (j < nact)` guard. CPU in MAX: unmeasured.
- Literal per-sample transliteration of the codebox (Data arrays, cursor, smoothing) matches the vectorised model to 2e-9.

### Build

- **`generated/terrain-cheby.maxpat`** (new abstraction, args: coefficient offset, orbit-param send name): in1 / in2 orbit
  x / y 0-1 (= terrain-osc outlets 2 / 3, so every orbit control, mod input, LFO / ENV 2 depth and the pitch zoom apply
  unchanged), in3 Hz, in4 mode; `sig~ #1` -> gen~ in5 (offset); `receive #2` -> `route shape lobes` -> `prepend` -> gen~
  Params (plain Param messages in a poly~ abstraction = the form confirmed in v0.7.0). Output = `dcblock(sum)`, **no tanh /
  DRIVE** (a waveshaper would undo the band limit); bounded to +/-1 by construction (sum |c| = 1, |T| <= 1).
  Codebox: two flat constant-bound loops, no nested loops, no else-if, spaces only, peek / poke with channel arg,
  `Data tx(8) ty(8) wd(16) cs(64) ce(64)`, no Param-only dependent chains (`fr` depends on the Hz signal). If gen~
  defers Data pokes to the end of the sample the core is simply one sample late -- still correct.
- **terrain-voice:** `terrain-cheby 0 tsyn-osc` / `terrain-cheby 64 tsyn-oscB`; `receive tsyn-cheby` ->
  `route modeA modeB` -> `$1 20` -> `line~`; one select gen~ per slot (`in1 + clamp(in3) * (in2 - in1)`, the confirmed
  crossfade codebox) between each terrain-osc and the A > B crossfade, so the 20 ms ramp is the click-free switch. The
  confirmed crossfade gen~ is untouched. Rows from y 500 moved down 90 px.
- **`generated/cheby-coefs.js`** (one instance per slot, arg = offset 0 / 64): `preset i`, `bright f`, `mode 0/1`,
  `srcchanged`. Writes `c * b^(degree - lowest degree)`, renormalised to sum |c| = 1, into `buffer~ chebcoef 10`
  (idx = offset + m * 8 + n). Presets: saw, square, hollow xy, cross, glass, bell (same table in the pre-flight tool --
  keep both in sync by hand). While mode = 1 it also emits `backup` | `exprfill 0 <polynomial>`, `bang` | `restore`.
  The expression is generated (Horner in x*x, 240-730 chars, verified against numpy chebval2d to 2e-5); a Task debounces
  redraws by 60 ms during a BRIGHT drag.
- **p terrain-source / -b:** `receive tsyn-chebfill<A|B>` -> `route backup restore`: backup = source-1 store copied to
  `tsrc<A|B>bak`; unmatched (`exprfill`, `bang`) -> source-1 store -> existing compose -> terrain matrix -> 3D view +
  terrainbuf; restore = the saved matrix back into the store (no regenerate: noise keeps its roll, the image source opens
  no dialog). Inlet 0 also -> `deferlow` -> `srcchanged` -> `send tsyn-chebsrc<A|B>` so a source change made in CHEBY
  mode is re-saved and the polynomial redrawn. MORPH / RIPPLE still draw on top of the polynomial but are inaudible in
  CHEBY mode (the core reads only chebcoef).
- **Main 4.16 / 4.17:** toggle -> `t i i i` (right to left: `sel 1` -> `0` -> shape menu | `prepend mode` -> js | `i` ->
  `prepend mode<A|B>` -> `send tsyn-cheby`); `receive tsyn-resend` bangs the `i` so reloaded voices get the mode. Preset
  umenu, BRIGHT dial (`/ 127.`, default 100 = 0.79). Presentation: 3D VIEW panel narrowed to [511, 410, 214, 108] (its
  110 Hz note wraps under ON), new CHEBY CORE panel [733, 410, 157, 108], columns A / B 76 px apart: toggle, preset menu,
  32 px dial + readout. Window size unchanged (900 x 1048). Presentation exclusions: unchanged (bench flonums only).

Unverified in MAX: everything -- gen~ compile of the codebox (for loops with loop-carried locals, poke-then-peek on Data
in one sample, `i * fr` with the loop index), `sig~ #1` / `receive #2` abstraction args, a ~700-char `exprfill` symbol
from js, named-matrix backup / restore, js `Task` debounce, umenu at fontsize 10 in 72 px, CPU of 2 cores x 8 voices at
2x (expect the cheby sum to cost several times a terrain read while a slot is in CHEBY mode, ~0 when off), level of the
cheby core against the tanh-driven terrain core.

### v0.12.0 confirmed in MAX (2026-09-21)

User: "ok it seems to work" (checklist items not itemised). Confirmed at least: terrain-cheby codebox compiles (two flat
constant-bound for loops with loop-carried locals, poke-then-peek on Data within one sample, loop index in float math,
History cursor), `sig~ #1` / `receive #2` abstraction args inside `poly~ ... up 2`, per-slot line~-driven select gen~,
js-generated long `exprfill` symbol into a named jit.matrix, js Buffer pokes into `buffer~ chebcoef 10`. Not reported:
CPU with both slots in CHEBY, cheby vs terrain level, backup / restore edge cases, alias A/B at the top of the keyboard.

## Build v0.13.0 (2026-09-21) -- more orbit shapes

SHAPE menu (A + B, bench menu in terrain-osc-test) grows from 3 to 8; indices 0-2 unchanged. No new controls: every new
shape reuses LOBES / LOBE AMT, so the presentation layout is untouched. The 3D view's helper terrain-osc draws them for free.

| idx | shape | curve (unit, before rx / ry / rot / zoom) | LOBES | LOBE AMT | top partial (integer LOBES) |
|-----|-------|-------------------------------------------|-------|----------|-----------------------------|
| 3 | lissajous | `cos(th)`, `sin(L th + a * pi/2)` | y rate | phase 0-90 deg | L f |
| 4 | rose | `r = (1 - a) + a cos(L th)` on the circle | bumps (at depth 1: L petals odd L, 2L even L) | depth (1 = passes through the centre) | (L + 1) f |
| 5 | hypotrochoid | `(cos th + a cos L th, sin th - a sin L th) / (1 + a)` -- counter-rotating epicycle, L + 1 cusps | epicycle rate | size | L f |
| 6 | spiral | `r = 1 - a (0.5 - 0.5 cos th)`, angle `L th` -- winds in and back out, closed | turns per cycle | inward depth | (L + 1) f |
| 7 | polygon | `r = 1 + a (cos(pi/n) / cos(pa - pi/n) - 1)`, `n = max(round(L), 3)` | sides (snapped) | circle -> polygon | never bandlimited |

- All |ux|, |uy| <= 1 and closed at integer LOBES (numpy sweep, L = 1 ... 16, a = 0 / 0.4 / 1). Non-integer LOBES jumps at
  the phase wrap exactly like the epitrochoid always has (sync-like buzz); polygon snaps its side count so it never jumps.
- **Spiral at LOBE AMT 0 is a circle traversed L times -> pitch reads L * f.** Depth > 0 brings the fundamental back.
- Codebox: `cos / sin` of `th` and `lobes * th` computed once and shared by all shapes (ellipse / epitrochoid / squarcle
  are the same math as before). Polygon setup (`pn -> seg`) is a dependent Param-only chain, so `lobes` goes through
  `History one(1)` (`kl = lobes * one`) -- the reverse-delay v0.3.3 de-hoist form. Sequential range-test ifs, `rr` / `pn` /
  `seg` / `pa` initialised before the blocks, spaces only, no else-if.
- terrain-cheby: `shape` max 7; limiter `fh` = `f * lobes` for 1 / 3 / 5, `f * (lobes + 1)` for 4 / 6, `f` otherwise
  (lissajous bound is conservative: x runs at f). CHEBY-on still snaps to ellipse; the two patching notes were reworded.
- Critic: no new findings (the one blocker, a jit.matrix fan-out in the terrain-osc-test bench, predates this edit).

Unverified in MAX: gen~ compile of the three edited codeboxes (notably `History one(1)` + polygon chain, `pi` constant),
CPU of 4 unconditional trig calls per voice-slot (was 2 for ellipse, 6 for epitrochoid), umenu 8 entries at 120 px.

## Build v0.14.0 (2026-09-21) -- more terrains

Nine analytic terrains appended to all four source menus (A / B x source 1 / source 2) as indices 7-15; indices 0-6 and
the load defaults (A = 0, B = 1) are unchanged. No new controls, presentation untouched. DETAIL / REGEN do nothing on them
(same as the original four analytic terrains). All signed, numpy range-checked inside -1..1 on the 256 grid.

| idx | name | formula (x = snorm[0], y = snorm[1], r = hypot) | character |
|-----|------|--------------------------------------------------|-----------|
| 7 | peaks | MATLAB `peaks` at 3x / 3y, * 0.122 | smooth, mellow; timbre moves a lot with orbit centre |
| 8 | spiral | `sin(r PI 5 + 3 atan2(y, x))` | 3 arms; ROTATE = phase, RADIUS = brightness |
| 9 | egg crate | `tanh(4 sin(4 PI x) sin(4 PI y))` | squared-off cells, bright / hollow |
| 10 | ridges | `1 - 2 abs(sin(3 PI x + 1.5 cos(2 PI y)))` | creased, buzzy |
| 11 | pyramids | `asin(sin(3 PI x)) asin(sin(3 PI y)) * 0.405` | triangle-wave product, odd-harmonic |
| 12 | drumhead | `1.2 sin(8 PI r) / (1 + 4 r)` | decaying rings; centred orbit is near-DC, offset the centre |
| 13 | wave packet | `exp(-3 r^2) sin(8 PI x + 3 PI y)` | Gabor; loud at the centre, silent at the edges |
| 14 | interference | two ring sources at x = +/-0.5, averaged | moire |
| 15 | terraces | `floor(4 sin(2 PI x) cos(1.5 PI y)) / 4 + 0.125` | stepped, deliberately harsh / aliasing |

- **Wiring:** zero edits to existing objects. Each generator block's `select 0 1 2 3 4 5 6` had a free unmatched outlet
  (7), which passes the int through -> new `p more-terrains` (`select 7 ... 15` -> 9 `exprfill 0 <expr>, bang` messages)
  -> that block's source store (`tsrc<A|B><1|2>`), so compose / 3D view / buffer bridge / cheby `srcchanged` all follow.
- **Binary functions in a message box** use the escaped-comma form found in the shipped Jitter examples
  (`exprfill hypot(snorm[0]\,snorm[1])`, `jit.expr @expr ... atan2(snorm[1]\,snorm[0])`). On disk: `\\,` in JSON.
- Function names `exp`, `tanh`, `abs`, `asin`, `floor` come from the jit.op operator list that the jit.expr refpage
  points to; only `hypot`, `atan2`, `pow`, `sqrt`, `min`, `round` appear in shipped example expressions.
- Negation written `0.-(...)` inside `exp()` to avoid relying on unary minus.
- Critic: no new findings vs. the pre-edit patch.

Unverified in MAX: every new expression (a bad function name would give a flat / black terrain, the v0.2.2 failure shape),
escaped commas surviving the message box, the 2900 px wide `peaks` message, 16-entry umenu at 100 px (source 2).

## Build v0.15.0 (2026-09-21) -- O-Strata parity (orbits + terrains, fixed shapes)

Compared against `Dev/VST-development/plugins/O-Strata/Source/dsp/Orbits.h` + `Terrains.h` (11 orbits, 6 terrains with
mx / my shape inputs). Already covered: ellipse, epitrochoid 3/5/7 (= LOBES 4/6/8, same curve up to a 45 deg rotation),
hypocycloid 3/5/7 (= hypotrochoid, LOBES 2/4/6, identical form), squarcle (ours is fixed pow 0.5, theirs tanh(k)/tanh k
-- left alone), sine product, radial rings, saddle (different formula). Added, at O-Strata's default mx = my = 0.5:

- **Orbits 8-10** (all three slots' menus + bench): `superellipse` (n = 0.5 + 5.5 * LOBE AMT: astroid -> circle at
  0.27 -> rounded square; gen~ `pow` per sample instead of O-Strata's LUT; max radius 2^(1/2 - 1/n) once n > 2, divided
  out), `limacon` (`(1 + 2a cos) / (1 + 2a)`, inner loop above a = 0.5), `butterfly` (Fay: `e^cos - 2 cos 4th +
  2a sin^5`; max radius 4.06 -> 4.38 over a, normalised by `4.06 + 0.33 a` instead of O-Strata's per-block 64-point
  scan; fills only ~0.77 of the box in x / y since it is radius-normalised). `ka = lobeamt * one` and `sn` go through
  the History so the superellipse `pow(2, 0.5 - 1/n)` chain is not hoisted. cheby limiter: limacon = 2 f (exact),
  butterfly = 4 f (O-Strata's nominal), superellipse = f (nominal, not bandlimited).
- **Terrains 16-18** (all four source menus, via the free unmatched outlet of `select 7 ... 15` -> `select 16 17 18`
  inside `p more-terrains`): `ridged cosines` `1 - |cos 3PI x| - |cos 3PI y|`, `mitsuhashi` (1982 via Mills & de
  Souza: triangle-wrapped `1.747 u (u^2 - 1)(w^2 - 1)`, tri written out with `floor` / `abs`), `cosine wells`
  `1 - 2 h^4`, `h = (1 + cos 3PI x cos 3PI y) / 2` (`pow(...\,4.)`, the shipped escaped-comma form; mean +0.67,
  dcblock handles it). F = 3 so the cell count matches our other analytic terrains.
- Not built (declined): the mx / my shape dials; tanh squarcle. Menus: shapes 11 entries, terrains 19.

Unverified in MAX: all of it, on top of v0.13.0 / v0.14.0 (also unverified). New gen~ risks: `pow` with a negative
exponent, `exp`, `abs` in codebox; `floor` and `pow(\,)` in exprfill.
