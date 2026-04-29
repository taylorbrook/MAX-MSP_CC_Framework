# Deferred Items — Phase 29 (Validator Depth)

Out-of-scope discoveries logged during plan execution. Per Rule 3 scope boundary,
these are NOT fixed during the current plan.

## Plan 29-03 (role-aware tier dispatch)

### Pre-existing test failures (not introduced by this plan)

- `tests/test_validation.py::TestCommunityPackageBlock::test_community_block_warning`
- `tests/test_validation.py::TestCommunityPackageBlock::test_ircam_spat_specific_message`

Both fail on the base commit `427a21e0deb8a5ecd486d59cdac00d26cbb7e159`
before any Plan 29-03 changes. Verified by stashing Plan 29-03 edits and
running the tests against the unchanged base. Likely cause: package_info.json
state for community packages no longer matches the asserts (extracted flag
flip or message rewording in an earlier phase). Not in this plan's surface.
