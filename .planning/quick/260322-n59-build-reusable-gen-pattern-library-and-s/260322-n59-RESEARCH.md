# Quick Task 260322-n59: Gen~ Pattern Library & UI Presets - Research

**Researched:** 2026-03-22
**Domain:** Gen~ .gendsp files, GenExpr DSP patterns, MAX UI dial presets
**Confidence:** HIGH

## Summary

The codebase already generates and references external .gendsp files successfully. The stutter and FDNVerb projects demonstrate the pattern: a `.maxpat` contains `gen~ filename` (no extension) in the text attribute, and MAX resolves the `.gendsp` file from the same directory or search path. The `generate_gendsp()` function in `src/maxpat/codegen.py` and `write_gendsp()` in `src/maxpat/hooks.py` produce valid .gendsp files with codebox + in/out objects.

For the pattern library, each .gendsp file is a standalone gen~ patcher with `Param` declarations for tunability. Agents reference them via `gen~ pattern-name` in the parent .maxpat. The UI preset reference document captures the rhythmic-sampler dial convention (55x55px presentation, 40x40px patching, `parameter_enable: 0`) with `scale` objects for range mapping.

**Primary recommendation:** Create .gendsp files in `patterns/gen/` directory, one file per pattern. Create a UI preset reference at `.claude/skills/references/ui-presets.md`. Wire agents to consult both during generation.

<user_constraints>

## User Constraints (from CONTEXT.md)

### Locked Decisions
- Pattern storage: .gendsp files in a patterns/ directory, standalone Gen~ patcher files
- Scope: 7 categories (ramps/envelopes, parameter smoothing, phasor timing, gain safety, buffer record/playback, essential DSP, randomization)
- UI presets: Reference doc + agent wiring, stored in .claude/skills/references/ markdown, style based on rhythmic-sampler

### Claude's Discretion
- Specific .gendsp file naming convention and directory structure
- Which additional "obviously reusable" gen snippets beyond the user's list
- Exact dial preset values (derive from working rhythmic-sampler patterns)
- How agents discover and reference .gendsp files during generation

### Deferred Ideas (OUT OF SCOPE)
None specified.

</user_constraints>

## .gendsp File Format

**Confidence: HIGH** -- verified from 6 existing .gendsp files in the repo.

### Structure

A `.gendsp` file is identical in JSON structure to a `.maxpat` file, but contains gen~ domain objects (`in`, `out`, `codebox`, gen~ operators). Key differences from .maxpat:

```json
{
  "patcher": {
    "fileversion": 1,
    "appversion": { "major": 9, "minor": 0, "revision": 0, "architecture": "x64", "modernui": 1 },
    "classnamespace": "box",
    "rect": [100.0, 100.0, 600.0, 450.0],
    "boxes": [
      { "box": { "maxclass": "newobj", "text": "in 1", "id": "obj-1", "numinlets": 0, "numoutlets": 1, ... } },
      { "box": { "maxclass": "codebox", "id": "obj-2", "code": "GenExpr code here", "numinlets": 1, "numoutlets": 1, ... } },
      { "box": { "maxclass": "newobj", "text": "out 1", "id": "obj-3", "numinlets": 1, "numoutlets": 0, ... } }
    ],
    "lines": [ ... ],
    "bgcolor": [0.9, 0.9, 0.9, 1.0]
  }
}
```

- `classnamespace`: Either `"box"` (our generator) or `"dsp.gen"` (MAX native). Both work.
- Objects: `in N`, `out N` (newobj), `codebox` (maxclass "codebox" with "code" attribute)
- Codebox `numinlets`/`numoutlets` must match actual `in`/`out` object count
- Gen~ patcher objects use `in 1`/`out 1` (with space). Codebox GenExpr uses `in1`/`out1` (no space).

### How a .maxpat References a .gendsp

In the parent .maxpat, the gen~ object text includes the filename (without extension):

```json
{
  "box": {
    "maxclass": "newobj",
    "text": "gen~ FDNverb",
    "numinlets": 2,
    "numoutlets": 2,
    "outlettype": ["signal", "signal"],
    "patching_rect": [50.5, 257.0, 87.0, 22.0]
  }
}
```

MAX resolves `FDNverb.gendsp` from the search path (same directory, project folder, or MAX search path). The `numinlets`/`numoutlets` on the parent gen~ box must match the in/out count of the referenced .gendsp.

### Existing API Support

| Function | Module | Purpose |
|----------|--------|---------|
| `generate_gendsp(code, num_inputs, num_outputs)` | `src.maxpat.codegen` | Returns .gendsp JSON dict |
| `write_gendsp(code, path, num_inputs, num_outputs)` | `src.maxpat.hooks` | Writes .gendsp file to disk |
| `parse_genexpr_io(code)` | `src.maxpat.codegen` | Auto-detects I/O count from GenExpr code |
| `build_genexpr(params, code_body, ...)` | `src.maxpat.codegen` | Builds formatted GenExpr with Param section |
| `Patcher.add_gen(code, ...)` | `src.maxpat.patcher` | Embeds gen~ with inline codebox (NOT for .gendsp ref) |

**Key gap:** `Patcher.add_gen()` creates an inline codebox gen~ object. To reference an external .gendsp, agents must create a plain `gen~ filename` newobj box instead. This is straightforward -- just `Box("gen~", ["pattern-name"], db)` -- but should be documented in the agent reference.

## Rhythmic-Sampler Dial Patterns (UI Reference Standard)

**Confidence: HIGH** -- extracted directly from `patches/rhythmic-sampler/generated/slot.maxpat`.

### Dial Box Attributes

All dials in the rhythmic-sampler follow this exact pattern:

```json
{
  "box": {
    "id": "obj-XX",
    "maxclass": "dial",
    "numinlets": 1,
    "numoutlets": 1,
    "outlettype": [""],
    "parameter_enable": 0,
    "patching_rect": [X, Y, 40.0, 40.0],
    "presentation": 1,
    "presentation_rect": [X, Y, 55.0, 55.0],
    "varname": "descriptive_name_dial"
  }
}
```

**Key values:**
- Patching mode size: **40x40px**
- Presentation mode size: **55x55px**
- `parameter_enable`: 0 (no automation/parameter system)
- Always has `varname` for scripting access
- Always has both `presentation: 1` and explicit `presentation_rect`

### Dial-to-Parameter Chain

Every dial connects through a `scale` object for range mapping:

| Parameter | Scale Text | Range | Purpose |
|-----------|-----------|-------|---------|
| Cutoff | `scale 0 127 20. 20000.` | 20-20000 Hz | Filter frequency |
| Resonance | `scale 0 127 0. 1.` | 0.0-1.0 | Normalized 0-1 |
| Volume | `scale 0 127 0. 1.` | 0.0-1.0 | Gain multiplier |
| Degrade | `scale 0 127 0.1 1.` | 0.1-1.0 | Bit reduction amount |
| Pitch | `expr pow(2., $f1 / 12.)` | Semitones | Pitch ratio (no scale) |

**Pattern:** `dial` (0-127 output) -> `scale 0 127 min max` -> parameter inlet.

### Number Display Pattern

For readout displays alongside dials:
- `number` box with `presentation: 1`
- Size: **50x22px** in patching, **100x22px** in presentation
- Connected after the scale object to show mapped value

### Presentation Layout Grid

Dials are arranged on a 60px horizontal grid in presentation mode:
- First column: x=5
- Second column: x=65
- Third column: x=125
- Fourth column: x=185 (or x=245, x=305 for second row)
- Row spacing: 80px vertical (55px dial + 25px gap for label)

## Gen~ DSP Pattern Specifications

**Confidence: HIGH for basic patterns, MEDIUM for complex DSP (reverb, compression).**

All patterns use GenExpr codebox syntax per CLAUDE.md rules: declarations at top, `in1`/`out1` for I/O, `Param` for tunability, `History` for state.

### Category 1: Ramps & Envelopes

**smooth-ramp.gendsp** -- Sample-accurate ramp (replaces line~)
- 1 in (target value), 1 out (smoothed signal)
- Params: `time` (ramp time ms)
- Uses `History` for current value, ramps at sample rate
- Advantage over line~: sample-accurate, no message jitter

**ar-envelope.gendsp** -- Attack-Release envelope
- 1 in (gate signal), 1 out (envelope signal)
- Params: `attack` (ms), `release` (ms)
- Exponential curves via `exp(-1 / (time_samps))` coefficient

**adsr-envelope.gendsp** -- Full ADSR
- 1 in (gate), 1 out (envelope 0-1)
- Params: `attack`, `decay`, `sustain`, `release`
- State machine using History for phase tracking

**exp-curve.gendsp** -- Exponential curve shaper
- 1 in (linear 0-1), 1 out (curved 0-1)
- Param: `curve` (negative = log, positive = exp)
- `pow(in1, exp(curve))` pattern

### Category 2: Parameter Smoothing

**one-pole-smooth.gendsp** -- One-pole lowpass smoother
- 1 in, 1 out
- Param: `smooth` (0-1, higher = smoother)
- `History y(0); y = y + smooth_coeff * (in1 - y); out1 = y;`
- Eliminates zipper noise on parameter changes

**lag-processor.gendsp** -- Asymmetric lag (different up/down rates)
- 1 in, 1 out
- Params: `rise_ms`, `fall_ms`
- Different coefficients for rising vs falling signal

### Category 3: Phasor-Based Timing

**master-clock.gendsp** -- BPM-driven phasor clock
- 0 in, 1 out (phasor 0-1)
- Params: `bpm`, `multiplier`
- `phasor(bpm / 60 * multiplier)` -- sample-accurate timing

**subdivider.gendsp** -- Clock subdivision from master phasor
- 1 in (master phasor), 1 out (subdivided phasor)
- Param: `division` (2, 3, 4, 6, 8, etc.)
- `wrap(in1 * division, 0, 1)`

**swing-generator.gendsp** -- Applies swing to phasor
- 1 in (phasor), 1 out (swung phasor)
- Param: `swing` (0-1, 0.5 = no swing)
- Piecewise linear remapping of phasor position

### Category 4: Gain Safety

**soft-clipper.gendsp** -- Soft saturation/clipping
- 1 in, 1 out
- Param: `drive` (1-10)
- `tanh(in1 * drive) / tanh(drive)` -- normalized tanh waveshaper

**safe-gain.gendsp** -- Gain with built-in limiting
- 1 in, 1 out
- Param: `gain` (0-1)
- Applies gain then soft-clips at 1.0 to prevent overs

### Category 5: Buffer Record/Playback

**buffer-recorder.gendsp** -- Record to buffer with position tracking
- 1 in (audio), 1 out (position)
- Params: `record` (0/1 gate), `loop` (0/1)
- Uses `Buffer` and `Data` for sample storage, `History` for write position

**buffer-player.gendsp** -- Variable-speed buffer playback
- 0 in, 1 out (audio)
- Params: `speed`, `start`, `end`, `loop`
- Phasor-driven with `peek()` for sample interpolation

### Category 6: Essential DSP

**simple-reverb.gendsp** -- Schroeder reverb (lightweight)
- 2 in (stereo), 2 out (stereo)
- Params: `decay`, `damping`, `drywet`
- 4 comb filters + 2 allpass (classic Schroeder topology)
- Note: FDNVerb.gendsp already exists as a full-featured alternative

**multi-tap-delay.gendsp** -- Multi-tap delay with feedback
- 1 in, 1 out (or 2 out for ping-pong)
- Params: `time_ms`, `feedback`, `drywet`, `taps`
- Uses `Delay` objects with modulated read positions

**compressor.gendsp** -- Basic dynamics compressor
- 1 in (or 2 for stereo), same out count
- Params: `threshold`, `ratio`, `attack_ms`, `release_ms`, `makeup`
- Envelope detection + gain computation + smoothing
- Note: brickwall-limiter.gendsp already exists

**noise-generator.gendsp** -- Multiple noise types
- 0 in, 1 out
- Param: `type` (0=white, 1=pink, 2=brown)
- White via `noise()`, pink via 3-stage filter, brown via integrated white

### Category 7: Randomization

**sample-and-hold.gendsp** -- S&H with random source
- 1 in (trigger/clock), 1 out (random value)
- Params: `min`, `max`
- Triggers on rising edge, outputs random in range

**random-walk.gendsp** -- Brownian/random walk generator
- 0 in, 1 out
- Params: `rate`, `step_size`, `min`, `max`
- Bounded random walk at controllable rate

## Agent Integration Pattern

### How Agents Use .gendsp Files

When an agent needs a gen~ pattern from the library:

1. Create a `gen~ pattern-name` box in the parent .maxpat:
   ```python
   gen_box = Box("gen~", ["smooth-ramp"], db)
   # Sets text to "gen~ smooth-ramp", numinlets/numoutlets from DB
   ```

2. Override numinlets/numoutlets to match the .gendsp pattern's I/O:
   ```python
   gen_box.numinlets = 1
   gen_box.numoutlets = 1
   gen_box.outlettype = ["signal"]
   ```

3. Send parameters via messages: `smooth 0.99` (plain name, NOT @smooth)

4. Copy the .gendsp file to the project's `generated/` directory (or ensure it's in MAX's search path).

### Pattern Discovery

Agents should consult a pattern index that maps use cases to .gendsp filenames:

| Need | Pattern File | I/O |
|------|-------------|-----|
| Smooth parameter changes | `one-pole-smooth` | 1 in / 1 out |
| Replace line~ for audio ramps | `smooth-ramp` | 1 in / 1 out |
| ADSR envelope | `adsr-envelope` | 1 in / 1 out |
| Sample-accurate timing | `master-clock` | 0 in / 1 out |
| Prevent clipping | `soft-clipper` | 1 in / 1 out |
| Reverb (lightweight) | `simple-reverb` | 2 in / 2 out |
| Reverb (full-featured) | `FDNverb` (existing) | 2 in / 2 out |
| Limiter | `brickwall-limiter` (existing) | 2 in / 2 out |

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Smooth parameter transitions | Custom line~ message chains | `one-pole-smooth.gendsp` or `smooth-ramp.gendsp` | line~ has message jitter; gen~ is sample-accurate |
| ADSR envelopes | function + line~ combos | `adsr-envelope.gendsp` | State machine in gen~ is click-free and phase-accurate |
| Timing/clocks | metro + counter | `master-clock.gendsp` + `subdivider.gendsp` | Phasor is sample-accurate, metro has scheduler jitter |
| Soft clipping | clip~ 0 1 | `soft-clipper.gendsp` | Hard clip causes distortion artifacts; tanh is smooth |
| Parameter smoothing | nothing (zipper noise) | `one-pole-smooth.gendsp` | Every parameter change needs smoothing at audio rate |

## Common Pitfalls

### Pitfall 1: classnamespace Mismatch
**What goes wrong:** .gendsp files generated with `"classnamespace": "box"` vs MAX native `"dsp.gen"`.
**Why it happens:** Our `generate_gendsp()` uses `"box"` from DEFAULT_PATCHER_PROPS.
**How to avoid:** Both work. Keep using `"box"` for consistency with existing codebase. No action needed.

### Pitfall 2: numinlets/numoutlets Mismatch on Parent gen~ Box
**What goes wrong:** Parent `gen~` box in .maxpat declares wrong I/O count vs the .gendsp.
**Why it happens:** When referencing external .gendsp, MAX infers I/O from the file, but our validator checks the declared count.
**How to avoid:** Document each pattern's I/O count in the index. Agents must set correct counts when creating the parent box.

### Pitfall 3: GenExpr Declaration Order
**What goes wrong:** Params/Delay/History mixed with expressions causes compile errors.
**Why it happens:** GenExpr requires ALL declarations before ANY expressions.
**How to avoid:** Every .gendsp pattern must group declarations at top: Params, then Delays, then History, then Buffer/Data. Code body follows.

### Pitfall 4: gen~ Param Messages Use Plain Names
**What goes wrong:** Sending `@decay 0.5` instead of `decay 0.5`.
**Why it happens:** Confusion with MAX attribute syntax.
**How to avoid:** gen~ params receive plain name messages: `decay $1`, NOT `@decay $1`. Document in pattern reference.

### Pitfall 5: .gendsp File Must Be in Search Path
**What goes wrong:** `gen~ pattern-name` can't find the .gendsp file.
**Why it happens:** File not in same directory or MAX search path.
**How to avoid:** Copy .gendsp files to project's `generated/` directory alongside the .maxpat, or add patterns/ to project search path.

## Recommended Directory Structure

```
patterns/
  gen/
    ramps/
      smooth-ramp.gendsp
      ar-envelope.gendsp
      adsr-envelope.gendsp
      exp-curve.gendsp
    smoothing/
      one-pole-smooth.gendsp
      lag-processor.gendsp
    timing/
      master-clock.gendsp
      subdivider.gendsp
      swing-generator.gendsp
    gain/
      soft-clipper.gendsp
      safe-gain.gendsp
    buffer/
      buffer-recorder.gendsp
      buffer-player.gendsp
    dsp/
      simple-reverb.gendsp
      multi-tap-delay.gendsp
      compressor.gendsp
      noise-generator.gendsp
    random/
      sample-and-hold.gendsp
      random-walk.gendsp
    INDEX.md          # Pattern index with I/O counts, params, use cases
```

UI preset reference goes to: `.claude/skills/references/ui-presets.md`

## Sources

### Primary (HIGH confidence)
- `patches/stutter/generated/stutter.maxpat` -- working gen~ external .gendsp reference pattern
- `patches/FDNVerb/generated/FDNverb.gendsp` -- complex .gendsp with full FDN reverb
- `patches/stutter/generated/brickwall-limiter.gendsp` -- .gendsp with stereo I/O
- `patches/rhythmic-sampler/generated/slot.maxpat` -- dial attribute reference standard
- `src/maxpat/codegen.py` -- generate_gendsp() implementation
- `src/maxpat/hooks.py` -- write_gendsp() implementation
- `src/maxpat/patcher.py` -- add_gen() for inline codebox (not external .gendsp)

### Secondary (MEDIUM confidence)
- GenExpr DSP patterns based on standard DSP algorithms (Schroeder, one-pole, etc.)
- Phasor-based timing patterns from established MAX/gen~ practice

## Metadata

**Confidence breakdown:**
- .gendsp format: HIGH -- verified from 6 existing files
- UI dial presets: HIGH -- extracted from working rhythmic-sampler
- Gen~ DSP patterns: HIGH for simple (ramp, smooth, clip), MEDIUM for complex (reverb, compressor)
- Agent integration: HIGH -- existing referencing pattern proven in stutter/FDNVerb projects

**Research date:** 2026-03-22
**Valid until:** Stable -- no external dependencies or version sensitivity
