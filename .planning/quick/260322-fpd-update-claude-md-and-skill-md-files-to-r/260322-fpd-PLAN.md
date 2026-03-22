---
phase: quick-260322-fpd
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - CLAUDE.md
  - .claude/skills/max-dsp-agent/SKILL.md
  - .claude/skills/max-patch-agent/SKILL.md
  - .claude/skills/max-rnbo-agent/SKILL.md
  - .claude/skills/max-ui-agent/SKILL.md
autonomous: true
requirements: [quick-fpd]

must_haves:
  truths:
    - "CLAUDE.md recommends ObjectDatabase.lookup() as the primary object lookup method"
    - "Agent SKILL.md files use ObjectDatabase instead of raw JSON file reads for object lookups"
    - "Domain-specific context loading sections no longer instruct agents to read individual objects.json files"
  artifacts:
    - path: "CLAUDE.md"
      provides: "Updated How to Use the Database section"
      contains: "ObjectDatabase"
    - path: ".claude/skills/max-dsp-agent/SKILL.md"
      provides: "Updated domain context loading"
      contains: "ObjectDatabase"
    - path: ".claude/skills/max-patch-agent/SKILL.md"
      provides: "Updated domain context loading"
      contains: "ObjectDatabase"
    - path: ".claude/skills/max-ui-agent/SKILL.md"
      provides: "Updated domain context loading"
      contains: "ObjectDatabase"
  key_links:
    - from: "CLAUDE.md"
      to: "src/maxpat/db_lookup.py"
      via: "ObjectDatabase.lookup() reference"
      pattern: "ObjectDatabase"
---

<objective>
Update CLAUDE.md and agent SKILL.md files to recommend `ObjectDatabase.lookup()` from `src.maxpat.db_lookup` instead of the current sequential domain file search pattern.

Purpose: The `ObjectDatabase` class already loads all 8 domain JSON files into a single dict and handles alias resolution, overrides, PD blocklist, and variable I/O computation. But CLAUDE.md tells Claude to manually search domain files one by one ("check max/objects.json first, then msp/, jitter/, mc/, etc."), and SKILL.md files instruct agents to read specific domain JSON files. This creates unnecessary context overhead and artificial domain boundaries. The instructions should match what the code already does.

Output: Updated CLAUDE.md and 4 SKILL.md files with ObjectDatabase-first lookup instructions.
</objective>

<execution_context>
@~/.claude/get-shit-done/workflows/execute-plan.md
@~/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@CLAUDE.md
@src/maxpat/db_lookup.py
@.claude/skills/max-dsp-agent/SKILL.md
@.claude/skills/max-patch-agent/SKILL.md
@.claude/skills/max-rnbo-agent/SKILL.md
@.claude/skills/max-ui-agent/SKILL.md
</context>

<tasks>

<task type="auto">
  <name>Task 1: Update CLAUDE.md "How to Use the Database" section</name>
  <files>CLAUDE.md</files>
  <action>
Replace the "### How to Use the Database" section (lines 32-43) with ObjectDatabase-first instructions. The new section should:

1. Lead with `ObjectDatabase` from `src.maxpat.db_lookup` as the primary lookup method:
   - `from src.maxpat.db_lookup import ObjectDatabase`
   - `db = ObjectDatabase()`
   - `obj = db.lookup("cycle~")` -- returns object dict or None, auto-resolves aliases
   - `db.exists("t")` -- checks existence (resolves alias to "trigger")
   - `db.is_pd_object("osc~")` -- checks PD blocklist
   - `db.get_pd_equivalent("osc~")` -- returns "cycle~"
   - `db.compute_io_counts("trigger", ["b", "i", "f"])` -- returns (1, 3)
   - `db.get_outlet_types("cycle~")` -- returns ["signal"]

2. Keep a secondary note: "The raw JSON files at `.claude/max-objects/{domain}/objects.json` are still available for browsing all objects in a domain or bulk operations, but for individual lookups always use ObjectDatabase."

3. Remove the sequential search pattern ("check max/objects.json first, then msp/, jitter/, mc/") -- ObjectDatabase searches all domains automatically.

4. Keep the supplementary files subsection (aliases.json, overrides.json, etc.) as-is -- those are still useful context for understanding the data structure.

Do NOT change any other section of CLAUDE.md.
  </action>
  <verify>
    <automated>grep -c "ObjectDatabase" CLAUDE.md | test $(cat) -ge 2 && grep -c "sequential" CLAUDE.md | test $(cat) -eq 0 && echo "PASS" || echo "FAIL"</automated>
  </verify>
  <done>CLAUDE.md "How to Use the Database" section recommends ObjectDatabase.lookup() as primary method. Sequential domain file search pattern removed.</done>
</task>

<task type="auto">
  <name>Task 2: Update agent SKILL.md domain context loading sections</name>
  <files>.claude/skills/max-dsp-agent/SKILL.md, .claude/skills/max-patch-agent/SKILL.md, .claude/skills/max-rnbo-agent/SKILL.md, .claude/skills/max-ui-agent/SKILL.md</files>
  <action>
Update the "## Domain Context Loading" section in each SKILL.md to use ObjectDatabase instead of raw JSON file reads:

**max-dsp-agent/SKILL.md** (lines 19-29):
Replace the numbered list of "Read .claude/max-objects/msp/objects.json" etc. with:
```
Before any generation:
1. Read `CLAUDE.md` at project root -- follow MSP and Gen~ domain-specific rules
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, and checks PD blocklist automatically. No need to read individual domain JSON files.
3. Check `.claude/max-objects/pd-blocklist.json` if you need to browse PD equivalents in bulk

**Domain focus:** MSP (signal processing) and Gen~ (DSP operators). Other domains are handled by their respective agents.
```
Remove the "Do NOT load" line -- ObjectDatabase loads everything, domain boundaries are a focus concern, not a loading concern.

**max-patch-agent/SKILL.md** (lines 19-28):
Replace similarly:
```
Before any generation:
1. Read `CLAUDE.md` at project root -- follow all 5 rules and patch style guidelines
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for all object lookups -- it loads all domains, resolves aliases, checks PD blocklist, and provides relationship data automatically
3. Read `.claude/max-objects/relationships.json` for common object pairings (if needed for design decisions)

**Domain focus:** Max control/data/UI objects. Signal processing and RNBO are handled by their respective agents.
```

**max-rnbo-agent/SKILL.md** (lines 28-33):
Replace the "When invoked" list:
```
When invoked:
1. Read `CLAUDE.md` RNBO section for export rules and constraints
2. Use `RNBODatabase()` from `src.maxpat.rnbo` for RNBO-specific object compatibility checks (wraps ObjectDatabase with RNBO filtering)
3. Use `ObjectDatabase` from `src.maxpat.db_lookup` for general object lookups when checking companion MSP/Gen objects
```
Remove the lines about reading specific domain JSON files.

**max-ui-agent/SKILL.md** (lines 19-25):
Replace:
```
Before any generation:
1. Read `CLAUDE.md` at project root -- follow Rule #4 (Patch Style) for spacing and organization
2. Use `ObjectDatabase` from `src.maxpat.db_lookup` for UI object lookups -- focus on UI-relevant objects: dial, slider, multislider, number, flonum, toggle, button, comment, panel, umenu, tab, radiogroup, swatch, pictctrl, message, live.dial, live.slider, live.numbox, live.toggle, live.menu, live.text, live.tab

**Domain focus:** UI objects and presentation layout. Signal processing is handled by the DSP agent.
```

Do NOT change any other sections in these files. Only the "Domain Context Loading" sections.
  </action>
  <verify>
    <automated>for f in .claude/skills/max-dsp-agent/SKILL.md .claude/skills/max-patch-agent/SKILL.md .claude/skills/max-rnbo-agent/SKILL.md .claude/skills/max-ui-agent/SKILL.md; do grep -q "ObjectDatabase\|RNBODatabase" "$f" && echo "OK: $f" || echo "FAIL: $f"; done</automated>
  </verify>
  <done>All 4 agent SKILL.md files reference ObjectDatabase (or RNBODatabase) instead of raw JSON file reads. No "Read .claude/max-objects/{domain}/objects.json" instructions remain in the domain context loading sections.</done>
</task>

</tasks>

<verification>
- CLAUDE.md "How to Use the Database" section mentions ObjectDatabase as primary method
- No remaining "check max/objects.json first" sequential search instructions
- All 4 agent SKILL.md files updated with ObjectDatabase references
- No other sections of any file were changed
- grep -r "Read.*objects\.json" .claude/skills/*/SKILL.md returns no matches in domain context loading sections
</verification>

<success_criteria>
- ObjectDatabase.lookup() is the documented primary object lookup method in CLAUDE.md
- Agent SKILL.md files no longer instruct loading individual domain JSON files for object lookups
- All existing non-context-loading content preserved unchanged
</success_criteria>

<output>
After completion, create `.planning/quick/260322-fpd-update-claude-md-and-skill-md-files-to-r/260322-fpd-SUMMARY.md`
</output>
