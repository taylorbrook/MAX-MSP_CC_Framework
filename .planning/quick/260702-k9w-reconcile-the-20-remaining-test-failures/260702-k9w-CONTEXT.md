# Quick Task 260702-k9w: Reconcile remaining test failures — Context

**Gathered:** 2026-07-02
**Status:** Ready for planning

<domain>
## Task Boundary

Reconcile all remaining test failures so the suite is green. Actual count at task start: **24 failures** (not 20 as originally scoped):

1. **14× `test_review_patch_no_blockers`** — real Rule #3 fan-out violations in committed patches (gen-eq, gong-model, intelligent-corpus-remixer, kicksynth, minitaur, mixer-bus, comp-band, physics-composition, rhythmic-sampler ×2, scala-synth ×2, stutter, wormhole-test). Example: kicksynth has 8 blockers, mostly `prepend → gen~ + js` fan-outs.
2. **6× community-package tests** — behavior drift: `test_community_unextracted_warning`, `test_community_stubs_verified_false`, `test_community_stubs_signal_objects_have_signal_io`, `test_lookup_ears`, `test_community_block_warning`, `test_ircam_spat_specific_message`. Recent commits deliberately backfilled FluCoMa (verified=true, real I/O); tests still expect old stub-with-warnings behavior.
3. **4× `test_validate_patch_no_errors`** (scala-synth-voice, tape-wobble, timestretch, wormhole) — GenExpr codebox validator reports "Unknown GenExpr operator: 'DRIFT'/'EQ'/'LFO'/'ROLLOFF'/'SATURATION'/'SIGNAL'" — ALL-CAPS comment banners misparsed as operators. Validator false positive, not patch bugs.

</domain>

<decisions>
## Implementation Decisions

### Scope
- **Include all 24 failures.** The 4 `test_validate_patch_no_errors` failures are in scope; fix the GenExpr validator's comment-banner misparse (validator parser bug, not patch bugs). Suite must be green after.

### Fan-out blockers (14 patches)
- **Allowlist all 14 — do NOT edit committed patches.** Create a per-patch documented baseline/allowlist file that the critic/test consumes. Each entry must cite the specific fan-outs it exempts (patch path, source obj, outlet, destinations). New patches must still get blocked — the allowlist is scoped to existing documented debt only, not a global severity downgrade.

### Community-package tests (6)
- **Update tests to match current validation behavior.** The extracted FluCoMa DB (verified=true, real I/O) is intentional; rewrite tests to assert current behavior (verified stubs OK, no warning needed for extracted packages).
- **Exception — `test_lookup_ears`:** investigate separately. `db.lookup("ears.slice")` returning None may be a real gap; prefer adding the missing data/override over weakening the test, if ears objects were supposed to be in the DB.

### Claude's Discretion
- Exact allowlist file format/location and how the critic/test loads it.
- Root-cause fix approach for the GenExpr validator comment parsing (strip comments before tokenizing, or equivalent).
- Whether `test_lookup_ears` resolves via DB data restore or a justified test update (justify in SUMMARY if the latter).

</decisions>

<specifics>
## Specific Ideas

- User's frustration profile: regression. Zero edits to committed working `.maxpat` files is a hard constraint of the chosen approach.
- CLAUDE.md Rule #7: commit after every save; no `git stash`; no `git add -A`.
- Verify final state with a full `python3 -m pytest tests/ -q` run — must show 0 failed.

</specifics>

<canonical_refs>
## Canonical References

- `tests/test_integration_patches.py` — `test_review_patch_no_blockers`, `test_validate_patch_no_errors`
- `tests/test_package_schema.py::TestCommunityPackageStubs`, `tests/test_validation.py::TestCommunityPackageBlock`, `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning`
- CLAUDE.md Rules #3 (hot/cold ordering) and #4 (trigger fan-out) — the rules the critic enforces

</canonical_refs>
