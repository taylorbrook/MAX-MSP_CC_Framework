---
phase: quick
plan: 260411-epc
type: execute
wave: 1
depends_on: []
files_modified:
  - README.md
autonomous: true
must_haves:
  truths:
    - "README Patches table lists all 14 projects in patches/ directory"
    - "gong-model and timestretch entries are present with accurate descriptions"
    - "Table remains alphabetically sorted"
  artifacts:
    - path: "README.md"
      provides: "Complete patches table"
      contains: "gong-model"
---

<objective>
Add the 2 missing patches (gong-model, timestretch) to the README.md Patches table.

Purpose: README should accurately reflect all 14 projects in the patches/ directory.
Output: Updated README.md with complete Patches table.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@README.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Add gong-model and timestretch to README Patches table</name>
  <files>README.md</files>
  <action>
In README.md, find the Patches table (starts around line 144). Add these two entries in alphabetical order:

1. **gong-model** — insert between gen-eq and granularsynthtest:
   `| **gong-model** | Physical model of a gong using gen~ modal synthesis with pitch/timbre control, MIDI and audio excitation, drift engine | `.maxpat`, `.gendsp`, `.js` |`

2. **timestretch** — insert between tape-wobble and wormhole:
   `| **timestretch** | Granular time-stretching instrument in gen~ with real-time and offline modes, WSOLA-enhanced overlap-add engine | `.maxpat` |`

After adding, verify the table has exactly 14 rows (excluding header/separator).
  </action>
  <verify>
    <automated>grep -c '^\| \*\*' README.md | grep -q '^14$' && echo "PASS: 14 patch entries" || echo "FAIL: wrong count"</automated>
  </verify>
  <done>README Patches table contains all 14 projects alphabetically sorted with accurate descriptions and file types.</done>
</task>

</tasks>

<verification>
- Patches table has 14 entries (one per project in patches/ directory)
- gong-model entry accurately describes modal synthesis, gen~, MIDI/audio excitation
- timestretch entry accurately describes granular time-stretching, real-time/offline, WSOLA
- Table remains alphabetically sorted
- No other docs (TECHNICAL.md) need updating (confirmed -- no patches table there)
</verification>

<success_criteria>
README.md Patches table lists all 14 projects with accurate descriptions and correct file types.
</success_criteria>

<output>
After completion, create `.planning/quick/260411-epc-update-the-readme-and-any-other-docs-to-/260411-epc-SUMMARY.md`
</output>
