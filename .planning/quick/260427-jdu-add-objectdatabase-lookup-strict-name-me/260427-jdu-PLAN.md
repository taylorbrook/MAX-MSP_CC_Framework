---
phase: quick-260427-jdu
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/db_lookup.py
  - tests/test_db_lookup.py
autonomous: true
requirements:
  - JDU-01  # Add ObjectDatabase.lookup_strict(name) returning None for empty-I/O entries (no variable_io_rule)
  - JDU-02  # Preserve existing lookup() semantics unchanged
  - JDU-03  # Cover behavior with 3-4 unit tests matching existing test_db_lookup.py style

must_haves:
  truths:
    - "ObjectDatabase.lookup_strict('cycle~') returns the cycle~ object dict (normal hit)"
    - "ObjectDatabase.lookup_strict('dsp') returns None (DB entry has empty inlets and empty outlets, no variable_io_rule)"
    - "ObjectDatabase.lookup_strict('trigger') returns the trigger object dict (variable_io_rule present, even when defaults are empty)"
    - "ObjectDatabase.lookup_strict('__does_not_exist__') returns None (unknown name)"
    - "ObjectDatabase.lookup() behavior is byte-identical to before (regression-free)"
    - "lookup_strict resolves aliases (e.g., 't' -> 'trigger')"
  artifacts:
    - path: "src/maxpat/db_lookup.py"
      provides: "ObjectDatabase.lookup_strict() method"
      contains: "def lookup_strict"
    - path: "tests/test_db_lookup.py"
      provides: "Unit tests covering lookup_strict cases (a) normal hit, (b) empty-I/O returns None, (c) variable_io entry returns object"
      contains: "lookup_strict"
  key_links:
    - from: "src/maxpat/db_lookup.py:lookup_strict"
      to: "src/maxpat/db_lookup.py:lookup"
      via: "delegation — lookup_strict calls lookup() then applies the empty-I/O guard"
      pattern: "self\\.lookup\\("
    - from: "src/maxpat/db_lookup.py:lookup_strict"
      to: "self._variable_io_rules"
      via: "exemption check — variable_io entries pass through even with empty default I/O"
      pattern: "_variable_io_rules"
    - from: "tests/test_db_lookup.py"
      to: "src/maxpat/db_lookup.py:lookup_strict"
      via: "import + call"
      pattern: "lookup_strict"
---

<objective>
Add `ObjectDatabase.lookup_strict(name, *, allowed_packages=None)` that returns `None` for DB entries with empty `inlets` AND empty `outlets` AND no `variable_io_rule`. This lets patch builders fail fast at lookup time instead of receiving a "successful" hit that has no usable I/O schema (the silent-connection-failure class of bug documented in 260427-hox FINDINGS P1-2).

Purpose: Plug the gap where `lookup()` returns empty-I/O entries indistinguishable from valid hits. Callers wanting strict semantics (most patch-builder code paths) get the strict API; callers wanting inspection (audits, diagnostics) keep `lookup()`.

Output: New method + unit test coverage. No call-site migrations in this task — it's purely additive.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
</execution_context>

<context>
@CLAUDE.md
@.planning/STATE.md
@.planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-FINDINGS.md

<interfaces>
<!-- Key state and methods on ObjectDatabase that lookup_strict will use. Extracted from src/maxpat/db_lookup.py — executor should NOT need to re-explore. -->

From src/maxpat/db_lookup.py (already loaded — DO NOT re-read):

```python
class ObjectDatabase:
    # Internal state populated by _load():
    self._objects: dict[str, dict]            # canonical name -> object entry
    self._aliases: dict[str, str]             # alias -> canonical
    self._variable_io_rules: dict[str, dict]  # canonical -> rule (registry of dynamic-I/O objects)

    # Existing methods (DO NOT MODIFY):
    def lookup(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
        """Returns object dict or None. Resolves aliases. Filters by package. Emits one-time
        UserWarning via _maybe_warn_empty_io for empty-I/O entries (but still returns them)."""

    def has_complete_io(self, name: str) -> bool:
        """Returns True if (canonical in _variable_io_rules) OR (inlets AND outlets both populated).
        This is exactly the predicate lookup_strict needs in inverted form."""
```

The `has_complete_io()` predicate is the precise condition for lookup_strict's "should I return this?" gate. The new method MUST delegate to `lookup()` (to preserve aliasing, package filtering, and the existing warning behavior) then apply the empty-I/O guard.

DB entries used by existing tests (stable, do NOT need re-discovery):
- `"cycle~"` — normal hit, populated I/O, not in variable_io_rules
- `"dsp"` — stable empty-I/O entry in max/objects.json (no variable_io_rule). Used by test_has_complete_io_false_for_empty_entry.
- `"trigger"` — has variable_io_rule. Today defaults are populated; the rule entry is what matters.
- `"t"` — alias for `"trigger"` (used to verify alias resolution).

Test style (from tests/test_db_lookup.py):
- One assertion per test
- Tests instantiate `db = ObjectDatabase()` directly (no fixtures)
- `from src.maxpat.db_lookup import ObjectDatabase`
- Section comments use box-drawing chars: `# ── section name ──`
- Use monkey-patched `db._objects[...]` + `db._variable_io_rules[...]` to inject synthetic empty-I/O-with-variable_io_rule case (see test_has_complete_io_respects_variable_io_exemption for exact pattern at line 56-75).
</interfaces>
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add ObjectDatabase.lookup_strict() method</name>
  <files>src/maxpat/db_lookup.py</files>
  <behavior>
    - lookup_strict("cycle~") returns the cycle~ object dict (normal hit, populated I/O)
    - lookup_strict("dsp") returns None (empty I/O, no variable_io_rule)
    - lookup_strict("trigger") returns the trigger object dict (has variable_io_rule, even though tested via injected empty-I/O entry as well)
    - lookup_strict("t") returns the trigger object (alias resolution preserved)
    - lookup_strict("__does_not_exist__") returns None
    - lookup_strict honors allowed_packages parameter identically to lookup()
    - Existing lookup() behavior is unchanged
  </behavior>
  <action>
    Add a new method `lookup_strict` to the `ObjectDatabase` class in `src/maxpat/db_lookup.py`, placed immediately AFTER the existing `lookup()` method (before `_maybe_warn_empty_io`). Implementation:

    ```python
    def lookup_strict(self, name: str, *, allowed_packages: list[str] | None = None) -> dict | None:
        """Look up an object by name, returning None for unusable empty-I/O entries.

        Stricter variant of `lookup()` for patch-builder call sites that need
        to fail fast. An entry is treated as "not found" when BOTH `inlets`
        and `outlets` are empty AND there is no `variable_io_rules` entry
        for the canonical name — i.e., when the entry has no usable I/O
        schema and is not a dynamically-sized object.

        Variable-I/O objects (e.g., `trigger`, `pack`, `route`) are returned
        even when their static `inlets`/`outlets` arrays are empty, because
        their I/O is computed from arguments at runtime via
        `compute_io_counts()`.

        Aliases, package filtering, and the one-time empty-I/O UserWarning
        emitted by `lookup()` are preserved (this method delegates to
        `lookup()` for those concerns).

        Args:
            name: Object name or alias.
            allowed_packages: Package filter, identical to lookup().

        Returns:
            Object dict, or None if not found, filtered out, or empty-I/O
            without a variable_io_rules exemption.
        """
        obj = self.lookup(name, allowed_packages=allowed_packages)
        if obj is None:
            return None
        canonical = self._aliases.get(name, name)
        if canonical in self._variable_io_rules:
            return obj
        if obj.get("inlets") and obj.get("outlets"):
            return obj
        return None
    ```

    Do NOT modify `lookup()`, `_maybe_warn_empty_io()`, or any other method. Do NOT change the warning behavior — `lookup()` still emits the empty-I/O UserWarning, and `lookup_strict` inherits it via delegation (acceptable: callers learn about the data-quality issue AND get the strict None return).

    Rationale for the predicate (matches `has_complete_io()` semantics inverted): the `variable_io_rules` membership check is the authoritative exemption — DB entries that are dynamically sized may legitimately ship with empty default arrays, and inferring exemption from the `variable_io` boolean field on the object would be a redundant second source of truth.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX &amp;&amp; python -c "from src.maxpat.db_lookup import ObjectDatabase; db = ObjectDatabase(); assert db.lookup_strict('cycle~') is not None; assert db.lookup_strict('dsp') is None; assert db.lookup_strict('trigger') is not None; assert db.lookup_strict('t') is not None; assert db.lookup_strict('__nope__') is None; print('OK')"</automated>
  </verify>
  <done>
    `lookup_strict` method exists on ObjectDatabase, returns None for `"dsp"`, returns objects for `"cycle~"` / `"trigger"` / `"t"`, returns None for unknown names. `lookup()` is byte-identical to its prior implementation.
  </done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Add unit tests for lookup_strict</name>
  <files>tests/test_db_lookup.py</files>
  <behavior>
    - test_lookup_strict_returns_object_for_normal_hit: `lookup_strict("cycle~")` returns dict, name == "cycle~"
    - test_lookup_strict_returns_none_for_empty_io_entry: `lookup_strict("dsp")` returns None (and lookup("dsp") still returns the object — proves they diverge as designed)
    - test_lookup_strict_returns_object_for_variable_io_with_empty_defaults: monkey-patch a synthetic empty-I/O entry with a variable_io_rule, assert lookup_strict returns it (mirrors the test_has_complete_io_respects_variable_io_exemption pattern at line 56-75)
    - test_lookup_strict_resolves_alias: `lookup_strict("t")` returns the trigger object
  </behavior>
  <action>
    Append a new test section to `tests/test_db_lookup.py`. Place it immediately AFTER the `# ── lookup() warning behavior ──` block (after `test_lookup_does_not_warn_when_package_filtered`, around line 152) and BEFORE `# ── audit_empty_io() ──`. Match existing style exactly: section header with box-drawing chars, one assertion per test (multiple are OK when they reinforce one behavior), no fixtures, direct `db = ObjectDatabase()` instantiation.

    Tests to add:

    ```python
    # ── lookup_strict() ─────────────────────────────────────────────

    def test_lookup_strict_returns_object_for_normal_hit():
        db = ObjectDatabase()
        result = db.lookup_strict("cycle~")
        assert result is not None
        assert result["name"] == "cycle~"


    def test_lookup_strict_returns_none_for_empty_io_entry():
        """'dsp' is the same stable empty-I/O canary used by has_complete_io
        tests above. lookup() still returns it (with a UserWarning); the
        strict variant must return None so callers fail fast."""
        db = ObjectDatabase()
        # Suppress the expected one-time UserWarning from the lookup()
        # delegation — it's the documented behavior, not what this test guards.
        with warnings.catch_warnings():
            warnings.simplefilter("ignore", UserWarning)
            assert db.lookup("dsp") is not None  # baseline: lookup still hits
            assert db.lookup_strict("dsp") is None  # strict variant rejects


    def test_lookup_strict_returns_object_for_variable_io_with_empty_defaults():
        """Defensive variable_io exemption: an entry with empty default I/O
        but a variable_io_rules registration is a legitimate dynamically-
        sized object (its real I/O is computed by compute_io_counts at
        connection time). Must NOT be rejected.

        Real DB has no such entry today (every variable_io_rules target ships
        with populated defaults), so we inject one — same pattern as
        test_has_complete_io_respects_variable_io_exemption."""
        db = ObjectDatabase()
        db._objects["__test_var_io_strict__"] = {
            "name": "__test_var_io_strict__",
            "inlets": [],
            "outlets": [],
        }
        db._variable_io_rules["__test_var_io_strict__"] = {
            "inlet_count": "arg_count",
            "outlet_count": "arg_count",
        }
        result = db.lookup_strict("__test_var_io_strict__")
        assert result is not None
        assert result["name"] == "__test_var_io_strict__"


    def test_lookup_strict_resolves_alias():
        """t -> trigger; lookup_strict must use the same alias map as lookup()."""
        db = ObjectDatabase()
        result = db.lookup_strict("t")
        assert result is not None
        assert result["name"] == "trigger"
    ```

    The `warnings` module is already imported at the top of the file (line 15) — do NOT re-import.

    Do NOT modify or remove any existing tests. Do NOT alter section ordering of pre-existing blocks.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX &amp;&amp; python -m pytest tests/test_db_lookup.py -k lookup_strict -v</automated>
  </verify>
  <done>
    All four `lookup_strict` tests pass. Full `tests/test_db_lookup.py` suite still passes (no regressions in pre-existing tests).
  </done>
</task>

</tasks>

<verification>
Run the full test file to prove no regressions in `lookup()`, `has_complete_io()`, `audit_empty_io()`, `compute_io_counts()`, or `get_outlet_types()`:

```bash
cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_db_lookup.py -v
```

Expected: all pre-existing tests pass + 4 new lookup_strict tests pass.

Sanity-check that `lookup()` was not touched (the diff for `lookup()` itself should be zero lines):

```bash
cd /Users/taylorbrook/Dev/MAX && git diff src/maxpat/db_lookup.py | grep -E '^[+-]' | grep -v '^[+-]{3}' | grep -v 'lookup_strict\|"""\|^\+#\|^\+ *$' | head -50
```

The output should show only additions inside the new `lookup_strict` method body and docstring — no edits to existing lines.
</verification>

<success_criteria>
- `ObjectDatabase.lookup_strict(name, *, allowed_packages=None)` exists and behaves per the must_haves truths
- `ObjectDatabase.lookup()` is unchanged (no diff lines outside the new method block)
- 4 new tests in `tests/test_db_lookup.py` pass
- Pre-existing `tests/test_db_lookup.py` suite continues to pass (no regressions)
</success_criteria>

<output>
After completion, create `.planning/quick/260427-jdu-add-objectdatabase-lookup-strict-name-me/260427-jdu-SUMMARY.md` documenting:
- Final method signature
- The exact predicate used (variable_io_rules membership OR populated inlets+outlets)
- Test additions
- Confirmation that `lookup()` was not modified
- Recommended follow-up (NOT in scope for this task): migrate patch-builder call sites from `lookup()` to `lookup_strict()` — track as a separate quick task per FINDINGS P1-2.
</output>
