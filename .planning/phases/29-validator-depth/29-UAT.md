---
status: complete
phase: 29-validator-depth
source: [29-01-SUMMARY.md, 29-02-SUMMARY.md, 29-03-SUMMARY.md, 29-04-SUMMARY.md, 29-05-SUMMARY.md]
started: 2026-04-28T00:00:00Z
updated: 2026-04-29T00:00:00Z
---

## Current Test

[testing complete]

## Tests

### 1. Phase 29 test suites green
expected: Running `python3 -m pytest tests/test_schema_extensions.py tests/test_code_validation.py tests/test_validation.py -q --deselect "tests/test_validation.py::TestCommunityPackageBlock::test_community_block_warning" --deselect "tests/test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message"` reports 184+ passed, 2 deselected, 0 failed (47 schema-extensions + 32 code-validation + 105+ validation).
result: pass
evidence: 185 passed, 2 deselected, 4 warnings, 0 failures (warnings are pre-existing empty-I/O on read/ezdac~/print/send~, documented in 29-VERIFICATION.md anti-patterns). One extra test vs predicted 184 — net positive, no regressions.

### 2. Install-state warning fires once-per-name (Plan 01 / VALID-03)
expected: Probe constructs ObjectDatabase, clears `_install_warned`, calls `db.lookup('bach.llll2list')` twice inside `warnings.catch_warnings(record=True)` — exactly one UserWarning captured (second call silent), message references `bach.llll2list` and "Run package extraction or remove from". `cycle~` lookup emits zero warnings.
result: pass
evidence: 1 warning captured for bach.llll2list (msg: "bach.llll2list marked verified_installed: false — not present in this install. Run package extraction or remove from overrides.json if intentional."). cycle~: 0 warnings. D-09/D-10/D-11 contracts confirmed live.

### 3. GenExpr Check 7 — delay() rejected (Plan 02 / D-14)
expected: Trigger case emits one `('code','error', ...)` with "delay() is not supported"; word-bound skip cases (Delay/myDelay.read) emit zero.
result: pass
evidence: trigger -> ('code','error','delay() is not supported in GenExpr codebox; use Delay.read/write (declare Delay myDelay(max_samples) first)'). skip -> 0 delay() findings. Pre-existing 'read'/'write' empty-I/O UserWarnings from db.lookup are noise, not findings.

### 4. GenExpr Check 8 — clip() rejected (Plan 02 / D-15)
expected: One `('code','error', ...)` finding stating clip is unsupported and pointing to `min(max(...))`.
result: pass
evidence: ('code','error','clip() does not exist in expr/GenExpr; use min(max(x, lo), hi)'). D-15 contract met verbatim.

### 5. GenExpr Check 9 — init-before-if/else (Plan 02 / D-16, D-20)
expected: Multi-line code `if (in1 > 0) {\n  y = in1 * 2;\n}\nout1 = y;` returns one `('code','error', ...)` finding naming variable `y`, instructing to assign before the if/else block, and containing the lowercase substring `if this is a false positive` (D-20).
result: pass
evidence: ('code','error',"variable 'y' used inside if/else without prior init (line 1); GenExpr errors with 'not defined'. Restructure to assign 'y' before the if/else, or if this is a false positive (e.g., shadowed inner declaration), declare via Param/History/Delay/Buffer/Data."). Names 'y', contains D-20 substring. (Initial single-line probe missed — that form is the documented false-negative covered by test_check9_single_line_if_block_false_negative.)

### 6. Role-aware tier dispatch — TestRoleAwareValidation green (Plan 03 / VALID-01)
expected: 10/10 TestRoleAwareValidation pass (4 ERROR rows + 2 WARNING rows + audio fall-through + audio-key absence + uncurated fall-through + severity contract); `_ROLE_TIER_TABLE` has no `('audio','signal')` key, has `('status','signal')`.
result: pass
evidence: 10 passed in 0.04s. _ROLE_TIER_TABLE invariants confirmed live. R2/R10/D-19 contracts all green.

### 7. Domain guard — floor~ at top-level errors, silent inside gen~ (Plan 04 / VALID-02, D-07)
expected: TestDomainGuard 5/5 pass; manual probe: top-level floor~ → 1 `[domain:error]` with floor~ + ['rnbo'] + Wrap in suggestion; nested in gen~ → 0 domain errors.
result: pass
evidence: 5 passed in 0.04s. Live probe top-level floor~ → ('domain','error',"'floor~' is restricted to ['rnbo']; not allowed at MSP/Max top level. Wrap in rnbo~ container or use a non-restricted equivalent."). Same floor~ inside gen~ → 0 findings. D-07 + D-08 contracts confirmed.

### 8. Embedded codebox walker — gen~ codebox findings tagged (Plan 05 / VALID-04, D-13/D-17)
expected: TestEmbeddedGenExpr 8/8 pass. Manual probe: top-level gen~ (id g1) + codebox `out1 = delay(in1, 100);` → one `[code:error]` tagged `gen~ 'g1' codebox:` containing Check 7 body. Clean codebox emits zero error findings.
result: pass
evidence: 8 passed in 0.05s. Trigger probe → ('code','error',"gen~ 'g1' codebox: delay() is not supported in GenExpr codebox; use Delay.read/write (declare Delay myDelay(max_samples) first)"). Clean probe → 0 error findings (1 info-level "Detected I/O: 1 input(s), 1 output(s)" from Check 6 is normal). Layer="code" preserved through walker per D-17.

## Summary

total: 8
passed: 8
issues: 0
pending: 0
skipped: 0

## Gaps

[none yet]
