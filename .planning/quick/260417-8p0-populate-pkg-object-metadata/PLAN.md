---
id: 260417-8p0
slug: populate-pkg-object-metadata
status: in-progress
date: 2026-04-17
---

# Populate package object metadata (dada / bach / odot)

Source of truth: `.claude/max-objects/_pkg-source/{dada,bach}/docs/refpages/*/{name}.maxref.xml`.
Odot has no local refpage — mark verified:false with documented reason.

## Targets

- `dada.bounce`, `dada.bodies`, `dada.base` → `.claude/max-objects/packages/Dada/objects.json`
- `bach.roll`, `bach.score` → `.claude/max-objects/packages/Bach/objects.json`
- `o.pack`, `o.route`, `o.prepend`, `o.expr.codebox` → `.claude/max-objects/packages/Odot/objects.json`

## Steps

1. Parse each `.maxref.xml`: methodlist → messages, attributelist → attributes, objarglist → arguments, inletlist/outletlist → I/O refinement.
2. Merge into per-package domain file. Preserve all unrelated fields. Set `verified: true` only when parse succeeded.
3. I/O discrepancies recorded in `.claude/max-objects/overrides.json` under `objects.{name}` with `_audit` note (not by editing the extracted domain file).
4. Run validation (`db_lookup` smoke check).
5. Single atomic commit.

## Guardrails

- No generator/extractor script (CLAUDE.md Rule #5) — inline parsing only.
- Do not touch MSP/MAX/Gen/Jitter domain files or unrelated overrides.
- No fabrication — Odot objects get `verified: false` with audit note if refs cannot be obtained.
