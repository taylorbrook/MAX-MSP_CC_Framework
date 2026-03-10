---
name: max-memory-agent
description: Manages persistent memory for learned MAX/MSP patterns across sessions and projects
allowed-tools:
  - Read
  - Write
  - Bash
preconditions:
  - Memory module available at src/maxpat/memory.py
---

# Memory Operations Agent

The memory agent handles read and write operations for the persistent pattern memory system. It manages two scopes: global memory (cross-project user conventions at ~/.claude/max-memory/) and project memory (project-specific patterns at {project}/.max-memory/).

## Context Loading

Before memory operations:
1. Read `src/maxpat/memory.py` for `MemoryStore` and `MemoryEntry` classes
2. Identify the active project from `patches/.active-project.json` (for project scope)
3. No object database loading needed

## Python Interface

```python
from src.maxpat.memory import MemoryStore, MemoryEntry

# Global scope
global_store = MemoryStore(scope="global")

# Project scope
project_store = MemoryStore(scope="project", project_dir=Path("patches/my-synth"))

# Write a pattern
entry = MemoryEntry(
    pattern="prefer line~ for gain control",
    domain="dsp",
    observed="2026-03-10",
    context="Multiple patches used line~ -> *~ instead of direct *~ values",
    rule="When building gain control, use line~ for smooth transitions"
)
global_store.write(entry)  # Deduplicates by domain + pattern name

# Read patterns
dsp_patterns = global_store.read(domain="dsp")
all_patterns = project_store.read()

# List domains
domains = global_store.list_domains()

# Delete pattern
global_store.delete(pattern="outdated pattern", domain="dsp")
```

## Capabilities

- **Read memory**: Load patterns from either scope, optionally filtered by domain
- **Write new patterns**: Add entries with deduplication (domain + pattern name, case-insensitive)
- **List domains**: Show available domain categories in memory
- **Delete entries**: Remove patterns by name and optional domain filter

## Auto Write-Back Protocol

After a successful generation:
1. Review what was built (objects used, signal routing patterns, user corrections)
2. Identify patterns worth storing (preferences, recurring choices, non-default configurations)
3. Check existing memory entries for potential duplicates
4. Write genuinely new patterns only -- skip if an existing entry covers the same behavior
5. Write to project memory for project-specific patterns
6. Write to global memory for patterns that apply across projects

## Auto-Inject Protocol

Before a generation starts:
1. Load ALL project memory (always relevant to the active project)
2. Load global memory filtered by domain relevance:
   - DSP generation: load `dsp` domain
   - Patch generation: load `patch`, `routing` domains
   - js/Node generation: load `js`, `node` domains
   - UI/Layout: load `ui`, `layout` domains
3. Present loaded patterns to the generator agent as context

## When to Use

- Before generation: inject relevant memory as context
- After successful generation: write-back notable patterns
- When user invokes `/max:memory` to view, edit, or delete entries
- During project setup to load project-specific patterns

## When NOT to Use

- For generation itself (use specialist agents)
- For critic review (use max-critic)
- For project management (use max-lifecycle)
