# amplitude-follower — Context

## Kickoff (2026-08-21)

Simple RMS amplitude follower with a smoothing parameter, built in gen~. Smoothness
over snappiness — latency is not a concern.

- **Input:** live audio via `adc~` only (no test source, no sample player)
- **Output:** continuous signal, clamped 0–1, usable as a modulation source
- **Smoothing:** single parameter, time in milliseconds (symmetric attack/release)
- **UI:** minimal — flonum for smoothing ms, small display for verification
- **Signal delivery:** kept inline — signal ends at a `number~` display; user will
  copy the gen~ into other patches when needed (no send~, no abstraction outlets)

## Design Decisions

- **RMS via one-pole averaging in gen~ codebox:** square input → one-pole lowpass
  (mean-square) → sqrt → clamp 0..1. This is the standard smooth RMS estimator;
  no windowed buffer needed since latency doesn't matter.
- **Coefficient from ms param:** `a = exp(-1 / (smooth_ms * 0.001 * samplerate))`,
  computed per-sample in the codebox (cheap, avoids param-change glitches).
  `History` holds the mean-square state.
- **Param:** `Param smooth(100, min=1, max=5000)` — ms. Set from MAX via
  `smooth $1` message (no `@` prefix, per CLAUDE.md gen~ rules).
- **Display:** `number~` on the gen~ output for verification. `scope~` skipped
  (empty I/O in DB; number~ suffices for a minimal patch).
- **Signal termination:** output chain ends at `number~` (a signal sink) — no dac~
  connection needed; nothing routes to speakers.

## Research

- All required objects verified in DB: `adc~` (3 out), `gen~` (variable I/O),
  `number~` (2 in / 2 out), `flonum`, `comment`.
- gen~ codebox rules from CLAUDE.md apply: declarations first (Param, then
  History), spaces only, no else-if chains, plain if/else fine.
- Mono follower on adc~ left channel (outlet 0). Stereo could sum/average later
  if requested — out of scope for v1.

## v0.2.0 — Range expansion (2026-08-21)

User found raw RMS mostly sat in 0–0.2. Added two-stage output shaping in the codebox:
1. **dB mapping:** `db = 20*log10(max(rms, 1e-5))`, then `lin = clamp((db - floordb) / -floordb, 0, 1)`.
   `Param floordb(-60, min=-96, max=-6)` — the level that maps to 0.
2. **Exponent curve:** `out1 = pow(lin, curve)`, `Param curve(1, min=0.1, max=4)` for extra shaping.

Param renamed `floordb` (not `floor` — GenExpr builtin collision). Two new flonum chains
(`floordb $1`, `curve $1`); loadbang fan-out now goes through `t b b b`. User's own MAX
edits (added meter~, repositioned boxes) preserved via surgical edit.

## v0.3.0 — Presentation mode (2026-08-21)

272x152 panel, opens in presentation (`openinpresentation: 1`). Layout: title;
row of three labeled flonums (smooth ms / floor dB / curve); input meter~ below;
number~ RMS readout + label at bottom. All interactive widgets covered — no
deliberate exclusions. Presentation attrs written to box._raw (round-trip
overlay drops plain attr mutations) and verified on disk after save.

## v0.3.1 — S-curve (2026-08-21)

Replaced `pow(lin, curve)` with Schlick gain: `lin^k / (lin^k + (1-lin)^k)` on the
same `curve` param (0.1–4). k=1 identity, k>1 = S (mid expansion, floor squash),
k<1 = inverse-S. Denominator can't hit zero for lin in [0,1]. Label updated to
"curve (S)". Chosen over pow: symmetric mid-range contrast + soft-gates the noise
floor, pairs better with the dB map.

## v0.4.0 — Noise response fix (2026-08-23)

User: works well for pitched sound, noise reads very low. Cause: crest factor —
noise RMS sits 9–12 dB below its peaks vs 3 dB for a sine, so RMS understates
noisy input. Fix: added a peak-envelope branch in the codebox —
`pk = max(abs(in1), pk1 * a)` (instant attack, release = smooth coeff), scaled
by 0.7071 so a sine reads identically through either branch, then one-pole
smoothed (keeps attack smooth) and combined via `env = max(rms, pks)`. Pitched
behavior unchanged (sine: peak*0.7071 == RMS); noise lifted by its crest factor.
Readout label updated to "amplitude 0-1 (RMS/peak)". Note: versions.json had
lost 0.2.0–0.3.1 history; corrected this bump from auto-computed 0.1.0 to 0.4.0.

## v0.4.1 (2026-08-23) — HF loudness weighting (port of spectraldetector v0.2.4)

Sustained fricative-type noise ("sh", hiss) reads far below its perceived loudness on a flat detector — its energy sits above 1 kHz where the ear is most sensitive. Added an HF-weighted branch: onepole HP at ~1.2 kHz (coeff exp(-2pi*1200/sr)) on the input, peak-followed and one-pole smoothed exactly like the existing main peak branch (both paced by the `smooth` param), weighted x4 (+12 dB); `env = max(env, pfs)`. New Histories: hbx, hby, pkf1, pfs1. Low/mid pitched material unaffected; hiss/room tone reads ~+9-12 dB hotter, so `floordb` settings may need to come up. Also applied to both gen~ copies in the user's 0_Burnt.maxpat (p ampfollow).
