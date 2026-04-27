# Deferred Items — quick-260427-kbe

Out-of-scope discoveries logged during execution. Not fixed; flagged for future
work per SCOPE BOUNDARY rule (only auto-fix issues directly caused by the
current task's changes).

## Pre-existing test failure (unrelated to fan-out severity promotion)

**Test:** `tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning`

**Symptom:**
```
AssertionError: Expected community extraction warning, got: []
```

**Why deferred:**
- Test exercises `review_packages` (package_critic.py), not `review_structure`
- My change is confined to `structure_critic.py:143` (severity literal) and its
  docstring; cannot influence `review_packages` results
- Failure exists on the base commit (37c2627) — present before this task started

**Verification path:** `git checkout 37c2627 -- src/maxpat/critics/structure_critic.py tests/test_critics.py && python3 -m pytest tests/test_critics.py::TestPackageCritic::test_community_unextracted_warning -v`
(do NOT actually run this — destructive to working tree; use a separate worktree
if the regression must be confirmed empirically)

**Suggested follow-up:** Open a separate quick task to investigate why FluCoMa
objects no longer trigger the "unextracted" warning path in package_critic. Likely
candidates: `db.lookup` now returns the entry with extracted metadata, or the
warning emit path was refactored without updating the test.
