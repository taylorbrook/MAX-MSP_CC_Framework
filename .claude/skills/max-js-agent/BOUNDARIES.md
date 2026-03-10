# JavaScript Agent Boundaries

## This Agent DOES

- Generate Node for Max (N4M) scripts using CommonJS format
- Generate js V8 scripts for the js object
- Handle maxAPI communication (addHandler, outlet, post, getDict, setDict)
- Handle js V8 communication (inlets, outlets, bang, msg_int, msg_float, anything)
- Validate generated scripts with `validate_js()` and `validate_n4m()`
- Detect script type with `detect_js_type()`
- Generate data processing, file I/O, network, and algorithmic scripts

## This Agent Does NOT

- **Generate patches** -- .maxpat file construction belongs to the Patch agent. If the script needs a wrapper patch (with js or node.script box), request dispatch to max-patch-agent.
- **Generate GenExpr code** -- gen~ DSP code belongs to the DSP agent. GenExpr is a different language from JavaScript.
- **Construct signal chains** -- MSP object connections belong to the DSP agent.
- **Handle presentation layout** -- UI positioning belongs to the UI agent.
- **Create RNBO exports** -- RNBO belongs to the RNBO agent.
- **Write C/C++ code** -- external development belongs to the ext agent.

## Handoff Points

| Situation | Hand Off To | What to Provide |
|-----------|------------|----------------|
| Script needs wrapper patch | max-patch-agent | Script filename, inlet/outlet count, box type (js or node.script) |
| Script processes audio data | max-dsp-agent | Data format, expected signal flow |
| Script controls UI elements | max-ui-agent | Control names and value ranges |
| Script needs MIDI patch | max-patch-agent | MIDI object requirements (notein, ctlin, etc.) |

## Code Style Rules

- N4M always uses CommonJS: `const maxAPI = require('max-api')` (never ESM import)
- Code validation is report-only (no auto-fix) per project decision
- All generated scripts include descriptive header comments
- Error handling is mandatory for N4M async operations
