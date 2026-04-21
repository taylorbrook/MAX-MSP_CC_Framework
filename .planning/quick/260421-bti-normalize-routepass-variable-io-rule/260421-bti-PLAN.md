---
id: 260421-bti
title: Normalize routepass variable_io rule (DQ-02 judgment)
date: 2026-04-21
status: complete
type: quick
refs:
  - .planning/quick/260420-j15-review-the-objects-database-entries-and-/260420-j15-REVIEW.md DQ-02
  - .planning/quick/260421-b3a-refactor-variable-io-rules-to-single-sou/260421-b3a-PLAN.md
must_haves:
  - truths:
      - routepass has an explicit entry in overrides.json:variable_io_rules
      - outlet_count formula is the supported "arg_count+1" (not legacy "arg_count_plus_1")
      - default_outlets matches the routepass DB entry (2 outlets)
      - compute_io_counts("routepass", ["a","b"]) returns (1, 3)
  - artifacts:
      - .claude/max-objects/overrides.json (routepass default_outlets 3 → 2)
      - tests/test_db_lookup.py (bti-anchored regression test)
---

# Normalize routepass variable_io rule

**Scope:** REVIEW-260420-j15 DQ-02 judgment-required item — the routepass inline `io_rule.outlet_count="arg_count_plus_1"` doesn't match `_apply_io_formula`'s supported formula `"arg_count+1"`, which meant the inline rule was silently ignored before b3a.

**State on entry:** quick-260421-b3a already lifted routepass into `overrides.json:variable_io_rules` with the normalized formula. This quick task finishes the normalization by aligning `default_outlets` with the per-domain DB entry.

## Task list

### Task 1 — Normalize default_outlets to match DB entry

**files:** `.claude/max-objects/overrides.json`

**action:**
- Update the existing `variable_io_rules.routepass` entry:
  - `default_outlets: 3` → `default_outlets: 2`
  - Update description to reflect 2-outlet default
  - Extend `_audit` block to cite `quick-260421-bti` in addition to `review-260421-b3a`
- Keep `inlet_count: "fixed:1"`, `outlet_count: "arg_count+1"`, `default_inlets: 1` unchanged

**verify:** `jq '.variable_io_rules.routepass' .claude/max-objects/overrides.json` shows `default_outlets: 2`

**done:** Rule entry matches user spec exactly; `arg_count+1` formula has no behavioral change because it never falls through to default.

### Task 2 — Add bti-anchored regression test

**files:** `tests/test_db_lookup.py`

**action:**
- Add `test_compute_io_counts_routepass_normalized_default_outlets` asserting `compute_io_counts("routepass", ["a","b"]) == (1, 3)`
- Include docstring referencing quick-260421-bti and explaining the redundancy-with-purpose: existing b3a test covers behavior; this test anchors this task's spec so future default_outlets drift gets a traceable regression signal

**verify:** `pytest tests/test_db_lookup.py -x -q` — 26 passed (25 baseline + 1 new)

**done:** New test passes alongside existing routepass test
