# Deferred Items — quick-260921-knq

Out-of-scope discoveries surfaced by the new `tools/audit_db.py`. Not fixed
here per the executor scope boundary (pre-existing, unrelated to this task's
changes). Each is a genuine finding the harness is designed to surface.

## DEF-knq-01 — `tests/fixtures/expected/gen_codebox.maxpat` uses the invalid `maxclass: "gen~"` form

**Surfaced by:** `sections.ui_maxclasses_gap` — the single residual maxclass on
the current tree is `gen~`, attributed to `tests/fixtures/expected/gen_codebox.maxpat`.

**Finding:** that fixture's first box is `{"maxclass": "gen~", "id": "obj-1"}`
with no `text` field. Per CLAUDE.md ("The `maxclass` field in the DB is NOT
authoritative"), `gen~` is a `newobj` with `gen~` in `text`; setting `maxclass`
to a non-UI name causes "invalid attribute maxclass" errors at load.

**Not a live bug in the builder.** Verified: `Patcher().add_gen(...)` emits
`{"maxclass": "newobj", "text": "gen~"}` — the correct form. The defect is
confined to the hand-written expected-output fixture.

**Suggested fix:** correct the fixture to the `newobj`/`text` form, or, if the
fixture is unreferenced, delete it. `grep -rn gen_codebox tests/` found no
Python test referencing it, so it may be dead.

**Why deferred:** `tests/fixtures/` is outside this task's `files_modified`
(`tools/audit_db.py`, `tests/test_audit_db.py`), and editing an expected-output
fixture risks a regression in a suite this task must leave baseline-identical.
