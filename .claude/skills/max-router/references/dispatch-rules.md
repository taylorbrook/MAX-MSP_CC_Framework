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

## Domain Overlays

Overlays are not agents. When an overlay's keywords or object names match, it sets the lead agent (overriding keyword counting), adds the secondaries it lists, and passes its required reading and checks to every dispatched specialist. When two overlays match (a polyphonic M4L instrument), take the M4L lead and apply both overlays' reading and checks.

### Jitter (video, matrices, OpenGL)

**Detect (keywords):** jitter, video, camera / webcam, texture, OpenGL / GL, shader, 3D render, mesh, particles, pixel processing, Vizzie, any `jit.*` name. "matrix" alone is NOT Jitter (mod matrix, routing matrix).

**Object references:** `jit.world`, `jit.gl.render`, `jit.gl.mesh`, `jit.gl.gridshape`, `jit.gl.videoplane`, `jit.gl.texture`, `jit.gl.pix`, `jit.gl.slab`, `jit.matrix`, `jit.pwindow`, `jit.window`, `jit.movie`, `jit.grab`, `jit.noise`, `jit.bfg`, `jit.op`, `jit.expr`, `jit.gen`, `jit.pix`, `jit.catch~`, `jit.release~`, `jit.buffer~`, `jit.poke~`, `jit.peek~`, `jit.xfade`, `jit.pack`, `jit.unpack`, `jit.matrixinfo`, `qmetro`

**Agents:**
- lead max-patch-agent: matrix and render chains are newobj control flow (a `qmetro` or `jit.world` drives them; matrices are routed like messages);
- plus max-dsp-agent for `jit.gen` / `jit.pix` / `jit.gl.pix` codeboxes (GenExpr, under the codebox safe-construct rules in `.claude/skills/references/genexpr-rules.md`) and for audio-to-matrix bridges (`jit.catch~`, `jit.release~`, `jit.buffer~`, `jit.poke~`, `jit.peek~`);
- plus max-ui-agent when a `jit.pwindow` goes into presentation;
- plus max-js-agent only when JS scripting is asked for.

**Pass to specialists:** proven-forms.md "enum values" (check `jit.*` attribute values in the bundle maxref / help before use, e.g. `jit.bfg @basis`); look `jit.*` objects up in `ObjectDatabase` (domain Jitter).

**Checks:** never route Jitter to max-rnbo-agent (it has no RNBO equivalent); `jit.gen` / `jit.pix` / `jit.gl.pix` inner patchers validate in gen scope.

### Max for Live (M4L)

**Experimental:** not yet confirmed in MAX or Live.

**Detect (keywords):** max for live, m4l, ableton, Live device, amxd, audio effect device, instrument device, MIDI effect device, Live parameter / automation, Push, `plugin~` / `plugout~` / `live.thisdevice`. "live" alone (live input, live performance, live coding) is not M4L. A `live.dial` face in a plain MAX patch is UI (max-ui-agent), not M4L.

**Object references:** `plugin~`, `plugout~`, `live.thisdevice`, `live.dial`, `live.slider`, `live.numbox`, `live.menu`, `live.text`, `live.toggle`, `live.tab`, `live.meter~`, `live.object`, `live.path`, `live.observer`, `live.remote~`, `midiin`, `midiout`

**Agents:**
- audio effect or instrument: lead max-dsp-agent (`add_m4l_device("audio_effect" | "instrument", params)`, or `add_m4l_gen_synth` for a gen~ synth body; both experimental);
- MIDI effect: lead max-patch-agent (`add_m4l_device("midi_effect", params)`, experimental);
- plus max-ui-agent for `live.*` controls in presentation;
- plus max-js-agent only for Live API scripting asked for in JS.

**Pass to specialists:** "Max for Live Device Rules" in `.claude/skills/references/shared-capabilities.md` (no `gain~` / `live.gain~` / `ezdac~` before `plugout~`; `live.dial` / `live.slider` bind through `param_connect` with `parameter_enable`); the `add_m4l_device` and `add_m4l_gen_synth` docstrings; "Builder API" in `.claude/skills/references/shared-capabilities.md` (both builders, and `export_amxd`).

**Checks:**
- `review_patch` runs the M4L critic only when `detect_m4l_device_type` finds `plugin~`, `plugout~` or `live.thisdevice` (`plugin~` gives an audio effect, else `plugout~` an instrument, else `midiin` / `midiout` a MIDI effect; `live.thisdevice` alone is a helper abstraction, `m4l_abstraction`, which gets only the per-scope checks), so every M4L build includes them;
- the `.maxpat` is the source of truth: save it, then write the `.amxd` next to it with `export_amxd(maxpat_path)` from `src.maxpat.m4l_device` (experimental; it refuses a helper abstraction unless `kind=` is given);
- report the result as experimental.

### poly~ (polyphonic voices)

**Detect (keywords):** poly~, polyphony / polyphonic, N-voice synth, voice allocation, voice stealing, thispoly~. "voice" alone (vocal processing, harmonizer voices) is not poly~.

**Object references:** `poly~`, `mc.poly~`, `thispoly~`, `in`, `in~`, `out`, `out~`, `adsr~`

**Agents:**
- lead max-dsp-agent (the voice abstraction);
- plus max-patch-agent for the host: notes to `midinote` / `note` / `target` messages, the voice file and the `poly~ <voice> N` arguments, `thispoly~` busy / mute;
- plus max-ui-agent for host controls.

**Pass to specialists:** proven-forms.md "poly~ voices"; troubleshooting.md (`No such object` when the voice file is not next to the host).

**Checks:**
- the voice is a separate .maxpat next to the host, and the walker never loads it, so run `validate_patch` and `review_patch` on the voice file too;
- inside the voice, use `in` / `in~` / `out` / `out~` (not `inlet` / `outlet`) for poly~ I/O;
- new inlets on a shared voice abstraction go rightmost.

## Ambiguity Resolution

When keywords match multiple domains:

1. **Count primary keyword matches** per domain -- highest count wins lead
2. **Check intent patterns** -- strongest match determines lead
3. **Default lead hierarchy:** DSP > Patch > js > UI (for tie-breaking)

Domain overlays (see "Domain Overlays" above) are applied before the default lead hierarchy.

### Edge Cases

Some terms are ambiguous between data/control operations and audio/signal operations. The table below includes explicit disambiguation for common cases. When the user's description is still ambiguous after checking these rules, prefer the DSP interpretation if the project context includes audio objects, otherwise prefer the data/control interpretation.

| Task Description | Agents | Lead | Reasoning |
|-----------------|--------|------|-----------|
| "synth with knobs" | DSP + UI | DSP | Audio generation is primary |
| "MIDI step sequencer" | Patch | Patch | Control-rate sequencing |
| "gen~ waveshaper" | DSP | DSP | Pure DSP task |
| "data parser in js" | js | js | Pure JavaScript task |
| "audio visualizer" | DSP + UI + js | DSP | Signal analysis drives display |
| "preset manager" | Patch + js | Patch | Patch routing with js storage |
| "export synth as VST" | RNBO | RNBO | Export target dispatch |
| "filter the data" | js or Patch | js | Data filtering = JavaScript array ops, not audio |
| "audio filter" / "lowpass filter" | DSP | DSP | Audio filtering = signal processing (biquad~, onepole~, svf~) |
| "buffer management" / "load samples into buffer~" | DSP | DSP | buffer~ is MSP domain, sample playback/recording |
| "buffer data" / "buffer array" | js or Patch | js/Patch | Data buffering = storing/queuing values, not audio buffers |
| "gen~ buffer" / "Buffer operator" | DSP | DSP | Gen~ Buffer/Data operators for sample access inside gen~ |
| "delay messages" / "delayed bang" | Patch | Patch | Control-rate delay = delay/pipe objects |
| "delay effect" / "audio delay" | DSP | DSP | Signal delay = tapin~/tapout~ or gen~ Delay operator |
| "video mixer with crossfade" | Patch (Jitter) | Patch | Jitter overlay: matrix routing with jit.xfade |
| "audio-reactive 3D visuals" | Patch (Jitter) + DSP | Patch | Jitter overlay; DSP for the audio analysis and jit.catch~ bridge |
| "mod matrix for a synth" | DSP | DSP | "matrix" alone is not Jitter |
| "M4L audio effect" | DSP (M4L) + UI | DSP | M4L overlay: plugin~ -> plugout~ audio device |
| "M4L MIDI effect" | Patch (M4L) + UI | Patch | M4L overlay: MIDI device, control flow |
| "8-voice poly synth" | DSP (poly~) + Patch | DSP | poly~ overlay: voice abstraction leads, host patch secondary |
| "polyphonic M4L instrument" | DSP (M4L + poly~) + Patch + UI | DSP | Both overlays; M4L lead, both overlays' reading and checks |
| "live input looper" | DSP | DSP | "live" alone is not M4L |

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
