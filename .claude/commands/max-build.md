---
name: max-build
description: Generate MAX patches and code via agent dispatch
argument-hint: "[description]"
---

# /max-build

Generate MAX/MSP patches, Gen~ code, JavaScript, or other artifacts by routing the user's description through the agent system. Creates new .maxpat files directly via the Patcher API -- no intermediary scripts.

## Behavior

1. **Load active project** -- read `patches/.active-project.json` for the current project. If no active project, prompt the user to create one with `/max-new`.

2. **Load project context** -- read the project's `context.md` for vision, decisions, and research.

3. **Route through max-router** -- invoke the max-router skill with:
   - The user's task description
   - Project context
   - The router analyzes keywords/intent and dispatches to specialist agent(s)

4. **Specialist generation** -- the router dispatches to one or more specialist agents:
   - max-patch-agent (control flow, routing, subpatchers)
   - max-dsp-agent (GenExpr, signal chains, audio)
   - max-js-agent (JavaScript, Node for Max)
   - max-ui-agent (presentation mode, layout, controls)
   - max-rnbo-agent (RNBO export, target validation, param mapping)
   - max-ext-agent (C++ externals, Min-DevKit scaffolding, build)

   Each specialist creates a `Patcher` instance, builds the patch structure using `add_box()` and `add_connection()`, then applies styling, layout, and validation via `_apply_auto_styling(patcher)`, `apply_layout(patcher)`, `validate_patch(patcher.to_dict())`.

5. **Critic loop** -- run the max-critic skill on generated output:
   - Invoke `review_patch(patch_dict, code_context)` from `src.maxpat.critics`
   - If blockers found: request revisions from the generator
   - If clean or warnings-only: approve output with inline annotations
   - Loop continues until clean (no hard round limit)

6. **Write output** -- save generated files via `save_patch_roundtrip(patcher.to_dict(), path)` to the project's `generated/` directory. No intermediary Python scripts are created at any point.

7. **Commit to git** -- after saving, `save_patch_roundtrip()` auto-commits the .maxpat file via `auto_commit_patch()`. If additional files were generated (e.g., .gendsp, .js) that were saved separately, run an explicit commit:
   ```python
   from src.maxpat.project import auto_commit_patch
   auto_commit_patch(project_dir, base_dir, description="build: {brief description}", files=[...all generated file paths...])
   ```
   This ensures work is committed to git immediately and cannot be lost to stash operations or other instances.

8. **Update status** -- set stage to "build" and increment progress via `update_status()`.

## Skills Referenced

- **max-router** -- task analysis and agent dispatch
- **max-critic** -- generate-review-revise quality loop
- **max-lifecycle** -- project context and status updates

## Python Modules

```python
from src.maxpat import Patcher, Box, _apply_auto_styling, apply_layout, validate_patch, save_patch_roundtrip, LayoutOptions
from src.maxpat.project import get_active_project, read_status, update_status, auto_commit_patch
from src.maxpat.critics import review_patch, CriticResult
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
