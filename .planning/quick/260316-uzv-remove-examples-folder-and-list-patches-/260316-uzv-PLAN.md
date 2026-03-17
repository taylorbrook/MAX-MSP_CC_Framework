---
phase: quick
plan: 260316-uzv
type: execute
wave: 1
depends_on: []
files_modified:
  - README.md
  - PATCHES.md
autonomous: true
requirements: [quick-task]

must_haves:
  truths:
    - "examples/ directory no longer exists in git"
    - "PATCHES.md no longer references examples/"
    - "README.md lists patches/ directory contents instead of examples/"
    - "README.md Project Structure section no longer shows examples/"
  artifacts:
    - path: "README.md"
      provides: "Updated documentation with patches listing"
      contains: "patches/"
    - path: "PATCHES.md"
      provides: "Updated catalog pointing to patches/"
      contains: "patches/"
  key_links:
    - from: "README.md"
      to: "patches/"
      via: "directory listing in Example Projects section"
      pattern: "patches/"
---

<objective>
Remove the `examples/` directory (which duplicates content already in `patches/`) and update README.md and PATCHES.md to reference `patches/` instead.

Purpose: Eliminate content duplication between examples/ and patches/ directories; make patches/ the single source of truth for all example and user-created projects.
Output: Updated README.md and PATCHES.md; examples/ removed from git.
</objective>

<execution_context>
@/Users/taylorbrook/.claude/get-shit-done/workflows/execute-plan.md
@/Users/taylorbrook/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@README.md
@PATCHES.md

Current state:
- `examples/` has 5 projects (FDNVerb, granularsynthtest, performancepatchtest, rhythmic-sampler, scala-synth) tracked in git
- `patches/` has 11 projects (the original 5 plus kicksynth, minitaur, mixer, stutter, TSC, wormhole) with generated .maxpat files
- Both README.md and PATCHES.md currently reference `examples/` paths
- The examples/ content is a stale duplicate of what already lives in patches/
</context>

<tasks>

<task type="auto">
  <name>Task 1: Remove examples/ from git and delete PATCHES.md</name>
  <files>examples/, PATCHES.md</files>
  <action>
1. Remove the entire `examples/` directory from git tracking AND from disk:
   ```
   git rm -r examples/
   ```
2. Remove PATCHES.md from git tracking AND from disk:
   ```
   git rm PATCHES.md
   ```
   PATCHES.md is no longer needed -- the README will contain the project listing directly.
  </action>
  <verify>
    <automated>test ! -d examples/ && test ! -f PATCHES.md && echo "PASS" || echo "FAIL"</automated>
  </verify>
  <done>examples/ directory and PATCHES.md are removed from disk and staged for git deletion</done>
</task>

<task type="auto">
  <name>Task 2: Update README.md to list patches/ contents</name>
  <files>README.md</files>
  <action>
Update README.md with these specific changes:

1. **"Example Projects" section** (lines ~111-123): Replace the current table that references `examples/` with a new section titled "Patches" that lists ALL projects in `patches/`. Use a simple table format:

```markdown
## Patches

The `patches/` directory contains example and user-created projects:

| Project | Description | Files |
|---------|-------------|-------|
| **FDNVerb** | Feedback delay network reverb with 8 delay lines, Hadamard matrix, decay/diffusion/damping/freeze controls | `.maxpat`, `.gendsp` |
| **granularsynthtest** | Granular synthesizer with Gen~ DSP engine and MC multichannel output | `.maxpat`, `.gendsp` |
| **kicksynth** | Kick drum synthesizer | `.maxpat` |
| **minitaur** | Moog Minitaur editor/controller | `.maxpat` |
| **mixer** | Mixing console with channel strips, buses, and master output | `.maxpat` |
| **performancepatchtest** | Live performance cue system with multiband compression, feedback delay, distortion, and soundfile playback | `.maxpat`, `.gendsp` |
| **rhythmic-sampler** | 8-slot sampler with slice-based sequencing, time-stretching, and per-slot FX | `.maxpat`, `.js` |
| **scala-synth** | 16-voice polyphonic additive synthesizer with Scala (.scl) file support | `.maxpat`, `.js` |
| **stutter** | Stutter/glitch effect processor | `.maxpat` |
| **TSC** | Temporal Semiotic Composition system | `.maxpat` |
| **wormhole** | Audio effect processor | `.maxpat` |
```

For the newer patches (kicksynth, minitaur, mixer, stutter, TSC, wormhole), read their `context.md` files to get accurate one-line descriptions. If a context.md has a clear description, use it. If not, derive from the patch name.

2. **Remove the line** "Each project contains a `context.md`..." paragraph that follows the old examples table (line ~123).

3. **Remove the PATCHES.md link**: The old text says "(see [PATCHES.md](PATCHES.md) for the full catalog)" on line 113 -- remove this parenthetical.

4. **"Project Structure" section** (lines ~139-158): Remove the `examples/` line from the directory tree:
   - Delete: `├── examples/               # Example patches with catalog (PATCHES.md)`

5. **Keep everything else unchanged** -- do not modify any other section of README.md.
  </action>
  <verify>
    <automated>grep -c "examples/" README.md | xargs -I{} test {} -eq 0 && grep -c "patches/" README.md | xargs -I{} test {} -gt 0 && echo "PASS" || echo "FAIL"</automated>
  </verify>
  <done>README.md no longer references examples/ or PATCHES.md; the Patches section lists all 11 projects from patches/ with accurate descriptions</done>
</task>

</tasks>

<verification>
- `examples/` directory does not exist on disk
- `PATCHES.md` does not exist on disk
- `git status` shows examples/ and PATCHES.md staged for deletion
- `grep -r "examples/" README.md` returns no results
- README.md contains a "Patches" section listing projects from `patches/`
</verification>

<success_criteria>
- examples/ fully removed from git and disk
- PATCHES.md fully removed from git and disk
- README.md Patches section lists all 11 projects in patches/ with descriptions
- README.md Project Structure tree no longer shows examples/
- No remaining references to examples/ or PATCHES.md in README.md
</success_criteria>

<output>
After completion, create `.planning/quick/260316-uzv-remove-examples-folder-and-list-patches-/260316-uzv-SUMMARY.md`
</output>
