# Status Tracking

Stage definitions and progress format for MAX project lifecycle.

## Stages

Projects move through these stages (mirroring the GSD workflow):

| Stage | Description | Triggered By |
|-------|-------------|--------------|
| ideation | Initial project creation, no details yet | `/max:new` |
| discuss | Capturing requirements and vision | `/max:discuss` |
| research | Investigating MAX approaches and patterns | `/max:research` |
| build | Active generation of patches and code | `/max:build` |
| verify | Testing and validation of generated output | `/max:test` or `/max:verify` |

Stages are not strictly linear -- a project can return to earlier stages (e.g., from build back to discuss if requirements change).

## Progress Format

Progress is tracked in `status.md` as a simple string:

```
progress: 2/5 patches generated
progress: critic review in progress
progress: all tests passing
progress: initial setup
```

The format is free-text to accommodate different project types. The lifecycle agent updates it after significant actions.

## Status Operations

### Read Status
```python
status = read_status(project_dir)
# Returns: {"stage": "build", "progress": "2/5 patches generated", "created": "...", "updated": "..."}
```

### Update Status
```python
update_status(project_dir, stage="verify", progress="test checklist generated")
# Updates stage, progress, and sets updated timestamp
```

## Display Format

When showing status (via `/max:status`):

```
Project: my-synth
Stage: build
Progress: 2/5 patches generated
Created: 2026-03-10
Last Updated: 2026-03-10

Files:
  generated/my-synth.maxpat
  generated/filter-env.gendsp
  generated/midi-handler.js
```
