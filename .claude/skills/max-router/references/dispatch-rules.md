# Dispatch Rules

Detailed keyword-to-agent mapping for the router agent. The router scans the user's task description against these rules to determine which specialist(s) to invoke.

## Keyword Classification

### max-patch-agent (Patch/Control Flow)

**Primary keywords:** patch, object, route, routing, trigger, message, bang, toggle, button, number, integer, float, list, symbol, gate, switch, select, pack, unpack, prepend, append, zl, coll, dict, table, send, receive, forward, pattr

**Secondary keywords:** subpatcher, bpatcher, patcher, encapsulate, abstraction, metro, counter, timer, delay (non-signal), pipe, buddy, thresh, change, split, iter, funnel, spray, loadbang, closebang, notein, noteout, ctlin, ctlout, pgmin, midiin, midiout, makenote, stripnote, borax, flush

**Object references:** Any MAX object name from `.claude/max-objects/max/objects.json`

**Intent patterns:**
- "Create a patch that..."
- "Route messages from..."
- "Build a sequencer" (control-rate)
- "Handle MIDI input/output"
- "Organize into subpatchers"

### max-dsp-agent (DSP/Gen~)

**Primary keywords:** signal, audio, synth, synthesizer, oscillator, filter, delay~, reverb, feedback, gen~, GenExpr, codebox, cycle~, saw~, rect~, noise~, phasor~, gain, amplitude, mix, wet/dry, envelope, adsr~, line~, function

**Secondary keywords:** dac~, adc~, tapin~, tapout~, allpass~, biquad~, onepole~, reson~, svf~, cascade~, lores~, comb~, flanger, chorus, phaser, distortion, waveshaper, compressor, limiter, buffer~, play~, groove~, wave~, record~, snapshot~, meter~, scope~, spectroscope~, fft~, ifft~, pfft~, mc., multichannel, History, Param, Data, Buffer (gen~)

**Object references:** Any object from `.claude/max-objects/msp/objects.json` or `.claude/max-objects/gen/objects.json`

**Intent patterns:**
- "Build a synthesizer..."
- "Create an audio effect..."
- "Write GenExpr code for..."
- "Design a signal chain..."
- "Add feedback delay..."

### max-rnbo-agent (RNBO Export)

**Primary keywords:** rnbo, rnbo~, export, vst, vst3, au, audio unit, plugin, web audio, c++ export, embedded, raspberry pi, target

**Secondary keywords:** param (RNBO context), inport, outport, rnbo-compatible, self-contained, codebox (RNBO context)

**Intent patterns:**
- "Export as VST plugin..."
- "Make this RNBO-compatible..."
- "Build for Web Audio..."
- "Target embedded hardware..."

### max-js-agent (JavaScript/Node)

**Primary keywords:** javascript, js, node, n4m, node.script, script, max-api, require, handler, callback, maxAPI

**Secondary keywords:** CommonJS, module, file I/O, network, fetch, http, json, parse, data processing, algorithm, sort, filter (data), map, reduce, inlets, outlets, bang(), msg_int, msg_float, anything, post, outlet (js)

**Intent patterns:**
- "Write a Node script that..."
- "Create a js object for..."
- "Handle data processing in JavaScript..."
- "Build a MIDI processor in N4M..."
- "Script that reads/writes files..."

### max-ext-agent (Externals/C++)

**Primary keywords:** external, sdk, c++, c, compile, build, mxo, min-devkit, max-sdk, xcode

**Secondary keywords:** dsp perform method, inlet/outlet registration, class_new, class_addmethod, object_alloc, t_object, buffer access (C), attr, attribute (C), package

**Intent patterns:**
- "Build a C++ external..."
- "Create a custom object..."
- "Compile for Max..."

### max-ui-agent (UI/Layout)

**Primary keywords:** layout, presentation, ui, controls, interface, display, visual, panel, design, arrangement, spacing, alignment, grid

**Secondary keywords:** dial, slider, multislider, live.dial, live.slider, number~, flonum, comment, panel, bpatcher (UI context), umenu, tab, radiogroup, swatch, pictctrl, jsui, presentation_rect, presentation mode, patching mode, background, foreground, color, font, size, position

**Intent patterns:**
- "Layout the controls..."
- "Design a user interface..."
- "Add presentation mode..."
- "Arrange knobs and sliders..."
- "Create a control panel..."

## Ambiguity Resolution

When keywords match multiple domains:

1. **Count primary keyword matches** per domain -- highest count wins lead
2. **Check intent patterns** -- strongest match determines lead
3. **Default lead hierarchy:** DSP > Patch > js > UI (for tie-breaking)

### Edge Cases

| Task Description | Agents | Lead | Reasoning |
|-----------------|--------|------|-----------|
| "synth with knobs" | DSP + UI | DSP | Audio generation is primary |
| "MIDI step sequencer" | Patch | Patch | Control-rate sequencing |
| "gen~ waveshaper" | DSP | DSP | Pure DSP task |
| "data parser in js" | js | js | Pure JavaScript task |
| "audio visualizer" | DSP + UI + js | DSP | Signal analysis drives display |
| "preset manager" | Patch + js | Patch | Patch routing with js storage |
| "export synth as VST" | RNBO | RNBO | Export target dispatch |

## Single vs Multi-Agent Decision

**Single agent when:**
- All keywords fall within one domain
- Intent clearly targets one specialist
- No cross-domain dependencies

**Multi-agent when:**
- Keywords span 2+ domains
- Task requires both patch structure AND code generation
- Task requires both signal processing AND UI layout
- Output will contain multiple file types (.maxpat + .gendsp, .maxpat + .js)
