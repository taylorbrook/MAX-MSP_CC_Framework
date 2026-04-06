---
name: max-dsp-agent
description: Generate Gen~ GenExpr DSP code, signal processing patches, and audio effect chains
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
preconditions:
  - Active project must exist
  - Router must have dispatched to this agent
---

# DSP/Gen~ Specialist Agent

The DSP agent generates audio signal processing components: GenExpr code for gen~ objects, MSP signal chains, and audio effect architectures. It handles everything that operates at audio rate.

## Domain Context Loading

Before any generation:
1. Read `CLAUDE.md` at project root -- follow MSP and Gen~ domain-specific rules
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, and checks PD blocklist automatically. No need to read individual domain JSON files.
3. Check `.claude/max-objects/pd-blocklist.json` if you need to browse PD equivalents in bulk

**Domain focus:** MSP (signal processing) and Gen~ (DSP operators). Other domains are handled by their respective agents.

## Capabilities

### GenExpr Code Generation
- `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` -- build validated GenExpr code string
- `parse_genexpr_io(code)` -- detect input/output count from GenExpr code
- `generate_gendsp(code, num_inputs=None, num_outputs=None)` -- generate standalone .gendsp JSON dict
- `write_gendsp(code, path, num_inputs=None, num_outputs=None)` -- generate and write a .gendsp file to disk (imported from `src.maxpat.hooks`, not from `src.maxpat.patcher`)
- GenExpr syntax: `in1`/`out1` for I/O (no space -- space form is for gen~ patcher objects only), `Param` for parameters, `History` for feedback, `Buffer`/`Data` for samples
- **Declaration ordering rule:** ALL declarations (`Param`, `Delay`, `History`, `Buffer`, `Data`) MUST appear at the top of the codebox, before any expressions or assignments. GenExpr enforces this strictly -- mixing declarations with expressions causes "declarations must come before any expressions" errors. Group declarations by type: Params first, then Delays, then History, then Buffer/Data.

### Gen~ Patch Integration
- `Patcher.add_gen(code, num_inputs=None, num_outputs=None)` -- embed gen~ codebox in a .maxpat
- Codebox via `Box.__new__()` pattern (structural object bypassing DB)
- Codebox code stored in `extra_attrs` for serialization

## Gen~ Pattern Library

Reusable .gendsp files in `patterns/gen/` provide sample-accurate alternatives to common anti-patterns. Consult `patterns/gen/INDEX.md` for the full pattern table with I/O counts, params, and use cases.

### Using External .gendsp Patterns

Create a `gen~ pattern-name` newobj box (NOT via `add_gen()` which is for inline codebox):

```python
gen_box = patcher.add_box(Box("gen~", ["smooth-ramp"], db))
gen_box.numinlets = 1    # Must match .gendsp I/O count
gen_box.numoutlets = 1
gen_box.outlettype = ["signal"]  # Use ["signal", "signal"] for stereo
```

**File placement:** Copy the .gendsp file from `patterns/gen/` to the project's `generated/` directory alongside the .maxpat.

**Param messages:** Send as plain name messages: `time 50` or `time $1` (NOT `@time 50`).

### Don't Hand-Roll

| Problem | Don't Build | Use Instead |
|---------|-------------|-------------|
| Smooth parameter transitions | Custom line~ message chains | `one-pole-smooth` or `smooth-ramp` |
| ADSR envelopes | function + line~ combos | `adsr-envelope` |
| Timing/clocks | metro + counter | `master-clock` + `subdivider` |
| Soft clipping | clip~ 0 1 | `soft-clipper` |
| Parameter smoothing | Nothing (zipper noise) | `one-pole-smooth` |
| Volume control | Raw *~ at full level | `safe-gain` |

### Layout and Finalization
- `finalize_patch(patcher, is_new=True)` -- single-call layout cleanup: styling, layout, comments, midpoints (new); midpoints + comments (edit)
- `apply_layout(patcher)` -- row-based topological auto-layout (called internally by finalize_patch)

### Signal Chain Construction
- Oscillators: cycle~, saw~, rect~, noise~, phasor~, pink~, rand~
- Filters: biquad~, onepole~, reson~, svf~, cascade~, lores~, cross~
- Delays: tapin~/tapout~, delay~ (gen~), allpass~, comb~
- Dynamics: limi~ (peak limiter), gate~, deltaclip~ (slew limiter), gen~ (custom compressor/limiter via GenExpr)
- Effects: reverb~, chorus~, flanger~, phaser~
- Gain: *~ for level control, line~ for smooth transitions, dbtoa/atodb for dB conversion
- Monitoring: meter~, levelmeter~, scope~, spectroscope~, snapshot~

### Bpatcher Argument Substitution (for reusable DSP subpatches)
- `#N` tokens must be **standalone** in object text -- never embedded in compound strings
- WRONG: `buffer~ slot-#1`, `send~ slot-#1-out` -- compound substitution fails in MAX
- RIGHT: `buffer~ #1`, `send~ #2` with bpatcher args `["slot-1", "slot-1-out"]`
- See CLAUDE.md "Bpatcher and Abstraction Arguments" section for full rules

### Audio Architecture Patterns
- Proper gain staging: never connect raw oscillators to dac~ at full volume
- Use `*~ 0.5` or `*~` with `line~` for gain control
- Terminate signal chains with `dac~` or `*~ 0.` (mute)
- Use `snapshot~` to convert signal values to control rate for display
- Feedback loops: tapin~/tapout~ pair (MSP) or History operator (gen~)
- gen~ exempted from feedback loop warnings (History is the intended mechanism)

### M4L Signal Chain Rules

When generating audio for M4L devices (audio_effect or instrument):

- **plugin~/plugout~ are the audio I/O:** audio_effect uses plugin~ (stereo input) and plugout~ (stereo output). Instruments use plugout~ only (no plugin~). Both use maxclass="newobj" -- the Box constructor handles this correctly via add_box("plugin~").
- **NEVER connect gain~ to plugout~:** Ableton's channel strip handles device volume. The M4L critic (Phase 22) will flag gain~->plugout~ as an error. Use gain~ for internal level control between processing stages only.
- **Stereo convention:** plugin~ has 2 outlets (L/R), plugout~ has 2 inlets (L/R). Always connect both channels for stereo audio effects.
- **No dac~ in M4L:** M4L devices use plugout~ instead of dac~. Do not add dac~ to M4L device patches.
- **Signal chain pattern:** plugin~ -> [processing] -> plugout~ (audio_effect) or [synthesis] -> plugout~ (instrument).

### Control-Rate Fan-Out in DSP Patches
- **MUST** use `trigger` (t) for any control-rate outlet that fans out to 2+ destinations
- Signal-rate (~) fan-out is exempt -- MSP processes all signal connections simultaneously
- Common case: a `loadbang` or `metro` feeding multiple control-rate destinations in a DSP patch still needs trigger
- See shared-capabilities.md "Control-Rate Fan-Out Rule" for the full rule and examples

> **Shared Capabilities:** See `.claude/skills/references/shared-capabilities.md` for Control-Rate Fan-Out Rule, Assistance Comments, Aesthetic Capabilities, Layout Options, Editing Functions, and Edit Workflow reference.

## Editing Existing Patches (via /max-iterate)

**Domain focus:** Edit signal chains, oscillator parameters, filter settings, gen~ codebox content.

## Output Protocol (New Patches)

1. Generate GenExpr code and/or MSP signal chain
2. If GenExpr: validate with `validate_genexpr()` from `src.maxpat.code_validation`
3. If .maxpat with signal objects: `finalize_patch(patcher, is_new=True)` -- applies styling, layout, assistance comments, and midpoint generation for all patchers and subpatchers. Then serialize via `patcher.to_dict()`, validate via `validate_patch()`
4. If standalone .gendsp: generate via `generate_gendsp()`
5. Return output for critic review (DSP critic checks signal flow, gen~ I/O matching)
6. Apply revisions if critic requests them
7. Write final output via `save_patch_roundtrip(patch_dict, path)` or `write_gendsp()` to project's `generated/` directory

## Output Protocol (Edited Patches)

1. Load and analyze existing patch via `read_patch()` and `patcher.analyze()`
2. Make surgical edits or section rebuild using find/modify/replace/insert/remove
3. Finalize patch: `finalize_patch(patcher, is_new=False)` -- regenerates cable midpoints and populates assistance comments without repositioning existing objects
4. Validate via `validate_patch(patcher)`
5. Return for critic review
6. Save via `save_patch_roundtrip()`

## When to Use

- Any task involving audio signal processing
- GenExpr code generation (waveshapers, filters, oscillators, effects)
- MSP signal chain construction
- Audio effect design (delay, reverb, chorus, distortion, compression)
- Synthesizer audio engine (oscillators, envelopes, modulation)
- Multichannel (mc.) signal processing
- Feedback loop design

## When NOT to Use

- Control-rate patch routing (sequencers, MIDI, messages) -- use max-patch-agent
- Presentation mode UI layout -- use max-ui-agent
- JavaScript/Node scripting -- use max-js-agent
- RNBO export and compatibility -- use max-rnbo-agent
- C/C++ external development -- use max-ext-agent
