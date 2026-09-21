---
phase: quick-260921-hll
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/db_lookup.py
  - tests/test_db_lookup.py
  - CLAUDE.md
  - .planning/STATE.md
  - .planning/quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/260921-hll-SUMMARY.md
autonomous: true
requirements: [MF-03, NH-02]

estimate:
  tokens: 60000
  raw_tokens: 45000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "ObjectDatabase.lookup('dac~') emits zero empty-I/O UserWarnings (inlets populated, outlets legitimately empty) — per D-01"
    - "ObjectDatabase.lookup('dsp') (both sides empty, no variable_io rule) still emits exactly one empty-I/O UserWarning, and is silent on the second call"
    - "The set of canonical names that trigger the empty-I/O warning is EXACTLY audit_empty_io()['critical'] + audit_empty_io()['covered_by_override'] — the two predicates no longer disagree"
    - "audit_half_empty_io() reports the one-side-empty canonicals, split into sinks (no outlets) and sources (no inlets) — per D-02"
    - "A full pytest run reports strictly fewer warnings than the pre-change baseline, and every test that existed before the change has an identical outcome after it"
  artifacts:
    - "src/maxpat/db_lookup.py — _maybe_warn_empty_io predicate aligned; audit_half_empty_io() added"
    - "tests/test_db_lookup.py — new tests for the aligned predicate, the audit-parity invariant, and audit_half_empty_io()"
    - "SCRATCH/before.xml + SCRATCH/after.xml — junit outcome maps for the before/after comparison"
    - "SCRATCH/before-summary.txt + SCRATCH/after-summary.txt — pytest tail lines carrying the warning counts"
    - ".planning/quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/260921-hll-SUMMARY.md"
  key_links:
    - "_maybe_warn_empty_io predicate <-> audit_empty_io predicate — must be bit-for-bit the same rule (both sides empty), asserted by a test, not by reading the code"
    - "audit_half_empty_io() <-> the 209-name set the warning no longer covers — the information channel moves, it is not deleted"
    - "before.xml/after.xml comparison <-> the 'no existing test changes outcome' claim — measured per-test, never from totals"
---

<objective>
Close MF-03 and NH-02 from `.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md`.

Two predicates in `src/maxpat/db_lookup.py` disagree about what "empty I/O" means:

| Mechanism | Predicate today | Fires on (live count, measured at planning time) |
|---|---|---|
| `audit_empty_io()` (line ~830) | **both** sides empty | **9** |
| `_maybe_warn_empty_io()` (line ~392) | **either** side empty | **218** |

The 209-name gap is objects with exactly one side populated, and it is mostly correct data: 109 zero-outlet sinks (`dac~`, `ezdac~`, `scope~`, `send~`, `print`, `panel`, `outlet`, `out~`, `mc.dac~`, `out`) and 100 zero-inlet sources (`begin~`, `bp.Input`, …). Every one of those emits "patch generation may fail silently" on lookup, burying the real signal in ~483 warnings per suite run.

Purpose: make the one channel designed to surface "this object cannot be connected" trustworthy again, without losing visibility into the one-side-empty set.
Output: an aligned warning predicate, a new `audit_half_empty_io()` surface for the set the warning no longer covers, tests for both, and a measured before/after proving the warning count drops while no pre-existing test changes outcome.

**Locked decisions for this task** (no CONTEXT.md exists for a quick task; these are the plan's own decisions and are cited by ID in the tasks below):

- **D-01** — Align `_maybe_warn_empty_io()` with the audit: warn only when **both** `inlets` and `outlets` are empty. MF-03 offered two options (align, or keep the stricter check with sink/source exemptions); align is chosen because an exemption list is a second source of truth that drifts, and NH-02 explicitly asks for the two mechanisms to stop disagreeing.
- **D-02** — Add `audit_half_empty_io()` returning the one-side-empty set split into `sinks` (inlets populated, outlets empty) and `sources` (outlets populated, inlets empty), excluding `variable_io_rules` entries exactly as `audit_empty_io()` does. The information is not deleted — it moves to an explicit audit surface.
- **D-03** — **Do NOT touch `lookup_strict()` or `has_complete_io()`.** Both keep the stricter "both sides populated" rule. Live grep at planning time confirms neither has any production call site (`grep -rn "lookup_strict\|has_complete_io" --include="*.py" src/ tools/` returns only the definitions in `db_lookup.py`), so their behavior is API surface exercised solely by tests. Changing them is a wider blast radius than MF-03 asks for and is out of scope for this task.
- **D-04** — Verification is per-test, not by totals. Capture a junit outcome map BEFORE any edit, and prove after the edit that every pre-existing `(classname, name)` has an identical outcome. New tests are additions and are permitted; a pre-existing test flipping in either direction (including a pre-existing failure "becoming" a pass) is a failed verification, not a bonus.

This plan is a single vertical slice — predicate, audit surface, and tests land together in one task and are proven end-to-end by a real run, so there is no horizontal-layer ordering to trace through.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md
@src/maxpat/db_lookup.py
@tests/test_db_lookup.py
</context>

<environment>
Repo root: `/Users/taylorbrook/Dev/MAX` — run every command from there (there is no `pytest.ini`/`pyproject.toml`/`setup.cfg`; tests import `from src.maxpat...`, so rootdir MUST be the repo root).

Scratchpad (all measurement artifacts go here, never in the repo):
`/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/21a37e1d-5218-48c4-938e-40907a6a414b/scratchpad`
Referred to below as `$SCRATCH`. Export it once: `SCRATCH=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/21a37e1d-5218-48c4-938e-40907a6a414b/scratchpad`

Working-tree hazard (live observation at planning time — CLAUDE.md Rule #7): two unrelated pre-existing modifications belong to a concurrent instance and MUST NOT be staged, committed, reverted, or stashed:
- `patches/.active-project.json`
- `patches/scala-synth/generated/scala-synth.maxpat`

Never `git add .` / `git add -A`. Never `git stash`. Stage only the explicit paths listed in Task 3.

Suite size at planning time: 2186 tests collected in 0.89s. A full run is minutes, not seconds — allow up to 10 minutes per full-suite command.
</environment>

<tasks>

<task type="auto">
  <name>Task 1: Capture the BEFORE baseline and build the comparison harness</name>
  <files>
    $SCRATCH/before.xml,
    $SCRATCH/before-summary.txt,
    $SCRATCH/probe_empty_io_warnings.py,
    $SCRATCH/compare_junit.py,
    $SCRATCH/before-probe.txt
  </files>
  <precondition>The working tree contains exactly two unrelated modified files (`patches/.active-project.json`, `patches/scala-synth/generated/scala-synth.maxpat`). Run `git status --porcelain` first; if `src/maxpat/db_lookup.py` or `tests/test_db_lookup.py` is already modified, halt — a concurrent instance is editing the same files and the baseline would be meaningless.</precondition>
  <action>
    Per D-04, every measurement must exist on disk BEFORE any source edit. Make no change to `src/` or `tests/` in this task.

    1. Write `$SCRATCH/probe_empty_io_warnings.py`: a standalone script that builds one `ObjectDatabase()`, calls `lookup()` on every key of `db._objects` inside `warnings.catch_warnings(record=True)` with `simplefilter("always")`, and isolates the empty-I/O warnings by substring-matching the phrase that appears in the warning message emitted by `_maybe_warn_empty_io` (the fragment about empty inlets/outlets in the DB) — this is required because `_maybe_warn_install_state` emits the same `UserWarning` category and would otherwise be counted. Extract each warned canonical name from the quoted name in the message. Compute the audit's both-sides-empty set as `set(audit_empty_io()['critical']) | set(audit_empty_io()['covered_by_override'])`. Print exactly three lines: `WARNED=<count>`, `AUDIT_BOTH_EMPTY=<count>`, `MATCH=<True|False>` where MATCH compares the two sorted name lists (not just counts). The script MUST always `sys.exit(0)` — it is an instrument, not a gate; the alignment assertion lives in the pytest test added in Task 2 and in the Task 3 grep gate. Expected reading at this point: `WARNED=218`, `AUDIT_BOTH_EMPTY=9`, `MATCH=False`.

    2. Write `$SCRATCH/compare_junit.py`: takes two junit XML paths, parses each into a map of `(classname, name) -> outcome` where outcome is one of passed/failed/error/skipped/xfailed (derive from the child element of each `<testcase>`; no child element means passed). It prints, and exits non-zero on, any key present in BEFORE whose outcome differs in AFTER, plus any key present in BEFORE and missing from AFTER (a deleted or renamed pre-existing test is also a changed outcome per D-04). Keys only in AFTER are printed as `NEW:` lines and do NOT cause failure.

    3. Run the probe and save its output: `python3 $SCRATCH/probe_empty_io_warnings.py | tee $SCRATCH/before-probe.txt`.

    4. Run the full suite capturing both artifacts:
       `python3 -m pytest -q --junitxml=$SCRATCH/before.xml 2>&1 | tail -5 | tee $SCRATCH/before-summary.txt`
       Record the warning count and the pass/fail/skip counts from the summary line into the task notes. Per the review history, quick task 260921-gut already triaged the 9 MF-02 failures and left the suite green — whatever the baseline actually is, it is the contract; do NOT "fix" any pre-existing failure in this task or the next.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && test -s $SCRATCH/before.xml && test -s $SCRATCH/before-summary.txt && test -s $SCRATCH/before-probe.txt && python3 -c "
import sys, xml.etree.ElementTree as ET
cases = list(ET.parse('$SCRATCH/before.xml').getroot().iter('testcase'))
print('testcases', len(cases))
sys.exit(0 if len(cases) > 2000 else 1)" && grep -q "WARNED=" $SCRATCH/before-probe.txt && grep -q "warning" $SCRATCH/before-summary.txt && [ -z "$(git status --porcelain src tests)" ]</automated>
  </verify>
  <done>`before.xml` holds >2000 testcase entries, `before-summary.txt` holds the pytest tail with the warning count, `before-probe.txt` holds the `WARNED=`/`AUDIT_BOTH_EMPTY=`/`MATCH=` triple, both helper scripts exist in `$SCRATCH`, and `git status --porcelain src tests` prints nothing (no source file was touched).</done>
  <reversibility rating="reversible">Measurement only; no repo file is written.</reversibility>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Align the warning predicate (D-01) and add audit_half_empty_io() (D-02), tests first</name>
  <files>tests/test_db_lookup.py, src/maxpat/db_lookup.py</files>
  <behavior>
    Write these tests in `tests/test_db_lookup.py` FIRST and confirm they fail against the current code, then implement. Follow the file's existing conventions: section banner comments, `db = ObjectDatabase()` per test, explicit precondition asserts with a documented fallback when a canary name is used.

    - Test 1 (sink canary, D-01): `lookup("dac~")` inside `catch_warnings(record=True)` + `simplefilter("always")` emits zero `UserWarning`s. Assert the precondition first — `dac~` has a non-empty `inlets` list, an empty `outlets` list, and no `_variable_io_rules` entry (measured at planning time: 2 inlets, 0 outlets) — so a DB change surfaces as a precondition failure rather than a confusing assertion failure.
    - Test 2 (source canary, D-01): same shape for a zero-inlet source. Use `begin~` (measured at planning time: 0 inlets, populated outlets, no variable_io rule). Document the fallback in the docstring, matching the style of `test_lookup_does_not_warn_when_package_filtered`: rescan with `[n for n,o in db._objects.items() if o.get("outlets") and not o.get("inlets") and n not in db._variable_io_rules]`.
    - Test 3 (both-empty unchanged): `lookup("dsp")` still warns exactly once and is silent on the second call. The existing `test_lookup_warns_once_per_empty_io_name` already covers this — do not duplicate it; instead assert here that the warning message still names `dsp`, so the message contract is pinned.
    - Test 4 (THE MF-03 invariant, the core of this task): sweep `lookup()` over every key of `db._objects` in one `catch_warnings(record=True)` block, collect the canonical names carried by empty-I/O warnings only (filter by the message substring — `_maybe_warn_install_state` shares the `UserWarning` category), and assert that sorted set is EQUAL to `sorted(set(audit_empty_io()["critical"]) | set(audit_empty_io()["covered_by_override"]))`. Equality, not a count — this is what stops the two predicates from drifting apart again.
    - Test 5 (`audit_half_empty_io()` shape, D-02): returns exactly the keys `{"sinks", "sources"}`; each is a sorted list of `str`; the two buckets are disjoint; `dac~` is in `sinks`; the Test-2 source canary is in `sources`; neither bucket intersects `audit_empty_io()["critical"]`, `["covered_by_override"]`, or `["variable_io_ok"]`.
    - Test 6 (`audit_half_empty_io()` independent oracle, D-02): recompute both buckets by brute force from `db._objects`, skipping `_variable_io_rules` keys, and assert equality with the audit result. Follow the independent-oracle style of `test_audit_empty_io_covers_all_domain_files` — the oracle must not call the production helper it is checking. Also assert both buckets are non-empty (measured at planning time: 109 sinks, 100 sources) without hard-coding those numbers.

    Every one of Tests 1, 2, 4, 5, 6 must be observed RED before the implementation lands (1/2/4 because the predicate still fires on one-side-empty entries; 5/6 because the method does not exist).
  </behavior>
  <action>
    Implement only after the tests above are red.

    1. `_maybe_warn_empty_io` (`src/maxpat/db_lookup.py` ~line 392, per D-01): change the early-return so the method returns when EITHER side is populated, making the fire condition "both sides empty" — identical to the rule `audit_empty_io` applies at its own `continue` guard. Keep the `variable_io_rules` short-circuit, the `_empty_io_warned` dedup, the `UserWarning` category, `stacklevel=3`, and the message text exactly as they are; the message is asserted by existing tests and by Test 3.

    2. Update that method's docstring to state the aligned predicate, name `audit_empty_io()` as the mechanism it now agrees with, and point readers at `audit_half_empty_io()` for the one-side-empty set. Record in the docstring that a zero-outlet sink or zero-inlet source is legitimate DB data, not a defect — that is the reason the warning stopped firing on it.

    3. Add `audit_half_empty_io(self) -> dict[str, list[str]]` next to `audit_empty_io` (per D-02). Iterate `self._objects`, skip canonicals present in `self._variable_io_rules`, and bucket the rest: `sinks` when `inlets` is truthy and `outlets` is falsy, `sources` when `outlets` is truthy and `inlets` is falsy; skip anything with both sides populated or both sides empty (the latter belongs to `audit_empty_io`). Return both lists sorted. Write the docstring in the established house style of the sibling audits: explain each bucket, state that the union of this result and `audit_empty_io()`'s both-empty buckets is the full set the old warning predicate covered, and cite NH-02 plus the MF-03 counts measured at planning time (9 both-empty, 109 sinks, 100 sources) as the reading at the time of writing.

    4. Extend the module docstring at the top of `tests/test_db_lookup.py` so its bullet list covers the aligned predicate and the new audit, matching how the existing bullets describe the other behaviors.

    Per D-03, leave `lookup_strict()` and `has_complete_io()` untouched — including their docstrings, which correctly describe their own stricter rule.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest tests/test_db_lookup.py tests/test_schema_extensions.py tests/test_audit_signal_role.py -q && python3 $SCRATCH/probe_empty_io_warnings.py | tee $SCRATCH/after-probe.txt && grep -q "MATCH=True" $SCRATCH/after-probe.txt && grep -c "def audit_half_empty_io" src/maxpat/db_lookup.py && git diff --stat -- src/maxpat/db_lookup.py tests/test_db_lookup.py</automated>
  </verify>
  <done>
    The three audit/lookup test modules pass; `$SCRATCH/after-probe.txt` reports `MATCH=True` with `WARNED` equal to `AUDIT_BOTH_EMPTY` (expected 9, down from the baseline 218 recorded in `before-probe.txt`); `audit_half_empty_io` is defined in `src/maxpat/db_lookup.py`; `git diff --stat` shows exactly two changed files — `src/maxpat/db_lookup.py` and `tests/test_db_lookup.py`.
  </done>
  <reversibility rating="reversible">A predicate change plus an additive method, both behind tests; `git revert` of the single commit restores prior behavior exactly.</reversibility>
</task>

<task type="auto">
  <name>Task 3: Prove the AFTER state against the baseline, document, and commit</name>
  <files>
    $SCRATCH/after.xml,
    $SCRATCH/after-summary.txt,
    CLAUDE.md,
    .planning/quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/260921-hll-SUMMARY.md,
    .planning/STATE.md
  </files>
  <precondition>`$SCRATCH/before.xml`, `$SCRATCH/before-summary.txt`, `$SCRATCH/before-probe.txt`, and `$SCRATCH/compare_junit.py` all exist from Task 1. If any is missing the comparison has no authority — halt rather than re-deriving a baseline from the already-modified tree.</precondition>
  <action>
    1. Run the full suite again, capturing the AFTER artifacts:
       `python3 -m pytest -q --junitxml=$SCRATCH/after.xml 2>&1 | tail -5 | tee $SCRATCH/after-summary.txt`

    2. Run `python3 $SCRATCH/compare_junit.py $SCRATCH/before.xml $SCRATCH/after.xml`. Per D-04 it must report zero changed and zero missing pre-existing tests; `NEW:` lines for the tests added in Task 2 are expected. If ANY pre-existing test changed outcome — including a pre-existing failure that now passes — stop and investigate before committing; that is an unplanned side effect, not a win.

    3. Read the warning counts out of `before-summary.txt` and `after-summary.txt` and record both, plus the delta and the percentage drop, in the SUMMARY. The baseline reading cited by MF-03 was 483 warnings; the actual numbers on this machine are whatever Task 1 and this task measured.

    4. Append one sentence to the "Verify lookup results have non-empty I/O" paragraph in the Object Database section of `CLAUDE.md` (a targeted `Edit`, not a rewrite of the rule): note that `lookup()` warns only when BOTH sides are empty, that a zero-outlet sink or zero-inlet source is legitimate DB data, and that `db.audit_half_empty_io()` enumerates the one-side-empty entries as `sinks`/`sources`. Keep the existing guidance intact — `tests/test_claude_md.py` asserts section presence, so do not remove or reorder headings.

    5. Write `260921-hll-SUMMARY.md` in this quick-task directory covering: the D-01..D-04 decisions and why align beat an exemption list; the before/after probe readings (218 -> 9 warned names, MATCH False -> True); the before/after suite warning counts and per-test comparison result; the explicit non-change to `lookup_strict()`/`has_complete_io()` with the grep evidence that they have no production call sites; and a pointer noting MF-03/NH-02 are now closed while follow-up items 4, 5 and 6 of the review's task table remain open.

    6. Update `.planning/STATE.md`: add a row to the "Quick Tasks Completed" table for `260921-hll` with the date `2026-09-21`, the commit SHA, and the directory link, and refresh the "Last activity" line in Current Position.

    7. Commit, per CLAUDE.md Rule #7, staging ONLY these explicit paths — the two concurrent-instance modifications under `patches/` must remain unstaged and unmodified:
       `git add src/maxpat/db_lookup.py tests/test_db_lookup.py CLAUDE.md .planning/STATE.md .planning/quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/`
       then commit with message:
       `fix(db-lookup): align empty-I/O warning with audit predicate, add audit_half_empty_io (MF-03, NH-02)`
       Never `git add .`, never `git add -A`, never `git stash`.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 $SCRATCH/compare_junit.py $SCRATCH/before.xml $SCRATCH/after.xml && python3 -c "
import re,sys
def warns(p):
    t=open(p).read(); m=re.search(r'(\d+)\s+warning', t); return int(m.group(1)) if m else -1
b,a=warns('$SCRATCH/before-summary.txt'),warns('$SCRATCH/after-summary.txt')
print('warnings before',b,'after',a)
sys.exit(0 if b>0 and a<b else 1)" && grep -q "audit_half_empty_io" CLAUDE.md && test -s .planning/quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/260921-hll-SUMMARY.md && grep -q "260921-hll" .planning/STATE.md && test -z "$(git show --name-only --format= HEAD -- patches/)" && python3 -c "
import subprocess, sys
out = subprocess.run(['git','status','--porcelain','patches/'], capture_output=True, text=True, check=True).stdout
print(out.rstrip())
sys.exit(0 if any(line.startswith(' M') for line in out.splitlines()) else 1)" && git show --name-only --format="%s" HEAD</automated>
  </verify>
  <done>
    `compare_junit.py` exits 0 (every pre-existing test has an identical outcome; only `NEW:` additions appear); the after warning count is strictly lower than the before count and both are printed; `CLAUDE.md` names `audit_half_empty_io`; the SUMMARY exists and STATE.md carries the `260921-hll` row; `git status --porcelain patches/` still shows the two concurrent-instance files as modified-but-unstaged (` M` prefix, not `M `); and the last commit touches only `src/maxpat/db_lookup.py`, `tests/test_db_lookup.py`, `CLAUDE.md`, `.planning/STATE.md`, and the quick-task directory.
  </done>
  <reversibility rating="reversible">Documentation and state updates on top of an already-reversible code change.</reversibility>
</task>

</tasks>

<threat_model>
ASVS level 1, block_on: high. This task touches no network, no user input, no authentication, and installs no packages.

## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| `.claude/max-objects/**/objects.json` -> `ObjectDatabase` loader | Local repo data files parsed into the in-memory object map; the only input this change reads |
| `ObjectDatabase` -> patch-building callers | The warning channel this change narrows is the integrity signal those callers rely on |
| developer working tree -> git index | A concurrent instance holds unrelated uncommitted changes under `patches/` |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-hll-01 | Repudiation | `_maybe_warn_empty_io` narrowing (D-01) | medium | mitigate | Narrowing the warning could mask a genuinely broken one-side-empty entry. The channel is not removed — `audit_half_empty_io()` (D-02) exposes the exact 209-name set, Test 4 pins warning-set == audit-set so the two can never silently drift apart again, and `lookup_strict()`/`has_complete_io()` retain the stricter rule per D-03 |
| T-hll-02 | Tampering | `.claude/max-objects/**/objects.json` | low | accept | Local, version-controlled repo data; this task only reads it and writes no DB file. Existing `audit_empty_io` bound tests already guard DB drift |
| T-hll-03 | Tampering | git index / concurrent-instance files under `patches/` | medium | mitigate | Task 3 stages an explicit path list only; `git add .`/`-A`/`git stash` are prohibited, and the Task 3 verify asserts `patches/` files stay unstaged |
| T-hll-04 | Denial of Service | full-suite verification runs | low | accept | Two full 2186-test runs are the cost of the per-test before/after comparison required by D-04; bounded at ~10 minutes each |
| T-hll-SC | Tampering | npm/pip/cargo installs | n/a | accept | No package-manager install occurs in this plan — no dependency is added, removed, or upgraded. The package-legitimacy gate does not apply; if an executor finds itself needing to install anything, that is a scope breach and the task must halt |
</threat_model>

<verification>
1. `python3 -m pytest tests/test_db_lookup.py -q` — all tests pass, including the six added in Task 2.
2. `python3 $SCRATCH/probe_empty_io_warnings.py` — prints `MATCH=True` with `WARNED` equal to `AUDIT_BOTH_EMPTY` (the MF-03 disagreement is gone).
3. `python3 $SCRATCH/compare_junit.py $SCRATCH/before.xml $SCRATCH/after.xml` — exits 0; only `NEW:` lines.
4. Warning count from the pytest summary line is strictly lower after than before, with both numbers recorded in the SUMMARY.
5. `git status --porcelain patches/` — the two concurrent-instance files remain modified and unstaged.
</verification>

<success_criteria>
- `_maybe_warn_empty_io()` and `audit_empty_io()` apply the same both-sides-empty rule, proven by an equality assertion over the full DB rather than by code inspection (MF-03).
- `audit_half_empty_io()` exists and reports the one-side-empty set split into `sinks` and `sources`, verified against an independent brute-force oracle (NH-02).
- Suite-wide warning count drops substantially versus the captured baseline.
- Every test that existed before the change has an identical outcome after it; the only test-inventory change is the additions from Task 2.
- `lookup_strict()` and `has_complete_io()` are byte-unchanged (D-03).
- One commit, explicit path list, `patches/` untouched.
</success_criteria>

<output>
Create `.planning/quick/260921-hll-per-mf-03-and-nh-02-in-planning-quick-26/260921-hll-SUMMARY.md` when done.
</output>