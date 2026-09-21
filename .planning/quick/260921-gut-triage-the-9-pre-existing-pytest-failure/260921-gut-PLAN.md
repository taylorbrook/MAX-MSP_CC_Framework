---
phase: quick-260921-gut
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - tests/test_signal_role_migration.py
  - tests/test_round_trip.py
  - tests/review_blocker_allowlist.json
autonomous: true
requirements: [MF-02]

estimate:
  tokens: 55000
  raw_tokens: 35000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "`python3 -m pytest -q` exits 0 from the repo root"
    - "All 9 previously-failing node ids resolve to passed or xfailed — none failed"
    - "Each of the 9 failures has its individual root cause recorded in the artifact that implements its resolution (allowlist `reason` field, xfail reason string, or test docstring)"
    - "scala-synth byte-identity retains REAL coverage: the assertion still executes and passes against the clean committed blob"
    - "No file under `patches/` is modified, staged, or reverted"
    - "Round-trip semantic losslessness is asserted for every parametrized patch, including ones exempted from byte identity"
  artifacts:
    - tests/test_signal_role_migration.py
    - tests/test_round_trip.py
    - tests/review_blocker_allowlist.json
  key_links:
    - "allowlist JSON path keys <-> `patch_path.relative_to(_REPO_ROOT).as_posix()` in `_is_allowlisted`"
    - "new allowlist entry fields `kind`/`source_id`/`outlet` <-> `_entry_key()` signature derivation"
    - "MAX-compact-array detection in source text <-> `json.dumps(indent=N)` structural inability to reproduce it"
---

<objective>
Return `python3 -m pytest -q` to a green baseline by individually root-causing and resolving the 9 pre-existing failures recorded as MF-02.

Purpose: a suite with 9 permanent failures cannot certify any change — "9 failed" is indistinguishable from "9 failed plus yours". This restores the suite as a gate.
Output: three test-layer files edited; zero files under `patches/` touched; every one of the 9 carries a specific recorded reason.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md

@tests/test_integration_patches.py
@tests/test_round_trip.py
@tests/test_signal_role_migration.py
@tests/review_blocker_allowlist.json
</context>

<planning_observations>
The live failure set was measured at planning time and is **identical** to the 9 listed under MF-02 — no drift. Baseline: `9 failed, 2169 passed, 4 xfailed` in ~37s.

Root causes established at planning time (do not re-derive from scratch; verify and build on these):

**Group A — 6x `test_review_patch_no_blockers`.** `tests/review_blocker_allowlist.json` was committed `85b8f92` on **2026-07-02** covering the 14 patches that existed then. All 6 failing patches were added or re-saved **after** that date (looper 2026-08-24, simple-fm 2026-08-19, stereo-feedback-delay 2026-08-26, reverse-delay 2026-09-16, terrain-osc-test 2026-09-21). Probed directly: each of the 6 has `in_allowlist=False` with `entries=0`, and each carries **exactly one** fan-out blocker. The path-key format is correct and the mechanism works as designed ("a NEW patch is never exempted") — it simply was not maintained as new patches landed. This is unmaintained debt, not a broken mechanism.

**Group B — 2x `test_byte_identical_round_trip`.** Shared root cause: the file on disk carries MAX-saved **compact inline arrays** (`"rect": [ 34.0, 104.0, 1333.0, 617.0 ],`) which `json.dumps(indent=N)` structurally cannot reproduce — verbatim the reason already recorded on the existing `minitaur` xfail. Proven **not** data loss: `Patcher.from_dict(o).to_dict() == o` is `True` for all three files. Per-file:
- `performance-patch-template.maxpat` — MAX-compact at **HEAD** (329 compact lines). Permanent; same class as minitaur.
- `scala-synth.maxpat` — round-trips **byte-identical at HEAD** (162823 -> 162823, verified against `git show HEAD:...`). It fails **only** because the working tree holds the user's uncommitted 100,771-byte MAX-re-saved copy (319 compact lines vs **0** at HEAD).

  > This **contradicts** REVIEW-FINDINGS MF-02, which claims the HEAD blob also fails (162823 -> 162824). That claim is wrong. A static xfail on scala-synth would permanently mask a test that genuinely passes on committed state — forbidden here.

  Working-tree vs committed is therefore the discriminator, and it is **content-derived**: grep for compact arrays returns 319 in the working tree and 0 at HEAD.

**Group C — 1x `test_dsp_critic_outlet_signal_read_pattern_unchanged`.** The test asserts a hard-coded **line number** (`lines[300]`, i.e. line 301). `dsp_critic.py` gained lines (most recently `b1a68c9 fix(critics): recognize multichannelsignal as a signal outlet type`), so line 301 is now `if src_is_signal or not dst_is_signal:` while the anchored `outlettype` read moved to lines 305-306. The anchored **behavior is fully intact** — four `outlettype` consumer sites remain (204/207, 305/306, 405/408, 433/436). The test is brittle by construction: it asserts a location, not a property. Its sibling at `lines[249]` (patcher.py:250) currently passes **by luck** and carries the identical anti-pattern.
</planning_observations>

<planner_contribution_dispositions>
Four `plan:pre` fragments were injected. Firing conditions evaluated against this task's scope:

- **ai-integration API coverage** — does not fire. No external API/SDK/service is integrated; scope is the local pytest suite and three test-layer files.
- **assumption-delta** — does not fire. No singular->plural, required->optional, or derived->chosen transition in a core identity model. (Task 2 moves a static exemption list to content-derived detection, which is the *opposite* direction — chosen to derived — and changes no primary-key/identity noun.)
- **schema-push gate** — does not fire. No Prisma/Drizzle/Payload/Supabase/TypeORM schema files exist in this repo.
- **security threat_model** — fires (enforcement active). `<threat_model>` block included below at ASVS level 1, `block_on: high`.
</planner_contribution_dispositions>

<tasks>

<task type="tracer">
  <name>Task 1: De-brittle the back-compat consumer anchors — one failure, end-to-end</name>
  <files>tests/test_signal_role_migration.py</files>
  <precondition>`src/maxpat/critics/dsp_critic.py` still contains at least one `src_outlettype[...] in _SIGNAL_OUTLET_TYPES` read; if zero such reads exist the back-compat consumer surface is genuinely gone and this task must halt rather than adjust the test.</precondition>
  <action>
Fix `TestBackCompatConsumerAnchors` so both anchors assert the back-compat consumer *property* instead of a source line number.

Replace the `lines[300]` lookup in `test_dsp_critic_outlet_signal_read_pattern_unchanged` with a whole-file scan of `src/maxpat/critics/dsp_critic.py`: collect every line matching the existing accepted read shapes (the `outlet` subscript/`get` forms already enumerated in the test, plus the `outlettype` form) and assert the collected set is non-empty. Assert a floor on the number of matching consumer sites (four exist today at 204/207, 305/306, 405/408, 433/436 — anchor at >= 4 so deletion of a consumer still trips the test) and include the matched line numbers in the assertion message so a future drift is self-diagnosing.

Apply the identical restructuring to the sibling `patcher.py` anchor that reads `lines[249]`. It passes today only because `patcher.py` has not drifted; leaving it is a scheduled recurrence of this same failure. Its accepted read shapes are the `outlet` subscript/`get` forms (no `outlettype` form).

Update the docstrings and the module-header prose that name `dsp_critic.py:301` and `patcher.py:250` so they describe the anchored property rather than a coordinate. Record in the docstring of the dsp_critic anchor the individual root cause for this failure: the anchor tracked a line index, `dsp_critic.py` grew via `b1a68c9`, and the read relocated while the behavior stayed intact.

Preserve the intent exactly: the test must still fail if the back-compat consumer read pattern is removed. Do not weaken it to a bare "file is non-empty" check.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest -q tests/test_signal_role_migration.py 2>&1 | tail -3</automated>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "import re,pathlib; s=pathlib.Path('tests/test_signal_role_migration.py').read_text(); body=[l for l in s.splitlines() if not l.lstrip().startswith('#')]; assert not [l for l in body if re.search(r'lines\[\d+\]', l)], 'a positional line index survives in executable code'; print('anchors are property-based')"</automated>
  </verify>
  <done>`tests/test_signal_role_migration.py` passes in full; no positional `lines[N]` index remains in executable code in that file; both anchors still fail if the consumer read pattern is deleted.</done>
</task>

<task type="auto">
  <name>Task 2: Make round-trip byte identity content-derived, and assert semantic losslessness always</name>
  <files>tests/test_round_trip.py</files>
  <precondition>`git show HEAD:patches/scala-synth/generated/scala-synth.maxpat` round-trips byte-identical (162823 bytes in, 162823 out) while the working-tree copy does not — confirming the scala-synth failure is working-tree-only. Verify this before editing; if the HEAD blob also fails, the root cause differs from the one planned here and the task must halt.</precondition>
  <behavior>
    - Every parametrized patch: `Patcher.from_dict(original).to_dict() == original` (semantic losslessness) — asserted unconditionally, including for patches exempted from byte identity.
    - A patch whose source text has no MAX-compact arrays: byte identity asserted for real and passes (clean committed scala-synth is the live example).
    - A patch whose source text has MAX-compact arrays: byte identity is skipped via a dynamic xfail naming the detected formatting, not silently passed.
  </behavior>
  <action>
Restructure `TestSubpatcherByteIdentity::test_byte_identical_round_trip` around the proven root cause.

First, add an unconditional assertion that the round-trip is semantically lossless — compare the `to_dict()` result against the parsed original dict directly. This is a strengthening: no such assertion exists today, and it is what actually proves `Patcher` is not losing data. It must run for every parametrized patch, including ones exempted from byte identity, and must run before the byte comparison.

Second, replace the static per-file xfail with content-derived detection. Add a small module-level helper that reports whether the source text contains MAX-saved compact inline numeric arrays — measured at planning time as 0 occurrences in the clean committed scala-synth blob versus 319/329/1292 in the three re-saved files, so the signal is unambiguous. When the helper reports compact formatting, call `pytest.xfail` with a reason that names the file and states that MAX-saved compact array formatting cannot be reproduced by `json.dumps` with an indent, and that semantic equality was already asserted above. When it does not, assert byte identity as the test does today.

Remove the now-redundant static `xfail` marker on the `minitaur` param, since detection subsumes it — leave the param itself in place. Do not add a static marker for `performance-patch-template` or `scala-synth`; detection must be the only mechanism, so that a future clean re-save of any of them silently restores full byte-identity coverage.

Record the two individual root causes in the reason string and in the test docstring: `performance-patch-template` is MAX-compact at HEAD and therefore permanently exempt; `scala-synth` is byte-identical at HEAD and is exempt only while an uncommitted MAX-re-saved copy sits in the working tree.

Do not read, write, stage, or revert anything under `patches/` — the working-tree copies are inputs observed as-is.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest -q tests/test_round_trip.py 2>&1 | tail -3</automated>
    <automated>cd /Users/taylorbrook/Dev/MAX && D=$(mktemp -d) && git show HEAD:patches/scala-synth/generated/scala-synth.maxpat > "$D/s.maxpat" && python3 -c "
import json,sys; sys.path.insert(0,'.')
from src.maxpat.patcher import Patcher
from tests.test_round_trip import detect_indent
t=open('$D/s.maxpat').read(); o=json.loads(t)
r=Patcher.from_dict(o).to_dict()
assert r==o, 'semantic round-trip regressed'
rt=json.dumps(r,indent=detect_indent(t),ensure_ascii=False)+('\n' if t.endswith('\n') else '')
assert rt==t, 'clean committed scala-synth lost real byte-identity coverage'
print('clean HEAD blob: semantic OK, byte-identical OK')"</automated>
  </verify>
  <done>`tests/test_round_trip.py` reports zero failures; the clean committed scala-synth blob still passes a real byte-identity assertion; semantic equality is asserted for every parametrized patch.</done>
</task>

<task type="auto">
  <name>Task 3: Extend the review-blocker allowlist with six individually-reasoned entries, then gate the full suite green</name>
  <files>tests/review_blocker_allowlist.json</files>
  <action>
Add one entry per failing patch to the `patches` object, keyed by the exact repo-relative POSIX path that `_is_allowlisted` derives. Each of the six carries exactly one fan-out blocker; the signature keys were probed at planning time:

| path key | source | source_id | outlet | destinations |
|---|---|---|---|---|
| `patches/looper/generated/looper.maxpat` | `inlet` | `obj-51` | 0 | `gen~`, `meter~` |
| `patches/reverse-delay/generated/reverse-delay-mono.maxpat` | `preset` | `obj-2` | 0 | 24 controls (`dial` x22, `umenu` x1, `toggle` x1) |
| `patches/reverse-delay/generated/reverse-delay.maxpat` | `preset` | `obj-2` | 0 | 25 controls (`dial` x22, `umenu` x2, `toggle` x1) |
| `patches/simple-fm/generated/simple-fm.maxpat` | `kslider` | `obj-1` | 1 | `select`, `makenote` |
| `patches/stereo-feedback-delay/generated/stereo-feedback-delay.maxpat` | `preset` | `obj-59` | 0 | 8 `dial` |
| `patches/terrain-synth/generated/terrain-osc-test.maxpat` | `jit.matrix` | `obj-18` | 0 | `trigger`, `jit.cellblock` |

Mirror the existing entry shape exactly (`severity`, `kind`, `source`, `source_id`, `outlet`, `destinations`) so `_entry_key()` matches — it reads only `kind`, `source_id`, and `outlet`. Re-derive each signature from a live `review_patch()` run rather than transcribing this table, and confirm the derived key equals `_blocker_match_key(finding)` before writing.

Add a `reason` field to each new entry. `_entry_key()` ignores unknown fields, so this is safe, and it is where the individual root cause for each of these six failures is recorded. Each reason must be specific to that blocker — no shared boilerplate. Judge and state which kind it is: a `preset` object fanning out to its own bound controls cannot be trigger-ordered and is inherent to how `preset` works; an `inlet` feeding `gen~` alongside a `meter~` monitor tap is a signal-domain connection where CLAUDE.md Rule #3 states ordering does not apply; `kslider` outlet 1 velocity feeding `select` and `makenote` is genuine control-rate fan-out debt in a frozen patch. State in each reason that the patch is frozen per the allowlist's own `_doc` regression constraint.

Extend the file's `_doc` string to note that the allowlist requires maintenance when new patches land, and that these six were added by quick-260921-gut after the original 14 went stale on 2026-07-02.

Do not modify `src/maxpat/critics/` in this task. Changing fan-out critic behavior alters generation-time output for every patch and belongs to its own task with its own test coverage — the same boundary REVIEW-FINDINGS drew for MF-03 and SF-03. Do not edit, stage, or revert any file under `patches/`.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -c "
import json,sys; sys.path.insert(0,'.')
d=json.load(open('tests/review_blocker_allowlist.json'))['patches']
new=['patches/looper/generated/looper.maxpat','patches/reverse-delay/generated/reverse-delay-mono.maxpat','patches/reverse-delay/generated/reverse-delay.maxpat','patches/simple-fm/generated/simple-fm.maxpat','patches/stereo-feedback-delay/generated/stereo-feedback-delay.maxpat','patches/terrain-synth/generated/terrain-osc-test.maxpat']
assert len(d)==20, f'expected 20 patch keys, got {len(d)}'
rs=[]
for k in new:
    assert k in d, f'missing {k}'
    for e in d[k]:
        r=e.get('reason','').strip()
        assert len(r)>=40, f'{k}: reason too thin to be a root cause'
        rs.append(r)
assert len(set(rs))==len(rs), 'reason strings are not individually specific'
print('6 keys present, 20 total, reasons specific and distinct')"</automated>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest -q 2>&1 | tail -2</automated>
    <automated>cd /Users/taylorbrook/Dev/MAX && python3 -m pytest -q >/dev/null 2>&1; echo "pytest exit=$?"; test -z "$(git diff --cached --name-only -- patches/)" && echo "patches staged: none"; echo "patches dirty count: $(git status --porcelain -- patches/ | wc -l | tr -d ' ')"</automated>
  </verify>
  <done>Twenty patch keys in the allowlist; all six new entries carry a distinct, specific `reason`; `python3 -m pytest -q` exits 0; nothing under `patches/` is staged and the dirty count there is still exactly 2.</done>
</task>

</tasks>

<threat_model>
Security enforcement is active (ASVS level 1, `block_on: high`). This task edits three test-layer files in a local repo, installs nothing, and adds no network or user-input path — so the register is short and honest rather than padded.

## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| working tree -> test process | `.maxpat` files are read from disk and `json.load`ed by the suite. Includes another Claude instance's uncommitted `scala-synth.maxpat`. Pre-existing, in-repo, developer-controlled. |
| git object store -> verify commands | `git show HEAD:<path>` blobs are round-tripped in Task 2's verification. Read-only, committed content. |

No package-manager install task exists in this plan (no npm/pip/cargo install), so the package-legitimacy gate does not apply and no `T-*-SC` row is required.

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-gut-01 | Tampering | `tests/review_blocker_allowlist.json` | medium | mitigate | An over-broad entry would silently exempt future real blockers. Entries are keyed per-patch AND per-signature (`kind`/`source_id`/`outlet`) via `_entry_key()`; Task 3's verify asserts exactly 20 keys and distinct per-entry reasons, so a wildcard or duplicated exemption fails the gate. |
| T-gut-02 | Tampering | `tests/test_round_trip.py` exemption path | high | mitigate | A blanket xfail would mask a genuinely-passing test (scala-synth). Exemption is content-derived, never static; Task 2's second verify command asserts the clean committed blob still passes a real byte-identity assertion, and a new unconditional semantic-equality assertion covers every patch including exempted ones. |
| T-gut-03 | Tampering | `patches/` working-tree files owned by a concurrent instance | high | mitigate | Plan touches no file under `patches/`. Task 3's final verify asserts nothing under `patches/` is staged and the dirty count is exactly 2. No `git add .`/`-A` and no `git stash` anywhere, per CLAUDE.md Rule #7. |
| T-gut-04 | Repudiation | root-cause record for the 9 failures | low | mitigate | Each resolution records its own reason in the enforcing artifact (allowlist `reason`, xfail reason string, or test docstring), so the justification cannot drift away from the exemption it justifies. |
| T-gut-05 | Information disclosure | `.maxpat` contents surfaced in assertion output | low | accept | Local developer repo, local test output, no secrets in patch JSON. |
</threat_model>

<verification>
Run from the repo root after all three tasks:

1. `python3 -m pytest -q` — exits 0. Expect `0 failed`; passed count >= 2169 and xfailed count may rise (byte-identity exemptions are now dynamic).
2. All 9 originally-failing node ids resolve to passed or xfailed:
   `python3 -m pytest -q tests/test_integration_patches.py::test_review_patch_no_blockers tests/test_round_trip.py::TestSubpatcherByteIdentity tests/test_signal_role_migration.py::TestBackCompatConsumerAnchors`
3. No regression in total collected tests — the count must not drop. No test was deleted, skipped wholesale, or had an assertion loosened.
4. `git status --porcelain -- patches/` still lists exactly the 2 pre-existing user modifications; `git diff --cached --name-only -- patches/` is empty.
5. Commit only the three test-layer files by explicit path. Never `git add .` or `git add -A`.
</verification>

<success_criteria>
- `python3 -m pytest -q` exits 0 from `/Users/taylorbrook/Dev/MAX`.
- Zero failures; the 9 are resolved as: 6 allowlisted with distinct reasons, 2 dynamically exempted with file-specific reasons, 1 fixed outright.
- Each of the 9 has an individually recorded root cause in the artifact enforcing its resolution.
- The clean committed scala-synth blob still passes a real byte-identity assertion — coverage preserved, not masked.
- Semantic round-trip losslessness is now asserted for every parametrized patch (net new coverage).
- `patches/` is untouched: 2 dirty files, 0 staged, 0 reverted.
- No change under `src/maxpat/` — critic-behavior changes are out of scope and belong to the MF-03/SF-03 follow-ups.
</success_criteria>

<output>
Create `.planning/quick/260921-gut-triage-the-9-pre-existing-pytest-failure/260921-gut-SUMMARY.md` when done.

The SUMMARY must contain a table of all 9 node ids with, for each: root cause, resolution (fixed / allowlisted / dynamically exempted), and where the reason is recorded. It must also note the correction to REVIEW-FINDINGS MF-02: the claim that the committed scala-synth blob fails byte identity at HEAD is wrong — it round-trips byte-identical (162823 -> 162823), and only the uncommitted working-tree copy fails.
</output>
