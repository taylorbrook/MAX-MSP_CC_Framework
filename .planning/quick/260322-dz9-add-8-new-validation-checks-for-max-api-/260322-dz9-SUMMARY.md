---
phase: quick-260322-dz9
plan: 01
subsystem: validation
tags: [genexpr, umenu, multislider, line~, gen~, inlet, outlet, regex]

requires:
  - phase: quick-260322-c7w
    provides: validation pipeline with domain checks and ctrl_adj pattern
provides:
  - 8 new domain-level validation sub-functions for MAX API misuse detection
  - ctrl_adj control adjacency map for connection-aware checks
affects: [validation, patch-generation, iterate-workflow]

tech-stack:
  added: []
  patterns: [regex-based codebox code scanning, ctrl_adj for non-signal connection tracing]

key-files:
  created: []
  modified:
    - src/maxpat/validation.py
    - tests/test_validation.py

key-decisions:
  - "ctrl_adj built in same loop pass as signal_adj (second iteration over lines) for clean separation"
  - "Test filters use unique message substrings (e.g. 'replaces ramps') to avoid collisions with existing domain warnings"

patterns-established:
  - "Domain check pattern: _check_* returns list[ValidationResult], called from _validate_domain_rules"
  - "Connection-aware checks receive ctrl_adj alongside box_lookup"

requirements-completed: [VAL-GENEXPR-IO, VAL-GENEXPR-DELAY, VAL-GEN-PARAM-MSG, VAL-COMMENT-HASH, VAL-LINE-COMMA, VAL-MULTISLIDER-FETCH, VAL-UMENU-ITEMS, VAL-ASSISTANCE-COMMENTS]

duration: 3min
completed: 2026-03-22
---

# Quick Task 260322-dz9: 8 New Validation Checks Summary

**8 domain-level validation checks catching GenExpr syntax errors, message formatting mistakes, umenu item format, and missing assistance comments**

## Performance

- **Duration:** 3 min
- **Started:** 2026-03-22T17:07:49Z
- **Completed:** 2026-03-22T17:10:33Z
- **Tasks:** 2
- **Files modified:** 2

## Accomplishments
- 8 new `_check_*` sub-functions in validation.py catching common MAX API misunderstandings
- ctrl_adj control adjacency map for connection-aware checks (gen~ @param, line~ comma)
- 21 new tests covering positive triggers, negative (no false positive), and edge cases
- 108 total tests pass (64 validation + 44 critics), zero regressions

## Task Commits

Each task was committed atomically:

1. **Task 1 RED: Failing tests** - `7de723f` (test)
2. **Task 1 GREEN: 8 validation sub-functions + wiring** - `f376fd6` (feat)

## Files Created/Modified
- `src/maxpat/validation.py` - 8 new _check_* functions, ctrl_adj map in _validate_domain_rules
- `tests/test_validation.py` - TestLayer4GenExprChecks class with 21 test methods

## Checks Implemented

| # | Function | Level | Catches |
|---|----------|-------|---------|
| 1 | `_check_genexpr_io_syntax` | error | `in 1`/`out 2` in codebox (should be `in1`/`out1`) |
| 2 | `_check_genexpr_delay_usage` | error | `delay()` in codebox (should be `Delay.read()`) |
| 3 | `_check_gen_param_message_syntax` | warning | `@depth $1` message to gen~ (should be `depth $1`) |
| 4 | `_check_comment_hash_substitution` | warning | `#1` in comment box (no substitution support) |
| 5 | `_check_line_tilde_comma_messages` | warning | Comma in message to line~ (replaces ramps) |
| 6 | `_check_multislider_fetchindex` | error | `fetchindex` message (should be `fetch`) |
| 7 | `_check_umenu_items_format` | warning | Items without comma separators |
| 8 | `_check_assistance_comments` | info | inlet/outlet missing comment tooltip |

## Decisions Made
- ctrl_adj built as a second pass over lines (separate from signal_adj loop) for clean code separation
- Test filters use unique message substrings to avoid false matches with existing domain warnings (e.g. "replaces ramps" not "line~")

## Deviations from Plan

### Auto-fixed Issues

**1. [Rule 1 - Bug] Fixed test filter collision for line~ comma check**
- **Found during:** Task 1 GREEN phase
- **Issue:** Test filtering on "line~" matched unrelated "unterminated signal chain" warning for line~ object
- **Fix:** Changed test filter to match "replaces ramps" (unique to the comma check message)
- **Files modified:** tests/test_validation.py
- **Committed in:** f376fd6

---

**Total deviations:** 1 auto-fixed (1 bug)
**Impact on plan:** Minor test filter fix, no scope change.

## Issues Encountered
None.

## Known Stubs
None -- all 8 checks fully implemented with real logic.

## User Setup Required
None - no external service configuration required.

---
*Phase: quick-260322-dz9*
*Completed: 2026-03-22*
