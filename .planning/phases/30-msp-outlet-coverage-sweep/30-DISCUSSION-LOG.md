# Phase 30: MSP Outlet Coverage Sweep - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md — this log preserves the alternatives considered.

**Date:** 2026-04-29
**Phase:** 30-msp-outlet-coverage-sweep
**Areas discussed:** Curation Strategy, Audit Taxonomy + Output, Coverage Scope, audit_signal_role_coverage + Batching

---

## Curation Strategy

### Q1: How should signal_role values get assigned to the ~80 unverified MSP objects + the 50 outlet-override migrations?

| Option | Description | Selected |
|--------|-------------|----------|
| Hybrid auto/manual (Recommended) | Audit script auto-suggests roles by digest keyword. High-confidence matches (bang→trigger, signal:true→audio, list→list) auto-apply; ambiguous "other" digests (~65 outlets) flagged in a review file for manual roles. | ✓ |
| Manual per-digest | Read each object's digest by hand and assign roles. Slow but zero false positives. | |
| Pure heuristic auto | Run the classifier across all candidates and commit the output verbatim. Fastest but the 65 "other" digests leave many outlets as None. | |

**User's choice:** Hybrid auto/manual (Recommended)

### Q2: What's the human-review surface for the ambiguous 'other' digests?

| Option | Description | Selected |
|--------|-------------|----------|
| Review file the script writes (Recommended) | Markdown table at .planning/phases/30-.../SIGNAL-ROLE-REVIEW.md (object/outlet/digest/suggested_role/confidence). Curator edits in place; follow-up script applies. | ✓ |
| Direct overrides.json edit | Script writes auto-applied roles with TODO comments next to ambiguous outlets. | |
| Interactive CLI prompt | Script runs interactively with stdin per-outlet. | |

**User's choice:** Review file the script writes (Recommended)

### Q3: When auto-applying high-confidence roles, drop the legacy `signal: bool` field from the override?

| Option | Description | Selected |
|--------|-------------|----------|
| Yes, drop signal: bool (Recommended) | Phase 28 D-03: single source of truth is signal_role; loader projects bool back. | ✓ |
| Keep both during migration | Transitional safety; cleanup later. | |
| Drop bool only on roles ≠ audio | Mostly cosmetic. | |

**User's choice:** Yes, drop signal: bool (Recommended)

### Q4: Conflict policy when signal:true outlet's digest implies a control role (e.g. stash~ "Index (signal)")?

| Option | Description | Selected |
|--------|-------------|----------|
| signal:true wins, role=audio (Recommended) | Trust the structured field over the prose; mismatches are vanishingly rare. | ✓ |
| Digest wins, flag conflict | Override signal:true to control role; route to review as CONFLICT. | |
| Both possible, leave None | Classifier abstains. | |

**User's choice:** signal:true wins, role=audio (Recommended)

---

## Audit Taxonomy + Output

### Q1: How aggressive should the digest-keyword classifier be?

| Option | Description | Selected |
|--------|-------------|----------|
| Hybrid — strict triggers, broad data (Recommended) | Strict regex for trigger/status; broad synonyms for data/list. Drops "other" from 65 to ~25. | ✓ |
| Conservative | Only obvious matches. Highest precision, biggest review pile. | |
| Aggressive synonyms across all roles | Broad maps for every role. Lowest "other" count but risks misclassifying status as data. | |

**User's choice:** Hybrid — strict triggers, broad data (Recommended)

### Q2: Where should the audit script's output live?

| Option | Description | Selected |
|--------|-------------|----------|
| Both md + json under .planning/phases/30 (Recommended) | SIGNAL-ROLE-REVIEW.md (human review) + signal-role-audit.json (machine snapshot for drift). | ✓ |
| Md only in phase dir | Single review file, no machine snapshot. | |
| JSON in .claude/max-objects/_audit/ | Sibling to extraction-log.json. Outside the phase folder. | |

**User's choice:** Both md + json under .planning/phases/30 (Recommended)

### Q3: Where does the audit/migration script itself live?

| Option | Description | Selected |
|--------|-------------|----------|
| scripts/audit_signal_role.py (Recommended) | Standalone CLI; same pattern as other one-off DB tooling. | ✓ |
| tools/db_audit/signal_role.py | New tools/ subtree for future audits. | |
| Inline in src/maxpat/db_lookup.py via __main__ | Bloats db_lookup.py with CLI argparse. | |

**User's choice:** scripts/audit_signal_role.py (Recommended)

### Q4: What confidence levels should the audit script emit alongside its suggestions?

| Option | Description | Selected |
|--------|-------------|----------|
| Three tiers: high / medium / low (Recommended) | high=signal:true or strict trigger; medium=broad data/list; low=other digests force into review. | ✓ |
| Binary: confident / needs-review | Simpler but loses signal about which auto-applied items deserve a sanity check. | |
| Score 0.0–1.0 | Numeric score with threshold gating. More flexible long-term but no clear handle. | |

**User's choice:** Three tiers: high / medium / low (Recommended)

---

## Coverage Scope

### Q1: Which domains does the sweep populate signal_role across?

| Option | Description | Selected |
|--------|-------------|----------|
| MSP only — strict (Recommended) | msp/objects.json only, matching roadmap title. MC gaps deferred. | |
| MSP + MC tildes | Pull in mc.* and mcs.* tildes. Resolves Phase 28 deferred MC test failures. | ✓ |
| MSP + MC + Jitter tildes | Maximum coverage but stretches the phase past its named scope. | |

**User's choice:** MSP + MC tildes (overrode the recommended option)
**Notes:** User explicitly opted into MC scope so Phase 28's deferred MC tilde test failures get resolved as a side-effect.

### Q2: How does the success-criterion threshold ("<20 remaining MSP gaps") apply when MC is in scope?

| Option | Description | Selected |
|--------|-------------|----------|
| <20 MSP + <20 MC reported separately (Recommended) | Per-domain accountability. Matches MSPCOV-05 literal text + adds explicit MC gate. | ✓ |
| <20 combined across MSP+MC | Pooled. Lets MC slip if MSP overshoots. | |
| <20 MSP only, MC best-effort | MC tracked but ungated. | |

**User's choice:** <20 MSP + <20 MC reported separately (Recommended)

### Q3: Should MC variants auto-mirror their bare-MSP sibling's roles?

| Option | Description | Selected |
|--------|-------------|----------|
| Auto-mirror with override allowed (Recommended) | Inherit sibling roles by name match; flag 'inherited'; curator may override per outlet. | ✓ |
| No mirroring — classify each MC object independently | Slower, no risk of inheriting wrong role. | |
| Auto-mirror + lock | Fastest, but loses fidelity for divergent objects. | |

**User's choice:** Auto-mirror with override allowed (Recommended)

### Q4: Should the audit/migration also touch verified_installed while it's running across MSP/MC?

| Option | Description | Selected |
|--------|-------------|----------|
| signal_role only (Recommended) | Tightly scoped; other field sweeps deferred. | ✓ |
| signal_role + verified_installed pass-through | Stamp verified_installed=true opportunistically. Risks miscalibrating Phase 29 install warning. | |
| All three fields opportunistically | Maximum coverage; blurs phase boundaries. | |

**User's choice:** signal_role only (Recommended)

---

## audit_signal_role_coverage + Batching

### Q1: What shape should `audit_signal_role_coverage()` return?

| Option | Description | Selected |
|--------|-------------|----------|
| Per-domain bucketed counts + lists (Recommended) | {msp:{covered,uncovered,by_role,gap_count}, mc:{...}}. Matches per-domain <20 gate. | ✓ |
| Symmetric with audit_install_coverage | {audited, unaudited}. Simplest; doesn't track per-domain. | |
| Flat with suggested roles inline | {covered, uncovered:[{name,outlet_id,suggested_role,confidence}]}. Couples audit fn to classifier. | |

**User's choice:** Per-domain bucketed counts + lists (Recommended)

### Q2: How should the migration land as commits / PRs?

| Option | Description | Selected |
|--------|-------------|----------|
| Plan-aligned batches (Recommended) | 4 plans: audit infra → existing-overrides migration → unverified MSP population → MC sweep. | ✓ |
| One atomic PR | Easy to revert; harder to review. | |
| Per-confidence tiers | Plans aligned to classifier output rather than logical work units. | |

**User's choice:** Plan-aligned batches (Recommended)

### Q3: What test coverage should land alongside the new audit function and the migrations?

| Option | Description | Selected |
|--------|-------------|----------|
| Audit fn unit tests + migration regression tests (Recommended) | test_audit_signal_role.py for shape; test_signal_role_migration.py asserts no regressions in patcher.py:250 / dsp_critic.py:301 via back-compat shim. | ✓ |
| Just audit fn unit tests | Trust Phase 28's shim tests; smaller surface. | |
| End-to-end on real generated patches | Couples to flaky integration-patch fixtures. | |

**User's choice:** Audit fn unit tests + migration regression tests (Recommended)

### Q4: Should Phase 30 also resolve Phase 28's deferred MC tilde test failures?

| Option | Description | Selected |
|--------|-------------|----------|
| Yes — fold into 30-04 (Recommended) | MC sweep already touches the same overrides; loader projection re-stamps signal:true automatically. Closes the loop on Phase 28 deferred-items.md. | ✓ |
| No — stay strictly on signal_role coverage | Leaves known-broken tests in the suite. | |
| Resolve only on objects already touched for signal_role | Middle ground. | |

**User's choice:** Yes — fold into 30-04 (Recommended)

---

## Claude's Discretion

- Exact apply-step shape (`--apply` flag vs separate `apply_signal_role.py`)
- Review-file table format (pipe-delimited markdown vs YAML front-matter)
- Whether the digest classifier promotes from `scripts/` to `src/maxpat/audit/`
- Exact ordering of Plans 30-02 / 30-03
- Whether to add CLAUDE.md guidance about running the audit script periodically
- Whether `gap_count` is its own field or derived from `len(uncovered)` at call sites

## Deferred Ideas

- `verified_installed` population sweep across MSP/MC — future phase
- `domain_restricted` annotations beyond explicit cases — future phase if false-negatives accumulate
- Jitter tilde `signal_role` coverage — future phase if real cases emerge
- Promoting the audit script to a milestone-level CI gate
- Per-inlet `signal_role` — v6.0+
- Auto-extraction of `signal_role` from MAX refpages during next help-patch extraction
- Generic `audit_field_coverage(field_name)` helper — premature abstraction
