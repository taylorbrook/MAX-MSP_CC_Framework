# terrain-osc CPU test (slice 2, v0.2.0)

Patch: `generated/terrain-osc-test.maxpat` (loads `poly~ terrain-osc-core N up M`, which wraps `terrain-osc.maxpat`).
Purpose: retire risk #1 -- CPU of `jit.peek~` inside an upsampled `poly~` per voice -- before the voice architecture is locked.

## Protocol

1. Open the test patch with no other DSP running. Note the idle CPU % (adstatus cpu, 250 ms poll) with audio ON and voices = 1, 2x.
2. Terrain fills at load (perlin, 256x256 float32 `terrain`). Confirm the jit.pwindow shows noise; press `regen` if not.
3. Set `freq` = 220, drive 1.5, defaults elsewhere. Confirm audio + scope shape changes when `rx`/`ry`/`shape` change.
4. For each row below: set `voices`, pick oversampling, then **re-enter freq** (new instances need `target 0` + freq). Wait 5 s, read the CPU number. Record the steady value, not the peak.
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

Machine / sample rate / vector size:

## Decision rule

- 8 voices x 2x under ~15 % CPU: keep the single-poly~ voice (wt-osc + terrain-osc + filter all at 2x) as planned.
- 8 voices x 2x over ~15 % but 8 x 1x fine: split into two poly~ objects (wt at 1x, terrain at 2x/4x).
- 1 voice x 4x already heavy: jit.peek~ is the bottleneck; try a gen~ `Data`/`peek` copy of the terrain instead (jit.matrix -> buffer~ bridge) before changing the orbit design.
