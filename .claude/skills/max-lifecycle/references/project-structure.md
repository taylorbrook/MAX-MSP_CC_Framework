# Project Directory Structure

Standard layout for MAX projects created by `/max-new`.

## Directory Layout

```
patches/
  .active-project.json      # Tracks which project is currently active
  {project-name}/
    config.json             # Package selection (which packages this project uses)
    versions.json           # Version history (semver, auto-created at 0.0.0)
    context.md              # Project vision, requirements, clarifying answers
    status.md               # Current stage, progress, created date
    generated/              # All generated output files
      *.maxpat              # MAX patches
      *.gendsp              # Gen~ patches
      *.js                  # Node for Max or js scripts
    test-results/           # Manual test result records
      test-001.md           # Individual test run results
```

## File Details

### .active-project.json
```json
{
  "name": "my-synth",
  "activated": "2026-03-10T14:00:00Z"
}
```

### config.json
Package configuration for the project. Created during `/max-new` after the user selects packages. Can be edited directly or via `/max-config`.
```json
{
  "packages": ["BEAP", "Vizzie"]
}
```
Package names match keys in `.claude/max-objects/package_info.json`. An empty list means core objects only. If this file does not exist, the project has not been configured for packages yet -- `/max-build` will block until packages are configured.

### versions.json
Semver version history, auto-created at `0.0.0` when a project is created. Each entry records the version number, a description of what changed, and an ISO timestamp.
```json
{
  "versions": [
    {
      "version": "0.0.0",
      "description": "Initial version",
      "timestamp": "2026-03-12T00:00:00+00:00"
    },
    {
      "version": "0.0.1",
      "description": "Fixed oscillator frequency mapping",
      "timestamp": "2026-03-12T01:30:00+00:00"
    }
  ]
}
```
Versions are stored oldest-first on disk. Use `list_versions(project_dir)` to get them newest-first.

### context.md
Populated during `/max-discuss` or conversational kickoff in `/max-new`. Contains:
- Project description and goals
- Audio/MIDI requirements
- Signal flow description (inputs, processing, outputs)
- UI needs (controls, displays, panels)
- Any specific object preferences or constraints

### status.md
Simple key-value format:
```
stage: build
progress: 2/5 patches generated
created: 2026-03-10T14:00:00Z
updated: 2026-03-10T15:30:00Z
```

### generated/
All output from specialist agents. Files written via `save_patch_roundtrip()`, `write_gendsp()`, `write_js()` hooks which trigger validation on write.

### test-results/
Manual test results from `/max-test` runs. Each file is a completed checklist with Pass/Fail markings.
