# Reverse Delay

A granular reverse delay for MAX 9, ported from the O-ReverseDelay VST. Incoming audio is written into a 14-second ring buffer; a scheduler continuously spawns overlapping grains that read that buffer *backwards*, so the delayed signal plays in reverse. Feedback closes through the same ring, so each regeneration flips direction again (reverse → forward → reverse…). The output is 100 % wet — mix it with the dry signal in your mixer.

Two patches, same engine:

| File | Input | Output |
|---|---|---|
| `generated/reverse-delay.maxpat` | stereo (`adc~ 1 2`) | stereo |
| `generated/reverse-delay-mono.maxpat` | mono (`adc~ 1`) | stereo |

The mono version has no **Source** menu; everything else is identical.

## Quick start

1. Open the patch, click the speaker icon to start audio.
2. Presets 1–6 are factory sounds (preset 1 *Reverse Bloom* loads automatically). Input and output faders are excluded from presets.
3. Start with **Grain** around 500–2000 ms and moderate **Density** for an obvious reversed sound. At short grain sizes (~200 ms) the stream reads forward with backwards attacks — a smear rather than a reversal.

## Signal flow

```
in → In gain → [ring buffer] → grain scheduler → grains (reverse read, windowed, panned)
                    ↑                                   │
                    │                                   ├──► wet L/R → Duck → Out gain → dac~
                    └── HP → LP → Diffusion → Drive ◄───┘ (loop sum × Feedback × Regen)
```

## Core parameters

| Parameter | Range | Default | What it does |
|---|---|---|---|
| **Time** | 50–4000 ms | 500 | Delay before a grain starts playing back the captured audio. Log-scaled dial. Overridden by the transport when **Sync** is on. |
| **Sync** | off / on | on | On: delay time is computed from the global transport BPM and **Division**. Falls back to the **Time** dial when the transport is stopped. |
| **Division** | 1/16 … 1/1 (incl. dotted and triplet) | 1/4 | Note value used in sync mode. `delay = beats × 60000 / bpm`, clamped 50–4000 ms. |
| **Run / BPM** | — | — | Start/stop the MAX global transport and set its tempo. |
| **Grain** | 50–4000 ms | 200 | Length of each reversed grain. Longer grains = longer continuous reversed passages; shorter grains = granular smear. Log-scaled. |
| **Density** | 0–100 % | 60 | How many grains overlap (2 at 0 %, up to **Grain Count** at 100 %). Low = sparse/rhythmic, high = smooth wash. |
| **Feedback** | 0–100 % | 40 | Amount of the grain output fed back into the ring. The loop is normalised so anything below 100 % always decays; 100 % is near-infinite sustain. |
| **Low Cut** | 20–2000 Hz | 100 | 2nd-order high-pass in the feedback path only. Thins out repeats with each pass. |
| **High Cut** | 500–20000 Hz | 8000 | 2nd-order low-pass in the feedback path only. Darkens repeats with each pass. |
| **Width** | 0–100 % | 60 | Stereo spread. Each new grain is panned alternately left/right by a random amount scaled by Width. 0 % = mono. |

## Advanced parameters

| Parameter | Range | Default | What it does |
|---|---|---|---|
| **Jitter** | 0–100 % | 0 | Randomises the interval between grain spawns (up to ±90 %). Breaks up the regular grain rhythm. |
| **Scatter ms** | 0–500 ms | 0 | Random ± offset on each grain's delay time. Smears the delay taps in time. |
| **Size Rand** | 0–100 % | 0 | Random ± variation of each grain's length. |
| **Gain Rand** | 0–100 % | 0 | Random level per grain (output only — does not affect feedback decay). |
| **Shape** | Hann / Tukey / Gaussian / Triangular / Expo-Decay | Hann | Grain window. Hann is smooth; Tukey has a flat top (see **Tukey a**); Gaussian is softer; Triangular is more percussive; Expo-Decay gives a sharp attack and exponential tail (reverse-cymbal style). |
| **Tilt** | 0–1 | 0.5 | Moves the window peak earlier (<0.5) or later (>0.5) within the grain. 0.5 is symmetric. |
| **Tukey a** | 0.01–1 | 0.5 | Tukey only: fraction of the window taken up by the fade-in/out. 1 = Hann, small values = near-rectangular. |
| **Grain Count** | 2–16 | 8 | Maximum number of simultaneous grains **Density** can reach. Higher = denser, more CPU. |
| **Direction** | 0–100 % | 0 | Probability that a grain plays *forward* instead of reversed. 0 = fully reversed, 100 = a normal granular delay, 50 = a mix. |
| **Regen dB** | 0–6 dB | 0 | Extra gain in the feedback loop before the filters. Use with Feedback below 100 % to lengthen tails without runaway. |
| **Source** *(stereo patch only)* | Mono Sum / Stereo | Mono Sum | Mono Sum: grains read the L+R sum. Stereo: each grain reads from one input channel, alternating with the pan sign. |
| **Duck** | 0–100 % | 0 | Sidechain-style ducking of the wet output by the dry input level (5 ms attack, 250 ms release). Keeps the effect out of the way while you play and lets it bloom in the gaps. |
| **Drift Rate** | 0.02–5 Hz | 0.30 | Speed of a slow LFO modulating the delay time. |
| **Drift Depth** | 0–100 % | 0 | Depth of that modulation, up to ±25 % of the delay time. Adds movement / chorus-like wobble to repeats. |
| **Diffusion** | 0–100 % | 0 | Wet/dry mix of four Schroeder allpasses in the feedback path. Smears repeats into a reverb-like haze. |
| **Drive** | 0–100 % | 0 | `tanh` saturation in the feedback loop (up to 8× drive, gain-normalised). Adds grit to repeats; higher Drive makes repeats decay slightly faster. |

## I/O

- **In gain / Out gain** faders (stereo pair is linked in the stereo patch) with meters. Not stored in presets; both reset to unity on load.
- Output is wet only — there is no Mix control (removed in v0.2.0).

## Factory presets

1. **Reverse Bloom** — default, medium grains, moderate feedback
2. **Guitar Swell** — slower, longer grains for pad-like swells
3. **Slow Wash** — long grains, high feedback, wide
4. **Tight Smear** — short grains, high density
5. **Dark Cavern** — low high-cut, long feedback tail
6. **Rhythmic Reverse** — sync on, dotted 1/8
7. *(user slot)*

## Notes

- Nothing inside a grain is smoothed; all per-grain values (time, size, gains, pan, direction) are latched at spawn. This is what keeps parameter changes click-free.
- The randomised and level-dependent parameters (Gain Rand, Duck, forward-grain normalisation) act on the output only, so they never change the feedback decay rate.
- Engine: a single `gen~` codebox (32-grain pool, per-sample scheduler). The stereo and mono patches share it verbatim apart from the input stage.
