# Phase 31: Layout & UX Builders - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-30
**Phase:** 31-layout-ux-builders
**Areas discussed:** Builder home & layering, Overlay readout API, Labeled param bank API, Companion-pair semantics

---

## Builder home & layering

### Q1: Where should the 4 builders live in the codebase?

| Option | Description | Selected |
|--------|-------------|----------|
| All on Patcher class | add_overlay_readout, add_labeled_param_bank, add_m4l_gen_synth, plus a companion-pair hook all become Patcher methods in patcher.py. Single discoverable API. Cost: patcher.py grows ~300-500 LOC against the FINDINGS goal of shrinking it. | ✓ |
| New src/maxpat/builders/ module | Separate files: builders/overlay.py, builders/param_bank.py, builders/m4l_synth.py, builders/companion.py. Patcher exposes thin delegating methods. Keeps patcher.py size in check; aligns with PATCHER-SPLIT future requirement. | |
| Split: Patcher methods + m4l_polish.py | Overlay readout + param bank + companion logic on Patcher (general layout primitives). m4l_gen_synth goes in m4l_polish.py next to existing M4L scaffolding. Smallest delta, follows existing seam. | |
| Standalone functions in src/maxpat/ | layout_builders.py module with overlay_readout(p, target, ...), labeled_param_bank(p, ...) etc. that take a Patcher as first arg. Patcher stays clean. | |

**User's choice:** All on Patcher class
**Notes:** PATCHER-SPLIT is explicitly future-bucket. Single discoverable API matters more than LOC at this phase. m4l_gen_synth body can still delegate to a helper in m4l_polish.py to keep patcher.py shorter.

### Q2: How should LAYOUT-05 wire the new builders to max-patch-agent and max-ui-agent?

| Option | Description | Selected |
|--------|-------------|----------|
| Update each agent SKILL.md | Add a 'Builder API' section to .claude/skills/max-patch-agent/SKILL.md and .claude/skills/max-ui-agent/SKILL.md with usage examples + when to call each. | ✓ |
| CLAUDE.md only | Document builders in CLAUDE.md under 'Layout/UX Builders' section. Less duplication but less discoverable per-agent. | |
| Both CLAUDE.md + agent SKILL.md | CLAUDE.md gets canonical reference; each agent SKILL.md gets a one-line pointer + 'when to use' guidance. | |
| Auto-generated reference doc | Build script extracts builder docstrings into .planning/codebase/builders.md. Heavier infra. | |

**User's choice:** Update each agent SKILL.md
**Notes:** Concrete, agent-readable, matches existing convention. CLAUDE.md gets a brief pointer per the locked decision.

---

## Overlay readout API

### Q1: What format= should add_overlay_readout accept?

| Option | Description | Selected |
|--------|-------------|----------|
| Printf-style string | format='%.2f Hz' baked into a flonum's `format` attribute or comment text via prepend chain. | ✓ |
| Lambda / callable | format=lambda v: f'{v:.2f} Hz'. Only works at Python build-time, awkward semantics. | |
| Structured kwargs | decimals=2, unit='Hz', prefix='cutoff: '. More verbose but discoverable. | |
| Plain decimals int + unit str | decimals=2, unit='Hz' kwargs only. Halfway between printf and structured. | |

**User's choice:** Printf-style string

### Q2: What readout types should add_overlay_readout produce?

| Option | Description | Selected |
|--------|-------------|----------|
| flonum (numeric) by default; type= override | type='flonum'/'comment'/'number'. Single API covers all three. | ✓ |
| Three separate builders | add_overlay_flonum, add_overlay_comment, add_overlay_number. 3x API surface. | |
| flonum-only | Strict to LAYOUT-01's literal phrasing. Smallest API. | |

**User's choice:** flonum (numeric) by default; type= override

### Q3: How should the readout position relative to the target?

| Option | Description | Selected |
|--------|-------------|----------|
| Auto-overlap target rect | Default copies target.patching_rect; offset_x/offset_y kwargs for fine-tuning. | ✓ |
| Explicit x, y, w, h required | Caller passes patching_rect; builder only handles z-order + ignoreclick. | |
| Anchor mode: 'overlay' \| 'below' \| 'right' | Multiple anchor positions. Ambiguates 'overlay' vs LAYOUT-01 intent. | |

**User's choice:** Auto-overlap target rect

### Q4: Should ignoreclick=1 be unconditional, or opt-out?

| Option | Description | Selected |
|--------|-------------|----------|
| Default on, editable=False kwarg flips it | ignoreclick=1 by default; editable=True opts out. | ✓ |
| Always ignoreclick=1; no opt-out | Strict to prose rule. Loses M4L editable-readout case. | |
| ignoreclick required as kwarg, no default | Force caller to pass every call. Defeats the codify-the-recipe purpose. | |

**User's choice:** Default on, editable=False kwarg flips it

---

## Labeled param bank API

### Q1: How should params be specified to add_labeled_param_bank?

| Option | Description | Selected |
|--------|-------------|----------|
| List of (name, min, max) tuples | params=[('cutoff', 0., 1.), ('reso', 0., 1.), ...]. Shortest call site. | ✓ |
| List of dicts | params=[{'name': 'cutoff', 'min': 0., 'max': 1.}, ...]. Most extensible, verbose. | |
| List of strings (uniform 0..1 range) | params=['cutoff', 'reso', ...]. Default range [0., 1.]; sacrifices per-bar ranges. | |
| Param dataclass | params=[Param('cutoff', 0., 1.), ...]. Typed, IDE-discoverable, heaviest setup. | |

**User's choice:** List of (name, min, max) tuples

### Q2: Where do labels go relative to the multislider?

| Option | Description | Selected |
|--------|-------------|----------|
| Left of bars | Comment labels left-aligned, vertically aligned with each bar at y_label_i = ms.y + i*24. | ✓ |
| Above each bar | Doesn't match the existing recipe; uses more vertical space. | |
| Caller chooses (label_side= kwarg) | label_side='left' (default) or 'right'. More flexible. | |

**User's choice:** Left of bars
**Notes:** Reserve `label_side='right'` as a future kwarg if a real case appears (deferred).

### Q3: Should the builder also generate the prepend/route chain?

| Option | Description | Selected |
|--------|-------------|----------|
| Builder returns multislider + labels only | Caller wires `fetch $1` themselves and consumes outlet 1. Keeps builder focused on layout. | ✓ |
| Builder also creates a named subpatcher with prepend/route chain | Returns a subpatcher with fetch + prepend + route chain pre-wired. Couples layout to routing. | |
| Builder accepts subpatcher_name= kwarg | Both modes; encapsulates when subpatcher_name set. | |

**User's choice:** Builder returns multislider + labels only

### Q4: What attributes should be locked in vs configurable?

| Option | Description | Selected |
|--------|-------------|----------|
| Lock recipe attrs, accept extra_attrs= overrides | Bake size/height/orientation/contdata/setstyle/setminmax; deep-merge extras. | ✓ |
| Strict recipe — no overrides | Hard-code; caller mutates extra_attrs after. Loses ergonomics. | |
| Every recipe attr promoted to a kwarg | size=, height=, etc. Defeats LAYOUT-02's intent. | |

**User's choice:** Lock recipe attrs, accept extra_attrs= overrides

---

## Companion-pair semantics

### Q1: When should signal_role-driven companion placement fire?

| Option | Description | Selected |
|--------|-------------|----------|
| Lazy: at apply_layout time | apply_layout reads signal_role; positions existing companions by role. No box auto-creation. | ✓ |
| Eager: explicit add_with_companion() builder | p.add_with_companion('gain~') creates gain~ + meter~. Less 'auto-place' than LAYOUT-03 implies. | |
| Eager auto-create at add_box() time | Patcher.add_box auto-creates canonical companions. Most magical; high surprise risk. | |
| Both lazy layout + explicit add_with_companion | Two complementary surfaces. | |

**User's choice:** Lazy: at apply_layout time

### Q2: Where should the role→companion mapping live?

| Option | Description | Selected |
|--------|-------------|----------|
| Module-level constant in layout.py | _ROLE_COMPANION_MAP next to existing _COMPANION_NAMES. | ✓ |
| Per-object in overrides.json | Per-object companion_hint field. Doesn't scale; breaches Phase 28 schema cap. | |
| Hybrid: role default + per-object override | Module map default + overrides.json per-object override. | |
| Builder kwargs only — no auto-mapping | Caller passes companion= explicitly. Loses LAYOUT-03 intent. | |

**User's choice:** Module-level constant in layout.py

### Q3: How should the new logic interact with existing _COMPANION_NAMES heuristic?

| Option | Description | Selected |
|--------|-------------|----------|
| Augment: keep _COMPANION_NAMES, add signal_role lookup as primary | Role first; fall through to heuristic on None. | ✓ |
| Replace _COMPANION_NAMES with role-driven mapping | Clean cut; regression risk on unaudited objects. | |
| Two parallel paths, never merged | Heuristic stays; role-driven layer applies only to overlay readouts. | |

**User's choice:** Augment: keep _COMPANION_NAMES, add signal_role lookup as primary

### Q4: What should each signal_role map to?

| Option | Description | Selected |
|--------|-------------|----------|
| audio→meter~ right; status→flonum overlay; rest none | Conservative mapping matching LAYOUT-03's literal phrasing. | ✓ |
| Full coverage: every role gets a companion | trigger→button, float→flonum, data/list→comment. Risk of clutter. | |
| Conservative: audio→meter~ only; rest by add_overlay_readout call | Smallest blast radius; status outlets become explicit-only. | |
| Configurable: ship default map but expose role_map= kwarg on apply_layout | Default + per-call override. Adds knobs. | |

**User's choice:** audio→meter~ right; status→flonum overlay; rest none

---

## Claude's Discretion

- **m4l_gen_synth scope** — User explicitly opted to lock in defaults rather than discuss. Default: minimum-viable skeleton (gen~ + live.dials with `param_connect` + `plugout~`; no DSP body, no MIDI input, no preset chunk, no parameter banks beyond the dial row).
- **Plan boundaries** — natural split: 31-01 overlay readout, 31-02 labeled param bank, 31-03 companion-pair logic, 31-04 m4l_gen_synth, 31-05 SKILL.md updates.
- **Internal helper placement for m4l_gen_synth** — whether the body lives in `patcher.py` or delegates to a helper in `m4l_polish.py`.
- **Format-string parsing depth in add_overlay_readout** — auto-detect unit suffix and emit prepend chain, or always treat as flonum `format` attribute.
- **apply_layout signal_role caching** — read per-call vs cache at first call. Perf unlikely to matter at v5.0 patch sizes.
- **Per-bar setminmax** — locked envelope mode; per-bar ranges deferred.
- **Whether to ship a tiny `examples/` patch** demonstrating each builder.

## Deferred Ideas

- `Patcher.add_with_companion(name, ...)` explicit eager builder
- `subpatcher_name=` kwarg on `add_labeled_param_bank` for full prepend/route encapsulation
- `anchor='below'`/`'right'` modes on `add_overlay_readout`
- `label_side='right'` and `'above'` on `add_labeled_param_bank`
- Per-bar `setminmax` ranges in `add_labeled_param_bank`
- Per-object `companion_hint` field in `overrides.json`
- Auto-generated `.planning/codebase/builders.md`
- Richer m4l_gen_synth skeleton (preset chunk, MIDI input, polyphony, Push device banks)
- `live.dial` parameter-bank-aware skeleton via existing `polish_m4l_device` Push-banking pass
- Splitting `patcher.py` into `builders/` submodule (PATCHER-SPLIT future-bucket)
