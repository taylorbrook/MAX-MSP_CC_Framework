---
name: max-research
description: Research MAX-specific approaches and techniques for the active project
argument-hint: "[topic?]"
---

# /max-research

Research MAX-specific approaches, object choices, signal flow patterns, and techniques relevant to the active project.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` to identify the current project. If no active project, prompt the user to create one with `/max-new`.

2. **Load project context** -- read the project's `context.md` for existing context and decisions.

3. **Research MAX approaches** -- investigate the topic using the object database:
   - Read relevant domain files from `.claude/max-objects/` (msp, gen, max, etc.)
   - Check `relationships.json` for common object pairings
   - Check `aliases.json` for shorthand references
   - Look up specific objects for inlet/outlet counts, arguments, messages
   - Consult the PD blocklist to avoid Pure Data object confusion

4. **Present findings** -- summarize research results including:
   - Recommended objects and why
   - Signal flow patterns for the approach
   - Alternative techniques with tradeoffs
   - Any version compatibility notes for MAX 9 objects used

5. **Write findings to context** -- append research results to the project's `context.md` under a "Research" section.

6. **Update status** -- set the project stage to "research" via `update_status()`.

## Skills Referenced

- **max-lifecycle** -- project context loading, status tracking

## Object Database

Read from `.claude/max-objects/` domains as needed:
- `max/objects.json` -- control flow, data, UI
- `msp/objects.json` -- audio/signal processing
- `gen/objects.json` -- Gen~ DSP operators
- `jitter/objects.json` -- video, matrix, OpenGL
- `mc/objects.json` -- multichannel wrappers

## Python Modules

```python
from src.maxpat.project import get_active_project, read_status, update_status
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| topic | No | Research focus (e.g., "granular synthesis approaches") |

## Examples

```
/max-research granular synthesis approaches
/max-research MIDI mapping patterns
/max-research gen~ waveshaping techniques
/max-research
```
