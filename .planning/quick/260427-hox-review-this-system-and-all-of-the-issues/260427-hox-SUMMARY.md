---
phase: quick-260427-hox
plan: 01
status: complete
type: meta-review
date: 2026-04-27
tags:
  - meta-review
  - synthesis
  - feedback-memories
  - improvements
key-files:
  created:
    - .planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-FINDINGS.md
    - .planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-PLAN.md
  modified: []
decisions:
  - "Synthesis-only review per user direction (no code changes, no quick wins applied in this pass)"
  - "Cross-referenced 30 feedback memories + 4 prior reviews (j15, n24, bbh, w95) + current DB/validator/critic state"
  - "Recommended P0-5 (CLAUDE.md drift audit) as cheapest next quick task"
  - "Recommended v5.0 milestone scoped around schema improvements (signal_role, install-state) + validator hardening (fan-out hard-error, .gendsp validation)"
metrics:
  duration: "~25 min"
  feedback_memories_reviewed: 30
  prior_reviews_referenced: 4
  recommendations_identified: 15 (P0:5, P1:6, P2:5)
---

# Quick Task 260427-hox: System Review Summary

Meta-review of the MAX framework after v4.0 ship. Synthesized 30 feedback memories with recent quick-task history and current code state to identify recurring root causes and prioritize improvements.

## Headline Findings

The framework's connection-level correctness is solid. Recurring issues cluster in **four pressure points**:

1. **Object DB is a leaky abstraction** — extraction errors (outlet types, maxclass, missing entries), 130 empty-I/O entries remain, stale aspirational entries (`bach.llll2list`)
2. **Validator catches connection-level bugs but not behavioral bugs** — fan-out-without-trigger has 8–16 instances per patch and is only a warning; external `.gendsp` files bypass validation
3. **CLAUDE.md / SKILL.md drift from reality** — multiple feedback memories exist *because* CLAUDE.md is wrong
4. **Editing API has sharp edges** — `replace_box` orphans connections silently; `lookup()` returns hits with empty I/O

## Top 10 Recommendations (Ranked)

1. CLAUDE.md drift audit against 30 memories *(P0-5, cheap)*
2. Per-outlet `signal_role` schema *(P0-3, high leverage)*
3. Promote fan-out-without-trigger to hard error *(P0-1)*
4. Validate external `.gendsp` files *(P0-2)*
5. `replace_box_safe` with auto-rewire by default *(P1-1)*
6. `lookup_strict()` rejecting empty-I/O entries *(P1-2)*
7. Install-state DB tag *(P0-4)*
8. Companion-pair layout patterns *(P1-3)*
9. Domain-restricted object guard (RNBO at MSP level) *(P1-4)*
10. DSP simulation harness for waveguides *(P2-1)*

## Suggested Path Forward

- **Immediate:** Run P0-5 (CLAUDE.md drift audit) as next quick task — cheapest win.
- **v5.0 milestone proposal:** Cluster schema improvements (P0-3 + P0-4) + validator hardening (P0-1 + P0-2) + editing-API safety (P1-1 + P1-2). Coherent scope, addresses the actual recurring problem surface.

## Deliverables

- `260427-hox-FINDINGS.md` — full pattern analysis, prioritized recommendations, layout-specific observations, DB health snapshot, top-10 ranking
- `260427-hox-PLAN.md` — task scope and boundaries
- `260427-hox-SUMMARY.md` — this file

## Self-Check

- 30 feedback memories cross-referenced ✓
- 4 prior reviews referenced (j15, n24, bbh, w95) ✓
- Current DB state captured (130 critical empty I/O, 34 variable_io_ok) ✓
- Validator structure mapped (1139 lines, 13 Layer-4 checks) ✓
- Critic modules sized (7 modules, ~2070 lines) ✓
- Patcher.py size tracked (2094 lines, down from 2827 in n24 review) ✓
- 15 recommendations classified P0/P1/P2 ✓
- No source code modified (synthesis-only per user direction) ✓
