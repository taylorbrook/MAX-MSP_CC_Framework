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
- **Voice slots: A = wt-osc, B = terrain-osc, mix dial.** Fixed roles, one instance of each engine
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
