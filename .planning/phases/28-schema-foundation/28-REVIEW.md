---
phase: 28-schema-foundation
reviewed: 2026-04-27T00:00:00Z
depth: standard
files_reviewed: 3
files_reviewed_list:
  - src/maxpat/db_lookup.py
  - .claude/max-objects/overrides.json
  - tests/test_schema_extensions.py
findings:
  critical: 0
  warning: 0
  info: 5
  total: 5
status: issues_found
---

# Phase 28: Code Review Report

**Reviewed:** 2026-04-27
**Depth:** standard
**Files Reviewed:** 3
**Status:** issues_found (info-only — no bugs, no security issues)

## Summary

Phase 28 introduces three typed schema-extension fields (`signal_role`,
`domain_restricted`, `verified_installed`), five public getters, and three
audit functions, plus comprehensive tests. The implementation is clean,
well-commented, and consistent with the established `_validate_variable_io_rules`
fail-fast precedent (quick-260421-b3a). Cross-references to design decisions
(D-01 through D-15) are tight and the closed-enum sets mirror canonical
patterns elsewhere in the file.

No critical or warning-level findings. Five info-level observations follow,
all minor (dead-code parameter, multi-domain audit conservatism, missing
defensive checks for malformed JSON shape, an unused fixture parameter, and
a documentation gap on the in-place mutation contract). None are blockers
for Phase 29.

Strengths worth calling out:

- Strict-bool check (`type(value) is bool`) on `verified_installed` correctly
  rejects `1`/`0`, with an inline comment explaining the rationale. This is
  exactly the right decision given Python's int/bool subclass relationship.
- `get_domain_restrictions()` returns `list(...)` (a fresh copy), so callers
  cannot mutate the underlying schema. Test `test_get_domain_restrictions_returns_list_copy`
  pins this behavior.
- Validation-then-writethrough ordering is enforced and documented (line 162-170).
  The writethrough only runs after validation, so `role == "audio"` cannot
  inject typos.
- The reverse-derivation in `get_signal_role()` (D-02) correctly distinguishes
  "uncurated" (None) from "curated as non-audio" (`status`/`float`/etc.),
  enabling Phase 29 validators to fall back to the bool check without
  emitting false positives.

## Info

### IN-01: Unused `all_objects` fixture parameter in TestWriteThrough

**File:** `tests/test_schema_extensions.py:237`
**Issue:** `test_no_signal_role_preserves_legacy_signal(self, all_objects)`
declares the `all_objects` session fixture as a parameter but never reads
it — the test body instantiates `ObjectDatabase()` directly and looks up
`phasor~` through that instance. The fixture parameter is dead.
**Fix:** Either drop the parameter:

```python
def test_no_signal_role_preserves_legacy_signal(self):
    db = ObjectDatabase()
    obj = db.lookup("phasor~")
    ...
```

or actually iterate `all_objects` to scan ALL outlets (which would more
accurately implement the "2,015-object regression anchor" the docstring
promises). The current single-`phasor~` probe doesn't truly anchor the
regression for all 2,015 readers — it only confirms one bare-signal
outlet survives. Iterating `all_objects` to assert "every outlet without
`signal_role` retains its original `signal` value" would be a stronger
guarantee, at the cost of needing a pre-load snapshot to compare against.

### IN-02: `audit_domain_coverage()` over-flags multi-domain restrictions

**File:** `src/maxpat/db_lookup.py:836-867`
**Issue:** The audit treats an object as orphaned if ANY listed restriction
fails to match `obj['domain']`. For an object with
`domain_restricted: ["rnbo", "m4l"]`, the canonical entry can only live in
ONE domain JSON file, so at least one restriction will always appear
"orphaned" — the object would be reported even when it's legitimately
flagged as RNBO-AND-M4L compatible.

Today no object uses multi-domain restrictions (only `floor~` with
`["rnbo"]`), so the bug is dormant. But the code path at line 856-864
will misreport as soon as a curator writes
`domain_restricted: ["rnbo", "m4l"]`.
**Fix:** Either:

1. Document the audit semantic as "one canonical entry per object, so
   multi-domain restrictions are by construction always flagged" — and
   reject multi-domain lists at validation time.
2. Or change the semantic to "report only when NONE of the listed
   restrictions match `obj['domain']`":

```python
for restricted_to in restrictions:
    expected_field = _DOMAIN_TO_FIELD.get(restricted_to)
    if expected_field is None:
        continue
    if obj_domain == expected_field:
        break
else:
    # No restriction matched -> orphan
    no_coverage.append(canonical)
```

Recommend option 2 (matches the docstring intent of "coverage gap").

### IN-03: `_validate_schema_extensions()` assumes outlet entries are dicts

**File:** `src/maxpat/db_lookup.py:233-242`
**Issue:** `for i, outlet in enumerate(obj.get("outlets", []))` followed by
`if "signal_role" not in outlet` will raise `TypeError: argument of type
'X' is not iterable` if a curator accidentally writes `outlets: [null, ...]`
or `outlets: ["audio", "trigger"]` in JSON. The current data shape is
always a list-of-dicts, but the validator's own `domain_restricted` check
(line 247) defensively checks `isinstance(value, list)` — the per-outlet
loop should be similarly defensive given this is a fail-fast validator.
**Fix:** Add a type guard:

```python
for i, outlet in enumerate(obj.get("outlets", [])):
    if not isinstance(outlet, dict):
        raise ValueError(
            f"outlets[{i}] on object {name!r} must be a dict, "
            f"got {type(outlet).__name__}: {outlet!r}"
        )
    if "signal_role" not in outlet:
        continue
    ...
```

Same guard applies to `_apply_signal_role_writethrough()` line 283
(`outlet.get("signal_role")` on a non-dict crashes the same way).

### IN-04: `_apply_signal_role_writethrough()` silently mutates loaded JSON

**File:** `src/maxpat/db_lookup.py:270-287`
**Issue:** The writethrough overwrites `outlet['signal']` in-place. This
is intentional (D-01 contract) and runs once at load time, BUT the
behavior isn't documented at the public method boundary — callers of
`db.lookup()` see `outlet['signal']` as a derived value when
`signal_role` is set, but nothing in the `lookup()` docstring tells them
this. If a future curator writes both `signal: false` AND
`signal_role: "audio"` in overrides.json (a valid combination per the
validator), the writethrough silently flips `signal` to `True`.

The fixture at overrides.json:2136-2151 (cycle~) is a real example — the
override sets only `signal_role: "audio"` and the loaded outlet ends up
with `signal: True` after writethrough. Test
`test_signal_role_audio_projects_true` confirms this.
**Fix:** Add a brief note to `lookup()` docstring (or a new `lookup()`
note section) explaining: "When an outlet has both `signal_role` and
`signal`, the loader projects `signal_role` onto `signal` at load time
— see `_apply_signal_role_writethrough`." Helps debuggers who see
mismatches between source JSON and runtime values.

### IN-05: `_make_db_root` test helper omits supplementary files

**File:** `tests/test_schema_extensions.py:37-72`
**Issue:** The isolated test DB only writes `msp/objects.json` and
`overrides.json`. It deliberately omits `aliases.json`, `pd-blocklist.json`,
and `package_info.json`. This is fine because the constructor uses
`if path.exists()` guards, but it makes the helper fragile — if a future
refactor changes those guards to required reads, every test built on
`_make_db_root` will fail with confusing errors instead of a clean
"missing file" message.

Additionally, the helper's docstring at line 38-47 says "The lone msp
object is the override target; only `cycle~` exists in this isolated DB
so any override entry must target it" — but the helper accepts arbitrary
override keys. Calling
`_make_db_root(tmp_path, {"nonexistent~": {"signal_role": "frobnitz"}})`
would silently succeed (the deep-merge skips unknown names at line 154)
and the validator would never fire on that entry.
**Fix:** Either tighten the helper to assert override keys exist in the
seed objects, or add a comment clarifying that override keys for
nonexistent objects are silently dropped (so future tests don't waste
time wondering why their bad-override doesn't raise).

---

_Reviewed: 2026-04-27_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
