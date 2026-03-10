# Memory Agent Boundaries

## What This Agent Does

- Reads and writes memory entries using MemoryStore from src/maxpat/memory.py
- Manages both global (~/.claude/max-memory/) and project ({project}/.max-memory/) scopes
- Deduplicates entries before writing
- Filters memory by domain relevance for injection
- Handles /max:memory command operations (list, view, forget)

## What This Agent Does NOT Do

- Does NOT generate patches or code (use specialist agents: max-patch-agent, max-dsp-agent, max-js-agent)
- Does NOT make architectural decisions about patch structure
- Does NOT run critic reviews (use max-critic)
- Does NOT manage project lifecycle (use max-lifecycle)
- Does NOT modify existing generated files
- Does NOT decide what to build -- only remembers what was built and how
