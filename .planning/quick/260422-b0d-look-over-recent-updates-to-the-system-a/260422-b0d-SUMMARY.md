---
phase: quick-260422-b0d
plan: 01
subsystem: docs
tags: [readme, docs, stats-refresh, patches-table]
requires: []
provides:
  - Accurate README stats (3,434 objects, 29 packages, 1,589 tests)
  - Complete Patches table listing all 18 `patches/*/` projects
affects:
  - README.md
tech_stack:
  added: []
  patterns: [surgical-edit-replacement]
key_files:
  created: []
  modified:
    - README.md
decisions:
  - Preserve v4.0 milestone row 2,450-object count as historical snapshot (not drift)
metrics:
  duration: ~5 minutes
  completed: 2026-04-22
  tasks: 2
  files_modified: 1
  commits: 2
---

# Quick Task 260422-b0d: README Stats & Patches Table Refresh Summary

Surgical README.md refresh: updated stale object/package/test counts to match current repo state (3,434 / 29 / 1,589) and added 4 new patch projects (bassoon-model, intelligent-corpus-remixer, physics-composition, rhythmic-corpus-chopper) to the Patches table. No prose rewrites; milestone table preserved.

## Tasks Completed

### Task 1: Update stale counts (objects, packages, tests)

**Commit:** `7eee727`

Applied 5 surgical Edits to README.md:

- Line 13 (Features bullet): `2,450-object … 20 packages` → `3,434-object … 29 packages`
- Line 69 (Quick Start step 2): `2,450-object database` → `3,434-object database`
- Line 168 (How It Works → Object Database): `2,450 MAX objects … 20 packages` → `3,434 MAX objects … 29 packages`
- Line 181 (Project Structure comment): `2,450 objects across 8 domains + 20 packages` → `3,434 objects across 8 domains + 29 packages`
- Line 185 (Project Structure tests comment): `1,545 tests` → `1,589 tests`

### Task 2: Add 4 new patch projects to Patches table

**Commit:** `e12b549`

Added 4 rows to the Patches table in alphabetical order:

- `bassoon-model` — Physical model of a bassoon with conical waveguide and reed nonlinearity (before FDNVerb)
- `intelligent-corpus-remixer` — Corpus-based concatenative synthesis using FluCoMa + EARS + Odot (between granularsynthtest and kicksynth)
- `physics-composition` — Audiovisual instrument using dada.bounce + bach.roll (between performancepatchtest and rhythmic-sampler)
- `rhythmic-corpus-chopper` — Sample-accurate beat slicer using FluCoMa onset detection (before rhythmic-sampler)

Patches table now lists 18 projects, matching the 18 directories in `patches/`.

## Verification

Run-time numbers confirmed against plan expectations before editing:

| Metric | Plan | Actual | Match |
|--------|------|--------|-------|
| Objects | 3,434 | 3,434 | yes |
| Packages | 29 | 29 | yes |
| Tests | 1,589 | 1,589 | yes |
| Patches on disk | 18 | 18 | yes |

Final grep counts:

```
grep -c "3,434" README.md          → 4   (Features, Quick Start, How-It-Works, Project Structure)
grep -c "2,450" README.md          → 1   (v4.0 milestone row — historical, preserved)
grep -c "29 packages" README.md    → 3
grep -c "20 packages" README.md    → 0
grep -c "1,589 tests" README.md    → 1
grep -c "1,545 tests" README.md    → 0
awk '/^## Patches/,/^## How It Works/' README.md | grep -c "^| \*\*"  → 18
ls -d patches/*/ | wc -l           → 18
```

## Deviations from Plan

None — plan executed exactly as written. No drift between investigation and run-time numbers.

## Scope Preservation

- Milestone table row for v4.0 Package Integration (line 233) is unchanged; still reads `Package-aware DB (2,450 objects)` as a historical snapshot of what shipped at v4.0.
- GSD command table, Features bullet list, How It Works prose, Project Structure layout, Commands table, and all other sections untouched.
- No new feature bullets, no prose rewrites, no reformatting of existing table rows.

## Self-Check: PASSED

- FOUND: README.md (modified)
- FOUND commit: 7eee727 (Task 1: refresh stale counts)
- FOUND commit: e12b549 (Task 2: add 4 patch projects)
