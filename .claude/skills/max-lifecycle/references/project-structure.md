# Project Directory Structure

Standard layout for MAX projects created by `/max:new`.

## Directory Layout

```
patches/
  .active-project.json      # Tracks which project is currently active
  {project-name}/
    context.md              # Project vision, requirements, clarifying answers
    status.md               # Current stage, progress, created date
    .max-memory/
      patterns.md           # Project-specific learned patterns
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

### context.md
Populated during `/max:discuss` or conversational kickoff in `/max:new`. Contains:
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

### .max-memory/patterns.md
Project-specific patterns in structured markdown sections. Managed by the memory agent.

### generated/
All output from specialist agents. Files written via `write_patch()`, `write_gendsp()`, `write_js()` hooks which trigger validation on write.

### test-results/
Manual test results from `/max:test` runs. Each file is a completed checklist with Pass/Fail markings.
