---
phase: quick-260427-kbe
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/critics/structure_critic.py
  - tests/test_critics.py
autonomous: true
requirements:
  - QUICK-260427-kbe (P0-1 from 260427-hox-FINDINGS.md)
must_haves:
  truths:
    - "A control-rate fan-out (1 outlet → 2+ inlets) without a trigger object produces a CriticResult with severity=='blocker'"
    - "Signal-rate fan-out (~) continues to be skipped — no blocker, no warning"
    - "Trigger-mediated fan-out (source IS a trigger object) continues to be skipped — no blocker"
    - "All existing structure_critic tests still pass after the tier change"
    - "A new test asserts a 1-to-3 control fan-out yields severity=='blocker' (not 'warning')"
  artifacts:
    - path: "src/maxpat/critics/structure_critic.py"
      provides: "Fan-out detection emitting blocker tier instead of warning"
      contains: "CriticResult(\n            \"blocker\","
    - path: "tests/test_critics.py"
      provides: "Updated fan-out tests asserting blocker severity + new 1-to-3 control fan-out blocker test"
      contains: "test_fan_out_without_trigger_blocks"
  key_links:
    - from: "src/maxpat/critics/structure_critic.py:131"
      to: "src/maxpat/critics/base.py CriticResult"
      via: "severity argument"
      pattern: "CriticResult\\(\\s*\"blocker\""
    - from: "tests/test_critics.py TestStructureCritic"
      to: "structure_critic._check_fan_out_without_trigger"
      via: "review_structure(patch) result severity assertions"
      pattern: "severity == \"blocker\""
---

<objective>
Promote the structure critic's "fan-out without trigger" finding from `severity="warning"` to `severity="blocker"`. Per 260427-hox-FINDINGS.md §P0-1, agents currently produce 8–16 warning instances per patch and ignore the signal because it is non-blocking. Aligning this check with the existing blocker tier (used by dsp_critic, rnbo_critic, ext_critic, m4l_critic for similarly hard structural failures) forces agents to insert `trigger` objects per CLAUDE.md Rule #4.

**Severity name clarification:** the critic system uses `"blocker" | "warning" | "note"` (defined in `src/maxpat/critics/base.py`). The task description's "error severity / has_blocking_errors() returns True" is the *behavioral spirit* — `has_blocking_errors()` is a `validation.py` helper that operates on `ValidationResult.level == "error"`, not on `CriticResult`. There is no critic-side `has_blocking_errors()`. The right move is to use `"blocker"` so the finding sits in the same tier as gen~ I/O mismatch and other hard structural failures (which test_critics.py already filters via `[r for r in results if r.severity == "blocker"]`).

Scope guards (do NOT touch):
  - `_is_signal_object()` skip at line 119 — signal-rate fan-out stays exempt (Rule #3: all signal inlets are hot)
  - `_is_trigger_object()` skip at line 115 — trigger-mediated fan-out stays exempt
  - `_check_hot_cold_ordering()` and `_check_redundant_connections()` — out of scope, remain warnings
  - `validation.py has_blocking_errors()` and its `ValidationResult.level == "error"` semantics — out of scope; critic blockers do not flow into this helper today, and re-wiring that integration is a separate concern flagged in P2-4 of FINDINGS.md
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@src/maxpat/critics/structure_critic.py
@src/maxpat/critics/base.py
@.planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-FINDINGS.md

<interfaces>
<!-- Key types/contracts the executor needs. Extracted from codebase. -->
<!-- The executor should reference these directly — no codebase exploration needed. -->

From src/maxpat/critics/base.py:
```python
class CriticResult:
    """A single critic finding.

    Attributes:
        severity: "blocker", "warning", or "note".
        finding: Human-readable description of the issue.
        suggestion: Recommended fix or improvement.
    """
    __slots__ = ("severity", "finding", "suggestion")

    def __init__(self, severity: str, finding: str, suggestion: str): ...
```

Severity tier convention (already in use by sibling critics):
- `"blocker"` — hard fail (e.g., dsp_critic gen~ I/O mismatch line 128/139, rnbo_critic missing in~/out~ line 63, ext_critic missing MIN_EXTERNAL line 51)
- `"warning"` — advisory finding
- `"note"` — informational

From src/maxpat/critics/structure_critic.py (current fan-out emit, lines 131–138 — this is the ONLY line to change):
```python
results.append(CriticResult(
    "warning",   # ← change to "blocker"
    f"Fan-out without trigger: '{src_name}' ({src_id}) outlet "
    f"{src_outlet} connected to {len(destinations)} destinations "
    f"({', '.join(dst_names)}) -- execution order is undefined",
    f"Use a 'trigger' (t) object to explicitly control the order "
    f"of execution for multiple destinations",
))
```

From tests/test_critics.py — existing fan-out tests that MUST be updated:

Line 354–395: `_fan_out_no_trigger_patch()` fixture — 3 destinations from `metro 500` outlet 0 (control-rate, all non-signal destinations). This is already a 1-to-3 control fan-out and is the exact case the new blocker test needs.

Line 556–562: `test_fan_out_without_trigger_detected` — currently asserts `severity == "warning"`. Must update to assert `severity == "blocker"`.

Line 564–572: `test_fan_out_with_trigger_no_warning` — asserts NO fan warning when source is a trigger. Must keep behavior but verify against the blocker tier too (no fan finding at any severity).

Line 605–665: `test_review_patch_combines_both_critics` — asserts `has_fan_out` from review_patch. Severity-agnostic (uses `"fan" in r.finding.lower()`), so it continues to pass — but rename the inline comment "Should have both gain staging and fan-out warnings" → "blockers" for accuracy.
</interfaces>

Prior related work (for context only — do NOT re-implement):
- 260427-js3 added `replace_box_safe` (different P0-/P1- punch list item)
- 260427-hox FINDINGS.md §P0-1 is the source-of-truth for THIS task
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Update fan-out tests to assert blocker tier + add 1-to-3 control fan-out blocker assertion</name>
  <files>tests/test_critics.py</files>
  <behavior>
    - `test_fan_out_without_trigger_detected` (line 556) — change assertion from `severity == "warning"` to `severity == "blocker"`. The fixture `_fan_out_no_trigger_patch()` already constructs a 1-to-3 control fan-out (metro → counter, toggle, print) so it satisfies the new test requirement directly. Rename the test to `test_fan_out_without_trigger_blocks` to reflect the new tier (this also serves as the explicit "1-to-3 control fan-out now blocks" coverage required by the constraint).
    - `test_fan_out_with_trigger_no_warning` (line 564) — keep the test name (no-warning is still true), but broaden the filter from `r.severity == "warning"` to `r.severity in ("warning", "blocker")` so the test verifies trigger-mediated fan-out is exempt at BOTH tiers. Add comment "// Trigger-mediated fan-out exempt at both tiers".
    - `test_review_patch_combines_both_critics` (line 608) — only update the inline assertion-comment "fan-out warnings" → "fan-out blockers" for accuracy. Functional assertion (`has_fan_out` via finding text) is severity-agnostic and unchanged.
    - Add a NEW test `test_fan_out_signal_rate_not_blocked` immediately after `test_fan_out_with_trigger_no_warning`. Construct a patch where `cycle~ 440` (signal-rate, name ends in `~`) outlet 0 fan-outs to 2 `*~` boxes. Assert the result list has NO finding with severity in `("warning", "blocker")` mentioning fan-out. This locks in the "signal-rate detection logic is NOT touched" constraint via a regression test.
  </behavior>
  <action>
    Edit `tests/test_critics.py`:

    1. Locate `test_fan_out_without_trigger_detected` (line 556). Rename to `test_fan_out_without_trigger_blocks`. Replace the body:
    ```python
    def test_fan_out_without_trigger_blocks(self):
        """1-to-3 control fan-out without trigger -> blocker (was warning, promoted per 260427-kbe)."""
        patch = _fan_out_no_trigger_patch()
        results = review_structure(patch)
        blockers = [r for r in results if r.severity == "blocker"]
        assert len(blockers) >= 1, (
            f"Expected at least one blocker for 1-to-3 control fan-out, got: "
            f"{[(r.severity, r.finding) for r in results]}"
        )
        assert any(
            "fan" in r.finding.lower() or "trigger" in r.finding.lower()
            for r in blockers
        )
        # Regression: ensure NO warning-tier fan-out finding remains
        warning_fan = [
            r for r in results
            if r.severity == "warning" and ("fan" in r.finding.lower() or "trigger" in r.finding.lower())
        ]
        assert len(warning_fan) == 0, "Fan-out should now be blocker, not warning"
    ```

    2. Locate `test_fan_out_with_trigger_no_warning` (line 564). Update the filter to span both tiers:
    ```python
    def test_fan_out_with_trigger_no_warning(self):
        """Trigger object fanning out -> no fan-out finding at any severity."""
        patch = _fan_out_with_trigger_patch()
        results = review_structure(patch)
        # Trigger-mediated fan-out is exempt at BOTH warning and blocker tiers
        fan_findings = [
            r for r in results
            if r.severity in ("warning", "blocker") and "fan" in r.finding.lower()
        ]
        assert len(fan_findings) == 0
    ```

    3. Add new test `test_fan_out_signal_rate_not_blocked` directly after `test_fan_out_with_trigger_no_warning`:
    ```python
    def test_fan_out_signal_rate_not_blocked(self):
        """Signal-rate (~) fan-out is exempt — Rule #3 says all signal inlets are hot."""
        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "cycle~ 440",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "*~ 0.5",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "*~ 0.3",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-1", 0], "destination": ["obj-3", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_structure(patch)
        fan_findings = [
            r for r in results
            if r.severity in ("warning", "blocker") and ("fan" in r.finding.lower() or "trigger" in r.finding.lower())
        ]
        assert len(fan_findings) == 0, (
            f"Signal-rate fan-out must NOT be flagged. Got: "
            f"{[(r.severity, r.finding) for r in fan_findings]}"
        )
    ```

    4. In `test_review_patch_combines_both_critics` (line 608), update the assertion comment only:
    `# Should have both gain staging and fan-out warnings` → `# Should have both gain staging and fan-out blockers`
    (no logic change — assertions still use finding text matching).

    DO NOT modify the fan-out fixtures `_fan_out_no_trigger_patch()` or `_fan_out_with_trigger_patch()`.
    DO NOT modify any other test in the file.

    Run the tests — they should FAIL until Task 2 lands (RED step). Confirm the failure mode is "expected blocker, got warning" before proceeding.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_critics.py::TestStructureCritic::test_fan_out_without_trigger_blocks tests/test_critics.py::TestStructureCritic::test_fan_out_with_trigger_no_warning tests/test_critics.py::TestStructureCritic::test_fan_out_signal_rate_not_blocked -v 2>&1 | tail -30</automated>
  </verify>
  <done>
    Three fan-out tests exist with the expected names. Running them FAILS with "Expected at least one blocker" (RED state) — this proves the test wires are correct and the source change is required next. The other 2 tests (`test_fan_out_with_trigger_no_warning`, `test_fan_out_signal_rate_not_blocked`) PASS even before Task 2 because they only require *absence* of a fan-out finding, which the current code already satisfies for those fixtures.
  </done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Promote fan-out severity from "warning" to "blocker" in structure_critic.py</name>
  <files>src/maxpat/critics/structure_critic.py</files>
  <behavior>
    - The single `CriticResult(...)` emit at line 131 of `_check_fan_out_without_trigger()` changes its first arg from `"warning"` to `"blocker"`.
    - Update the function docstring (lines 85–89) to reflect the tier change and reference 260427-kbe / FINDINGS.md §P0-1.
    - No other changes. The signal-rate skip (`_is_signal_object`, line 119) stays. The trigger-source skip (`_is_trigger_object`, line 115) stays. The fan-out detection logic (count >= 2 destinations) stays. `_check_hot_cold_ordering` and `_check_redundant_connections` stay at "warning" — out of scope.
  </behavior>
  <action>
    Edit `src/maxpat/critics/structure_critic.py`:

    1. Update the `_check_fan_out_without_trigger` docstring (lines 85–89) from:
    ```python
    """Detect outlets connected to 2+ destinations without trigger.

    Per CLAUDE.md Rule #4: "Use explicit trigger objects for fan-out
    instead of connecting one outlet to multiple inlets."
    """
    ```
    to:
    ```python
    """Detect outlets connected to 2+ destinations without trigger.

    Per CLAUDE.md Rule #4: "Use explicit trigger objects for fan-out
    instead of connecting one outlet to multiple inlets."

    Tier: BLOCKER. Promoted from warning to blocker per 260427-hox-FINDINGS.md
    §P0-1 (2026-04-27). Agents were emitting 8–16 fan-out warnings per patch
    and ignoring them because the signal was non-blocking. Aligning with
    sibling critics' blocker tier (dsp_critic gen~ I/O, rnbo_critic missing
    in~/out~, ext_critic MIN_EXTERNAL) forces explicit trigger insertion.

    Skips:
      - Source IS a trigger object (the whole point — explicit ordering exists)
      - Source is signal-rate (~) — Rule #3: all signal inlets are hot, ordering
        does not apply in the audio domain
    """
    ```

    2. At line 131 (the `CriticResult(...)` call inside the destinations loop), change the first positional argument:
    ```python
    results.append(CriticResult(
        "warning",
    ```
    to:
    ```python
    results.append(CriticResult(
        "blocker",
    ```

    DO NOT modify `_check_hot_cold_ordering` (still warning).
    DO NOT modify `_check_redundant_connections` (still warning).
    DO NOT modify `_is_signal_object` or `_is_trigger_object`.
    DO NOT touch the finding/suggestion text.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_critics.py -v 2>&1 | tail -50</automated>
  </verify>
  <done>
    All three new/updated fan-out tests PASS (GREEN). The full `tests/test_critics.py` suite passes — no regression in `test_hot_cold_ordering_detected`, `test_duplicate_patchlines_detected`, `test_clean_patch_no_warnings`, `test_review_patch_combines_both_critics`, or any DSP/RNBO/external/package critic test. Confirmed by inspection: `grep -n '"blocker"' src/maxpat/critics/structure_critic.py` returns exactly one match (line ~140 in the fan-out emit), and `grep -n '"warning"' src/maxpat/critics/structure_critic.py` still returns matches in the hot/cold and redundant-connection checks (proving scope was respected).
  </done>
</task>

</tasks>

<verification>
Run the full critic test suite to confirm no regressions across sibling critics:

```bash
cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_critics.py -v 2>&1 | tail -60
```

Then sanity-check scope by grepping the structure_critic source:

```bash
grep -n '"blocker"\|"warning"' src/maxpat/critics/structure_critic.py
```

Expected: exactly one `"blocker"` (in fan-out emit) and exactly two `"warning"` instances (one in hot/cold ordering emit, one in redundant-connection emit). If counts differ, scope was exceeded.

Then verify the spirit of `has_blocking_errors()` — that an agent reviewing critic output via the standard `severity == "blocker"` filter (the same pattern used by `tests/test_critics.py:255`, `:277`, `:285`, `:293`, `:301`) now sees the fan-out finding:

```bash
cd /Users/taylorbrook/Dev/MAX && python -c "
from src.maxpat.critics import review_patch
patch = {
    'patcher': {
        'boxes': [
            {'box': {'id': 'a', 'maxclass': 'newobj', 'text': 'metro 500', 'numinlets': 2, 'numoutlets': 1, 'outlettype': ['bang']}},
            {'box': {'id': 'b', 'maxclass': 'newobj', 'text': 'print x', 'numinlets': 1, 'numoutlets': 0, 'outlettype': []}},
            {'box': {'id': 'c', 'maxclass': 'newobj', 'text': 'print y', 'numinlets': 1, 'numoutlets': 0, 'outlettype': []}},
            {'box': {'id': 'd', 'maxclass': 'newobj', 'text': 'print z', 'numinlets': 1, 'numoutlets': 0, 'outlettype': []}},
        ],
        'lines': [
            {'patchline': {'source': ['a', 0], 'destination': ['b', 0]}},
            {'patchline': {'source': ['a', 0], 'destination': ['c', 0]}},
            {'patchline': {'source': ['a', 0], 'destination': ['d', 0]}},
        ],
    }
}
results = review_patch(patch)
blockers = [r for r in results if r.severity == 'blocker']
print(f'Blocker count: {len(blockers)}')
for r in blockers:
    print(f'  {r}')
assert len(blockers) >= 1, 'Fan-out should now produce a blocker'
print('OK — fan-out blockers are emitted, satisfying has_blocking_errors() spirit')
"
```
</verification>

<success_criteria>
- All tests in `tests/test_critics.py` pass (was passing before, must still pass after — no regression).
- The three updated/new fan-out tests pass:
  - `test_fan_out_without_trigger_blocks` (new name; asserts blocker tier on 1-to-3 control fan-out)
  - `test_fan_out_with_trigger_no_warning` (broadened to check no fan finding at warning OR blocker tier)
  - `test_fan_out_signal_rate_not_blocked` (new; locks in signal-rate exemption regression)
- `src/maxpat/critics/structure_critic.py` line count delta: docstring expansion only; functional change is exactly one string literal (`"warning"` → `"blocker"`).
- `_check_hot_cold_ordering` and `_check_redundant_connections` continue to emit `"warning"` — out of scope.
- `_is_signal_object` skip remains unchanged — signal-rate fan-out still exempt.
- Manual spot-check via the verification script confirms a 1-to-3 control fan-out now appears in the `severity == "blocker"` filter that downstream agents/critic-loop logic uses.
</success_criteria>

<output>
After completion, create `.planning/quick/260427-kbe-promote-fan-out-without-trigger-from-war/260427-kbe-SUMMARY.md` documenting:
- Files changed (the one severity literal flip + docstring expansion + 3 test updates/additions)
- Test counts (before/after — should be +1 net new test)
- Confirmation that scope guards held (hot/cold + redundant still warning, signal-rate still exempt, _is_trigger_object still skips)
- Note for downstream work: the critic system's `"blocker"` tier is NOT yet wired into `validation.has_blocking_errors()` (which only inspects `ValidationResult.level == "error"`). FINDINGS.md §P2-4 captures this as a separate "critic loop hard tier" task.
</output>
