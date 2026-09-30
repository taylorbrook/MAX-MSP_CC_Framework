# timestretch

Granular time-stretching instrument built in gen~ with both real-time and offline modes.

## Requirements

- **Audio source:** Both live audio input AND pre-loaded buffer (switchable)
- **Algorithm:** Granular (overlap-add), implemented in gen~ for maximum quality and flexibility
- **UI:** Full presentation mode -- waveform display, playback position, grain visualization, preset recall
- **Modes:**
  - Real-time: continuous granular stretching of live input
  - Offline/triggered: stretch a loaded buffer on demand
- **Research mandate:** Investigate commercial, open-source, and academic timestretch algorithms to inform the gen~ implementation -- prioritize quality and flexibility

## Signal Flow

```
[live input / buffer~] → [grain engine (gen~)] → [output mix] → [dac~]
                              ↑
                     [stretch ratio, grain size, window shape,
                      pitch shift, grain density, randomization]
```

## Key Design Decisions

- gen~ codebox for the grain engine core (sample-rate precision, single-sample feedback)
- Buffer~ for file playback source, live input via adc~ for real-time mode
- Overlap-add with configurable grain density and scatter (Hann window)
- Waveform~ for visual feedback of playback position

---

## Research Findings

### Algorithm Selection: WSOLA-Enhanced Granular OLA

After surveying commercial (Elastique, Ableton, Paul Stretch, Serato, iZotope Radius), open-source (Rubber Band, SoundTouch, SuperCollider, Csound), and academic literature (Verhelst & Roelands 1993, Moulines & Charpentier 1990, Laroche & Dolson 1999, Roads 2001, Driedger & Muller 2016), the recommended approach is:

**WSOLA-enhanced synchronous granular overlap-add** -- this provides the best quality-to-complexity ratio for a gen~ implementation, combining:

1. **Synchronous granular OLA** (the proven Warp1/syncgrain model) as the core
2. **WSOLA cross-correlation search** at grain launch for optimal phase alignment (the single biggest quality improvement over naive OLA -- Verhelst & Roelands 1993)
3. **Transient-adaptive grain sizing** (shorter grains at transients, longer in steady-state -- informed by Roebel 2003, Duxbury et al. 2003)
4. **Quasi-synchronous emission** with jitter to eliminate periodic artifacts (Roads 2001)

This avoids the complexity of a full phase vocoder (Rubber Band R3 uses multi-resolution FFT with HPSS bin classification -- overkill for gen~) while surpassing basic granular quality.

### Key Insights from Research

**From commercial implementations:**
- Elastique's core innovation: transient/tonal decomposition with separate processing paths (US Patent 8,805,697 B2). We adapt this as adaptive grain sizing rather than full signal separation.
- Paul Stretch: phase randomization for extreme ratios (>8x). Simple to add as an optional mode -- randomize grain start positions with large scatter.
- iZotope Radius: multi-resolution approach (multiple FFT sizes). We approximate this with adaptive grain size.
- Ableton's best modes (Complex/Complex Pro) are phase vocoders, not granular. Their granular modes (Tones/Texture) are creative tools. Our approach targets the gap: granular quality approaching spectral methods.

**From open-source codebases:**
- SuperCollider Warp1: recursive second-order Hann envelope generation (`b1 = 2*cos(2*PI/N); y0 = b1*y1 - y2; amp = y1*y1`) -- zero table memory, perfect Hann. Directly applicable to gen~.
- SoundTouch WSOLA: cross-correlation search with center-bias heuristic (`corr *= (1 - 0.25*tmp*tmp)`). Grain size 40-90ms auto-tuned, seek window 15-20ms, overlap 8ms.
- Rubber Band R3: frequency-dependent phase locking (tight beta for low frequencies, loose for high). The HPSS bin classification (horizontal/vertical median filtering) is the gold standard but too complex for gen~.
- Csound syncgrain: `kprate` (pointer rate) as the time-stretch mechanism -- read pointer advances in "grain units". Clean model for gen~.

**From academic literature:**
- COLA constraint: Hann window at 50% or 75% overlap gives perfect constant-amplitude reconstruction. This is non-negotiable for artifact-free output.
- WSOLA tolerance window: +/-128 samples is sufficient for most material. Larger tolerance = better phase alignment but more temporal smearing.
- Grain density regimes (Roads): 50-200 grains/sec for tonal fusion. Below 20/sec = pointillistic. Above 500/sec = texture/noise.
- Driedger & Muller (2016) survey finding: WSOLA and phase-locked phase vocoder produce comparable quality for moderate stretch (0.5x-2x). Phase vocoder is only definitively better at extreme ratios (>4x).

### As built (v0.6.2)

The original plan (8 voices, selectable Hann/Tukey/Gaussian windows, "quality tiers", 8 preset slots) was superseded during the build. This section describes what exists.

```
adc~ 1 2 -> selector~ x2 (source menu) -> gen~ in1/in2        buffer~ timestretch-source (read by gen~ directly)
                                            |
     gen~ codebox: out1 L, out5 R -> *~ (line~ gain) -> dac~ 1 2 + levelmeter~ x2
                   out2 transient flag -> snapshot~ -> indicator
                   out3 read position (ms, -1 when not in buffer mode) -> waveform~ `line`
                   out4 end-of-file -> snapshot~/change/select -> s ts-stop -> Play toggle off
All control messages reach gen~ inlet 0 through `s ts-gen` / `r ts-gen`.
```

**Engine (single codebox):**
- Source modes: 0 none, 1 live (stereo 524288-sample ring buffer, ~11 s @ 48k), 2 buffer (mono or stereo file; mono duplicates to R).
- 16 grain voices, Hann window only, linear interpolation, output normalised by max(sum of windows, density/2). Density 2/4/8 sets the overlap (hop = grain / density).
- WSOLA: the reference is where the previous grain will be at the next launch. Correlation is 128 points at stride 3·speed on L+R, coarse ±tol in 4-sample steps (centre-out), then ±3 fine, normalised, with a centre bias. Amortised at 64 points/sample.
- Live read head: clamped to write head minus latency (~47 ms at defaults, more with long grains/tol/pitch-up). Jumps back to "now" when stretch > 1 drains the ring buffer.
- Adaptive: shorter grains around detected transients. Preserve: onsets play through at 1x with the time paid back afterwards (buffer mode keeps the long-term stretch exact). Extreme: ±1 grain position scatter, WSOLA off. Freeze: holds the read point (live: recording stops too).
- File sample rate comes from info~ (`bufsr`), so pitch and speed are correct for any file rate. Waveform selection -> `sel_a` / `sel_b` (click = seek, drag = loop region).

**Parameters (gen~ Params):**

| Param | Range | UI |
|---|---|---|
| stretch | 0.25 - 16 (1x at 12 o'clock) | Stretch dial |
| grain_ms | 5 - 200 | Grain dial |
| pitch | ±2400 cents | Pitch dial |
| wsola_tol | 0 - 256 samples | WSOLA dial |
| jitter_amt | 0 - 0.25 (fraction of hop) | Jitter dial |
| sensitivity | 0 - 1 | Sens dial |
| density | 2 / 4 / 8 | Density menu |
| adapt / preserve / extreme | 0/1 | toggles |
| mode | 0 / 1 / 2 | Source menu |
| playing / looping / freeze | 0/1 | Play, Loop, FREEZE |
| sel_a / sel_b | ms | waveform~ selection |
| bufsr | Hz | info~ after load |

**UI:** presentation card with the waveform + playhead, TIME / PITCH, QUALITY, OUTPUT (gain + L/R meters), SOURCE / transport and a preset object (Source, Play, Loop, FREEZE and the Transient light are excluded from presets).

### References

- Verhelst & Roelands (1993) -- WSOLA algorithm
- Moulines & Charpentier (1990) -- PSOLA
- Laroche & Dolson (1999) -- Phase-locked phase vocoder
- Roads (2001) -- Microsound / granular taxonomy
- Roebel (2003) -- Transient preservation
- Duxbury, Davies & Sandler (2003) -- Transient detection
- Driedger, Muller & Ewert (2014) -- Harmonic-percussive separation for TSM
- Driedger & Muller (2016) -- Review of TSM methods
- Gabor (1946) -- Acoustic quanta
- Truax (1988) -- Real-time granular synthesis
- SuperCollider GrainUGens -- Recursive Hann envelope
- SoundTouch TDStretch -- WSOLA reference implementation
- Rubber Band R3 -- Multi-resolution phase vocoder with HPSS

---

## v0.2.0 (2026-09-30) -- review fixes

- **Source modes:** gen~ `mode` Param is 0 none / 1 live / 2 buffer (umenu index sent directly). `groove~` removed -- gen~ reads the buffer itself.
- **Live read head:** ring buffer is 524288 samples (~11 s @ 48k). Read head is clamped to `wp - reach` (reach = grain span + WSOLA tolerance + search span; ~47 ms at defaults). When stretch > 1 drains the buffer, the read head jumps back to "now" (one brief level dip per lap, ~22 s at 2x).
- **WSOLA:** reference = where the previous grain will be at the next launch. Search spans 128 points at stride 3·speed, coarse ±tol in 4-sample steps (centre-out) then ±3 fine, normalised correlation with centre bias. Amortised at 64 points/sample (single constant-bound loop); if a hop is too short to finish, the best-so-far offset is used. A prediction mismatch (> 32 samples, e.g. after a lap jump or param change) skips alignment for that grain.
- **Voices:** 16 (adaptive mixes long + short grains; 8 was stolen from at density 8). A new grain takes a free slot, else the oldest. Output normalised by max(Σwindow, density/2).
- **Transport:** `playing` / `looping` Params. Non-loop end sets out4 -> snapshot~/change/select -> `s ts-stop` -> Play toggle off; next Play restarts from the top.
- **File rate:** buffer~ read-done -> info~ -> `bufsr $1`, so 44.1k files play at the correct pitch/speed on 48k.
- **Transients:** detected at the read head (tap 0.25 grain ahead), time constants scaled by stretch, held for max(grain, 60 ms).
- **Extreme:** scatter of ±1 grain around the read head, WSOLA off (not random whole-buffer positions).
- **UI:** waveform~ playhead via `line <ms>` from out3; Transient toggle ignoreclick; preset excludes Source/Play/Loop/Transient.
- Pre-flighted with a Python mirror of the codebox (file + live, stretch 1-4, ±1200 ct, adaptive, transport, bufsr).
- Deliberately unchanged: Stretch dial range stays 1-16 (Param accepts 0.25-16).

---

## v0.3.0 - v0.6.0 (2026-09-30) -- next-steps round

Built in four separate saves so a regression can be bisected per feature. Each was pre-flighted in the Python mirror; for every earlier setting, v0.6.0 output with Preserve off is bit-identical to v0.5.0.

- **v0.3.0 UI:** Stretch dial 0.25-16 with 1x at 12 o'clock (`parameter_exponent 4.39`, custom unit "x"). OUTPUT column (Gain + meters), Density moved into row 1, dark card panel + patcher `bgcolor`/`locked_bgcolor` (editing bg left at 0.333), descriptive varnames.
- **v0.4.0 buffer workflow:** waveform~ `outmode up` (loadmess). Selection start/end -> `sel_a`/`sel_b` (ms at the file rate). A click (< 10 ms wide) = seek, whole file loops; a drag = seek + loop region. Loading a file clears the selection (`t b b b`: gen reset, waveform `0 0`, then info~). FREEZE (live.text): file = read head held; live = recording stops too, so the frozen moment is kept indefinitely.
- **v0.5.0 stereo:** gen~ 2 in / 5 out, and **out5 = R** (out1-4 kept their meaning so existing wiring stayed). `Data circ(524288, 2)`, linked grains with WSOLA on L+R, mono files duplicate to R. adc~ 1 2 -> two selector~ driven by `t i i i`; second `*~` shares the line~ gain; second levelmeter~.
- **v0.6.0 Preserve:** the tap looks ahead 1 grain·speed + tol. A detected onset opens a window [onset - lead, onset + max(grain/2, 30 ms)) where the read head runs at 1x and grains launch exactly at rp (no jitter/WSOLA), so all grains read the same source time and the attack is reproduced. File mode: the read head slows on approach by the lead-in's gain and pays back leftover drift afterwards (τ 20 ms, ±50% rate), so onsets land on time (measured 1-17 ms at 2x/4x/8x). Window 1 + one queued slot; an overlapping onset extends the window. 50 ms refractory, 20 ms detector warm-up after seek/mode change/restart. Live mode: no timing payback (drift = 0).
- Known limits: an onset within the first lookahead after a seek/start can't be preserved. Dense onsets closer than about a grain + 50 ms merge into one longer 1x window. Uncorrelated L/R material can only be aligned on the sum.
