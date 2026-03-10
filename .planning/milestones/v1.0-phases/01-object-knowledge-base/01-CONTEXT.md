# Phase 1: Object Knowledge Base - Context

**Gathered:** 2026-03-09
**Status:** Ready for planning

<domain>
## Phase Boundary

Structured database of all MAX objects extracted from the local MAX installation's XML refpages, plus a CLAUDE.md with opinionated MAX/MSP development rules and domain-specific conventions. This phase builds the foundation that every subsequent phase depends on — no patch generation, no validation, no agents. Just the knowledge base and the rules.

</domain>

<decisions>
## Implementation Decisions

### Object coverage scope
- Extract all 1,924 maxref XML files from the MAX installation upfront — automated extraction means marginal cost per object is near-zero
- Apply equal curation depth across all domains (Max, MSP, Jitter, MC, Gen~, RNBO~) — no domain gets shortchanged
- Objects with variable inlet/outlet counts (pack, route, select, etc.) store the default count plus a rule describing how arguments change them — validators apply rules at generation time
- RNBO-compatible subset marked as a flag per object (`rnbo_compatible: true/false`), not a separate whitelist — single source of truth

### Knowledge base access
- Claude's discretion on access pattern — optimize for highest quality and lowest error likelihood
- Query interface supports both name-based lookup ("look up cycle~") and domain/category browsing ("list all MSP filter objects")
- Include object relationships from XML seealsolist and common pairings (tapin~/tapout~, notein/stripnote, loadbang/trigger) — helps Claude suggest correct companion objects
- Hot/cold inlet semantics marked in the database from Phase 1 — not deferred to Phase 2

### CLAUDE.md conventions
- #1 rule: Never guess objects — if an object isn't in the database, Claude must not use it. No hallucinating names, inlet counts, or behaviors from training data
- Opinionated style enforcement: top-to-bottom signal flow, explicit trigger objects for fan-out, comments on non-obvious connections, named sends/receives over long patch cords
- Domain-specific rule sections: MSP (signal termination, gain staging), Gen~ (History patterns, in/out binding), RNBO (export constraints), N4M (max-api patterns)
- PD/MAX confusion guard: Claude's discretion on whether to maintain an explicit blocklist or rely on DB-only enforcement — include blocklist if it proves useful, skip if DB rejection is sufficient

### Source trust hierarchy
- MAX installation XML refpages are the authoritative source — they're from Cycling '74 and match the installed version
- py2max is secondary for gap-filling where XML is incomplete or ambiguous
- Incomplete objects: flag + best effort — extract what's available, mark incomplete fields with a confidence flag (`verified: false`), validators warn but don't block
- Override layer: separate overrides file where expert corrections take precedence over extracted data — base data stays clean from extraction, overrides survive re-extraction
- No spot-check validation against MAX-saved patches — trust the extraction pipeline
- Version tracking: per-object `min_version` and optional `max_version` fields — MAX 9 additions marked as `min_version: 9`

### Claude's Discretion
- Database storage format (SQLite vs JSON files vs hybrid) — optimize for access quality
- Access pattern implementation (context injection, tool-based lookup, domain slices, or combination)
- PD blocklist inclusion — use judgment on whether it's needed given DB enforcement
- Extraction script architecture and implementation details

</decisions>

<specifics>
## Specific Ideas

- User is an expert MAX/MSP user — framework speaks MAX fluently, no hand-holding on object behavior
- Object database is the single most critical component — every other feature depends on it
- Research identifies object hallucination as the #1 LLM failure mode for MAX development
- Architecture research suggests JSON files per domain namespace as the reference format

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- No existing code — this is Phase 1 of a fresh project

### Established Patterns
- Plugin Freedom System at `/Users/taylorbrook/Dev/VST-development/` provides proven architecture patterns (agents, skills, hooks, Python scripts)
- py2max library available via pip for .maxpat generation reference

### Integration Points
- MAX installation at `/Applications/Max.app/` — 1,175 core + 189 Gen + 560 RNBO = 1,924 XML refpage files
- py2max MaxRef database (1,157 documented objects) — secondary data source
- Framework lives in `.claude/` directory structure per architecture research

</code_context>

<deferred>
## Deferred Ideas

None — discussion stayed within phase scope

</deferred>

---

*Phase: 01-object-knowledge-base*
*Context gathered: 2026-03-09*
