# Phase 31: Layout & UX Builders - Context

**Gathered:** 2026-04-30
**Status:** Ready for planning

<domain>
## Phase Boundary

Convert four CLAUDE.md prose recipes — overlay readouts, multislider parameter banks, signal_role-driven companion pairs, and the M4L gen synth scaffold — into callable builder functions on the Patcher API so `max-patch-agent` and `max-ui-agent` invoke them directly instead of restating the recipe in every patch. Phase 30's typed `signal_role` data is what makes the companion-pair builder concrete (audio outlets get meter~ companions, status outlets get flonum overlays).

**In scope:**
- New `Patcher.add_overlay_readout(target, format=..., type=..., editable=False, offset_x=0, offset_y=0)` baking in `bring_to_front` + `ignoreclick=1` (LAYOUT-01).
- New `Patcher.add_labeled_param_bank(params=[(name, min, max), ...], x, y, label_side='left', extra_attrs=None)` returning `(multislider, list[comment])` with `size=len(params)`, `height=size*24`, `orientation=0`, `contdata=1`, `setstyle=1` baked in and per-bar comment labels left-aligned (LAYOUT-02).
- Lazy companion-pair logic in `apply_layout`: read `db.get_signal_role(name, outlet_id)` for each box's outlets; consult a new `_ROLE_COMPANION_MAP` constant in `layout.py` to decide placement of *existing* companions (no auto-box-creation). Augments the existing `_COMPANION_NAMES` heuristic with role-based dispatch first; falls through to the legacy heuristic when the role is `None` (Phase 28 D-02 unaudited fallback) (LAYOUT-03).
- New `Patcher.add_m4l_gen_synth(params=[...])` minimum-viable skeleton in `m4l_polish.py`-adjacent or as a `Patcher` method that delegates to a helper in `m4l_polish.py`: gen~ (with `varname` set), `live.dial`s with `param_connect: "<varname>::<param_name>"` + full `saved_attribute_attributes.valueof` block per param, `plugout~` directly fed by gen~ outlet — explicitly NO `gain~`/`live.gain~` between gen~ and `plugout~` per CLAUDE.md M4L rule (LAYOUT-04).
- Update `.claude/skills/max-patch-agent/SKILL.md` and `.claude/skills/max-ui-agent/SKILL.md` with a "Builder API" section listing the four builders, their kwargs, and "when to call each" guidance (LAYOUT-05).
- Tests: unit tests for each builder (shape of returned boxes, baked attributes, z-order, ignoreclick); integration test for role-driven companion placement on a representative MSP patch using Phase 30's curated `signal_role` data.

**Out of scope:**
- Eager auto-box-creation when adding a tilde object (rejected — magical, surprises caller). Companion logic only re-positions companions the caller already added.
- Auto-rendering of the prepend/route chain inside `add_labeled_param_bank` (rejected — caller wires `fetch $1` themselves; reading via outlet 1 stays explicit per Memory).
- Per-object `companion_hint` field in `overrides.json` (rejected — would breach Phase 28's strict 3-field schema cap; mapping table lives in `layout.py`).
- Builders other than the four listed (e.g., `add_with_companion`, label-bank prepend chain, anchor='below'/'right' modes for overlay) — Phase 31 ships the prose-recipe-to-API delta; richer builders deferred.
- Splitting `patcher.py` into a `builders/` submodule — `PATCHER-SPLIT` is a future-bucket requirement, not Phase 31 scope. All four builders live on the `Patcher` class.
- Replacing `_COMPANION_NAMES` heuristic with role-only dispatch — augment, don't replace; regression risk on objects whose outlets aren't yet role-stamped.
- Auto-generated builder reference doc (`.planning/codebase/builders.md`) — heavier infra; SKILL.md updates are sufficient for v5.0.

</domain>

<decisions>
## Implementation Decisions

### Builder Home & Layering (LAYOUT-01..05)
- **D-01:** **All four builders live as `Patcher` class methods in `patcher.py`.** Single discoverable API (`p.add_overlay_readout`, `p.add_labeled_param_bank`, `p.add_m4l_gen_synth`, plus a passive companion-pair hook in `apply_layout`). Cost: `patcher.py` grows ~300–500 LOC against the FINDINGS PATCHER-SPLIT goal of shrinking it; that goal is explicitly future-bucket per REQUIREMENTS.md and is not Phase 31 scope. The `m4l_gen_synth` body may delegate to a helper in `m4l_polish.py` to keep `patcher.py` shorter, but the public entry point is `p.add_m4l_gen_synth(...)`.
- **D-02:** **LAYOUT-05 wired via per-agent SKILL.md updates.** `.claude/skills/max-patch-agent/SKILL.md` and `.claude/skills/max-ui-agent/SKILL.md` each get a "Builder API" section listing the four builders, their kwargs, and "when to call each" guidance. CLAUDE.md gets a brief pointer + the canonical recipe-removal note (the prose recipes that survive should now reference the builder name). No auto-generated reference doc this phase.

### Overlay Readout API (LAYOUT-01)
- **D-03:** **`format=` accepts a printf-style string.** `format='%.2f'` baked into a flonum's `format` attribute; `format='%.1f Hz'` (with unit suffix) baked via a prepend chain that emits `set %.1f Hz` to a comment. Single arg, declarative, agent-friendly. No callable/lambda support (rejected — only works at Python build-time, awkward semantics). No structured `decimals=`/`unit=` kwargs (rejected — verbose, loses ergonomics).
- **D-04:** **Default produces a flonum overlay; `type=` kwarg overrides.** `type='flonum'` (default) for numeric live readout, `type='comment'` for read-only label, `type='number'` for int-only. Single API covers all three. Three separate builders (`add_overlay_flonum` etc.) rejected — same z-order pattern, just different maxclass.
- **D-05:** **Auto-overlap target rect by default; `offset_x=`/`offset_y=` for fine-tuning.** Default copies `target.patching_rect` to the readout (same x, y, w, h). Caller fine-tunes with `offset_x=0`, `offset_y=4` etc. when an exact overlap doesn't fit. Matches the CLAUDE.md recipe ("overlap the dial").
- **D-06:** **`ignoreclick=1` baked in by default; `editable=True` opts out.** Default: clicks pass through to the underlying control (CLAUDE.md rule). `editable=True` flips `ignoreclick=0` and `bring_to_front` still applies — used when caller wants the readout itself to be edited (rare M4L case). `bring_to_front` is unconditional; the readout always renders on top.

### Labeled Param Bank API (LAYOUT-02)
- **D-07:** **`params=[(name, min, max), ...]` — list of `(str, float, float)` tuples.** One tuple per bar. Drives label text, `setminmax` (computed as the [min(all_mins), max(all_maxes)] envelope), and bar count. List of dicts rejected (verbose for common case). List-of-strings rejected (loses per-bar ranges). `Param` dataclass rejected (heaviest setup; not justified for one builder).
- **D-08:** **Labels left-aligned, vertically centered with each bar.** Each comment placed at `x = ms.x - label_width - gap`, `y = ms.y + i * 24` (matches CLAUDE.md spacing for fontsize=10). `label_side='left'` is the default; reserve `'right'` as a future kwarg if a real case appears (not implemented this phase). `'above'` not supported.
- **D-09:** **Builder returns `(multislider, list[comment])` only — no prepend/route chain.** Caller wires `fetch $1` → multislider input themselves and reads values from the multislider's RIGHT outlet (outlet 1) per existing memory note. Keeps the builder focused on layout. No `subpatcher_name=` kwarg this phase — that's a routing-encapsulation feature, separate concern. Caller can still wrap the returned boxes in their own `add_subpatcher` if they want.
- **D-10:** **Recipe attributes baked in; `extra_attrs={}` deep-merges overrides.** Hard-coded: `size=len(params)`, `height=size*24`, `orientation=0`, `contdata=1`, `setstyle=1`, `setminmax` derived from params. Caller passes `extra_attrs={'bgcolor': [...]}` to override or add attrs (deep-merged onto defaults). Strict-no-overrides rejected — loses ergonomics. Every-attr-as-kwarg rejected — defeats the codify-the-recipe intent.

### Companion-Pair Semantics (LAYOUT-03)
- **D-11:** **Lazy: companion placement decided at `apply_layout` time, not at `add_box`.** `apply_layout` calls `db.get_signal_role(name, outlet_id)` for each box's outlets; if a role implies a companion (audio→meter~ right, status→flonum overlay), uses that to place the companion the caller already added. No new boxes auto-created. Composes with existing `_identify_companions` flow. Eager add-time hook rejected (magical, grows boxes unannounced). Explicit `add_with_companion()` rejected as a Phase 31 deliverable (out of scope; can be added later if needed).
- **D-12:** **Role→companion mapping = module-level constant in `layout.py`.** `_ROLE_COMPANION_MAP: dict[str, dict[str, str | None]]` next to existing `_COMPANION_NAMES`. Single dict, easy to grep, one diff to change. Per-object `companion_hint` in `overrides.json` rejected (would breach Phase 28's strict 3-field schema cap; doesn't scale).
- **D-13:** **Augment `_COMPANION_NAMES`, don't replace it.** Role-driven mapping fires first; if `db.get_signal_role(name, outlet_id)` returns `None` (Phase 28 D-02 unaudited), fall through to the existing `_COMPANION_NAMES` heuristic. No regression risk on objects whose outlets weren't role-stamped by Phase 30. The heuristic gradually subsumes itself as future audits add coverage.
- **D-14:** **Conservative role mapping:**
  ```python
  _ROLE_COMPANION_MAP = {
      "audio":   {"companion": "meter~", "placement": "right"},
      "status":  {"companion": "flonum", "placement": "overlay"},
      "trigger": {"companion": None,     "placement": None},
      "float":   {"companion": None,     "placement": None},
      "data":    {"companion": None,     "placement": None},
      "list":    {"companion": None,     "placement": None},
  }
  ```
  Matches LAYOUT-03's literal phrasing. trigger/float/data/list have no canonical companion (caller decides, or uses `add_overlay_readout` explicitly). Conservative mapping reduces clutter on patches that don't need full companion coverage.

### M4L Gen Synth Skeleton (LAYOUT-04) — Claude's Discretion
- **D-15:** **Minimum-viable skeleton: gen~ + live.dials + plugout~.** No DSP body in gen~ (caller fills in), no MIDI input, no preset chunk, no parameter bank organization beyond the `live.dial` row. The skeleton's job is to get the `param_connect` plumbing right, not to ship a full instrument. Each `live.dial` gets its `param_connect: "<gen~_varname>::<param_name>"` + the full `saved_attribute_attributes.valueof` block (`parameter_initial`, `parameter_longname`, `parameter_shortname`, `parameter_mmin`, `parameter_mmax`, `parameter_modmode`, `parameter_type`, `parameter_unitstyle`). gen~ gets a stable `varname` matching the `param_connect` prefix. Explicitly NO `gain~`/`live.gain~`/`ezdac~` between gen~ and `plugout~` (CLAUDE.md M4L rule). The reusable `ensure_parameter_enable` / `polish_m4l_device` passes in `m4l_polish.py` are invoked on the result.

### Tests
- **D-16:** **Unit tests per builder + one integration test for companion placement.**
  - `tests/test_overlay_readout.py`: shape of returned box, `bring_to_front` index 0, `ignoreclick` value, format string baked, `editable=True` flips ignoreclick, all three `type=` variants.
  - `tests/test_labeled_param_bank.py`: returned `(ms, list[comment])` shape, locked attrs (`size`, `height = size*24`, `orientation=0`, `contdata=1`, `setstyle=1`), label x/y alignment formula, `setminmax` envelope across params, `extra_attrs` deep-merge.
  - `tests/test_m4l_gen_synth.py`: gen~ has `varname`; each `live.dial` has matching `param_connect` and full `saved_attribute_attributes.valueof`; plugout~ wired directly to gen~ (no `gain~` in path); `ensure_parameter_enable` invariants hold.
  - `tests/test_companion_role_layout.py` (integration): build a small MSP patch (cycle~ → gain~ → meter~ + dial+flonum overlay), call `apply_layout`, assert meter~ ends up to the right of gain~ via `_ROLE_COMPANION_MAP` (audio role), assert flonum overlays the dial via `bring_to_front` order, assert behavior when source role is `None` falls through to `_COMPANION_NAMES`.

### Claude's Discretion
- **Plan boundaries** — natural split looks like: 31-01 overlay readout + tests, 31-02 labeled param bank + tests, 31-03 companion-pair logic in apply_layout + integration test, 31-04 m4l_gen_synth + tests, 31-05 SKILL.md updates + CLAUDE.md pointer. Planner may bundle 31-01/31-02 if they ship cleanly together. Order: 31-03 should land after 31-01 (overlay readout used by status-role companion path).
- **Internal helper placement** — whether the m4l_gen_synth body lives entirely in `patcher.py` or delegates to a helper in `m4l_polish.py` (e.g., `_build_gen_synth_skeleton(p, params)`). Either works; delegating to `m4l_polish.py` keeps `patcher.py` shorter and groups the M4L knowledge with existing `polish_m4l_device`.
- **Format-string parsing depth in add_overlay_readout** — whether to detect a unit suffix (`'%.1f Hz'`) and auto-emit a prepend chain, or always treat the format as a single flonum `format` attribute. Auto-detection adds complexity; if simple `flonum.format` covers the common case, ship that and add prepend support only if a real case demands it.
- **Whether `apply_layout` reads `signal_role` per-call or caches at first call** — perf is unlikely to matter at v5.0 patch sizes; pick whichever survives diff review.
- **Per-bar `setminmax` instead of envelope** — the locked decision is to use the [min(mins), max(maxes)] envelope across all params, but multislider supports per-bar ranges via separate messages. If the planner finds the envelope cramps real use cases, propose the upgrade as a deferred follow-up rather than expanding scope here.
- **Whether to ship a tiny `examples/` patch** demonstrating each builder — nice-to-have; planner can decide if the test fixtures are sufficient.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Roadmap & Requirements (this milestone)
- `.planning/ROADMAP.md` §"Phase 31: Layout & UX Builders" — phase goal, success criteria, requirements list (LAYOUT-01..05).
- `.planning/REQUIREMENTS.md` §"Layout & UX Builders (Phase 31)" — the five LAYOUT-* requirements verbatim.
- `.planning/STATE.md` — milestone-level decisions for v5.0 (signal_role population landed in Phase 30; layout builders are the consumer surface).
- `.planning/PROJECT.md` §"Key Decisions" — Patcher-API-as-source-of-truth rationale; existing layout/aesthetics conventions.

### Prior Phase Artifacts (the schema this phase consumes)
- `.planning/phases/28-schema-foundation/28-CONTEXT.md` — Phase 28 locked decisions, especially:
  - **D-01:** loader write-through projects `signal_role` → `signal: bool`. Builder-level lookups use `get_signal_role()`.
  - **D-02:** `get_signal_role()` returns `None` for unaudited outlets — `_ROLE_COMPANION_MAP` dispatch must fall through on `None`.
  - **D-04:** closed enum `audio | trigger | status | float | data | list` — companion map covers exactly these six keys.
  - **D-13:** no umbrella audit wrapper — Phase 31 doesn't add audits.
  - **D-14:** schema lives in `overrides.json` only — no per-object `companion_hint` field this phase.
- `.planning/phases/29-validator-depth/29-CONTEXT.md` — Phase 29 locked decisions, especially:
  - **D-02:** role check runs first; `None` falls through to legacy. Builder companion dispatch follows the same pattern.
- `.planning/phases/30-msp-outlet-coverage-sweep/30-CONTEXT.md` — Phase 30 populated `signal_role` on MSP + MC outlets to <20 gaps each. The auto-mirror rule for MC siblings (`mc.cycle~` inheriting from `cycle~`) means companion behavior also propagates without per-MC entries.
- `.planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-FINDINGS.md` — origin of the four-builder roadmap (overlay-readout, labeled-param-bank, signal_role companion-pairs, m4l_gen_synth_skeleton).

### Codebase Anchors (must read before editing)
- `src/maxpat/patcher.py` — `Patcher` class. Key extension/integration points:
  - `add_panel` (line ~570) — sibling factory pattern for `add_overlay_readout` and `add_labeled_param_bank`.
  - `add_step_marker` (line ~639) — closer pattern for builders that bake in extra_attrs (`background`, `ignoreclick`, custom colors).
  - `bring_to_front` (line ~688) / `send_to_back` / `set_z_index` — z-order primitives the overlay builder calls.
  - Patcher.add_box / add_message / add_subpatcher — the existing builder vocabulary the new ones extend.
- `src/maxpat/layout.py` — row-based layout engine. Key extension points:
  - `_COMPANION_NAMES` (line ~50) — existing fallback heuristic that role-driven dispatch augments.
  - `_identify_companions` (line ~568) and `_place_companions` (line ~606) — where the new role-driven path slots in.
  - `_route_companion_cable` (line ~942) — cable routing for companion pairs; should keep working unchanged.
- `src/maxpat/m4l_polish.py` — existing M4L scaffolding. Key extension/integration points:
  - `ensure_parameter_enable` (SCAFFOLD-04) — `add_m4l_gen_synth` invokes this to populate `parameter_enable=1` + `saved_attribute_attributes`.
  - `polish_m4l_device` — composes the polish passes; the skeleton produced by `add_m4l_gen_synth` should be polish-ready.
  - `_ABBREVIATIONS` table — used to derive shortname from longname per dial.
- `src/maxpat/db_lookup.py` — `ObjectDatabase.get_signal_role(name, outlet)` (Phase 28) is the only DB call companion-pair logic needs. Returns `Optional[Literal['audio','trigger','status','float','data','list']]`.
- `.claude/max-objects/overrides.json` — Phase 30 populated MSP/MC `signal_role`. Read-only for Phase 31.
- `.claude/skills/max-patch-agent/SKILL.md` and `.claude/skills/max-ui-agent/SKILL.md` — destination for the LAYOUT-05 "Builder API" sections.
- `tests/conftest.py` — fixtures (`all_objects`, `objects_by_domain`) used by Phase 28/30 tests; reuse for the integration test.
- `tests/test_schema_extensions.py` — class structure to mirror for the new builder tests.

### Convention References
- `CLAUDE.md` §"Rule #6: Z-Order Awareness" — the prose recipe for overlay readouts (`bring_to_front` + `ignoreclick=1`); LAYOUT-01 is the codified form.
- `CLAUDE.md` §"Multislider as Labeled Parameter Bank" — the prose recipe for labeled param banks (size×24, contdata=1, setstyle=1, fetch from outlet 1); LAYOUT-02 is the codified form.
- `CLAUDE.md` §"Domain-Specific Rules → Max for Live (M4L / .amxd)" — `param_connect` syntax, no `gain~` before `plugout~`, `saved_attribute_attributes.valueof` block; `add_m4l_gen_synth` enforces these.
- `CLAUDE.md` §"Patch Style" — companion placement conventions, top-to-bottom signal flow, gutter spacing.
- Memory: `feedback_multislider_fetch.md` — multislider read uses `fetch` (not `fetchindex`), values emerge from outlet 1. Builder docs must reference this so callers don't wire outlet 0.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- **`Patcher.add_panel` / `add_step_marker` (patcher.py:570, 639)** — exact pattern for new builders that need to bake in `extra_attrs` and z-order behavior (background=1, ignoreclick=1, custom colors).
- **`Patcher.bring_to_front` / `send_to_back` / `set_z_index` (patcher.py:688)** — z-order primitives. `add_overlay_readout` calls `bring_to_front` after creating the readout.
- **`layout.py` `_COMPANION_NAMES` + `_identify_companions` + `_place_companions`** — existing companion-pair dispatch the role-driven path augments. Integration is "consult role first, fall through to heuristic".
- **`db.get_signal_role(name, outlet)` (Phase 28)** — single DB call the companion logic needs. Returns the closed enum value or `None`.
- **`m4l_polish.py` `ensure_parameter_enable` and `polish_m4l_device`** — `add_m4l_gen_synth` invokes these so the skeleton is parameter_enable-ready and naming-derived without re-implementing the abbreviation table.
- **Phase 28's `tests/test_schema_extensions.py` class structure** — template for `TestOverlayReadout`, `TestLabeledParamBank`, `TestM4LGenSynth`, `TestRoleDrivenCompanions`.

### Established Patterns
- **All Patcher builders are methods, not module functions** — `add_panel`, `add_step_marker`, `add_subpatcher`, `add_message`. New builders follow.
- **`extra_attrs={}` deep-merges over baked defaults** — pattern from existing `add_panel`. `add_labeled_param_bank` reuses it.
- **Z-order via insert position in `boxes` array** — `add_panel` inserts at index 0; `bring_to_front` moves to index 0. New overlay builder uses `bring_to_front` after `add_flonum`/`add_comment`/`add_number`.
- **`background=1`, `ignoreclick=1` on background panels** — same kwargs the overlay builder uses for click-pass-through.
- **layout.py reads box state, doesn't mutate construction** — companion-pair role logic stays in `_identify_companions` / `_place_companions`; doesn't reach into `Patcher.add_box`.

### Integration Points
- **No new module under `src/maxpat/` strictly required** — all four builders are `Patcher` methods on `patcher.py`. The `m4l_gen_synth` body MAY delegate to a helper in `m4l_polish.py` (Claude's discretion).
- **No new files in `.claude/max-objects/`** — companion mapping is a Python constant in `layout.py`, not a DB schema field.
- **Existing role-aware validators (Phase 29) stay unchanged** — they consume `get_signal_role()`; companion dispatch reads the same getter from layout.py.
- **Phase 30's `signal_role` curation directly enables LAYOUT-03** — without role coverage on MSP outlets, `_ROLE_COMPANION_MAP` would always fall through to the legacy heuristic and the companion-pair builder would deliver no incremental value.
- **Existing tests in `tests/test_validation.py`, `tests/test_schema_extensions.py`, `tests/test_audit_signal_role.py` MUST stay green.** No DB-schema or validator changes this phase.

</code_context>

<specifics>
## Specific Ideas

- The exact `_ROLE_COMPANION_MAP` dict shape lives in `layout.py` next to `_COMPANION_NAMES`:
  ```python
  _ROLE_COMPANION_MAP: dict[str, dict[str, str | None]] = {
      "audio":   {"companion": "meter~", "placement": "right"},
      "status":  {"companion": "flonum", "placement": "overlay"},
      "trigger": {"companion": None,     "placement": None},
      "float":   {"companion": None,     "placement": None},
      "data":    {"companion": None,     "placement": None},
      "list":    {"companion": None,     "placement": None},
  }
  ```
- `add_overlay_readout` signature: `add_overlay_readout(self, target: Box, *, format: str = '%.2f', type: str = 'flonum', editable: bool = False, offset_x: float = 0, offset_y: float = 0) -> Box`.
- `add_labeled_param_bank` signature: `add_labeled_param_bank(self, params: list[tuple[str, float, float]], x: float, y: float, *, label_side: str = 'left', extra_attrs: dict | None = None) -> tuple[Box, list[Box]]`.
- `add_m4l_gen_synth` signature: `add_m4l_gen_synth(self, params: list[tuple[str, float, float]], *, gen_varname: str = 'synth') -> tuple[Box, list[Box], Box]` returning `(gen_obj, live_dials, plugout_obj)`.
- The label spacing formula for `add_labeled_param_bank` is the existing CLAUDE.md recipe: `height = size * 24` for fontsize=10 labels; per-bar y-positions are `ms.y + i * 24`.
- The status→flonum overlay companion uses `placement='overlay'` which dispatches to `bring_to_front`-equivalent z-order positioning AND copies `target.patching_rect` (i.e. the LAYOUT-01 builder's behavior is reused internally for status outlets in apply_layout).
- m4l_gen_synth's `gen_varname` is what shows up in `param_connect: "<varname>::<param_name>"` — must be a valid MAX symbol (no spaces, leading letter). Default `'synth'` keeps the API ergonomic.

</specifics>

<deferred>
## Deferred Ideas

- **`Patcher.add_with_companion(name, ...)` explicit eager builder** — for callers who want gain~ + meter~ + wiring in one call. Discussed and deferred this phase; lazy companion-pair coverage delivers LAYOUT-03's promise without the surprise.
- **`subpatcher_name=` kwarg on `add_labeled_param_bank`** for full prepend/route encapsulation. Real use case but a separate routing concern; ship after the bare layout builder is in.
- **`anchor='below'`/`'right'` modes on `add_overlay_readout`** — LAYOUT-01 is specifically about overlap; below/right are different patterns. Promote to dedicated builder if a real case appears.
- **`label_side='right'` and `'above'` on `add_labeled_param_bank`** — only `'left'` ships this phase. Add others on demand.
- **Per-bar `setminmax` ranges in `add_labeled_param_bank`** — locked decision is the [min(mins), max(maxes)] envelope; per-bar ranges are a multislider feature but require runtime config messages, not just attrs.
- **Per-object `companion_hint` field in `overrides.json`** — would let two `audio` outlets imply different companions. Breaches Phase 28's strict 3-field cap; revisit in v6.0+ if the role-only mapping proves too coarse.
- **Auto-generated `.planning/codebase/builders.md`** from builder docstrings. Heavier infra, sufficient agent discoverability via SKILL.md updates for v5.0.
- **A richer m4l_gen_synth skeleton** (preset chunk, MIDI input, polyphony, Push device parameter banks) — minimum-viable ships first; bigger scaffolds are their own phase.
- **`live.dial` parameter banks via the existing `polish_m4l_device` Push-banking pass** — `add_m4l_gen_synth` produces a flat row of dials. Banks-of-8 grouping happens via `polish_m4l_device` post-hoc; if a richer "bank-aware skeleton" builder is wanted, that's a follow-up.
- **Splitting `patcher.py`** into `builders/` submodule (PATCHER-SPLIT) — future-bucket per REQUIREMENTS.md, not this phase.

</deferred>

---

*Phase: 31-layout-ux-builders*
*Context gathered: 2026-04-30*
