# subtractive-synth

Project context and notes.

## Kickoff (2026-07-04)

**Brief:** Basic subtractive synth with all the classic controls.

**Decisions (defaults chosen — user AFK during kickoff):**
- **Note input:** MIDI `notein` + on-screen `kslider` for testing without a controller
- **Voices:** Monophonic (classic mono-synth, last-note priority)
- **Controls in scope:**
  - 2 oscillators: waveform select (saw/square/tri/sine), detune
  - Filter: cutoff + resonance
  - Amp ADSR envelope
  - Filter ADSR envelope with envelope-amount control
  - LFO: rate + depth, routable to pitch or cutoff
  - Master level
- **DSP approach:** Native MSP objects (no gen~ core)
- **UI:** Yes — labeled dials/controls, patch usable from patching view

## Decisions (max-discuss, 2026-07-04 — defaults, user AFK)

All objects below verified in the object database (Rule #1 pass complete).

### Signal flow architecture
```
notein ─┬→ stripnote → ddg.mono (mono, last-note priority) ─┬→ mtof → pack f $glide → line~  (portamento)
kslider ┘                                                    └→ velocity → adsr~ triggers
pitch signal + LFO pitch-mod (*~ depth) → OSC1 & OSC2 (osc2 detuned, +~ detune Hz offset)
OSC1/OSC2: selector~ 4 over saw~ / rect~ / tri~ / cycle~ (all running, umenu selects)
osc mix (+ noise~ * noise-level) → lores~ → *~ (amp adsr~) → gain~ → ezdac~
```

### Object selection
- **Note input:** `notein` + `kslider` merged → `stripnote` → `ddg.mono` for mono last-note priority (handles held-note retrigger correctly; hand-rolled mono logic rejected)
- **Pitch:** `mtof` → `pack 0. 20` → `line~` — line~ ramp time IS the glide control (dial in ms). `rampsmooth~` rejected (sample-based, awkward ms mapping); `lag~` does not exist in MAX (PD-ism)
- **Oscillators:** band-limited `saw~`, `rect~`, `tri~` + `cycle~`, one `selector~ 4` per osc, `umenu` (Saw/Square/Tri/Sine) → selector~. Osc2 detune: `+~` Hz offset before osc2 input (simple beating detune, ±25 Hz dial)
- **Noise:** `noise~` with its own level dial (0–1) into the mix
- **Filter:** `lores~` — classic resonant lowpass, cutoff (signal) + resonance (0–1). `svf~` rejected for v1 (multimode not in scope)
- **Envelopes:** two `adsr~` (signal-rate). Amp env → `*~` after filter. Filter env → `*~ envAmount` → `+~` cutoff base. Trigger both from velocity/127. `function`+`line~` rejected (comma-segment line~ trap, no sustain stage)
- **LFO:** `cycle~` + rate dial (0.05–20 Hz), depth dial, `umenu` target (Pitch/Cutoff) gating two `*~` depth stages (unselected path depth = 0)
- **Cutoff modulation sum:** base cutoff (dial 20–8000 Hz, exponential feel via `scale ... 1.06`-style curve or expr) `+~` filter-env contribution `+~` LFO contribution, then `clip~ 20. 12000.` before lores~ cutoff inlet

### Gain staging (per MSP rules)
- Each osc scaled `*~ 0.4`; noise scaled by its dial (0–1 → `*~`)
- Velocity normalized `/ 127.` before envelope trigger level
- Final chain: `*~` (amp env) → `gain~` (master, default ~0.7 mapped) → `ezdac~`; `meter~` beside `gain~`
- All control values feeding `*~` normalized 0–1

### UI/control mapping (patching view, labeled)
- Osc section: 2× waveform umenu, detune dial, osc balance dial, noise dial
- Filter section: cutoff dial, resonance dial, env-amount dial
- Env section: 2×4 ADSR dials (attack ms, decay ms, sustain 0–1, release ms)
- LFO section: rate dial, depth dial, target umenu
- Global: glide dial (0–500 ms), gain~ + meter~, kslider, loadbang inits for all defaults

## Research (max-research, 2026-07-04)

All findings verified against the object database.

### Corrections to discuss-phase decisions
- **Drop `stripnote`.** `ddg.mono` needs note-offs to know when to release; stripnote removes them. Correct chain: `notein` (pitch, vel) → `ddg.mono` (2 in: pitch, vel; 2 out: pitch, vel). ddg.mono emits vel 0 on release, which is exactly what `adsr~` wants: trigger level > 0 starts attack, 0 starts release. `kslider` (2 outlets: pitch, vel) merges into the same ddg.mono inlets.

### Verified object facts
- **`ddg.mono`**: arg = note priority mode; messages `legato`, `retrig` control retrigger behavior. Use last-note priority + `retrig 1` for classic mono feel.
- **`adsr~`**: 5 inlets (trigger-level, A ms, D ms, S 0–1, R ms), outlet 0 = envelope signal. Args set ADSR defaults, e.g. `adsr~ 10. 80. 0.7 200.`. Trigger with normalized velocity (`/ 127.`) into inlet 0.
- **`selector~ 4`**: computed I/O = 5 in / 1 out. Inlet 0 = int select where **0 = closed, 1–4 = input n**. umenu index (0-based) must go through `+ 1` before selector~.
- **Oscillators**: `saw~` (2 in: freq, sync), `rect~` (3 in: freq, pulse-width, sync), `tri~` (3 in: freq, duty), `cycle~` (2 in). All freq inlets are signal/float — the shared `line~` pitch signal connects to inlet 0 of each. All are band-limited (saw~/rect~/tri~), safe for full range.
- **`lores~`**: 3 in (audio, cutoff signal/float, resonance 0–1 signal/float). Resonance dial maps 0–0.9 (self-oscillates near 1.0 — cap at 0.9).
- **`clip~ 20. 12000.`**: 3 signal inlets, min/max as args — guards the summed cutoff modulation before lores~.
- **`pack 0. 20`** → 2 inlets: pitch Hz (hot) + glide ms (cold) → `line~` gives portamento; glide dial writes pack's right inlet.
- **`umenu` items** must use the comma-as-element JSON format per CLAUDE.md (`["Saw", ",", "Square", ",", "Tri", ",", "Sine"]`).

### Signal flow (final, post-research)
```
notein ──┬─→ ddg.mono ─┬─ pitch → mtof → pack 0. $glide → line~ ──┬→ (+~ LFO pitch mod) → osc1 freq
kslider ─┘   (retrig 1)└─ vel → / 127. → t f f ─→ adsr~ (amp)      └→ +~ detune → osc2 freq
                                          └────→ adsr~ (filter)
osc1 sel~ ─ *~ 0.4 ─┐
osc2 sel~ ─ *~ 0.4 ─┼─ +~ ─→ lores~ ─→ *~ (amp env) ─→ gain~ ─→ ezdac~
noise~ ── *~ dial ──┘          ↑                          └→ meter~
cutoff dial + (filter-env *~ amount) + (LFO *~ depth) → clip~ 20. 12000. → lores~ cutoff
LFO: cycle~ rate-dial → target umenu routes depth to pitch-mod OR cutoff-mod path
```

### MAX 9 compatibility
All selected objects are long-standing Max 7/8-era objects; no MAX 9-only dependencies.
