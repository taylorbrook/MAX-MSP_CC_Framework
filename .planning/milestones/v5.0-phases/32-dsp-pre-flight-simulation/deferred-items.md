# Phase 32 Deferred Items

Out-of-scope discoveries logged during plan execution. Per execute-plan.md
SCOPE BOUNDARY rule: only auto-fix issues DIRECTLY caused by current task's
changes. The items below are pre-existing or unrelated and are NOT addressed
by Phase 32 plans.

## Plan 32-02 (worktree agent-aa806e46)

During post-task broader smoke check (`pytest tests/ --ignore=tests/dsp_sim -q`),
48 pre-existing test failures were observed. None touch `src/maxpat/dsp_sim/`
or `tests/dsp_sim/`. Failure categories (sample):

- `tests/test_integration_patches.py::test_review_patch_no_blockers[...]` -- integration patch reviews (scala-synth, stutter, wormhole)
- `tests/test_package_schema.py::TestCommunityPackageStubs::*` -- community package stub validation
- `tests/test_source_coverage.py::TestSourceCoverage::test_extraction_log_total` -- DB extraction-log totals
- `tests/test_validation.py::TestCommunityPackageBlock::*` -- community package warnings

These pre-existed before Phase 32 work began (worktree base = 8e09c18, the
"docs(32): create phase plan" commit). They are not caused by topology
library additions in plan 32-02.

Phase 32 plans modify only:
- `src/maxpat/dsp_sim/**` (new module)
- `tests/dsp_sim/**` (new tests)
- `.claude/skills/max-dsp-agent/SKILL.md` (plan 32-03; not 32-02)

No source files outside these scopes were modified by 32-02.
