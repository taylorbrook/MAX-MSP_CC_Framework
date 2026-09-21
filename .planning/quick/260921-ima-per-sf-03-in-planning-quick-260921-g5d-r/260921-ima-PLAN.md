---
phase: 260921-ima
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/maxclass_map.py
  - tests/test_maxclass_map.py
autonomous: true
requirements: [SF-03]
user_setup: []

estimate:
  tokens: 55000
  raw_tokens: 55000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "`resolve_maxclass(\"codebox\")` returns the object's own name, not `newobj` — but ONLY if committed-patch evidence confirms the MAX-saved form (SF-03)."
    - "`add_gen()` serialized output is byte-identical before and after the change."
    - "Every committed codebox-bearing `.maxpat` round-trips to byte-identical output before and after the change."
    - "The pytest pass/fail set is identical before and after the change, plus the new tests."
    - "Every UI_MAXCLASSES consumer site is enumerated with its observed impact recorded, before the edit is applied."
    - "If committed-patch evidence does NOT confirm the form, no edit is made and the executor reports instead."
  artifacts:
    - src/maxpat/maxclass_map.py
    - tests/test_maxclass_map.py
  key_links:
    - "`Box.__init__` (src/maxpat/patcher.py:177,188) — `resolve_maxclass` + the Rule #1 `is_ui_object` gate."
    - "`_validate_maxclass_usage` (src/maxpat/validation.py:330) — UI_MAXCLASSES membership skip."
    - "`_validate_objects` (src/maxpat/validation.py:283) — unknown-object warning skip."
    - "`PatchAnalysis` domain classification (src/maxpat/analysis.py:139) — maxclass-in-set branch."
    - "layout cluster exclusion (src/maxpat/layout.py:1283) — `is_ui_object(box.name)` branch."
    - "`add_gen()` codebox construction (src/maxpat/builders.py:884-908) — bypasses `Box.__init__` via `Box.__new__`."
    - "`generate_gen_patcher` raw dict (src/maxpat/codegen.py:231-235)."
---

<objective>
Close SF-03: `codebox` carries its own name as `maxclass` in committed patches but is absent from `UI_MAXCLASSES`. Confirm the MAX-saved form from committed git objects, add the entry if and only if confirmed, add test coverage mirroring the shape of the `jit.pwindow` / `jit.cellblock` fix in `fc3aa27` (which shipped with no test at all), and prove that `add_gen()` output and `.maxpat` round-trip bytes are unchanged.

Purpose: `UI_MAXCLASSES` is the authoritative source for the CLAUDE.md rule that only objects carrying their own name as `maxclass` belong in the set. A gap in it is the same bug class that `fc3aa27` fixed for the Jitter pair. The risk is not the one-line addition — it is the five consumer sites that branch on set membership.

Output: one entry added to `UI_MAXCLASSES`, new tests in `tests/test_maxclass_map.py` covering `codebox` and the currently-untested `fc3aa27` Jitter pair, and a recorded before/after byte-identity proof.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md
@src/maxpat/maxclass_map.py
@tests/test_maxclass_map.py
</context>

<planning_time_observations>
These are live observations made at planning time against `HEAD` (immutable commit content). Treat the counts as an expected baseline; recompute them at execution time and flag any drift rather than assuming them.

| Observation | Value | How it was measured |
|---|---|---|
| Committed `.maxpat` files containing a `codebox` maxclass | 26 | `git grep -l 'maxclass": "codebox"' HEAD -- 'patches/**/*.maxpat'` |
| Total `codebox` maxclass occurrences in `.maxpat` | 47 | `git grep -oh` on the same pattern |
| Committed `.gendsp` files containing one | 10 | same grep, `*.gendsp` |
| Top-level (non-nested) `codebox` boxes | 0 — every one is inside an embedded patcher | per-file JSON walk of `patcher.boxes` at HEAD |
| Generator-written `appversion.revision` | `0` | `src/maxpat/defaults.py:60-63` |
| Codebox-bearing patches with explicit MAX-re-save commit messages | terrain-synth (`55757e0`, `af20855`, `ef0859c`, `174840c`), ji-harmonizer (`4b82e72`), kicksynth (`02c9917`), sample-layers (`b540b11`), amplitude-follower (`bf0b9ba`), spectraldetector (`477dda6`), simple-fm (`a588c39`) | `git log --grep=MAX -- 'patches/*/generated/*.maxpat'` |
| Working tree (do NOT touch) | modified: `patches/.active-project.json`, `patches/FDNVerb/generated/FDNVerb.maxhelp`, `patches/scala-synth/generated/scala-synth.maxpat`, `patches/terrain-synth/generated/terrain-synth.maxpat` | `git status` |
| `tests/test_maxclass_map.py` at HEAD | 10 tests, passing in 0.07s; its `UI_OBJECTS` list does NOT cover `jit.pwindow` or `jit.cellblock` | `python3 -m pytest tests/test_maxclass_map.py -q` |
| `fc3aa27` | added two set entries to `maxclass_map.py` and nothing else — zero test coverage shipped with it | `git show fc3aa27 --stat` |
</planning_time_observations>

<tasks>

<task type="tracer">
  <name>Task 1: Confirm the MAX-saved form and capture BEFORE baselines end-to-end</name>
  <files>(read-only; writes only to the session scratchpad)</files>
  <precondition>The repository `HEAD` is readable and `python3 -m pytest` runs from the repo root (confirmed at planning time: `tests/test_maxclass_map.py` → 10 passed).</precondition>
  <action>
Establish the evidence and the before-state in one pass, so the edit in Task 2 is authorized by proof rather than by the review finding alone. Read only committed git objects — use `git show HEAD:<path>` and `git grep ... HEAD` throughout. Never read, stage, revert, or write any file under `patches/`; four files there carry another instance's uncommitted work.

First, recompute the codebox inventory at `HEAD` (the `.maxpat` file list, the total occurrence count, and the `.gendsp` file list) and compare against the planning-time baseline in the observations table. This recomputed `.maxpat` list is the authorized round-trip set for Task 3 — the planning-time list is guidance only.

Second, confirm the MAX-saved form. The discriminator that separates a patch an actual MAX application wrote from one this repo's generator wrote is `patcher.appversion.revision`: the generator hardcodes `0` (defaults.py:60-63), so any committed patch whose value is non-zero was written or re-saved by MAX itself. Apply that discriminator across the codebox-bearing set and cross-check it against the independent evidence of the MAX-re-save commit messages listed in the observations table. The form is CONFIRMED when at least one committed patch satisfies both signals and carries a box whose maxclass field equals the object's own name. Record the confirming file paths, their appversion values, and the confirming commit SHAs.

Third, capture the before-state baselines into the session scratchpad. Capture three things: (a) a deterministic hash of `add_gen()` serialized output — build a `Patcher`, call `add_gen` with a fixed GenExpr string and fixed inlet/outlet counts, serialize via `Patcher.to_dict()`, dump with sorted keys, hash it; (b) a per-file hash of the `Patcher.from_dict` → `Patcher.to_dict()` → sorted-key JSON dump for every file in the recomputed `.maxpat` set, read via `git show HEAD:<path>`; (c) the full `python3 -m pytest -q` outcome including the per-test pass/fail identity, not just the totals — STATE.md records the current baseline as 2191 passed / 6 xfailed after commit `d27a6be`. If `Patcher.from_dict` cannot ingest a `.gendsp` file, exclude `.gendsp` from the round-trip set and record it as inventory evidence only rather than forcing it.

Fourth, enumerate the consumer sites. Six call sites branch on `UI_MAXCLASSES` / `resolve_maxclass` / `is_ui_object`: `patcher.py:177` and `patcher.py:188`, `validation.py:283` and `validation.py:330`, `analysis.py:139`, and `layout.py:1283`. For each, record what adding the entry would change. Two are known live risks and must be answered concretely rather than assumed: whether `_validate_maxclass_usage` recurses into embedded patchers (if it walks only top-level boxes, it never sees a nested codebox and the membership skip is inert), and whether the layout clustering pass ever runs over an inner gen~ patcher (if it does, the entry would newly exclude codebox boxes from clustering — a behavior change that byte-identity checks would not catch). Also record that the Rule #1 gate at `patcher.py:188` currently makes a direct `Box("codebox")` construction raise, and that adding the entry stops that raise.

STOP GATE: if the MAX-saved form is not confirmed by the discriminator, or if a consumer site would change behavior in a way not covered by the Task 3 checks, halt and report the evidence instead of proceeding to Task 2. Do not add the entry on the strength of the review finding alone.
  </action>
  <verify>
    <automated>python3 -m pytest -q 2>&1 | tail -3   # baseline recorded; expect 2191 passed / 6 xfailed per STATE.md, flag any drift</automated>
    <automated>F=$(git grep -l 'maxclass": "codebox"' HEAD -- 'patches/**/*.maxpat'); test -n "$F" || exit 1; printf '%s\n' "$F" | grep -c .   # expect 26; flag drift</automated>
    <automated>S=$(git status --porcelain -- src/ tests/) || exit 1; test -z "$S"   # this task writes nothing outside the scratchpad</automated>
  </verify>
  <done>The codebox inventory is recomputed at HEAD; the MAX-saved form is CONFIRMED (or the task halted with a report); three before-state baselines are on disk in the scratchpad (add_gen hash, per-file round-trip hashes, per-test pytest identity); all six consumer sites are enumerated with their observed impact, including concrete answers on validation recursion and layout coverage.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Add the entry and the test coverage fc3aa27 never shipped</name>
  <files>src/maxpat/maxclass_map.py, tests/test_maxclass_map.py</files>
  <precondition>Task 1 reported CONFIRMED. If it halted, this task does not run.</precondition>
  <behavior>
    - `resolve_maxclass` for the confirmed object returns the object's own name rather than the structural fallback.
    - `is_ui_object` for the confirmed object returns True, mirroring set membership.
    - `resolve_maxclass("jit.pwindow")` and `resolve_maxclass("jit.cellblock")` each return their own name — the `fc3aa27` pair, currently uncovered by any test.
    - The existing structural invariants still hold for the enlarged set: frozenset type, `newobj` absent, every entry a clean lowercase stripped non-empty string.
    - The existing `NEWOBJ_OBJECTS` expectations are unchanged — `gen~`, `cycle~`, `pack`, `route`, `expr`, `trigger` still resolve to the structural fallback. `gen~` matters most: `tests/test_codegen.py:253-263` pins it, and a codebox entry must not perturb its container.
  </behavior>
  <action>
Write the tests first and watch them fail, then apply the edit.

In `tests/test_maxclass_map.py`, extend coverage rather than restructuring the file. Add the confirmed object and both `fc3aa27` Jitter names to the module-level `UI_OBJECTS` list so the existing `TestResolveMaxclass` and `TestIsUiObject` classes pick them up. Then add one focused test class that pins the SF-03 claim explicitly with a docstring citing SF-03 and naming the confirming committed patch and commit SHA recorded in Task 1 — that provenance is the whole point, because `fc3aa27` added its two entries with no test and no recorded evidence, which is how SF-03 stayed open. Add a companion assertion pinning the Jitter pair to the same provenance shape, crediting `fc3aa27`.

Keep the tests pure unit tests against `src.maxpat.maxclass_map`. Do not make them read files under `patches/` — the working tree there is dirty with another instance's edits and a fixture-reading test would be non-deterministic. The committed-patch evidence belongs in the docstring and in Task 3's verification, not in a test's file I/O.

Run the new tests and confirm they fail for the right reason (membership absent), not an import or name error.

Then edit `src/maxpat/maxclass_map.py`: add one entry to the `UI_MAXCLASSES` frozenset, placed in its own commented group rather than folded into the Jitter or MSP groups, since the object is a gen~/RNBO embedded-patcher code editor and not a visual widget. The comment must state that it carries its own maxclass in the MAX-saved form, cite SF-03, and name the confirming patch — mirroring the provenance style of the `fc3aa27` Jitter comment line. Also extend the module docstring's provenance sentence, which currently credits only `02-RESEARCH.md` Pattern 7 and the MAX SDK scripting docs, to acknowledge that entries are also admitted on committed-patch evidence.

Change nothing else. Do not touch `resolve_maxclass`, `is_ui_object`, `builders.py`, `codegen.py`, `validation.py`, `analysis.py`, or `layout.py`.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_maxclass_map.py -q 2>&1 | tail -3   # all green, count strictly greater than the 10 at HEAD</automated>
    <automated>python3 -c "from src.maxpat.maxclass_map import resolve_maxclass, is_ui_object; n='code'+'box'; assert resolve_maxclass(n)==n; assert is_ui_object(n) is True; assert resolve_maxclass('gen~')=='newobj'; print('OK')"</automated>
    <automated>git diff --stat -- src/maxpat/maxclass_map.py   # one file, additions only, no deletions of existing entries</automated>
    <automated>S=$(git status --porcelain -- patches/ src/ tests/) || exit 1; test -z "$(printf '%s\n' "$S" | grep -v '^ M patches/' | grep -vE 'src/maxpat/maxclass_map.py|tests/test_maxclass_map.py')"</automated>
  </verify>
  <done>`tests/test_maxclass_map.py` covers the confirmed object plus the `fc3aa27` Jitter pair with provenance docstrings naming the confirming patch and SHA; the tests failed before the edit and pass after; `UI_MAXCLASSES` has exactly one new entry in its own commented group; no file outside those two is modified and nothing under `patches/` is touched.</done>
</task>

<task type="auto">
  <name>Task 3: Prove nothing moved, then commit explicit paths</name>
  <files>src/maxpat/maxclass_map.py, tests/test_maxclass_map.py</files>
  <precondition>Task 1's three before-state baselines are still on disk in the session scratchpad.</precondition>
  <action>
Re-run the exact three baseline captures from Task 1 against the post-edit code and assert equality against the stored before-state.

For `add_gen()`: rebuild the same fixed-input patcher and compare the serialized hash to the stored one. Equality is expected on structural grounds — `add_gen` constructs its codebox through `Box.__new__` at `builders.py:884-908`, bypassing `Box.__init__` and therefore bypassing `resolve_maxclass` entirely, and `codegen.py:231-235` writes a raw dict. A mismatch means that reasoning is wrong and must be investigated before committing, not explained away.

For round-trip identity: replay the `git show HEAD:<path>` → `from_dict` → `to_dict` → sorted-key dump → hash pipeline over the recomputed `.maxpat` set from Task 1 and assert every per-file hash matches its stored before-state hash. Report the pass count explicitly against the expected file count.

For the suite: re-run the full pytest and diff the per-test pass/fail identity against the stored before-state. The only permitted delta is the tests added in Task 2. Any other test changing state — especially in `tests/test_analysis.py`, `tests/test_sizing.py`, `tests/test_codegen.py`, `tests/test_round_trip.py`, or `tests/test_integration_patches.py` — is a regression and blocks the commit.

Then re-check the two consumer risks Task 1 flagged, now empirically: if `_validate_maxclass_usage` does recurse into embedded patchers, run `validate_patch` over a committed codebox-bearing patch read from `HEAD` and confirm the result set is unchanged from before the edit; if the layout pass does reach inner gen~ patchers, run it over the same source and confirm the resulting box positions are unchanged. If neither consumer reaches a nested codebox, record that finding explicitly — that is the reason the addition is inert and it belongs in the summary.

Commit with explicit paths only: the two modified source files plus this task's planning directory. Never `git add .`, never `git add -A`, never `git stash`. The four modified files under `patches/` belong to another instance and must remain unstaged and unmodified — verify that in the staged diff before committing. Use a `fix(maxclass):` subject naming the object and the SF-03 origin, in the style of `fc3aa27`.
  </action>
  <verify>
    <automated>python3 -m pytest -q 2>&1 | tail -3   # pass count = Task 1 baseline + the new tests; xfail count unchanged; zero failures</automated>
    <automated>C=$(git diff --cached --name-only) || exit 1; test -z "$(printf '%s\n' "$C" | grep '^patches/')"   # nothing under patches/ is staged</automated>
    <automated>W=$(git status --porcelain -- patches/) || exit 1; printf '%s\n' "$W" | grep -c .   # expect 4, unchanged from planning time</automated>
    <automated>git show --stat HEAD -- src/ tests/   # commit touches exactly the two source files</automated>
  </verify>
  <done>add_gen() output hash matches before-state; every committed codebox-bearing `.maxpat` round-trips to its before-state hash; the pytest per-test identity differs only by the tests added in Task 2; both flagged consumer risks are answered empirically; the commit stages only the two source files plus the planning directory, with all four pre-existing `patches/` modifications left untouched and unstaged.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| working tree → git index | A concurrent Claude instance holds uncommitted edits in four files under `patches/`; a careless stage or revert destroys another agent's work. |
| committed git objects → evidence | Evidence must come from immutable `HEAD` blobs. The working tree is an untrusted evidence source here, because at least one file in it is a known-degraded save (NH-04: `scala-synth.maxpat` working copy is 62 KB smaller than HEAD). |
| `UI_MAXCLASSES` → six consumer branches | A single set entry silently re-routes six code paths, including a Rule #1 correctness gate and a validation error check. |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-ima-01 | Tampering | Concurrent instance's uncommitted `patches/` edits | high | mitigate | Every task reads evidence via `git show HEAD:` / `git grep HEAD`. Task 2 and Task 3 each carry a verify gate asserting nothing under `patches/` is modified or staged. Commits name explicit paths; `git add .`, `git add -A` and `git stash` are prohibited (CLAUDE.md Rule #7). |
| T-ima-02 | Tampering | `add_gen()` / `.maxpat` round-trip serialization | high | mitigate | Before/after hash equality asserted per file across the full committed codebox set plus a fixed-input `add_gen()` capture (Task 1 captures, Task 3 asserts). A mismatch blocks the commit. |
| T-ima-03 | Spoofing | Evidence provenance — generator-written output masquerading as a MAX-saved form | high | mitigate | The `appversion.revision != 0` discriminator (generator hardcodes `0`) is cross-checked against independent MAX-re-save commit messages. A single-signal match does not confirm. |
| T-ima-04 | Denial of Service | Rule #1 gate at `patcher.py:188` | medium | mitigate | Enumerated as a known consumer impact in Task 1: the addition stops a direct construction from raising. Recorded, not silently absorbed. |
| T-ima-05 | Tampering | Silent behavior change in `analysis.py:139` / `layout.py:1283`, which byte-identity cannot catch | medium | mitigate | Task 1 requires concrete answers on whether either consumer reaches a nested codebox; Task 3 re-checks empirically and blocks on any change. |
| T-ima-06 | Repudiation | Undocumented set membership (the `fc3aa27` failure mode) | low | mitigate | Test docstrings and the source comment both name the confirming patch and commit SHA, so a future audit can re-derive the claim. |
| T-ima-SC | Tampering | Package-manager installs | low | accept | No npm/pip/cargo install occurs — stdlib and the existing pytest install only. No package legitimacy audit is required. |

ASVS level 1; blocking threshold `high`. All four high-severity threats carry a `mitigate` disposition with a verify gate attached.
</threat_model>

<verification>
- Committed-patch evidence for the MAX-saved form is recorded with file paths, `appversion` values, and commit SHAs — or the run halted and reported.
- `python3 -m pytest -q` is green with the pass count raised only by the new tests; xfail count unchanged.
- `add_gen()` serialized output hash is identical before and after.
- Every file in the recomputed committed codebox `.maxpat` set round-trips to a byte-identical serialization before and after.
- All six `UI_MAXCLASSES` consumer sites are enumerated with recorded impact; the two that byte-identity cannot cover are re-checked empirically.
- `git status --porcelain -- patches/` still lists exactly the four pre-existing modifications, none of them staged.
</verification>

<success_criteria>
`codebox` is in `UI_MAXCLASSES` with provenance-bearing test coverage and a source comment naming its confirming patch — OR the executor halted with a report because committed-patch evidence did not confirm the form. Either outcome closes SF-03. In the first case, the change is proven inert against `add_gen()` output, `.maxpat` round-trip bytes, and the full test suite, and the `fc3aa27` Jitter pair gains the test coverage it shipped without.
</success_criteria>

<output>
Create `.planning/quick/260921-ima-per-sf-03-in-planning-quick-260921-g5d-r/260921-ima-SUMMARY.md` when done.
</output>
