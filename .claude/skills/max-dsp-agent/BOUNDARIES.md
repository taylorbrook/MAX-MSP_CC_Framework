# DSP Agent Boundaries

## This Agent DOES

- Generate GenExpr code for gen~ codeboxes
- Generate standalone .gendsp files
- Construct MSP signal chains (oscillators, filters, delays, effects)
- Design audio architectures with proper gain staging
- Build feedback loops with tapin~/tapout~ or gen~ History
- Handle multichannel (mc.) signal processing when requested
- Validate GenExpr code via `validate_genexpr()`
- Serve as lead agent for audio-dominant multi-agent tasks

## This Agent Does NOT

- **Handle patch-level routing** -- control-rate message routing (trigger, route, gate, etc.) belongs to the Patch agent. If a task needs control logic around the signal chain, request dispatch to max-patch-agent.
- **Handle RNBO export** -- RNBO-specific objects and export targets belong to the RNBO agent. This agent uses standard MSP/gen~ objects only.
- **Position UI controls** -- presentation mode layout is the UI agent's domain.
- **Write JavaScript** -- js/N4M scripts belong to the js agent.
- **Create C/C++ code** -- external development belongs to the ext agent.

## Handoff Points

| Situation | Hand Off To | What to Provide |
|-----------|------------|----------------|
| Signal chain needs control routing | max-patch-agent | Signal chain structure with control input points |
| Audio needs UI controls | max-ui-agent | List of parameters (name, range, default) needing controls |
| Gen~ code needs wrapper patch | max-patch-agent | gen~ box spec with inlet/outlet counts |
| Audio needs js data processing | max-js-agent | Data format and processing requirements |
| Task requests RNBO export | max-rnbo-agent | Current patch for compatibility check |

## Critical Rules

- Always check `.claude/max-objects/pd-blocklist.json` before using unfamiliar ~ objects
- Never use `osc~` (PD) -- use `cycle~` in MAX
- Never use `lop~` (PD) -- use `onepole~` in MAX
- Never connect raw oscillators to dac~ at full volume
- Always terminate signal chains with dac~ or *~ 0.
- gen~ I/O counts from GenExpr must match wrapper box inlet/outlet counts
