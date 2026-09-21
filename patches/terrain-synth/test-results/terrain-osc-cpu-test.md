# terrain-osc CPU test (slice 2, v0.3.0: single gen~ reading buffer~ terrainbuf)

Patch: `generated/terrain-osc-test.maxpat` (loads `poly~ terrain-osc-core N up M`, which wraps `terrain-osc.maxpat`).
gain~ loads at 100 (drag it if quiet); CPU readout is a flonum (values under 1 % are real).
Purpose: CPU of the single-codebox terrain oscillator (4 bilinear peeks + orbit math) per voice under poly~ @up, plus a first listen to trajectory feedback (`fb`) and the orbit-radius sweep.

## Sanity first

- jit.3m min/mean/max must differ (uniform terrain = silence). If they don't, click the exprfill message: analytic terrain, still silent => not the terrain.
- The orbit-x flonum must jitter with audio on. Frozen => freq never reached the poly~ instance (re-enter freq; check target 0).

## Protocol

1. Open the test patch with no other DSP running. Note the idle CPU % (adstatus cpu, 250 ms poll) with audio ON and voices = 1, 2x.
2. Terrain fills at load (`jit.bfg` basis `noise.gradient`, scale 0.02, 256x256 float32 `terrain`; the pwindow shows it through a display-only `jit.expr` 0.5*x+0.5). Confirm the jit.pwindow shows noise; press `regen` if not.
3. Set `freq` = 220, drive 1.5, defaults elsewhere. Confirm audio + scope shape changes when `rx`/`ry`/`shape` change.
4. For each row below: set `voices`, pick oversampling, then **re-enter freq** (both messages reload the poly~ instances; new instances start at the gen~ Param defaults, so also re-enter any param you changed). Wait 5 s, read the CPU number. Record the steady value, not the peak.
5. At 8 voices x 4x also set `freq` = 2000 and `rx` = `ry` = 0.5 -- read spectroscope~ for aliasing spray above the harmonic comb, and check whether `zoomk` (try 1000) cleans it up.

## Results (fill in)

| voices | up | CPU % | notes |
|---|---|---|---|
| 1 | 1x |  |  |
| 1 | 2x |  |  |
| 1 | 4x |  |  |
| 8 | 2x |  |  |
| 8 | 4x |  |  |
| 16 | 2x |  |  |

Machine / sample rate / vector size: 48 kHz (machine / vector size not recorded)

### User report (2026-09-21, v0.3.0)

Per-row numbers not recorded. Summary: "everything seems to work. cpu is staying low, around 3%
even with 8 voices" (oversampling setting for that reading not stated). Audio confirmed after
filling the terrain with the `exprfill` message -- matrix2buffer bridge + single-gen~ codebox
confirmed working in MAX.

**Decision:** ~3 % at 8 voices is far under the 15 % threshold -> keep the single-poly~ voice
(`poly~ terrain-voice 8 up 2`, wt-osc + terrain-osc + filter all oversampled together). No split,
no nearest-peek CPU-saver mode needed. 4x HQ toggle stays viable.

Open: whether the load-time `jit.bfg` noise fill produces a usable terrain without the manual
`exprfill` click was not confirmed.

## Decision rule

- 8 voices x 2x under ~15 % CPU: keep the single-poly~ voice (wt-osc + terrain-osc + filter all at 2x) as planned.
- 8 voices x 2x over ~15 % but 8 x 1x fine: split into two poly~ objects (wt at 1x, terrain at 2x/4x).
- 1 voice x 4x already heavy: drop to 2x and reduce the bilinear read to nearest (`peek` x1) for the CPU-saver mode.
