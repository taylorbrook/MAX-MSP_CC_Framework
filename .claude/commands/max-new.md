---
name: max-new
description: Create a new MAX/MSP project and start conversational kickoff
argument-hint: "[project-name]"
---

# /max-new

Create a new MAX/MSP project with the given name and begin the conversational kickoff phase.

## Behavior

1. **Validate the project name** -- must be lowercase alphanumeric with hyphens only, matching `^[a-z0-9]+(-[a-z0-9]+)*$`. Reject names with leading/trailing hyphens, spaces, or uppercase letters.

2. **Create the project** using the lifecycle skill and Python project module:
   - Load `src/maxpat/project.py`
   - Call `create_project(name, base_dir)` to scaffold the full directory structure under `patches/{name}/`
   - Call `set_active_project(name, base_dir)` to make this the active project
   - `create_project()` also creates an empty `.maxpat` file at `patches/{name}/generated/{name}.maxpat` with canvas background color set. The user can open this in MAX immediately.
   - No intermediary Python scripts are created for new projects.

3. **Start conversational kickoff** -- ask the user to describe what they want to build, then ask 3-4 clarifying questions:
   - What audio/MIDI requirements does this project have? (audio input/output, MIDI in/out, both?)
   - What is the signal flow? (describe the chain from source to output)
   - Does this need a UI/presentation mode? If so, what controls?
   - Are there any specific MAX objects or techniques you want to use?

4. **Record answers** -- write the user's responses to the project's `context.md` file in the project directory.

5. **Update status** -- set the project stage to "ideation" via `update_status()`.

6. **Flow into discuss** -- after the kickoff conversation, automatically invoke `/max-discuss` to dive deeper into implementation decisions. Use the kickoff answers as the starting point — ask about signal flow architecture, object selection, audio design, and UI/control mapping as relevant to the project.

7. **Flow into research** -- after discussion decisions are captured, automatically invoke `/max-research` to investigate the best MAX objects, patterns, and techniques for the approach decided in discussion. Research findings are appended to `context.md`.

8. **Ready to build** -- after research completes, inform the user that the project is ready and suggest `/max-build` with a concrete description based on everything captured so far.

## Skills Referenced

- **max-lifecycle** -- project creation, status tracking, directory scaffolding

## Python Modules

```python
from src.maxpat.project import create_project, set_active_project, update_status
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| project-name | Yes | Lowercase name with hyphens (e.g., `my-synth`) |

## Examples

```
/max-new my-synth
/max-new step-sequencer
/max-new granular-delay
```

## Error Handling

- If no name provided: prompt the user for a project name
- If name is invalid: show the naming rules and ask for a corrected name
- If project already exists: warn the user and ask whether to switch to it instead
