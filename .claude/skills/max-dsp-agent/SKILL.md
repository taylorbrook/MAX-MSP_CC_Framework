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
1. Read `.claude/max-objects/msp/objects.json` (248 MSP objects)
2. Read `.claude/max-objects/gen/objects.json` (189 Gen~ operators)
3. Read `CLAUDE.md` at project root -- follow MSP and Gen~ domain-specific rules
4. Read `.claude/max-objects/aliases.json` for shortcut resolution
5. Read `.claude/max-objects/pd-blocklist.json` to avoid PD object confusion (osc~ -> cycle~, lop~ -> onepole~, etc.)
6. Read active project's `.max-memory/patterns.md` for project patterns
7. Read `~/.claude/max-memory/dsp/` for global DSP patterns (if exists)
8. Optionally read `.claude/max-objects/mc/objects.json` (215 MC objects) if multichannel is requested

**Do NOT load:** max/objects.json (Patch agent's domain), rnbo/objects.json (RNBO agent's domain).

## Capabilities

### GenExpr Code Generation
- `build_genexpr(params, code_body, num_inputs=1, num_outputs=1)` -- build validated GenExpr code string
- `parse_genexpr_io(code)` -- detect input/output count from GenExpr code
- `generate_gendsp(code, num_inputs=None, num_outputs=None)` -- generate standalone .gendsp JSON dict
- `write_gendsp(code, path, num_inputs=None, num_outputs=None)` -- generate and write a .gendsp file to disk (imported from `src.maxpat.hooks`, not from `src.maxpat.patcher`)
- GenExpr syntax: `in 1`/`out 1` for I/O, `Param` for parameters, `History` for feedback, `Buffer`/`Data` for samples
- **Declaration ordering rule:** ALL declarations (`Param`, `Delay`, `History`, `Buffer`, `Data`) MUST appear at the top of the codebox, before any expressions or assignments. GenExpr enforces this strictly -- mixing declarations with expressions causes "declarations must come before any expressions" errors. Group declarations by type: Params first, then Delays, then History, then Buffer/Data.

### Gen~ Patch Integration
- `Patcher.add_gen(code, num_inputs=None, num_outputs=None)` -- embed gen~ codebox in a .maxpat
- Codebox via `Box.__new__()` pattern (structural object bypassing DB)
- Codebox code stored in `extra_attrs` for serialization

### Signal Chain Construction
- Oscillators: cycle~, saw~, rect~, noise~, phasor~, pink~, rand~
- Filters: biquad~, onepole~, reson~, svf~, cascade~, lores~, cross~
- Delays: tapin~/tapout~, delay~ (gen~), allpass~, comb~
- Dynamics: compressor~, limiter~, gate~, omx.comp~, omx.peaklim~
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

### Aesthetic Capabilities

**Auto-applied by generate_patch() -- no manual calls needed:**
- Canvas background color (off-white with blue tint) applied automatically
- `dac~` and `loadbang` objects highlighted with subtle background colors
- Existing user-set bgcolor is never overwritten

**Patcher methods for explicit styling:**
- `add_section_header(text)` -- 16pt bold colored header with background (for patch sections)
- `add_subsection(text)` -- 12pt bold dark gray label (for subsection grouping)
- `add_annotation(text, target=box)` -- 10pt italic light gray note (for inline documentation)
- `add_bubble(text, bubbleside=1)` -- comment with arrow pointer (for callout notes)
- `add_panel(x, y, w, h, gradient=True)` -- background panel for visual grouping
- `add_step_marker(number, x, y)` -- numbered amber circle (for step-by-step patches)

**Aesthetics helpers (from `src.maxpat.aesthetics`):**
- `set_canvas_background(patcher, color=None)` -- override default canvas color
- `set_object_bgcolor(box, palette_key=None, color=None)` -- highlight specific objects
- `auto_size_panel(boxes, padding=18)` -- compute panel rect to enclose a group of boxes
- `is_complex_patch(patcher)` -- heuristic: True if 10+ boxes or has subpatchers

**Layout options (`from src.maxpat import LayoutOptions`):**
- `generate_patch(patcher, layout_options=LayoutOptions(...))` -- customize layout
- `v_spacing` (default 20.0) -- vertical gap between rows in pixels
- `h_gutter` (default 15.0) -- horizontal gap between sibling objects
- `patcher_padding` (default 40.0) -- padding around content for auto-sized patcher rect
- `grid_size` (default 15.0) -- grid cell size in pixels (when grid_snap enabled)
- `grid_snap` (default True) -- snap box positions to grid_size grid
- `inlet_align` (default True) -- adjust child x-position to straighten cables to parent inlets
- `comment_gap` (default 10.0) -- horizontal offset for associated comment placement

## Output Protocol

1. Generate GenExpr code and/or MSP signal chain
2. If GenExpr: validate with `validate_genexpr()` from `src.maxpat.code_validation`
3. If .maxpat with signal objects: generate via `generate_patch()` pipeline
4. If standalone .gendsp: generate via `generate_gendsp()`
5. Return output for critic review (DSP critic checks signal flow, gen~ I/O matching)
6. Apply revisions if critic requests them
7. Write final output via `write_patch()` or `write_gendsp()` to project's `generated/` directory

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
