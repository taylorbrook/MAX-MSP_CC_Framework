---
id: 260417-8p0
slug: populate-pkg-object-metadata
status: complete
date: 2026-04-17
---

# Populate package object metadata — summary

Populated `messages`, `attributes`, `arguments` for 9 package objects from authoritative `.maxref.xml` sources. Set `verified: true` on each. Recorded I/O count discrepancies as overrides with audit notes.

## Populated (9/9 resolvable, all verified)

| Object | Source | messages | attributes | arguments |
|---|---|---:|---:|---:|
| dada.bounce     | local dada/docs/refpages           |  27 |  48 | 0 |
| dada.bodies     | local dada/docs/refpages           |  27 |  47 | 0 |
| dada.base       | local dada/docs/refpages           |  16 |   7 | 2 |
| bach.roll       | local bach/docs/refpages           | 131 | 201 | 1 |
| bach.score      | local bach/docs/refpages           | 151 | 277 | 1 |
| o.pack          | CNMAT/CNMAT-odot (master)          |  10 |   0 | 1 |
| o.route         | CNMAT/CNMAT-odot (master)          |   6 |   0 | 1 |
| o.prepend       | CNMAT/CNMAT-odot (master)          |   6 |   0 | 1 |
| o.expr.codebox  | CNMAT/CNMAT-odot (master)          |  11 |   0 | 0 |

Odot refpages were available in the public CNMAT-odot repo (not in `_pkg-source/`), so all 4 odot objects were verified from authoritative XML rather than skipped.

Meta-methods documented only with keyboard/mouse/drag conventions (e.g. `(drag)`, `(mouse)`, `(keyboard)`, `(tools)`) were excluded from `messages` — they are not dispatchable messages.

## I/O discrepancies recorded in overrides.json

Eight of nine objects had inlet/outlet counts in the DB that disagreed with the refpage. Overrides restore ref-accurate counts + digests.

| Object | DB (before) | Refpage | Override applied |
|---|---|---|---|
| dada.bounce    | 1 in / 2 out | 1 in / 5 out | ✓ |
| dada.bodies    | 1 in / 2 out | 1 in / 5 out | ✓ |
| dada.base      | 1 in / 1 out | 1 in / 2 out | ✓ |
| bach.roll      | 1 in / 4 out | 6 in / 8 out | ✓ |
| bach.score     | 1 in / 4 out | 7 in / 9 out | ✓ |
| o.pack         | 1 in / 1 out | 2 in / 1 out | ✓ |
| o.route        | 1 in / 3 out | 1 in / 1 out | ✓ (base topology — `o.route` is variable_io per argument) |
| o.prepend      | 1 in / 1 out | 1 in / 1 out | — (no discrepancy) |
| o.expr.codebox | 1 in / 1 out | 1 in / 2 out | ✓ |

All overrides inserted under `objects.<name>` in `.claude/max-objects/overrides.json`, with `_audit.source = "refpage_ioverify_260417"` and the concrete ref source URL/path.

## Validation

```
dada.bounce    inlets=1 outlets=5  msgs=27  attrs=48  args=0  verified=True
dada.bodies    inlets=1 outlets=5  msgs=27  attrs=47  args=0  verified=True
dada.base      inlets=1 outlets=2  msgs=16  attrs= 7  args=2  verified=True
bach.roll      inlets=6 outlets=8  msgs=131 attrs=201 args=1  verified=True
bach.score     inlets=7 outlets=9  msgs=151 attrs=277 args=1  verified=True
o.pack         inlets=2 outlets=1  msgs=10  attrs= 0  args=1  verified=True
o.route        inlets=1 outlets=1  msgs= 6  attrs= 0  args=1  verified=True
o.prepend      inlets=1 outlets=1  msgs= 6  attrs= 0  args=1  verified=True
o.expr.codebox inlets=1 outlets=2  msgs=11  attrs= 0  args=0  verified=True
```

All 9 targets: messages > 0 and verified = true.

## Scope adherence

- Touched exactly 4 files: the 3 package `objects.json` files + `overrides.json`.
- No generator/extractor script written to disk (Rule #5) — parsing done inline via `python3 - <<EOF`.
- MSP/MAX/Gen/Jitter domain files untouched.
- Unrelated working-tree modifications (`.DS_Store`, `patches/intelligent-corpus-remixer`, `patches/rhythmic-corpus-chopper`, `patches/physics-composition/`, `.claude/worktrees/`) left untouched and not staged.
