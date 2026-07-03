# Quick Task 260703-i0t: De-duplicate CLAUDE.md against feedback memory entries - Context

**Gathered:** 2026-07-03
**Status:** Ready for planning

<domain>
## Task Boundary

De-duplicate CLAUDE.md (23.6 KB) against the 30 `feedback_*.md` MEMORY entries at
`/Users/taylorbrook/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/`. The same
rules appear in both surfaces (line~ commas, floor~/RNBO, expr clip, gen~ param
messages, multislider fetch, umenu format, and more). Pick one canonical rule
surface and make the other a pointer.

</domain>

<decisions>
## Implementation Decisions

### Canonical surface
- **CLAUDE.md is canonical.** It is checked into the repo and loaded by every
  subagent (gsd-planner, gsd-executor, max-* skills); memory bodies are private
  and not loaded by default. Any rule an agent must obey lives in CLAUDE.md.

### Memory fate
- Feedback memories whose rule is fully covered by CLAUDE.md are **deleted**,
  with a safety net: archive each deleted file's body into
  `260703-i0t-archived-memories.md` in this task directory (committed to repo)
  before deletion.
- Memories carrying nuance NOT yet in CLAUDE.md: promote the missing nuance
  into the relevant CLAUDE.md section first, then delete the memory.
- Genuinely personal/workflow memories with no agent-facing rule content
  (e.g. `feedback_multiple_choice.md` — presentation preference) **stay in
  memory** untouched.
- `MEMORY.md` index: remove deleted entries' lines; add one line noting that
  MAX object/patching rules are canonical in the project CLAUDE.md.
- `project_*.md` entries are out of scope — untouched.

### Sweep scope
- **All 30 feedback entries**, not just the 6 named overlaps. Classify each as:
  duplicate (delete), partial (promote nuance then delete), or personal (keep).

### CLAUDE.md edits
- **Minimal edits.** Only add promoted rules into their existing sections and
  tighten obviously redundant prose within touched sections. No restructuring.

### Claude's Discretion
- User was unavailable during discussion (60s timeout); all four decisions
  above are Claude's recommended defaults. The archive-before-delete safety
  net was added specifically because the user could not confirm deletion.
- Per-entry classification (duplicate vs partial vs personal) is Claude's
  discretion, guided by: "would a build agent need this rule?" → CLAUDE.md.

### Execution note
- Executor runs WITHOUT worktree isolation: origin/main is stale (3722b27 vs
  local 440d151, see project_worktree_isolation_stale_origin memory) and the
  memory files live outside the repo where worktrees provide no isolation.

</decisions>

<specifics>
## Specific Ideas

- Known full duplicates called out by the user: line~ comma behavior,
  floor~/RNBO, expr clip(), gen~ param messages, multislider fetch,
  umenu items format.
- CLAUDE.md already has sections that absorbed several memories verbatim
  (MSP rules, Gen~ rules, bpatcher #N rules) — those memories are prime
  delete candidates.

</specifics>

<canonical_refs>
## Canonical References

- /Users/taylorbrook/Dev/MAX/CLAUDE.md (target, canonical surface)
- /Users/taylorbrook/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/ (source, 30 feedback_*.md + MEMORY.md index)

</canonical_refs>
