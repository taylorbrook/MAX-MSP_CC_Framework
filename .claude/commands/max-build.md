---
name: max-build
description: Generate MAX patches and code via agent dispatch
argument-hint: "[description]"
---

# /max-build

Generate MAX/MSP patches, Gen~ code, JavaScript, or other artifacts by routing the user's description through the agent system.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` for the current project. If no active project, prompt the user to create one with `/max-new`.

2. **Load project context** -- read the project's `context.md` for vision, decisions, and research.

3. **Inject memory** -- use the max-memory-agent skill to load relevant patterns:
   - Load ALL project memory from `{project}/.max-memory/`
   - Load domain-filtered global memory from `~/.claude/max-memory/`

4. **Route through max-router** -- invoke the max-router skill with:
   - The user's task description
   - Project context
   - Relevant memory entries
   - The router analyzes keywords/intent and dispatches to specialist agent(s)

5. **Specialist generation** -- the router dispatches to one or more specialist agents:
   - max-patch-agent (control flow, routing, subpatchers)
   - max-dsp-agent (GenExpr, signal chains, audio)
   - max-js-agent (JavaScript, Node for Max)
   - max-ui-agent (presentation mode, layout, controls)
   - max-rnbo-agent (RNBO export -- stub, Phase 5)
   - max-ext-agent (externals -- stub, Phase 5)

6. **Critic loop** -- run the max-critic skill on generated output:
   - Invoke `review_patch(patch_dict, code_context)` from `src.maxpat.critics`
   - If blockers found: request revisions from the generator
   - If clean or warnings-only: approve output with inline annotations
   - Loop continues until clean (no hard round limit)

7. **Write output** -- save generated files to the project's `generated/` directory.

8. **Write-back memory** -- use the max-memory-agent to store notable patterns learned during generation.

9. **Update status** -- set stage to "build" and increment progress via `update_status()`.

## Skills Referenced

- **max-router** -- task analysis and agent dispatch
- **max-critic** -- generate-review-revise quality loop
- **max-memory-agent** -- memory injection and write-back
- **max-lifecycle** -- project context and status updates

## Python Modules

```python
from src.maxpat.project import get_active_project, read_status, update_status
from src.maxpat.critics import review_patch, CriticResult
from src.maxpat.memory import MemoryStore, MemoryEntry
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| description | Yes | What to build (e.g., "subtractive synth with filter envelope") |

## Examples

```
/max-build subtractive synth with filter envelope
/max-build gen~ waveshaper with drive and mix controls
/max-build MIDI-controlled step sequencer
/max-build node.script OSC message router
```
