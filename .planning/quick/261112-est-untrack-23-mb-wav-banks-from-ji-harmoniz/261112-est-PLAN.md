---
phase: quick-261112-est
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - .gitignore
  - patches/ji-harmonizer/context.md
  - "patches/ji-harmonizer/generated/bank00..bank19-*.wav (index only: git rm --cached; the 20 files stay on disk)"
autonomous: true
requirements: [UNTRACK-01, UNTRACK-02, UNTRACK-03]

estimate:
  tokens: 40000
  raw_tokens: 40000
  tasks: 2
  confidence: low

must_haves:
  truths:
    - "`git ls-files -- '*.wav'` is empty at HEAD (baseline at aa087eea: 20 paths, all patches/ji-harmonizer/generated/bankNN-*.wav)"
    - "All 20 bank WAVs are still on disk in patches/ji-harmonizer/generated/ with sha256 identical to the pre-change snapshot (`shasum -a 256 -c --quiet` exits 0)"
    - "`git check-ignore` reports all 20 banks ignored by `/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav`; `patches/terrain-synth/generated/bank00-torus-sdf.wav` is ignored by the terrain-synth line; ji-harmonizer.maxpat, ji-engine.js, jhpresets.json and terrain-synth.maxpat are NOT ignored"
    - "`git status --porcelain -- patches/ji-harmonizer .gitignore` is empty after the commit (no `??` for the banks)"
    - "patches/ji-harmonizer/context.md has a `## Wavetable banks (not in git)` section with the regen command `python3 patches/ji-harmonizer/tools/render_wavetables.py --all`, the byte-identical/deterministic note, and the fresh-clone/agent-worktree prerequisite"
    - "Exactly one commit, exactly 22 paths (20 WAV deletions from the index + .gitignore + context.md); no history rewrite, no push"
    - "Full suite `python3 -m pytest -q` reports the same passed/failed/skipped/xfailed/error counts and the same failing test IDs as the pre-change baseline (last recorded green run: 7598 passed, 1 skipped, 4 xfailed in 261112-dci)"
    - "auto_commit_patch on ji-harmonizer is unaffected: `git add --dry-run -- patches/ji-harmonizer` exits 0 and names no WAV (directory pathspecs skip ignored files; the save hook only ever passes the saved .maxpat/.js/.gendsp path)"
  artifacts:
    - path: .gitignore
      provides: "Anchored ignore patterns for generated wavetable banks"
      contains: "/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav"
    - path: patches/ji-harmonizer/context.md
      provides: "Regeneration instructions for the untracked banks"
      contains: "## Wavetable banks (not in git)"
  key_links:
    - from: .gitignore
      to: patches/ji-harmonizer/generated/bankNN-*.wav
      via: "anchored pattern, proven with git check-ignore -v"
      pattern: "bank\\[0-9\\]\\[0-9\\]-\\*\\.wav"
    - from: patches/ji-harmonizer/context.md
      to: patches/ji-harmonizer/tools/render_wavetables.py
      via: "regen command; main() writes to Path(__file__).parent.parent / 'generated'"
      pattern: "render_wavetables.py --all"
    - from: patches/ji-harmonizer/generated/ji-harmonizer.maxpat
      to: patches/ji-harmonizer/generated/bankNN-*.wav
      via: "buffer~ jiharmA/jiharmB arg + umenu -> prepend replace (resolved from the patch dir)"
      pattern: "bank\\d\\d-[a-z0-9-]+\\.wav"
---

<objective>
Untrack the 20 ji-harmonizer wavetable banks (`patches/ji-harmonizer/generated/bankNN-*.wav`, ~23 MB each, ~461 MB total) from git, keep them on disk byte-for-byte, gitignore them with anchored patterns, and document regeneration in the project's context.md. One commit. NO history rewrite, NO filter-repo, NO push.

Requirement IDs (quick-task scope):
- UNTRACK-01: the banks leave the git index; they stay on disk unchanged; they cannot be re-added by accident (anchored gitignore, terrain-synth bank pattern included).
- UNTRACK-02: patches/ji-harmonizer/context.md says how to regenerate them, that output is byte-identical, and that fresh clones / agent worktrees must render before opening the patch in MAX.
- UNTRACK-03: nothing else regresses: the patch still references the 20 bank names and they resolve in generated/, auto_commit_patch still works on ji-harmonizer, the full pytest suite matches its baseline.

Locked facts (orchestrator Phase A, do not re-litigate):
- Generator `patches/ji-harmonizer/tools/render_wavetables.py` is deterministic numpy (no RNG); `--all` writes all 20 to `../generated/` relative to the script (hard-coded in `main()`), ~1 s. Re-render with numpy 2.4.0 gave sha256-identical files for all 20.
- Only consumer: `patches/ji-harmonizer/generated/ji-harmonizer.maxpat` (`buffer~ jiharmA bank00-ji-harmonic.wav`, `buffer~ jiharmB bank00-ji-harmonic.wav`, umenus -> `prepend replace` with all 20 names). No test reads the WAVs. Release is `git archive` and `.gitattributes` already export-ignores `/patches`, so banks never shipped.
- Decision: untrack and regenerate on demand (not release assets, not LFS).

Planner-verified facts (scratch repo + live tree, 2026-11-12):
- `git commit -m msg -- <wav paths>` after `git rm --cached` RE-READS the files from the working tree (git's --only mode) and the WAVs STAY TRACKED. The untrack commit must therefore commit the index with no pathspec, guarded by an exact staged-set assertion (Task 1 step 6).
- After the patterns are in place, `git add -- <dir>` exits 0 and silently skips ignored files; only an explicitly named ignored path makes `git add` exit 1. `src/maxpat/hooks.py` calls `auto_commit_patch(project_dir, root, files=[<saved file>])` with the saved .maxpat/.js/.gendsp only, so no ji-harmonizer save can hit the ignored-path refusal. No change to `src/maxpat/project.py` is needed.
- No file under tests, src, tools or scripts names a bank WAV (`grep -rlE 'bank[0-9]{2}-[a-z-]+[.]wav' tests src tools scripts` prints nothing); the repo tests that call ls-files/check-ignore glob only `*.maxpat`/`*.gendsp` or use temp repos.
- `git check-ignore` matches non-existent paths (used for the retired terrain-synth bank name). Git pathspec globs like `'*.wav'` and `'patches/ji-harmonizer/generated/*.wav'` match across directories (grounded: `git ls-files -- '*.wav'` lists the 20 banks at HEAD).

Purpose: ~461 MB of derived data stops riding along in every checkout, agent worktree and status scan, while the patch keeps working for anyone who runs the 1-second render.
Output: one commit touching .gitignore, patches/ji-harmonizer/context.md and the 20 index entries; SUMMARY with before/after pytest results.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@CLAUDE.md
@patches/ji-harmonizer/context.md
@patches/ji-harmonizer/tools/render_wavetables.py
@.gitignore

Interfaces the executor relies on (already read by the planner; do not re-derive):
- `render_wavetables.py` usage: no args = bank 0, `N M ...` = selected banks, `--all` = all 20; output dir is `Path(__file__).resolve().parent.parent / "generated"`.
- `.gitignore` currently ends with the GSD quick-task block whose last line is `!/.planning/quick/*/*.md` followed by a newline.
- `src/maxpat/project.py` `auto_commit_patch()` runs `git --literal-pathspecs add -- <paths>` then `git commit -m <msg> -- <paths>`; `_run_git` raises RuntimeError on a non-zero exit; `src/maxpat/hooks.py` catches it and warns.
- Scratch artifacts go in the quick dir as non-.md files (ignored by `/.planning/quick/*/*`, verified with `git check-ignore`).
- Full suite runs in ~30 s with `-n auto` (261112-dci full-suite.txt: `7598 passed, 1 skipped, 4 xfailed, 37 warnings in 25.78s`).
</context>

<tasks>

<task type="tracer">
  <name>Task 1: Pre-flight snapshot, untrack the 20 banks, gitignore + document, one commit</name>
  <files>.gitignore, patches/ji-harmonizer/context.md, patches/ji-harmonizer/generated/bank*.wav (index only)</files>
  <action>
Run everything from the repo root on the MAIN working tree. Never `git stash`, never `git add .` / `git add -A`, never plain `git rm` (always `--cached`), never `-f` on add, never filter-repo / push / force-push (CLAUDE.md Rule #7).

Let QD = `.planning/quick/261112-est-untrack-23-mb-wav-banks-from-ji-harmoniz`.

1. Pre-flight asserts (STOP and report if any fails, do not work around):
   - Main checkout, not a worktree: `git rev-parse --git-dir` equals `git rev-parse --git-common-dir` (both `.git`). A worktree commit that deletes tracked files would delete the on-disk banks in the main checkout when merged back.
   - Index clean: `git diff --cached --quiet` exits 0 (another instance's staged work must not ride along in the index-based commit below).
   - `git ls-files -- '*.wav'` lists exactly 20 paths, all under `patches/ji-harmonizer/generated/`.
   - Snapshot hashes: `shasum -a 256 patches/ji-harmonizer/generated/bank*.wav > QD/wav-sha256-before.txt`; it must have 20 lines.
2. Pytest baseline BEFORE any change: `python3 -m pytest -q > QD/pytest-before.txt 2>&1` (pytest.ini supplies `-n auto`; ~30 s). Do not edit files or the index while it runs. Its exit status may be non-zero if failures pre-exist; that is fine, the file is the baseline.
3. Edit `.gitignore` (Edit tool, anchored on the final `!/.planning/quick/*/*.md` line): append one blank line and then a block of three comment lines plus two patterns. Comments, in substance: generated wavetable banks (~23 MB each) are derived data, regenerate instead of committing (quick 261112-est); ji-harmonizer regen is `python3 patches/ji-harmonizer/tools/render_wavetables.py --all`; terrain-synth's retired bake_geometry banks are covered so they cannot be re-added. Patterns, exactly: `/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav` and `/patches/terrain-synth/generated/bank[0-9][0-9]-*.wav`. Do not touch any existing line. Keep the trailing newline.
4. Edit `patches/ji-harmonizer/context.md`:
   a. Insert a new section `## Wavetable banks (not in git)` immediately after the `## Origin` section (directly before the `## Source-plugin functional summary (from code exploration, 2026-08-13)` heading), with a blank line on each side, as 4-5 terse bullets covering: (i) the 20 `generated/bankNN-*.wav` banks (~23 MB each, ~461 MB total) were untracked on 2026-11-12 (quick 261112-est) and are ignored by `/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav` in the repo-root `.gitignore`; `tools/render_wavetables.py` is the source of truth; (ii) regenerate from the repo root with `python3 patches/ji-harmonizer/tools/render_wavetables.py --all` (writes to `patches/ji-harmonizer/generated/` regardless of cwd, ~1 s, needs numpy); output is deterministic (no RNG) and a 2026-11-12 re-render with numpy 2.4.0 matched all 20 previously tracked files by sha256, so regenerated banks are byte-identical; (iii) fresh clones and agent worktrees (`.claude/worktrees/`) have no banks: render before opening `ji-harmonizer.maxpat` in MAX, otherwise `buffer~ jiharmA` / `buffer~ jiharmB` and the bank umenu `replace` loads log "can't find file" and the wavetable oscillators have no data; (iv) history was not rewritten: commits before the untrack commit still hold the banks, so `git show <untrack-commit>^:patches/ji-harmonizer/generated/<name>.wav > patches/ji-harmonizer/generated/<name>.wav` recovers one without numpy; (v) never `git add -f` them.
   b. Mark the two historical decisions superseded without rewriting them: append ` *(Superseded 2026-11-12: banks untracked — see "Wavetable banks (not in git)".)*` to the end of the slice-2 bullet that ends `step; the Python tool remains the source of truth for regeneration.` and to the end of the slice-4 bullet that ends `well under GitHub's 100 MB per-file limit.` Touch nothing else in context.md.
5. Untrack (index only): `git rm --cached -q -- patches/ji-harmonizer/generated/bank*.wav` (the shell glob expands to exactly the 20 on-disk files). Then `git add -- .gitignore patches/ji-harmonizer/context.md`.
6. Staged-set assertion (this replaces path-scoping for Rule #7 multi-instance safety): `git diff --cached --name-status` must list exactly 22 lines: 20 `D` lines, all of them `patches/ji-harmonizer/generated/bankNN-<name>.wav`, plus `M .gitignore` and `M patches/ji-harmonizer/context.md`. Cross-check with `git diff --cached --name-only --diff-filter=D -- 'patches/ji-harmonizer/generated/*.wav'` listing 20 paths. If anything else is staged, STOP and report (do not unstage someone else's work).
7. Commit the index with NO pathspec: `git commit -q -m "chore(ji-harmonizer): untrack generated wavetable banks; regenerate on demand"` plus a short body (banks are derived, byte-identical via `python3 patches/ji-harmonizer/tools/render_wavetables.py --all`; history not rewritten; files kept on disk). Do NOT use `git commit -- <paths>` here: verified in a scratch repo that the pathspec form re-reads the WAVs from disk and keeps them tracked. Do not pass `--no-verify`.
8. Record the commit race-safely (path-scoped, the same technique auto_commit_patch uses): `git log -1 --format=%H -- .gitignore patches/ji-harmonizer/context.md > QD/untrack-commit.txt`; confirm its subject is the message from step 7. Every later check pins this sha instead of a relative `HEAD~N`.
9. Immediately re-check on-disk integrity: `shasum -a 256 -c --quiet QD/wav-sha256-before.txt` exits 0 and `ls patches/ji-harmonizer/generated/bank*.wav` lists 20 files.
  </action>
  <verify>
    <automated>QD=.planning/quick/261112-est-untrack-23-mb-wav-banks-from-ji-harmoniz && GD=$(git rev-parse --git-dir) && GC=$(git rev-parse --git-common-dir) && test "$GD" = "$GC" && C=$(cat "$QD/untrack-commit.txt") && SUBJ=$(git log -1 --format=%s "$C") && test "$SUBJ" = "chore(ji-harmonizer): untrack generated wavetable banks; regenerate on demand" && W=$(git ls-files -- '*.wav') && test -z "$W" && shasum -a 256 -c --quiet "$QD/wav-sha256-before.txt" && git check-ignore -q patches/ji-harmonizer/generated/bank00-ji-harmonic.wav && S=$(git status --porcelain -- patches/ji-harmonizer .gitignore) && test -z "$S" && N=$(git diff-tree --no-commit-id --name-only -r "$C") && test "$(printf '%s\n' "$N" | wc -l | tr -d ' ')" = 22 && D=$(git diff-tree --no-commit-id --name-only -r --diff-filter=D "$C" -- 'patches/ji-harmonizer/generated/*.wav') && test "$(printf '%s\n' "$D" | wc -l | tr -d ' ')" = 20 && grep -q '^## Wavetable banks (not in git)' patches/ji-harmonizer/context.md && grep -q 'python3 patches/ji-harmonizer/tools/render_wavetables.py --all' patches/ji-harmonizer/context.md && echo TRACER-OK</automated>
  </verify>
  <done>The recorded untrack commit has exactly 22 paths (20 WAV index deletions + .gitignore + context.md) and the planned subject; `git ls-files -- '*.wav'` is empty (baseline: 20 paths); all 20 banks exist on disk with unchanged sha256; bank00 is gitignored; ji-harmonizer and .gitignore have no untracked or modified entries; context.md has the new section (absent at HEAD before the change) with the regen command; QD/pytest-before.txt holds the pre-change suite run; QD/untrack-commit.txt holds the commit sha.</done>
</task>

<task type="auto">
  <name>Task 2: Prove nothing else moved — ignore scope, patch references, auto-commit path, full suite vs baseline</name>
  <files>(read-only checks; no tracked file changes)</files>
  <action>
Read-only verification; if any check fails, report it with the exact output and do not "fix" by editing patches or src. QD and the commit sha C come from Task 1 (`C=$(cat QD/untrack-commit.txt)`).

1. Ignore scope (UNTRACK-01): `git check-ignore patches/ji-harmonizer/generated/bank*.wav` prints 20 paths, and `git check-ignore -v` on any one bank attributes it to the `/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav` line of `.gitignore`. `git check-ignore -q patches/terrain-synth/generated/bank00-torus-sdf.wav` exits 0. Negative scope: `git check-ignore -q` must exit exactly 1 (not ignored; 128 would be a git error) for each of `patches/ji-harmonizer/generated/ji-harmonizer.maxpat`, `patches/ji-harmonizer/generated/ji-engine.js`, `patches/ji-harmonizer/generated/jhpresets.json`, `patches/terrain-synth/generated/terrain-synth.maxpat` (the patterns must not hide real project files from auto_commit_patch).
2. Patch references resolve (UNTRACK-03, verification d): the python one-liner in this task's `<verify>` extracts every distinct `bankNN-*.wav` name from `patches/ji-harmonizer/generated/ji-harmonizer.maxpat` and asserts there are 20 and all 20 exist in `patches/ji-harmonizer/generated/` (planner baseline at HEAD: `20 names 0 missing`). Confirm `git diff "$C^" "$C" -- patches/ji-harmonizer/generated/ji-harmonizer.maxpat` is empty (patch untouched by the commit). The MAX load check (open the patch, both buffer~ load bank00 without "can't find file", switching a bank umenu loads the new bank) is a PENDING USER CHECK: list it in the SUMMARY, do not claim it.
3. auto_commit_patch compatibility (orchestrator question, answered without a code change): `git add --dry-run -- patches/ji-harmonizer` exits 0 and its output names no WAV. Record in the SUMMARY: directory pathspecs skip ignored files silently; only an explicitly named ignored file makes `git add` exit 1, and `src/maxpat/hooks.py` only ever passes the saved .maxpat/.js/.gendsp path, so a ji-harmonizer save cannot hit that refusal.
4. Test invariant: `grep -rlE 'bank[0-9]{2}-[a-z-]+[.]wav' tests src tools scripts` prints nothing (no test asserts the banks are tracked; planner baseline: prints nothing).
5. Full suite AFTER: `python3 -m pytest -q > QD/pytest-after.txt 2>&1`. Compare with QD/pytest-before.txt: the outcome counts on the final line (passed/failed/skipped/xfailed/xpassed/error; ignore the warnings count and wall time) must be identical, and the sorted `FAILED`/`ERROR` test-ID lists (message tails stripped) must be identical. Any new failure is a regression: report it, do not mask it. Pre-existing failures are reported as pre-existing with their IDs.
6. Final repo state: `git log -1 --format='%H %s' "$C"`, `git status --porcelain -- patches/ji-harmonizer .gitignore` empty, `git ls-files -- '*.wav'` empty. Do not push (origin/main is the user's call). Note in the SUMMARY that clone size is unchanged because history is not rewritten; only future checkouts, worktrees and status scans stop carrying the banks.

SUMMARY (written by the executor per the template) must include: commit sha; before/after pytest final lines and failing-ID lists; the sha256 check result; the ignore-scope results; the auto_commit_patch finding; the pending user MAX check; and the "regenerate before opening in MAX" reminder for fresh clones/worktrees.
  </action>
  <verify>
    <automated>QD=.planning/quick/261112-est-untrack-23-mb-wav-banks-from-ji-harmoniz && C=$(cat "$QD/untrack-commit.txt") && L=$(git check-ignore patches/ji-harmonizer/generated/bank*.wav) && test "$(printf '%s\n' "$L" | wc -l | tr -d ' ')" = 20 && V=$(git check-ignore -v patches/ji-harmonizer/generated/bank19-deep-haze.wav) && case "$V" in *'/patches/ji-harmonizer/generated/bank[0-9][0-9]-*.wav'*) true;; *) false;; esac && git check-ignore -q patches/terrain-synth/generated/bank00-torus-sdf.wav && { git check-ignore -q patches/ji-harmonizer/generated/ji-harmonizer.maxpat; test $? -eq 1; } && { git check-ignore -q patches/ji-harmonizer/generated/ji-engine.js; test $? -eq 1; } && { git check-ignore -q patches/ji-harmonizer/generated/jhpresets.json; test $? -eq 1; } && { git check-ignore -q patches/terrain-synth/generated/terrain-synth.maxpat; test $? -eq 1; } && python3 -c "import re,pathlib;d=pathlib.Path('patches/ji-harmonizer/generated');t=(d/'ji-harmonizer.maxpat').read_text();n=sorted(set(re.findall(r'bank\d\d-[a-z0-9-]+\.wav',t)));m=[x for x in n if not (d/x).is_file()];print(len(n),'names',len(m),'missing');assert len(n)==20 and not m" && A=$(git add --dry-run -- patches/ji-harmonizer) && case "$A" in *.wav*) false;; *) true;; esac && P=$(git diff "$C^" "$C" -- patches/ji-harmonizer/generated/ji-harmonizer.maxpat) && test -z "$P" && echo SCOPE-OK; python3 -m pytest -q > "$QD/pytest-after.txt" 2>&1; tail -n 1 "$QD/pytest-before.txt" "$QD/pytest-after.txt"; diff <(tail -n 1 "$QD/pytest-before.txt" | grep -oE '[0-9]+ (passed|failed|skipped|xfailed|xpassed|errors?)' | sort) <(tail -n 1 "$QD/pytest-after.txt" | grep -oE '[0-9]+ (passed|failed|skipped|xfailed|xpassed|errors?)' | sort) && diff <(grep -E '^(FAILED|ERROR) ' "$QD/pytest-before.txt" | sed 's/ - .*//' | sort) <(grep -E '^(FAILED|ERROR) ' "$QD/pytest-after.txt" | sed 's/ - .*//' | sort) && echo SUITE-MATCHES-BASELINE</automated>
  </verify>
  <done>SCOPE-OK and SUITE-MATCHES-BASELINE both printed: 20/20 banks ignored by the ji-harmonizer pattern, the terrain-synth bank path ignored, the four real project files not ignored (exit 1, not 128); the patch names 20 banks and all 20 resolve on disk; the untrack commit left ji-harmonizer.maxpat untouched; `git add --dry-run -- patches/ji-harmonizer` exits 0 naming no WAV; after-suite outcome counts and failing-ID list equal the baseline; MAX load check recorded as a pending user check.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| git index -> working tree | `git rm`/`git commit` can delete or re-add on-disk data; the banks must survive untouched |
| shared index (multi-instance) | other Claude instances may stage files in the same checkout; an index-based commit could sweep them in |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-261112-est-01 | Tampering | untrack commit | medium | mitigate | Commit the index with no pathspec (pathspec form re-adds WAVs from disk, proven in scratch); Task 1 verify asserts `git ls-files -- '*.wav'` empty and the recorded commit has 20 `D` bank entries |
| T-261112-est-02 | Denial of Service (data loss) | patches/ji-harmonizer/generated/bank*.wav | high | mitigate | `git rm --cached` only; main-checkout assert (git-dir == git-common-dir) so no worktree merge deletes the files; sha256 snapshot re-checked after commit |
| T-261112-est-03 | Tampering | .gitignore scope | medium | mitigate | Anchored `bank[0-9][0-9]-*.wav` patterns; Task 2 asserts ji-harmonizer.maxpat, ji-engine.js, jhpresets.json, terrain-synth.maxpat are NOT ignored so auto_commit_patch still sees them |
| T-261112-est-04 | Repudiation | shared git index | low | mitigate | Pre-flight `git diff --cached --quiet`; exact 22-path staged-set assertion before committing; STOP rather than unstage foreign work; commit sha recorded path-scoped, never via relative HEAD |
| T-261112-est-SC | Tampering | npm/pip/cargo installs | low | accept | No package installs in this plan (numpy already present, only used by the documented regen command) |
</threat_model>

<verification>
- (a) `git ls-files -- '*.wav'` empty (baseline: 20 paths)
- (b) `shasum -a 256 -c --quiet .planning/quick/261112-est-untrack-23-mb-wav-banks-from-ji-harmoniz/wav-sha256-before.txt` exits 0; 20 files on disk
- (c) `git status --porcelain -- patches/ji-harmonizer .gitignore` empty (no `??` for banks)
- (d) ji-harmonizer.maxpat names 20 banks, all resolve in generated/; MAX load check = pending user check
- (e) `python3 -m pytest -q` outcome counts and failing IDs identical to the pre-change baseline
- No history rewrite, no push; exactly one new commit of 22 paths
</verification>

<success_criteria>
- The 20 banks are untracked, ignored, on disk and byte-identical.
- context.md documents regeneration, determinism, and the fresh-clone/worktree prerequisite; the two old "committed to git" decisions are marked superseded.
- No regression: patch references intact, auto_commit_patch path unaffected, suite matches baseline.
</success_criteria>

<output>
Create `.planning/quick/261112-est-untrack-23-mb-wav-banks-from-ji-harmoniz/261112-est-SUMMARY.md` when done
</output>
