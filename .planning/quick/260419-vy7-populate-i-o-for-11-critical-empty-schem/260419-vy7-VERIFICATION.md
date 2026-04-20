---
id: 260419-vy7
status: passed
date: 2026-04-20
---

# Quick Task 260419-vy7: Verification

## Must-Haves Check

| # | Must-have | Result |
|---|-----------|:------:|
| 1 | Override entries for all 11 target objects | ✅ verified via `is_overridden()` |
| 2 | Each inlet has {id, type, signal, hot, digest} | ✅ schema check on each entry |
| 3 | Each outlet has {id, type, signal, digest} | ✅ schema check on each entry |
| 4 | Each entry has _audit block (source, confidence=HIGH, date=2026-04-19) | ✅ grep 2026-04-19 in overrides.json |
| 5 | variable_io_rules entries for expr, expr~, codebox, codebox~, pan, pan~, bpatcher | ✅ 7 new rules added (funnel already present) |
| 6 | Validation command reports non-zero I/O for all 11 | ✅ see below |

## Validation Command Output

```
bpatcher 1 1
funnel 2 1
expr 1 1
expr~ 1 1
codebox 1 1
codebox~ 1 1
pan 2 2
pan~ 2 2
xfade 3 1
xfade~ 3 1
waveform~ 5 6
```

All 11 targets: inlet count > 0 AND outlet count > 0.

## Additional Sanity Checks

- `compute_io_counts("funnel", ["4"])` → `(4, 1)` ✓ (first_arg rule)
- `compute_io_counts("expr", [3 tokens])` → `(3, 1)` ✓ (arg_count rule)
- `compute_io_counts("codebox")` → `(1, 1)` ✓ (fixed:1 default)
- `get_outlet_types("pan~")` → `['signal', 'signal']` ✓
- `get_outlet_types("xfade~")` → `['signal']` ✓
- `get_outlet_types("codebox~")` → `['signal']` ✓
- `get_outlet_types("waveform~")` → 6 control outlets ✓
- JSON integrity: `overrides.json` parses cleanly (257 total object entries, 20 variable_io_rules)

## Status

**passed** — all must-haves met, validation command succeeds, supplementary checks clean.
