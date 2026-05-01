# Phase 30: MSP Outlet Coverage Sweep - Context

**Gathered:** 2026-04-29
**Status:** Ready for planning

<domain>
## Phase Boundary

Populate per-outlet `signal_role` (Phase 28's typed contract) across the MSP and MC tilde domains so role-aware validation (Phase 29) actually fires on real patches instead of falling back to the boolean shim. Curate ~50 existing MSP outlet-type overrides into typed roles, populate roles on ~80 commonly-used unverified MSP objects (`saw~`, `*~`, `noise~`, `sig~`, `gen~`, `selector~`, `send~`, etc.), extend coverage to MC tildes (with sibling auto-mirror from bare-MSP equivalents), build a digest-keyword audit script that classifies remaining gaps with three-tier confidence, add `audit_signal_role_coverage()` to db_lookup.py for reproducible drift detection.

**In scope:**
- Migrate ~50 existing MSP outlet-type overrides in `overrides.json` from `signal: bool` to per-outlet `signal_role` (drop the legacy bool — Phase 28 D-03's loader projection back-fills it).
- Populate `signal_role` on ≥80 unverified MSP objects from the 260331-n24 flagged list, plus all multi-outlet "mixed" MSP objects (34 candidates incl. `gain~`, `line~`, `play~`, `vst~`, `omx.4band~`).
- Populate `signal_role` on MC/MCS tilde objects (`mc.*~`, `mcs.*~`); auto-mirror from bare-MSP siblings where they exist (e.g. `mc.cycle~` ← `cycle~`); curator may override per outlet.
- New `scripts/audit_signal_role.py` CLI: digest-keyword classifier with three-tier confidence (high/medium/low), emits `SIGNAL-ROLE-REVIEW.md` (markdown table for human review) AND `signal-role-audit.json` (machine-readable snapshot) under `.planning/phases/30-msp-outlet-coverage-sweep/`.
- New `ObjectDatabase.audit_signal_role_coverage()` in `src/maxpat/db_lookup.py` returning per-domain bucketed counts + lists.
- Two new test files: `tests/test_audit_signal_role.py` (audit fn shape, per-domain bucketing, edge cases) and `tests/test_signal_role_migration.py` (back-compat regression: existing `signal: bool` readers in `patcher.py:250` and `dsp_critic.py:301` keep working post-migration).
- Resolve Phase 28's deferred MC tilde test failures as a side-effect of the MC sweep (Plan 30-04): `test_inlet_types.py::test_tilde_objects_have_signal_io` for `mc.capture~`, `mc.send~`, `mcs.loudness~`, `info~`.
- Audit output committed alongside the migration so future drift between extracted facts and curated roles is visible in git history (MSPCOV-04).

**Out of scope:**
- Populating `verified_installed` across MSP/MC — separate sweep, future phase.
- Populating `domain_restricted` beyond explicit cases already annotated (Phase 29 D-05 explicit-only stays in force).
- Jitter tilde signal_role coverage — future phase if real cases emerge.
- Modifying extracted per-domain JSONs (`msp/objects.json`, `mc/objects.json`) — all changes land in `overrides.json` per Phase 28 D-14.
- New validators or critics that read `signal_role` — that was Phase 29 (already shipped); Phase 30 is data population only.
- Unifying validation/critic severity vocabularies (Phase 29 D-18 deferred to v6.0+).
- Removing the `signal: bool` field from extracted JSONs — back-compat shim is permanent through v5.0 per STATE.md milestone decision.

</domain>

<decisions>
## Implementation Decisions

### Curation Strategy
- **D-01:** **Hybrid auto/manual curation.** The audit script auto-suggests roles by digest keyword. High-confidence matches (`signal: true` outlets → `audio`; strict trigger keywords like `bang`/`done`/`mute`/`state`/`flag` → `trigger` or `status`; bare `list` digests → `list`) auto-apply directly to `overrides.json`. Ambiguous outlets (broad data synonyms or the "other" digest bucket — ~25 outlets after broad-data classification) get flagged in a review file for manual roles. Pure manual is too slow; pure heuristic over-classifies.
- **D-02:** **Human-review surface = markdown review file.** Audit script writes `.planning/phases/30-msp-outlet-coverage-sweep/SIGNAL-ROLE-REVIEW.md` containing a table `| object | outlet_id | digest | suggested_role | confidence | curator_role |`. Curator fills `curator_role` column directly in the file; a follow-up apply step (same script with `--apply` flag, or a separate `apply` subcommand) reads the resolved review file and writes confirmed roles into `overrides.json`. Survives interruption (file-based, not stdin); diffable in git.
- **D-03:** **Drop legacy `signal: bool` when adding `signal_role` to an override.** Phase 28 D-03 locked: "single source of truth for curators is `signal_role`." The loader's write-through projection (Phase 28 D-01) re-materializes `signal: bool` at load time, so direct readers in `patcher.py:250` and `dsp_critic.py:301` keep working unchanged. Keeping both fields invites drift.
- **D-04:** **Conflict policy: `signal: true` wins, role = `audio`.** When the extracted DB says `signal: true` but the digest text implies a control role (e.g. `stash~`'s `Index (signal)` outlet), trust the structured field over the prose. Mismatches are vanishingly rare; the existing ~50 overrides exist precisely to fix the genuine cases. Eliminates a noisy edge case from the classifier.

### Audit Taxonomy + Output
- **D-05:** **Hybrid classifier — strict for trigger/status, broad for data/list.** Strict regex for `trigger`/`status` keywords (only `bang`, `done`, `state`, `mute`, `flag`, `active`, `busy`) — high precision because false positives in this lane would auto-remove connections. Broader synonym maps for `data`/`list` (allow `parameter`, `index`, `count`, `value`, `position`, `ms`, `samples`, `dB`, `note`, `symbol`) — false positives here are low-cost (worst case: a `data` outlet labelled `list` or vice versa). Drops the unclassified "other" bucket from ~65 outlets to ~25.
- **D-06:** **Audit output = both markdown and JSON, both in phase dir.** `SIGNAL-ROLE-REVIEW.md` is the human review surface (curator edits the `curator_role` column). `signal-role-audit.json` is the machine-readable snapshot (full classifier output: object/outlet/digest/suggested_role/confidence/curator_role). Both committed per MSPCOV-04 so future drift between extracted facts and curated roles is visible in git history. The JSON is what re-running the audit later compares against to detect drift.
- **D-07:** **Audit script = standalone CLI at `scripts/audit_signal_role.py`.** Imports `ObjectDatabase`, walks MSP and MC, calls the new `audit_signal_role_coverage()` under the hood, applies the digest classifier, emits md + json. Subcommands: default (audit + write review file + json), `--apply` (read curator-edited review file, write resolved roles into `overrides.json`). Re-runnable for drift detection in future milestones. Same pattern as other one-off DB tooling under `scripts/`.
- **D-08:** **Three-tier confidence: high / medium / low.**
  - **high** = `signal: true` outlets (auto-apply `audio`); strict trigger/status keyword matches (auto-apply `trigger` or `status`).
  - **medium** = broad data/list synonym matches (auto-apply with `# verify` marker in the review file so curator can spot-check).
  - **low** = "other" digest bucket — no classification proposed; row written to review file with empty `suggested_role` and `confidence: low`; curator must fill `curator_role`.

### Coverage Scope
- **D-09:** **MSP + MC tildes both in scope.** Strict-MSP-only would leave Phase 28's flagged MC test failures (`mc.capture~`, `mc.send~`, `mcs.loudness~`, `info~` lacking `signal: true` flags) deferred indefinitely. Adding MC here costs ~30–50 extra objects but resolves a real test-suite redness and pays the schema dividend across both domains.
- **D-10:** **`audit_signal_role_coverage()` reports MSP and MC counts separately; each must end < 20 gaps.** MSPCOV-05's literal "<20 remaining MSP gaps" stays satisfied; MC gets an explicit per-domain gate. Pooled threshold would let MC slip; MC-best-effort would leave the gate ungated.
- **D-11:** **MC variants auto-mirror their bare-MSP sibling's roles, curator may override per outlet.** Audit script proposes the bare-MSP sibling's roles when the MC name matches by stripping `mc.`/`mcs.` prefix (e.g. `mc.cycle~` → `cycle~`). Inherited roles flagged `inherited` in the review-file `confidence` column so curator can spot per-channel quirks (extra control outlets on `mcs.vst~`, control-rate index outlets on `mcs.play~`, etc.). Cuts manual MC work by ~40–60% while preserving fidelity for genuine divergence.
- **D-12:** **Phase 30 stays in the `signal_role` lane only.** `verified_installed` and `domain_restricted` get their own population sweeps in future phases. Stamping `verified_installed = true` opportunistically would expand the phase's blast radius and risk miscalibrating Phase 29's install-state warning. Cleaner diffs, tighter scope, easier review.

### Audit Function Shape + Batching
- **D-13:** **`audit_signal_role_coverage()` returns per-domain bucketed counts + lists.**
  ```python
  {
    "msp": {
      "covered": [list of object names with signal_role on every outlet],
      "uncovered": [list of object names with at least one outlet missing signal_role],
      "by_role": {"audio": N, "trigger": N, "status": N, "float": N, "data": N, "list": N},
      "gap_count": int,  # len(uncovered) — gates against MSPCOV-05's <20 threshold
    },
    "mc": { ... same shape },
  }
  ```
  Per-domain accountability matches the locked <20 MSP + <20 MC threshold. `by_role` distribution gives at-a-glance drift signal. Lives in `db_lookup.py` next to existing audit fns (lines 819–918). Pure read-only — no mutation, no classifier coupling.
- **D-14:** **Migration lands as 4 plans, plan-aligned.**
  - **Plan 30-01:** `audit_signal_role_coverage()` + `scripts/audit_signal_role.py` skeleton + `tests/test_audit_signal_role.py`. No data migration yet — pure infrastructure. Audit fn returns current (mostly-uncovered) state.
  - **Plan 30-02:** Migrate the ~50 existing MSP outlet-type overrides from `signal: bool` to `signal_role`. Drop the legacy bool. Tests in `tests/test_signal_role_migration.py` assert no regressions in `patcher.py:250` and `dsp_critic.py:301` consumers via the back-compat shim.
  - **Plan 30-03:** Populate ~80 unverified MSP objects via the audit script (high-confidence auto-apply + curator-resolved review file). Goal: drive MSP `gap_count` < 20.
  - **Plan 30-04:** MC + MCS tilde sweep with sibling auto-mirror. Resolve Phase 28's deferred MC tests as side-effect. Goal: drive MC `gap_count` < 20.
  Each plan ships atomically with its own tests, review file (where applicable), and audit-output commit. Matches GSD's standard plan-per-commit cadence.
- **D-15:** **Tests = unit (audit fn) + regression (migration back-compat).**
  - `tests/test_audit_signal_role.py`: covers the new `audit_signal_role_coverage()` shape, per-domain bucketing, edge cases (object with mixed audited/unaudited outlets; objects with empty I/O excluded), `by_role` count correctness.
  - `tests/test_signal_role_migration.py`: snapshot tests on the post-migration `overrides.json` shape; assertion tests that `patcher.py:250` and `dsp_critic.py:301` direct `outlet["signal"]` reads keep returning correct values via the Phase 28 write-through projection; format-stability snapshot test on `SIGNAL-ROLE-REVIEW.md` so the review-file shape doesn't drift between plans.
  - End-to-end validation against generated patches is intentionally NOT in scope here — Phase 28's deferred-items.md notes existing flaky integration-patch tests; coupling Phase 30's gates to them risks false reds.
- **D-16:** **Plan 30-04 also fixes Phase 28's deferred MC test failures.** When the MC sweep adds `signal_role` to `mc.capture~`, `mc.send~`, `mcs.loudness~`, `info~`, the loader's write-through projection re-stamps `signal: true` on their outlet metadata, which is exactly what `test_inlet_types.py::test_tilde_objects_have_signal_io` was asserting. No extra work; closes the loop on Phase 28 deferred-items.md.

### Claude's Discretion
- **Exact apply-step shape** — `scripts/audit_signal_role.py --apply` flag vs separate `apply_signal_role.py`. Either works; pick whichever survives diff review better.
- **Review-file table format** — pipe-delimited markdown is the obvious default; YAML front-matter for review metadata (date, classifier version) is optional polish.
- **Where the digest classifier lives** — inline in `scripts/audit_signal_role.py` is fine; promoting to `src/maxpat/audit/` is overkill until a second audit script needs the same heuristics.
- **Exact ordering of plans 30-02 / 30-03** — the override migration could land before or after the unverified population. 30-02 first feels safer (proven shim before populating new ground); 30-03 first is also defensible.
- **Whether to add CLAUDE.md guidance** about running the audit script periodically — minor docs polish; planner can decide if it's worth a paragraph.
- **Whether `gap_count` deserves its own field** vs deriving from `len(uncovered)` at call sites. Either works; explicit field saves duplication if multiple callers compute it.

</decisions>

<canonical_refs>
## Canonical References

**Downstream agents MUST read these before planning or implementing.**

### Roadmap & Requirements (this milestone)
- `.planning/ROADMAP.md` §"Phase 30: MSP Outlet Coverage Sweep" — phase goal, success criteria, requirements list (MSPCOV-01..05).
- `.planning/REQUIREMENTS.md` §"MSP Outlet Coverage Sweep (Phase 30)" — the five MSPCOV-* requirements verbatim.
- `.planning/STATE.md` — milestone-level decisions for v5.0 (3-field scope cap; `signal: bool` retained as derived shim through v5.0).
- `.planning/PROJECT.md` §"Key Decisions" — JSON-per-domain rationale, override deep-merge pattern.

### Prior Phase Artifacts (the schema this phase populates + the validators that consume it)
- `.planning/phases/28-schema-foundation/28-CONTEXT.md` — Phase 28 locked decisions, especially:
  - **D-01:** loader write-through projects `signal_role` → `signal: bool` at load time. Direct `outlet["signal"]` readers keep working.
  - **D-03:** single source of truth for curators is `signal_role`; never hand-edit both fields.
  - **D-04:** closed enum `audio | trigger | status | float | data | list` — loader fail-fasts on unknown values.
  - **D-12:** audit functions return sorted dict-of-lists; new `audit_signal_role_coverage()` follows the same shape.
  - **D-14:** all schema additions land in `overrides.json` only — extracted per-domain JSONs stay pristine.
- `.planning/phases/28-schema-foundation/28-VERIFICATION.md` — Phase 28 acceptance evidence; baseline for the back-compat shim Phase 30 leans on.
- `.planning/phases/28-schema-foundation/deferred-items.md` — pre-existing MC tilde test failures Phase 30 plan 30-04 will resolve.
- `.planning/phases/29-validator-depth/29-CONTEXT.md` — Phase 29 locked decisions, especially:
  - **D-02:** role check runs first; falls through to legacy `signal: bool` on `None`. Phase 30's gradual coverage relies on this.
  - **D-05:** `domain_restricted` stays explicit-only (no canonical-domain inference). Phase 30 does NOT populate domain_restricted.
- `.planning/quick/260331-n24-full-repo-analysis-identify-improvements/260331-n24-ANALYSIS.md` — origin of the "~80 commonly-used unverified MSP objects" target list (`saw~`, `*~`, `noise~`, `sig~`, `gen~`, `selector~`, `receive~`, `send~`).

### Codebase Anchors (must read before editing)
- `src/maxpat/db_lookup.py` — `ObjectDatabase` class. Key extension/integration points:
  - `_load()` (line ~69) and the override deep-merge — already deep-merges `signal_role` from overrides; no loader changes needed for this phase.
  - `_apply_signal_role_writethrough()` (Phase 28) — projects `signal_role` onto `signal: bool` at load time. Migration relies on this for back-compat.
  - `audit_empty_io()` (line ~819), `audit_install_coverage()` (line ~861), `audit_domain_coverage()` (line ~891) — exact sibling pattern for the new `audit_signal_role_coverage()`.
- `src/maxpat/patcher.py:250` — direct `outlet["signal"]` reader; back-compat regression anchor.
- `src/maxpat/critics/dsp_critic.py:301` — direct `outlet["signal"]` reader; back-compat regression anchor.
- `src/maxpat/validation.py` — Phase 29's `_validate_connections()` (line ~420) consumes `get_signal_role()`. Phase 30 doesn't modify validation; just makes role-aware errors actually fire.
- `.claude/max-objects/overrides.json` — the ONLY file where new `signal_role` data lands. Existing 50 MSP outlet overrides live here; migration rewrites them in place.
- `.claude/max-objects/msp/objects.json` (read-only this phase) — extracted MSP DB; the digest source for the classifier; the canonical name list for the sweep.
- `.claude/max-objects/mc/objects.json` (read-only this phase) — extracted MC DB; the canonical name list for plan 30-04.
- `tests/conftest.py` — `all_objects`, `objects_by_domain`, schema-extension fixtures from Phase 28.
- `tests/test_schema_extensions.py` — class structure and fixture conventions to mirror for `tests/test_audit_signal_role.py`.
- `tests/test_inlet_types.py::TestMSPSignalInlets::test_tilde_objects_have_signal_io` — Phase 28's deferred test; passes as a side-effect of plan 30-04.

### Convention References
- `CLAUDE.md` §"How to Use the Database" — `lookup_strict()` rationale, empty-IO caveat. The new audit fn extends the same diagnostic family.
- `CLAUDE.md` §"Domain-Specific Rules → MSP" — semantics of MSP signal-rate vs control outlets; informs the digest classifier's keyword maps.
- `CLAUDE.md` §"PD Confusion Guard" — informs `signal_role` choices for the MAX equivalents.

</canonical_refs>

<code_context>
## Existing Code Insights

### Reusable Assets
- **`audit_empty_io` / `audit_install_coverage` / `audit_domain_coverage` (db_lookup.py:819–918)** — exact siblings for the new `audit_signal_role_coverage()`. Same `dict[str, list[str]]`-ish shape (extended to nested per-domain), same sorted-list return convention, same per-canonical iteration pattern.
- **`_apply_signal_role_writethrough()` (Phase 28, in `_load`)** — projects `signal_role` → `signal: bool` automatically. This is what makes the migration safe: dropping `signal: bool` from `overrides.json` is a no-op for downstream consumers because the projection re-materializes it at load time.
- **Existing 50 MSP outlet overrides in `overrides.json`** — already provide the structural template for what migrated entries look like. Migration replaces `{"id": 0, "type": "signal", "signal": true}` with `{"id": 0, "type": "signal", "signal_role": "audio"}` (loader projects `signal: true` back). 34 of these have mixed audio/control outlets — high-value targets for the role-aware validator.
- **Phase 28's `tests/test_schema_extensions.py`** — class structure (`TestSchemaValidation`, `TestSchemaGetters`, `TestAuditFunctions`) is the template for `TestAuditSignalRoleCoverage`, `TestSignalRoleMigration`.

### Established Patterns
- **All schema population lives in `overrides.json`** (Phase 28 D-14) — no new files in `.claude/max-objects/`.
- **Curator writes one field, loader derives the other** (Phase 28 D-01/D-03) — the `signal_role` → `signal: bool` projection is the back-compat backbone Phase 30 leans on.
- **Per-domain JSON files are read-only** for schema work — Phase 30's MC sweep adds entries to `overrides.json`, never touches `mc/objects.json`.
- **Audit functions are pure read-only** — no mutation, no warnings emitted (those happen in `_maybe_warn_*` helpers per Phase 29 D-09). The new `audit_signal_role_coverage()` follows.
- **Closed enums are loader-validated** (Phase 28 D-04 / D-15) — adding new `signal_role` values to overrides automatically gets rejected by `_validate_schema_extensions()` if mistyped. The classifier MUST emit only the six canonical roles.

### Integration Points
- **No new Python modules in `src/maxpat/`** — `audit_signal_role_coverage()` slots into existing `db_lookup.py`. Audit script is standalone under `scripts/`.
- **No new files in `.claude/max-objects/`** — only `overrides.json` is mutated.
- **No public API additions** outside `ObjectDatabase.audit_signal_role_coverage()` and the standalone `scripts/audit_signal_role.py` CLI.
- **Existing 21+ tests in `tests/test_validation.py`, `tests/test_object_schema.py`, `tests/test_schema_extensions.py` MUST stay green.** Back-compat via `signal:bool` derivation (Phase 28 D-01) is the primary regression anchor.
- **Phase 29's role-aware validators stay unchanged** — they already consume `get_signal_role()`; Phase 30 just gives them more non-None data to work with.

</code_context>

<specifics>
## Specific Ideas

- The audit script's review-file row format: `| object | outlet_id | digest | suggested_role | confidence | curator_role |`. Curator edits only the last column.
- Three-tier confidence vocabulary (`high` / `medium` / `low`) maps directly to auto-apply behavior: high auto-applies silently; medium auto-applies with `# verify` marker; low forces curator entry. No numeric scores; no four-tier ceremony.
- The strict trigger/status keyword set: `bang`, `done`, `state`, `mute`, `flag`, `active`, `busy`. Anything else with control-rate semantics goes through the broad data/list synonym path.
- Sibling auto-mirror naming convention: strip `mc.` or `mcs.` prefix; if remaining name matches a known MSP object, inherit its roles outlet-by-outlet (positional). For objects where MC adds extra control outlets (e.g., `mcs.vst~` has 6 control outlets vs `vst~`'s 2), trailing extra outlets fall to the standard classifier.
- The new `audit_signal_role_coverage()` per-domain shape (`{msp: {...}, mc: {...}}`) is what gates the <20-per-domain success criterion; tests assert both keys exist and `gap_count` is computed from `len(uncovered)`.
- Plan ordering 30-01 → 30-02 → 30-03 → 30-04: infrastructure first, then existing-overrides migration (smallest data delta, proves the shim under real load), then unverified MSP population (largest data delta), then MC sweep (resolves Phase 28 deferred tests as bonus).
- The two known MSP entries that already have `signal_role` (`cycle~`, `snapshot~`) are the empirical baseline; the migration shape for the other 50 mirrors them exactly.

</specifics>

<deferred>
## Deferred Ideas

- **`verified_installed` population sweep across MSP/MC** — natural follow-on once `signal_role` coverage is in. Could be its own phase or fold into a v5.1 cleanup milestone.
- **`domain_restricted` annotations beyond explicit cases** (e.g., systematic auditing of every `rnbo/` object that might appear at MSP top level) — Phase 29 D-05 explicit-only stays in force; revisit if real-world false-negatives accumulate.
- **Jitter tilde `signal_role` coverage** — `jit.gen~` and friends could benefit from typed roles eventually; not urgent because Jitter validation is lighter-touch today.
- **Promoting the audit script to a milestone-level CI gate** — running `audit_signal_role_coverage()` in CI and failing the build on regression > N gaps. Nice-to-have once the baseline is solid.
- **Per-inlet `signal_role`** — Phase 28 explicitly capped at outlet roles; v6.0+.
- **Auto-extraction of `signal_role` from MAX refpages** during the next help-patch extraction pass — would reduce manual curation in future audits. Out of scope this phase.
- **Generic `audit_field_coverage(field_name)` helper** that subsumes `audit_signal_role_coverage`, `audit_install_coverage`, etc. — premature abstraction; revisit only if a fourth `audit_*` function appears.

</deferred>

---

*Phase: 30-msp-outlet-coverage-sweep*
*Context gathered: 2026-04-29*
