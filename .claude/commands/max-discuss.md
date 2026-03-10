---
name: max-discuss
description: Capture implementation decisions for the active MAX project
argument-hint: "[topic?]"
---

# /max-discuss

Engage in a structured discussion about implementation decisions for the active MAX project.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` to identify the current project. If no active project, prompt the user to create one with `/max-new` or switch with `/max-switch`.

2. **Load project context** -- read the project's `context.md` for existing decisions and project vision.

3. **Engage in discussion** -- if a topic is provided, focus the discussion on that topic. If no topic, ask the user what aspect of the project they want to discuss. Common discussion areas:
   - Signal flow architecture (object chains, routing patterns)
   - Object selection (which MAX objects to use for specific tasks)
   - Audio design (synthesis approach, effects chain, gain staging)
   - UI/control design (what controls, how they map to parameters)
   - Performance considerations (poly~, gen~, efficiency)

4. **Capture decisions** -- as the discussion progresses, record decisions and rationale. Append them to the project's `context.md` under a "Decisions" section.

5. **Update status** -- set the project stage to "discuss" via `update_status()`.

## Skills Referenced

- **max-lifecycle** -- project context loading, status tracking

## Python Modules

```python
from src.maxpat.project import get_active_project, read_status, update_status
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| topic | No | Focus area for discussion (e.g., "filter design") |

## Examples

```
/max-discuss filter design
/max-discuss signal routing
/max-discuss
```
