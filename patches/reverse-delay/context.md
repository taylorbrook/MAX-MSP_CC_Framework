# reverse-delay

gen~-based granular reverse delay, ported from the O-ReverseDelay VST (v1.8.1) at
`/Users/taylorbrook/Dev/VST-development/plugins/O-ReverseDelay`.

## Kickoff (2026-08-24, /max-new)

- **Scope:** full port of the VST feature set (all params).
- **Tempo sync:** global MAX transport (`transport` tempo) + note-division menu, plus free-ms mode.
- **UI:** presentation mode with overlay readouts + `preset` bar with factory presets (follow stereo-feedback-delay conventions).
- **I/O:** mono OR stereo in (adc~ 1/2, source mode Mono Sum / Stereo like the VST) → stereo out via dac~, input/output gain~ + meter~.

## VST DSP reference (distilled from source, NOT from the stale v1.0 planning docs)

### Parameters (25)
| id | range | default | unit | notes |
|---|---|---|---|---|
| delayTime | 50–4000 | 500 | ms | log-ish (skew centre 316) |
| syncMode | Free/Sync | Sync | — | |
| noteDivision | 13 entries | 1/4 (idx 6) | — | see table |
| grainSize | 50–4000 | 200 | ms | skew centre 316 |
| density | 0–100 | 60 | % | linear |
| feedback | 0–100 | 40 | % | smoothed 20 ms |
| lowCut | 20–2000 | 100 | Hz | skew 200, smoothed |
| highCut | 500–20000 | 8000 | Hz | skew 3162, smoothed |
| width | 0–100 | 60 | % | |
| mix | 0–100 | 35 | % | smoothed |
| jitter | 0–100 | 0 | % | spawn-interval jitter |
| delayScatter | 0–500 | 0 | ms | ± on latched D |
| sizeRandom | 0–100 | 0 | % | ± on latched G |
| gainRandom | 0–100 | 0 | % | output-only |
| grainTilt | 0–1 | 0.5 | — | window peak position |
| grainShape | Hann/Tukey/Gaussian/Triangular/Expo-Decay | Hann | — | |
| grainCount | 2–16 | 8 | — | overlap ceiling |
| tukeyTaper | 0.01–1 | 0.5 | α | Tukey only |
| freeze | bool | off | — | |
| direction | 0–100 | 0 | % | P(grain forward) |
| regenMakeup | 0–6 | 0 | dB | loop pre-gain |
| sourceMode | Mono Sum/Stereo | Mono Sum | — | |
| duck | 0–100 | 0 | % | wet-only ducking |
| driftRate | 0.02–5 | 0.30 | Hz | |
| driftDepth | 0–100 | 0 | % | ±25% of D at 100 |
| diffusion | 0–100 | 0 | % | allpass mix in loop |
| drive | 0–100 | 0 | % | loop saturator |

Divisions (beats, order is load-bearing): 1/16=.25, 1/16D=.375, 1/16T=1/6, 1/8=.5, 1/8D=.75, 1/8T=1/3, 1/4=1, 1/4D=1.5, 1/4T=2/3, 1/2=2, 1/2D=3, 1/2T=4/3, 1/1=4. `delayMs = beats*60000/max(1,bpm)` clamped [50,4000].

### Signal flow
- **Capture ring** (stereo, 14 s): `capture[w] = in + fbReturn`. Feedback closes through the same ring → regenerations alternate direction (intended). Ring must be ≥ `gD_max + 2*G_max` or long settings silently sound crunchy.
- **Scheduler:** `overlap = 2 + density*(grainCount-2)`; `interval = max(1, int(G/overlap))`; per-sample countdown. Jitter at spawn: `interval*(1 + 0.9*jitter*(2u-1))`. Overlap floor is 2 (at 1, Hann grains tremolo to silence).
- **Per-grain latch at spawn** (nothing below is smoothed — this is the click-free mechanism): `gD = int(D*driftMul) ± scatter`, clamped `[min(D, 50ms), ring - 2*G_max - 1]`; `gG = clamp(G*(1±sizeRandom))`; `readAbs = spawnAbs - gD`; `step = forward ? +1 : -1`; src channel; window geometry; four gains.
- **Reverse read:** readAbs steps -1 while the write head steps +1 (offset grows D+2n). Window: `p = n/gG`, tilt warp `t = 0.5+(tilt-0.5)*0.9; q = min(p,t)*0.5/t + max(p-t,0)*0.5/(1-t)`, Tukey remap `r = min(min(q,1-q)*2/α, 1)*0.5` into Hann. Gaussian σ=0.18 pedestal-subtracted; Expo-Decay 2% raised-cosine attack then e^{-5u}. `v = src*env*gain`; `wet += v*gOut; loop += v*gLoop`.
- **Two normalisation laws, never crossed:** output = power law `1/sqrt(overlap) * shapeNorm * tiltNorm`; loop = amplitude law `loopNorm(window mean) * loopCountTrim` where `loopCountTrim = overlap<=8 ? 1 : (overlap/8)^-0.5`. Output-only: gainRandom, duck, forwardNorm (`sqrt(q_eff/overlap)/m_eff`; forward grains sum coherently, +7.3 dB uncorrected). Loop-only: loopCountTrim. Anything randomised/level-dependent in the loop becomes a decay-rate control.
- **Feedback return** (tapped from loop sums): `g = fb * 10^(makeup/20)` → HP(lowCut) → LP(highCut) (2nd-order Butterworth, clamps [20,0.49fs]/[500,0.49fs]) → 4 Schroeder allpasses (`y = -0.7x + buf; buf = x + 0.7y`, 4.7/8.3/13.9/21.7 ms) as wet/dry MIX (never scale g) → `tanh(d*x)/d`, `d = 8^(drive)` (matches CLAUDE.md in-loop saturation rule). Non-finite guard resets filters + allpasses + zeroes fb.
- **Width:** `panSign` alternates per spawn; `spread = panSign*(0.5+0.5u)`; `pan = 0.5 + width*0.5*spread`; `gL = cos(pan*π/2), gR = sin(pan*π/2)`. Width also scales loop gain (worst-case stability at width 0).
- **Duck** (output only): `rect = 0.5(|dryL|+|dryR|)`, attack 5 ms / release 250 ms one-pole, NaN guard, `duckGain = 1 - depth*env/(env+0.1)`.
- **Mix:** `out = cos(m*π/2)*dry + sin(m*π/2)*duckGain*wet`.
- **Freeze:** keep writing but write back a copy of the ring (`freezeLoopSamples`, latched on rising edge); 20 ms content crossfade; fb computed then discarded. Stopping the write head buzzes; advancing without writing goes silent.
- **Pool:** 32 slots, refuse on exhaustion, never steal; scheduler countdown still advances.
- **RNG:** two xorshift32 streams (scheduler vs grain draws), fixed draw order scatter→size→gain→pan→direction, draws happen before pool request, zero-amount params draw nothing. Per-instance seed.
- **Smoothing (20 ms):** feedback, mix, lowCut, highCut, freeze only.
- Denormal flush on filter tails; latency 0.

### MAX-side equivalents needed
- BPM from `transport` (query on metro/`bang`), fallback to free delayTime when transport stopped/absent; note-division `umenu` → beats table → `delayMs` computed in MAX or in gen~.
- Param skew: gen~ Params are linear → apply dial mapping in MAX (`scale` with exponent) or expose 0–1 and curve inside.
- Grain pool: fixed 32 slots as `Data` arrays inside the codebox, single constant-bound `for` loop per sample (codebox-safe rule).
- Window LUTs: compute analytically per sample (cos/exp are cheap in gen~) rather than `Data` LUT init.

## Decisions (2026-08-24, /max-discuss)

- **UI:** Core + Advanced sections in presentation. Core row: time (ms dial), sync toggle, division umenu, grain size, density, feedback, low cut, high cut, width, mix. Advanced panel: jitter, scatter, size random, gain random, grain shape (umenu), tilt, tukey taper, grain count, direction, regen makeup, source mode, duck, drift rate, drift depth, diffusion, drive. Freeze slot reserved.
- **Freeze:** deferred to v0.2 (ring copy-back is the riskiest piece; verify the engine first).
- **Engine:** single gen~ codebox. `Data` ring (2ch, 14 s at 96k headroom) + `Data` per-slot arrays for a 32-slot grain pool; one constant-bound `for (i = 0; i < 32; i += 1)` per sample (codebox-safe). Feedback filters/allpasses/saturator live in the same codebox (single-sample loop).
- **Transport:** `transport` polled by `metro` → tempo → beats (umenu index → table) → `expr` → clamp 50–4000 → `delay_ms $1` into gen~. Sync toggle selects free dial vs computed; transport stopped falls back to free dial. Skew mapping for log-ish dials done on the MAX side.
- **RNG:** gen~ `noise()` (uniform ±1) instead of xorshift (no integer bit ops in GenExpr); draw discipline (order, zero-amount → no draw) kept in spirit but not bit-exact.

## Research (2026-08-24, /max-research)

All objects verified via `ObjectDatabase` (domain/IO checked).

### Top-level objects
- `adc~` (3 outlets; use 0/1) → input `gain~` ×2 (linked stereo pair per feedback_gain_linked_stereo) → `gen~` (2 signal inlets + param messages on inlet 0) → output `gain~` L/R → `dac~`. `meter~` side-by-side with each `gain~`.
- Params: `dial` → `scale` (with exponent arg for skewed ranges; `scale` has 6 inlets, 5th arg = exponent) → `message "name $1"` → gen~ inlet 0. Overlay `flonum` readouts (Rule #6).
- Menus: `umenu` (1 in, 3 out; outlet 0 = index) for division, grainShape, sourceMode. Items use comma-element format.
- Transport: `transport` (2 in, 9 out; outlet 4 = tempo, outlet 6 = state). `metro 100` bangs `transport` inlet 0 to poll. `expr` computes `beats*60000/max(1,$f2)` clamped with `min(max(...))` (no `clip()` in expr). `gate`/`switch` selects free vs sync value from `toggle`. All control-rate; no known IO gaps (`transport` outlets are typed control, not signal).
- `preset` (1 in, 5 out) scoped by cords to all param dials/umenus/toggles; gain~ excluded (same convention as stereo-feedback-delay; the fan-out critic warning on preset cords is a known false positive).
- Encapsulate transport/sync math in `p sync`, division/beats lookup in `coll` or `sel`-free `zl lookup` — pick `zl lookup` with a loadbang'd 13-element list (verified: `zl` 2 in / 2 out).

### gen~ engine (single codebox) — proven idioms in this repo
- `timestretch` (v0.1.7, in MAX): `Data circ(131072)` ring + parallel `Data gactive(8)/gpos(8)/gphase(8)/gsize(8)` grain slots with `for (i = 0; i < 8; i += 1)`, `peek`/`poke` with explicit channel arg. Scale to 32 slots + 2-channel ring: `Data ring(1344001, 2)` (14 s @ 96k) — `Data` sizes must be constant literals.
- `noise()` for uniform randomness (16 uses in repo); `samplerate` constant (74 uses). `cos`, `exp`, `tanh`, `sqrt`, `pow`, `abs`, `floor`, `wrap`, `clamp`, `mix`, `dcblock` all available in GenExpr.
- Filters: hand-rolled RBJ Butterworth biquads (HP/LP) as History pairs; coefficients computed per sample from smoothed cutoffs (cheap; removes the 32-sample grid caveat). Allpass diffusion as 4 `Delay` lines with constant max sizes (`Delay ap1(2200)` etc. ≥ 21.7 ms @ 96k), mixed wet/dry. Saturator `tanh(d*x)/d` — matches CLAUDE.md in-loop rule.
- Per-sample ordering inside the codebox: (1) advance smoothers, (2) scheduler countdown → spawn (latch gD/gG/step/gains/pan, draws before pool request, refuse if 32 slots busy), (3) loop over slots: read ring at `readAbs` (mono-sum or channel), window analytic (Hann/Tukey/Gaussian/Triangular/Expo via `if`/`else` — no `else if`), accumulate wet/loop sums, (4) feedback chain on loop sums, (5) write `in + fb` to ring, (6) duck + equal-power mix → out1/out2.
- Codebox safety: spaces only, no `else if`, all declarations first, single non-nested constant-bound loop, `Data` indices via `floor` + `wrap`.
- Pre-flight: numpy simulation of the loop gain laws (loopNorm × loopCountTrim × width pan) to confirm feedback<1 always decays before committing (per CLAUDE.md in-loop saturation/feedback lessons).

### Risks
- CPU: 32 slot iterations/sample with 5-way window branch ≈ heavy but gen~ handles it; if it stutters, reduce pool to 16 via the `Data` size constant.
- `Data` ring of 1.34M×2 doubles ≈ 21 MB — acceptable; alternatively 14 s @ 48k (672001) if memory matters.

## Build notes (2026-08-24, /max-build v0.1.0)

- Engine: single gen~ codebox (`varname rdgen`), 24 linear Params; `Data ring(1344000, 2)` + 17 `Data(32)` slot arrays; spawn folded into the single 32-slot render loop (first free slot, refuse when full). Window duty constants hardcoded from a 2048-pt table integration (Hann/Gauss/Tri/Expo; Tukey closed-form `1-0.625a` / `1-0.5a`). HP/LP = RBJ Butterworth biquads (TDF2) with per-sample coefficients; 4+4 Schroeder allpasses as `Delay` lines; `tanh(d*x)/d`.
- Loop-gain pre-flight (numpy overlap-add, width 0, all shapes, overlap 2–16): mean loop amplitude gain <= 1.004 x feedback, so feedback < 1 always decays; feedback = 1 is near-unity by design (VST law).
- MAX side: dial -> `expr lo + range * pow($f1/127.\, k)` for JUCE-skewed params (k = 1/skew from centre: time/grain 3.892, lowCut 3.46, highCut 2.873, driftRate 4.152); `scale 0 127 lo hi` for linear. flonum readouts sit under dials (stereo-feedback-delay convention) and are editable.
- `p sync`: metro 100 polls `transport`; `zl lookup` (0-based) maps division index -> beats; `pak` -> `expr` clamps 50–4000; selector `expr ($i3*$i4>0)*$f2 + ...` falls back to the free dial when sync is off or transport stopped; `change` dedupes. Run toggle + BPM flonum drive the global transport. **Verify in MAX:** `zl lookup` 0-based indexing (1/4 must yield 1 beat).
- Init: loadbang -> `t b b` -> `128` (`t i i` -> both gain~ pairs) then `1` -> preset (recall Reverse Bloom). Preset scope: 22 dials + shape/source/division umenus + sync toggle; gain~ excluded.
- Presets (dial ints quantise skewed values by ~±2%): 1 Reverse Bloom, 2 Guitar Swell, 3 Slow Wash, 4 Tight Smear, 5 Dark Cavern, 6 Rhythmic Reverse (sync on, 1/8D).
- Critic residue accepted: preset fan-out (known false positive), `p sync` hot/cold (inner `pak` is all-hot), message->gen~ control-to-signal warnings (param pattern).
- DB fix: `pak` gained `variable_io` + `arg_count` rule in overrides.json (was fixed at 2 inlets).
- v0.1.1 (2026-08-24): linear `scale` boxes had int bounds (`scale 0 127 0 1`) → int output, dials snapped 0/1. All bounds now floats (`0. 1.`). Rule: always write `scale`/`expr` bounds with a trailing dot unless integer output is intended (Grain Count).
