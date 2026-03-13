# Phase 9: Object DB Corrections - Context

**Gathered:** 2026-03-13
**Status:** Ready for planning

<domain>
## Phase Boundary

Review Phase 8 audit results and merge verified corrections into overrides.json so that db_lookup.py returns accurate outlet types, inlet/outlet counts, and argument formats. This phase merges data -- it does not change db_lookup.py load logic or restructure the database.

</domain>

<decisions>
## Implementation Decisions

### Confidence threshold
- Auto-merge ALL confidence tiers: HIGH (176), MEDIUM (29), and HELP_PATCH (6) proposals
- Each merged entry retains `_audit` metadata fields (_audit_confidence, _audit_instances, _audit_agreement, _audit_source) -- db_lookup.py already skips underscore-prefixed keys
- MEDIUM and HELP_PATCH entries are tagged so they're identifiable for future review if issues arise

### Conflict resolution
- Case-by-case review for the 8 objects where audit contradicts existing manual overrides
- Conflicts presented inline during plan execution: show DB value, audit value, and help patch instance count for user approval
- Field-by-field merge when resolving -- preserve expert-correct fields, adopt audit-correct fields (e.g., keep manual outlets but take audit inlets)
- Resolved conflicts retain `_manual_original` field with the original manual entry for reference (underscore-prefixed, skipped by db_lookup)

### Empty I/O strategy
- All 72 objects with empty I/O data AND help patch coverage get populated in this phase
- Same override format as outlet-type corrections: full inlets/outlets arrays with id, type, signal, digest fields
- Remaining 121 objects with no help patch data: Claude's Discretion on handling (document and defer, or flag as known-empty)

### Override file structure
- Single overrides.json file with domain section comments (_domain_header keys between groups, e.g., `"_msp_section": "--- MSP Objects ---"`)
- No structural change to db_lookup.py merge logic required

### Merge tooling
- Rerunnable Python merge script at src/maxpat/audit/merger.py
- Reads proposed-overrides.json, applies confidence filters, detects conflicts, writes updated overrides.json
- Wired into existing audit CLI as --merge flag (audit --report to analyze, audit --merge to apply corrections)
- Merge script handles: confidence filtering, conflict detection, domain grouping, audit metadata insertion, manual entry preservation

### Claude's Discretion
- Handling of 121 uncovered empty-I/O objects (document vs flag vs defer)
- Internal merge script architecture (class structure, helper functions)
- Test strategy for the merge script itself
- Exact domain ordering in overrides.json

</decisions>

<specifics>
## Specific Ideas

- Existing 23 manual overrides in overrides.json represent expert knowledge from real MAX testing -- these are authoritative and must never be silently overwritten
- The `_audit` and `_manual_original` underscore-prefix pattern is elegant -- db_lookup.py already skips `_` keys, so metadata is free from a runtime perspective
- Merge script should be idempotent -- running it twice produces the same result

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `src/maxpat/audit/overrides.py` (OverrideGenerator): Already generates proposed-overrides.json with conflict detection -- merger.py can reuse its conflict identification logic
- `src/maxpat/audit/cli.py`: Existing argparse CLI -- add --merge flag alongside existing --report, --outlets, --widths flags
- `src/maxpat/db_lookup.py` (ObjectDatabase): Deep-merge logic at lines 73-81 already handles underscore-prefixed keys -- no changes needed for audit metadata

### Established Patterns
- Override format: flat `objects` dict keyed by object name, fields deep-merged onto base domain objects
- Underscore-prefixed keys (`_comment`, `_audit`, etc.) are metadata, skipped during merge
- Confidence scoring: HIGH (90%+), MEDIUM (70-89%), LOW (<70%), CONFLICT (multiple disagreeing values)
- Audit output co-located at `.claude/max-objects/audit/`

### Integration Points
- Input: `.claude/max-objects/audit/proposed-overrides.json` (211 proposals + 8 conflicts)
- Input: `.claude/max-objects/audit/empty-io-coverage.json` (72 objects with help data)
- Target: `.claude/max-objects/overrides.json` (currently 23 entries, will grow to ~230+)
- Validation: 624 existing tests must all pass after merge (regression gate per DBCX-03)

</code_context>

<deferred>
## Deferred Ideas

None -- discussion stayed within phase scope

</deferred>

---

*Phase: 09-object-db-corrections*
*Context gathered: 2026-03-13*
