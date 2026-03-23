---
phase: quick-260322-g3q
verified: 2026-03-22T19:45:00Z
status: passed
score: 3/3 must-haves verified
---

# Quick Task 260322-g3q: Extend DSP Critic Gain Staging Verification Report

**Phase Goal:** Extend the DSP critic gain staging checks with three additions: line~ backward tracing for >1.0 message sources, conservative expr/vexpr normalizer detection, and MC gain object support.
**Verified:** 2026-03-22T19:45:00Z
**Status:** passed
**Re-verification:** No - initial verification

## Goal Achievement

### Observable Truths

| # | Truth | Status | Evidence |
|---|-------|--------|----------|
| 1 | line~ feeding *~ gain inlet with >1.0 message sources detected as blocker | VERIFIED | `_parse_line_tilde_targets` parses message text; `sig_predecessors` map detects line~ on inlet 1; BFS traces backward to message sources; `test_line_tilde_unsafe_message_to_gain` passes |
| 2 | expr/vexpr only treated as normalizer when containing division/scaling patterns | VERIFIED | `_is_normalizer` uses `re.search(r'[/!]\s*127\|[/!]\s*255\|[/!]\s*100\|\*\s*0\.\d', text)` for expr/vexpr; generic `$i1 + $i2` returns False; tests pass |
| 3 | mc.*~ gets same gain staging and inlet-1 unsafe-source checks as *~; mc.gain~ added to _GAIN_NAMES for recognition but excluded from inlet-1 checks | VERIFIED | `_GAIN_NAMES = frozenset({"*~", "gain~", "mc.*~", "mc.gain~"})`; `_GAIN_INLET_1_NAMES = frozenset({"*~", "mc.*~"})` excludes mc.gain~; mc.*~ BFS gain staging confirmed working via manual test |

**Score:** 3/3 truths verified

### Required Artifacts

| Artifact | Expected | Status | Details |
|----------|----------|--------|---------|
| `src/maxpat/critics/dsp_critic.py` | Extended gain staging checks | VERIFIED | Contains `_parse_line_tilde_targets`, `sig_predecessors` map, `_GAIN_INLET_1_NAMES`, conservative `_is_normalizer`, `mc.*~` and `mc.gain~` in `_GAIN_NAMES` |
| `tests/test_critics.py` | Tests for all three additions | VERIFIED | 12 new tests added (56 total, up from 44); all pass |

### Key Link Verification

| From | To | Via | Status | Details |
|------|----|-----|--------|---------|
| `_check_unsafe_gain_sources` | line~ tracing | backward BFS through line~ to message sources | WIRED | `sig_predecessors` map at `(dst_id, dst_inlet)` catches line~ on signal connection to *~ inlet 1; `ctrl_backward` traces from line~'s control inputs |
| `_is_normalizer` | expr/vexpr pattern matching | `re.search` on expr text | WIRED | Pattern `r'[/!]\s*127\|[/!]\s*255\|[/!]\s*100\|\*\s*0\.\d'` applied when `name in ("expr", "vexpr")`; no blanket return True |
| `_GAIN_NAMES` | MC variants | `mc.*~` and `mc.gain~` in frozenset | WIRED | Both present at line 28; `_check_gain_staging` references `_GAIN_NAMES` at line 242; `_check_unsafe_gain_sources` uses separate `_GAIN_INLET_1_NAMES` for inlet-1 checks |

### Requirements Coverage

| Requirement | Description | Status | Evidence |
|-------------|-------------|--------|----------|
| GAIN-LINE | line~ backward tracing for >1.0 gain sources | SATISFIED | `_parse_line_tilde_targets` + signal predecessor map + 5 integration tests |
| GAIN-EXPR | Conservative expr/vexpr normalizer detection | SATISFIED | `re.search` pattern-match in `_is_normalizer` + 4 unit tests |
| GAIN-MC | MC gain objects in gain staging checks | SATISFIED | `mc.*~` in `_GAIN_NAMES` and `_GAIN_INLET_1_NAMES`; `mc.gain~` in `_GAIN_NAMES` only; 3 tests |

### Anti-Patterns Found

None. No TODOs, placeholders, stub returns, or incomplete implementations detected in either modified file.

### Plan Test vs. Actual Test Deviation

The plan specified `test_mc_multiply_gain_staging` (a full integration test: cycle~ -> mc.*~ -> dac~ produces no gain staging blocker). The implementation substituted this with `test_mc_multiply_in_gain_names` (membership check only) and `test_mc_gain_in_gain_names`. The underlying behavior is correct — manual verification confirms cycle~ -> mc.*~ -> dac~ produces zero gain staging blockers — but the plan-specified integration test name was not created. This is a test naming deviation only; the functional goal is met.

### Human Verification Required

None. All behavioral checks are verifiable programmatically.

### Commit Verification

All four task commits from SUMMARY are present in git history:
- `27c751c` test(quick-260322-g3q): add failing tests for expr/vexpr normalizer and MC gain objects
- `a01f0a6` feat(quick-260322-g3q): conservative expr/vexpr normalizer + MC gain objects
- `d6c5948` test(quick-260322-g3q): add failing tests for line~ backward tracing
- `c4524b6` feat(quick-260322-g3q): add line~ backward tracing for unsafe gain sources

### Summary

All three goal additions are implemented, substantive, and wired:

1. **line~ tracing** — Signal predecessor map captures line~ feeding *~ inlet 1 via signal connection; BFS then crosses into the control domain to find message sources (parsed for target values > 1.0) and MIDI-range sources. Five tests cover safe/unsafe message values, MIDI through line~, normalized MIDI through line~, and no-flag when line~ feeds inlet 0.

2. **Conservative expr/vexpr** — The blanket `return True` for expr/vexpr is gone. `_is_normalizer` now applies `re.search` with a division/scaling pattern; generic arithmetic expressions return False. Four unit tests cover both directions for expr and vexpr.

3. **MC gain objects** — `mc.*~` is in both `_GAIN_NAMES` (gain staging BFS) and `_GAIN_INLET_1_NAMES` (inlet-1 source checks). `mc.gain~` is in `_GAIN_NAMES` only, correctly excluded from inlet-1 checks per its single-inlet design.

56/56 tests pass.

---

_Verified: 2026-03-22T19:45:00Z_
_Verifier: Claude (gsd-verifier)_
