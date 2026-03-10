---
name: max-memory
description: View, list, or manage stored MAX pattern memories
argument-hint: "[list|view|forget] [domain?]"
---

# /max-memory

View, list, or manage the persistent pattern memory system that stores learned MAX/MSP conventions across sessions and projects.

## Behavior

### Subcommands

**`list`** -- Show all memory domains with entry counts for both scopes:
- Global memory (`~/.claude/max-memory/`) -- patterns that apply across all projects
- Project memory (`{project}/.max-memory/`) -- patterns specific to the active project
- Display domain names and entry count per domain

**`view [domain]`** -- Show all memory entries:
- If domain provided (e.g., `dsp`, `patch`, `ui`): show entries for that domain only
- If no domain: show all entries across all domains
- Display each entry with: pattern name, domain, observation date, context, rule

**`forget [pattern-name] [domain]`** -- Delete a specific memory entry:
- Requires the exact pattern name to delete
- Optional domain to disambiguate if the same pattern exists in multiple domains
- Confirms deletion before proceeding

## Memory Scopes

The memory system has two scopes, both managed via `MemoryStore` from `src.maxpat.memory`:

| Scope | Location | Purpose |
|-------|----------|---------|
| Global | `~/.claude/max-memory/` | Cross-project user conventions |
| Project | `{project}/.max-memory/` | Project-specific patterns |

## Skills Referenced

- **max-memory-agent** -- memory read, write, list, and delete operations

## Python Modules

```python
from src.maxpat.memory import MemoryStore, MemoryEntry
from src.maxpat.project import get_active_project
```

## Arguments

| Argument | Required | Description |
|----------|----------|-------------|
| subcommand | Yes | One of: `list`, `view`, `forget` |
| domain | No | Filter by domain (e.g., `dsp`, `patch`, `ui`, `js`, `routing`) |
| pattern-name | For `forget` | Exact name of the pattern to delete |

## Examples

```
/max-memory list
/max-memory view dsp
/max-memory view
/max-memory forget "prefer line~ for gain" dsp
```
