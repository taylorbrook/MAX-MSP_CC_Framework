---
phase: quick-260921-kfd
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - CLAUDE.md
autonomous: true
requirements: [SF-04, SF-06, SF-07]

estimate:
  tokens: 26000
  raw_tokens: 26000
  tasks: 3
  confidence: low        # zero calibration samples for docs-only quick tasks in this repo

must_haves:
  truths:
    - "CLAUDE.md no longer claims the `live.*` extraction gap is open (SF-04)."
    - "CLAUDE.md states that the authoritative object name is the refpage `<c74object name>` attribute, never the filename (SF-07)."
    - "CLAUDE.md states that refpages are authoritative for I/O counts far more than for types and must never overwrite expert overrides (SF-06)."
    - "No other CLAUDE.md rule text changed; `git diff --stat` shows CLAUDE.md only."
  artifacts:
    - CLAUDE.md
  key_links:
    - "The two new paragraphs sit inside `### How to Use the Database`, immediately after the `**The `maxclass` field in the DB is NOT authoritative.**` paragraph and before `## Rules` — so a future extraction/audit run reads them alongside the DB-usage guidance."
    - "Commit stages CLAUDE.md by explicit path; three unrelated working-tree modifications from a concurrent instance stay unstaged and unmodified."
---

<objective>
Docs-only correction of three factual claims in `/Users/taylorbrook/Dev/MAX/CLAUDE.md`, sourced from `.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md` (SF-04, SF-06, SF-07).

Purpose: CLAUDE.md currently carries one stale claim (a closed `live.*` extraction gap presented as open) and is silent on two extraction hazards the g5d review proved are live — filename-vs-`name`-attribute divergence (which manufactured ~795 phantom gaps in that review's own first-draft harness) and placeholder-tainted refpage types (which would silently revert 36 curated outlets on a naive re-extraction).

Output: three surgical edits to CLAUDE.md. No other file, no rule rewording, no behavior change.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@CLAUDE.md
@.planning/quick/260921-g5d-review-this-repo-to-see-if-there-are-any/260921-g5d-REVIEW-FINDINGS.md
</context>

<planner_notes>
**Source-fact discrepancy (flagged per planning instruction).** The task description lists the C74 placeholder tokens as "TEXT_HERE, OUTLET_TYPE, Dummy". SF-06 in the findings file lists **five**: `TEXT_HERE`, `INLET_TYPE`, `OUTLET_TYPE`, `undefined`, `Dummy`. The findings file wins — Task 2 writes all five. Likewise the description says "~54%"; SF-06 says **54.5% (640 of 1175 core refpages)** — use the precise figure.

**Live verification done at planning time.** `/Applications/Max.app/Contents/Resources/C74/docs/refpages/*/live.*.maxref.xml` returns exactly **30** files, confirming SF-04's "30 `live.*` objects documented in the installed bundle". The DB-side count is deliberately NOT cited in the new text: SF-04 says 33, a direct key count across `m4l/` + two package files returns 37 pre-dedupe, and resolving that difference is out of scope for a docs task. The edit asserts only what is verified — that the gap is closed.

**Planner contribution fragments, resolved.** `api-coverage`: no external API/SDK in scope (a markdown edit) — no `COVERAGE.md`. `assumption-delta`: quick task with no ROADMAP phase, so the probe is `phase_unresolved`/skipped — no decision block. `schema-gate`: zero schema-relevant files — skipped silently. `security`: minimal `<threat_model>` below at ASVS L1, `block_on: high`.
</planner_notes>

<tasks>

<task type="auto">
  <name>Task 1: Retire the stale `live.*` extraction-gap claim (SF-04)</name>
  <files>CLAUDE.md</files>
  <read_first>
    CLAUDE.md line 51 — the paragraph led by `**Verify lookup results have non-empty I/O.**` inside `### How to Use the Database`. Read the whole paragraph before editing; it is one long line.
  </read_first>
  <action>
    In that paragraph's final sentence — the one beginning `Before declaring an object unknown, also grep existing` — remove the clause asserting that `live.*` UI objects were only partially captured by the extraction, and keep the surviving advice (grep committed `.maxpat` files; add user-confirmed objects to the appropriate domain file) intact and unreworded.

    Replace the removed clause with a terse parenthetical recording that the gap is closed, per SF-04: all 30 `live.*` objects documented in the installed bundle now resolve, and the 5 carrying one empty side are label/decorative/source shapes rather than gaps. Cite no DB-side object count — see planner_notes.

    Target final sentence (exact text to write):

    `Before declaring an object unknown, also grep existing \`.maxpat\` files under \`patches/\` — user-confirmed objects should be added to the appropriate domain file so future lookups succeed. The `live.*` gap this advice was written for is closed: all 30 `live.*` objects documented in the installed bundle resolve, and the 5 with one empty side are label/decorative/source shapes, not gaps.`

    Use the `Edit` tool with a scoped `old_string` covering only this trailing sentence. Do NOT rewrite the rest of the paragraph, and do NOT touch the `audit_empty_io()` / `audit_half_empty_io()` guidance earlier in it.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX &amp;&amp; test "$(grep -c 'incompletely extracted' CLAUDE.md)" = "0" &amp;&amp; test "$(grep -c 'all 30 `live\.\*` objects documented in the installed bundle resolve' CLAUDE.md)" = "1" &amp;&amp; test "$(grep -c 'db.audit_half_empty_io()' CLAUDE.md)" = "1"</automated>
  </verify>
  <done>The stale claim is gone (0 matches), the replacement sentence is present exactly once, and the surrounding `audit_half_empty_io()` guidance in the same paragraph is untouched (still exactly 1 match).</done>
</task>

<task type="auto">
  <name>Task 2: Add the two extraction/audit rules (SF-07 name attribute, SF-06 placeholders)</name>
  <files>CLAUDE.md</files>
  <read_first>
    CLAUDE.md lines 51-55 — the paragraph led by `**The `maxclass` field in the DB is NOT authoritative.**` (line 53), the blank line after it, and the `## Rules` heading (line 55). The new text goes between them, still inside `### How to Use the Database`.
  </read_first>
  <action>
    Append two new bold-lead paragraphs after the `maxclass` paragraph and before the `## Rules` heading, separated by blank lines, matching the file's existing bold-lead-sentence style. Write them verbatim:

    Paragraph 1 (SF-07):

    `**The authoritative object name is the refpage's \`<c74object name>\` attribute, never the filename.** 808 of 1932 bundled refpages disagree: \`bitand.maxref.xml\` documents \`&\`, \`greaterthan.maxref.xml\` documents \`>\`, \`fswap.maxref.xml\` documents \`swap\`, \`gswitch2.maxref.xml\` documents \`ggate\`. Any extraction or audit keyed off filenames manufactures ~795 phantom "missing from DB" gaps; keyed off the \`name\` attribute, only 9 installed names fail to resolve.`

    Paragraph 2 (SF-06):

    `**Refpages are authoritative for I/O counts far more than for types, and must never overwrite expert overrides.** 640 of 1175 core refpages (54.5%) carry unfilled Cycling '74 template placeholders — \`TEXT_HERE\`, \`INLET_TYPE\`, \`OUTLET_TYPE\`, \`undefined\`, \`Dummy\` — with \`max-ref\` worst at 429/473. \`spectroscope~\`'s maxref declares 1 outlet typed \`OUTLET_TYPE\`; \`in\`'s declares 1 inlet described \`Dummy\`. Both are wrong and both are already corrected in \`overrides.json\`. A re-extraction that trusts refpage types would silently revert 36 curated outlets.`

    Insert only. Do not reword the `maxclass` paragraph, do not add a new heading, and do not move the `## Rules` heading.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX &amp;&amp; test "$(grep -c '808 of 1932 bundled refpages disagree' CLAUDE.md)" = "1" &amp;&amp; test "$(grep -c '640 of 1175 core refpages (54.5%)' CLAUDE.md)" = "1" &amp;&amp; test "$(grep -c 'must never overwrite expert overrides' CLAUDE.md)" = "1" &amp;&amp; for t in TEXT_HERE INLET_TYPE OUTLET_TYPE Dummy; do grep -q "$t" CLAUDE.md || exit 1; done &amp;&amp; test "$(grep -c '^## Rules$' CLAUDE.md)" = "1" &amp;&amp; test "$(grep -c 'invalid attribute maxclass' CLAUDE.md)" = "1"</automated>
  </verify>
  <done>Both paragraphs present exactly once, all five placeholder tokens named, the `## Rules` heading still present exactly once, and the adjacent `maxclass` paragraph still intact (its closing phrase still matches exactly once).</done>
</task>

<task type="auto">
  <name>Task 3: Confirm the diff is docs-only and commit CLAUDE.md alone</name>
  <files>CLAUDE.md</files>
  <precondition>
    The working tree carries three unrelated modifications from a concurrent Claude instance — `patches/.active-project.json`, `patches/FDNVerb/generated/FDNVerb.maxhelp`, `patches/scala-synth/generated/scala-synth.maxpat`. They must remain modified-but-unstaged and byte-unchanged by this task. Assert with `git status --porcelain` before staging; halt and report if any of them is already staged or if the set has changed unexpectedly.
  </precondition>
  <action>
    Confirm the change set is exactly CLAUDE.md with a small line delta, then commit.

    Stage by explicit path only: `git add CLAUDE.md`. Per CLAUDE.md Rule #7, `git add .` / `git add -A` are forbidden during multi-instance work, and `git stash` is forbidden outright.

    Commit message: `docs(quick-260921-kfd): CLAUDE.md SF-04/SF-06/SF-07 corrections`.

    If a protected-branch assertion refuses the commit (HEAD is `main`, which resolves as this repo's default branch and `.planning/config.json` sets no `git.allow_default_branch_commits`), STOP and report the block to the orchestrator with the staged diff intact. Do NOT create or switch branches — a concurrent instance holds uncommitted work in this same tree, and switching underneath it risks that work. This is the same block the g5d review hit; the orchestrator resolves it, not the executor.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX &amp;&amp; SHOW=$(git show --numstat --format= HEAD -- . ':(exclude).planning') &amp;&amp; ST=$(git status --porcelain -- patches/) &amp;&amp; test "$(printf '%s\n' "$SHOW" | grep -cv '^$')" = "1" &amp;&amp; test "$(printf '%s\n' "$SHOW" | grep -c 'CLAUDE\.md$')" = "1" &amp;&amp; test "$(printf '%s\n' "$SHOW" | awk 'NF{print ($1 &lt;= 12 &amp;&amp; $2 &lt;= 6) ? "ok" : "big"}')" = "ok" &amp;&amp; test "$(printf '%s\n' "$ST" | grep -c '^[^ ?]')" = "0"</automated>
  </verify>
  <done>The HEAD commit touches exactly one non-`.planning/` file, CLAUDE.md, with a small delta (at most 12 added / 6 removed lines), and nothing under `patches/` is staged. Halt path: if the protected-branch assertion blocked the commit, the change is left staged, the `patches/` files are untouched, and the block is reported to the orchestrator — this verify is expected to fail in that state and the report is the deliverable.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| executor → git index | The only mutating surface. A wide stage would capture a concurrent instance's in-flight patch edits. |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-kfd-01 | Tampering | `git add` in Task 3 | medium | mitigate | Stage `CLAUDE.md` by explicit path; `git add .`/`-A` and `git stash` forbidden; Task 3 verify asserts nothing under `patches/` is staged. |
| T-kfd-02 | Tampering | CLAUDE.md rule text outside the three target sites | low | mitigate | Scoped `Edit` calls only; Task 1/2 verify re-asserts adjacent anchors (`audit_half_empty_io()`, `invalid attribute maxclass`, `## Rules`) are intact; Task 3 bounds the line delta. |
| T-kfd-03 | Information Disclosure | n/a — no secrets, no network, no external input | low | accept | Docs-only edit to a tracked file; nothing sensitive enters the diff. |
| T-kfd-SC | Tampering | package installs | low | accept | No npm/pip/cargo install in scope — no package-legitimacy gate required. |
</threat_model>

<verification>
1. `grep -c 'incompletely extracted' CLAUDE.md` → `0`
2. `grep -c 'all 30 `live\.\*` objects documented in the installed bundle resolve' CLAUDE.md` → `1`
3. `grep -c '808 of 1932 bundled refpages disagree' CLAUDE.md` → `1`
4. `grep -c '640 of 1175 core refpages (54.5%)' CLAUDE.md` → `1`
5. `git diff --stat HEAD -- . ':(exclude).planning'` → CLAUDE.md only, small delta
6. `git status --porcelain` → the three `patches/` files still show as unstaged modifications
</verification>

<success_criteria>
- SF-04, SF-06, SF-07 each corrected/recorded in CLAUDE.md, terse, in the file's existing bold-lead style.
- Zero other rules reworded, moved, or removed.
- CLAUDE.md is the only non-`.planning/` file in the commit; the concurrent instance's work is untouched.
</success_criteria>

<output>
Create `.planning/quick/260921-kfd-docs-only-update-to-claude-md-per-sf-04-/260921-kfd-SUMMARY.md` when done.
</output>
