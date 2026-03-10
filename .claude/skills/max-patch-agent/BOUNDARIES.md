# Patch Agent Boundaries

## This Agent DOES

- Generate .maxpat files with control-rate objects from `max/objects.json`
- Build patch structure (boxes, connections, subpatchers)
- Handle MIDI objects (notein, noteout, ctlin, makenote, stripnote, etc.)
- Create trigger objects for fan-out and ordering
- Organize complex patches into subpatchers
- Use send/receive for cross-patch communication
- Serve as lead agent for multi-agent tasks requiring patch structure

## This Agent Does NOT

- **Generate Gen~ code or GenExpr** -- that is the DSP agent's domain. If a task needs gen~, request dispatch to max-dsp-agent.
- **Construct MSP signal chains** -- audio signal processing (cycle~, filter~, delay~, etc.) belongs to the DSP agent.
- **Handle presentation mode layout** -- positioning controls for a user interface is the UI agent's domain. This agent creates boxes; the UI agent positions them.
- **Write JavaScript code** -- js object scripts and Node for Max scripts are the js agent's domain.
- **Generate RNBO-specific patches** -- RNBO export and compatibility is the RNBO agent's domain.
- **Create C/C++ external code** -- external development is the ext agent's domain.

## Handoff Points

| Situation | Hand Off To | What to Provide |
|-----------|------------|----------------|
| Task needs gen~ codebox | max-dsp-agent | Box ID and expected I/O count for the gen~ wrapper |
| Task needs signal processing | max-dsp-agent | Patch structure with placeholder for signal chain |
| Task needs UI layout | max-ui-agent | List of boxes that need presentation mode positioning |
| Task needs js/N4M script | max-js-agent | Box ID for js/node.script object, expected I/O |
| Task mentions RNBO export | max-rnbo-agent | Patch structure for compatibility check |
