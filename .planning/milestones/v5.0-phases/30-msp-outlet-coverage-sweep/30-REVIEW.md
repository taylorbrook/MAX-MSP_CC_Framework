---
phase: 30-msp-outlet-coverage-sweep
reviewed: 2026-04-29T00:00:00Z
depth: standard
files_reviewed: 6
files_reviewed_list:
  - src/maxpat/db_lookup.py
  - scripts/audit_signal_role.py
  - tests/test_audit_signal_role.py
  - tests/test_signal_role_migration.py
  - tests/test_schema_extensions.py
  - tests/test_inlet_types.py
findings:
  critical: 0
  warning: 4
  info: 5
  total: 9
status: medium
---

# Phase 30: Code Review Report

**Reviewed:** 2026-04-29
**Depth:** standard
**Files Reviewed:** 6
**Status:** issues_found (medium)

## Summary

The Phase 30 signal_role audit infrastructure is overall well-engineered: closed-enum loader validation, fail-fast on bad roles, path-traversal guard on `--apply`, atomic writes, idempotent re-runs, byte-stability test, and a thoughtful pipe-escape round-trip for digests with literal `|`. The classifier honors CONTEXT.md D-04 (`signal:true` wins) and D-05 lockdown (rejects unauthorized synonym tokens). Test coverage is broad with anchor tests pinning patcher.py:250 and dsp_critic.py:301 read patterns.

The most material issue is **WR-01**: `cmd_apply_run` synthesizes minimal outlet dicts (`{"id": N, "type": "", "digest": "", "signal_role": ...}`) for any object not already in `overrides.json`. Because the loader does a top-level key replacement (no per-element outlet merge), this clobbers the extracted `type`/`digest` fields from the per-domain JSON. Verified empirically: 703 outlets in the live `overrides.json` now carry empty `type` and 588 carry empty `digest`. This is a metadata-fidelity regression that escaped the tests because every existing test seeds the override with explicit `type`/`digest`, and the production path (object not previously overridden) is not exercised. No functional break today (the writethrough still re-stamps `signal:bool`, and the multichannel detection in `get_outlet_types` was already insufficient for `mc_signal`-typed outlets), but a real loss for future readers of `outlet["type"]` and human-readable `digest`.

The remaining warnings are smaller-blast-radius concerns: the pipe-unescape parser misinterprets a literal trailing backslash in a digest cell as an escape (WR-02), `--overrides-file` is unvalidated and can be written anywhere (WR-03), and the path-traversal guard rejects nested-deeper paths under the phase dir (WR-04, likely intentional but worth documenting).

## Critical Issues

None.

## Warnings

### WR-01: `cmd_apply_run` clobbers extracted `outlet["type"]` and `outlet["digest"]` for objects not previously in overrides.json

**File:** `scripts/audit_signal_role.py:625-626`
**Issue:** When an object's `--apply`-targeted outlet is not yet present in `overrides.json`, the code synthesizes a new minimal outlet entry:

```python
if target is None:
    target = {"id": outlet_id, "type": "", "digest": ""}
    outlets.append(target)
```

The loader (`src/maxpat/db_lookup.py:155-159`) does a top-level key REPLACEMENT — `self._objects[name]["outlets"] = override_outlets` — so the override's `outlets` array entirely supersedes the extracted-JSON `outlets` array. Net effect: the extracted `type` (e.g., `"signal"`, `"mc_signal"`) and `digest` ("Sawtooth out", "Per-band signal out", etc.) are lost. Empirical confirmation against the committed `.claude/max-objects/overrides.json`:
- 703 outlets carry `signal_role` with `type: ""`
- 588 outlets carry `signal_role` with `digest: ""`
- Spot check: `saw~`, `*~`, `noise~`, `sig~`, `selector~` all show `{"id": 0, "type": "", "digest": "", "signal_role": "audio"}` instead of preserving their canonical type/digest from `msp/objects.json`.

The tests do not catch this because every test (`test_round_trip_writes_signal_role`, `test_curator_role_overrides_suggested`, `test_overwrite_allowed_with_force`, `test_idempotent_apply_is_byte_stable`) seeds the isolated `overrides.json` with explicit `type`/`digest` already in place, so `target` is found via the inner loop and the synthesis branch never fires.

The row dicts produced by `_classify_outlet` already carry the correct `digest` (line 186: `"digest": outlet.get("digest", "")`) and the resolution loop has access to the row, so the fix is small.

**Fix:** Carry the row's `digest` (and ideally `type`) into the resolution tuple and use them when synthesizing a missing outlet entry. Replace the resolution loop preamble with:

```python
resolved: list[tuple[str, int, str, str]] = []   # add digest
for r in rows:
    if r["confidence"] == "low" and not r["curator_role"]:
        ...
    chosen = r["curator_role"] or r["suggested_role"]
    if chosen not in _SIGNAL_ROLE_ENUM:
        ...
    resolved.append((r["object"], r["outlet_id"], chosen, r["digest"]))

for obj_name, outlet_id, role, digest in resolved:
    entry = objects.setdefault(obj_name, {"outlets": []})
    outlets = entry.setdefault("outlets", [])
    target = None
    for o in outlets:
        if isinstance(o, dict) and o.get("id") == outlet_id:
            target = o
            break
    if target is None:
        # Pull type from the live DB so we don't drop multichannel/etc.
        db_obj = ObjectDatabase()._objects.get(obj_name, {}) if False else None
        target = {"id": outlet_id, "type": "", "digest": digest}
        outlets.append(target)
    ...
```

Better still, pre-load `ObjectDatabase()` once at the top of `cmd_apply_run`, look up the canonical outlet's `type` from the loaded DB, and pre-populate `type` from there (the writer already happens after the loader-construction smoke-test, so this is safe). At minimum, copy `digest` from the row — that's already in scope.

A regression test for the production scenario:

```python
def test_apply_to_object_not_in_overrides_preserves_type_and_digest(self, tmp_path):
    overrides = _make_overrides(tmp_path, {})  # empty — saw~ NOT pre-populated
    review = _make_review_file(tmp_path, [
        {"object": "saw~", "outlet_id": 0, "digest": "Sawtooth out (signal)",
         "suggested_role": "audio", "confidence": "high", "curator_role": ""},
    ])
    rc = audit_cli.cmd_apply_run(review_file=review, overrides_file=overrides, force=False)
    assert rc == 0
    outlet = json.loads(overrides.read_text())["objects"]["saw~"]["outlets"][0]
    assert outlet["digest"] == "Sawtooth out (signal)", "digest from row must round-trip"
    # type can be "" iff we accept the metadata-fidelity loss; assert what's intended.
```

Because the live `overrides.json` is already in this state, fixing forward means: (a) update `cmd_apply_run` to preserve digest/type, (b) add the regression test, (c) optionally re-run the apply pipeline against a fresh DB to back-fill the now-empty fields.

---

### WR-02: Pipe-unescape parser misinterprets literal trailing backslashes in digests as escape characters

**File:** `scripts/audit_signal_role.py:439-440`
**Issue:** The parser merges cells where the previous cell ends with a backslash, on the assumption that the backslash is an escape introduced by `_escape_pipe`. But a digest containing a literal trailing backslash (e.g., `"foo\\"`) is treated identically — the parser merges the next cell into it.

Reproduced:
```python
raw_cells = ['obj', ' 0 ', ' literal\\', ' next ']
# After unescape loop: ['obj', '0', 'literal| next']  ← wrong; cells 3 and 4 merged
```

The `_escape_pipe` writer only emits `\|` when escaping a pipe; it never emits a bare trailing backslash. So a curator-typed cell with a literal trailing `\` (rare in real digests, but legal in markdown) silently corrupts the row. There is no test for this edge case (`test_review_md_roundtrip_with_pipe_in_digest` covers `value|fallback` but not `value\`).

**Fix:** Track escape state explicitly rather than inferring from a trailing backslash. One approach — escape backslashes too:

```python
def _escape_pipe(cell: str) -> str:
    # Escape backslashes first, then pipes, so a literal '\' isn't ambiguous.
    return (cell or "").replace("\\", "\\\\").replace("|", "\\|")
```

And in the parser, walk character-by-character to detect `\|` (escaped pipe) vs `\\` (escaped backslash) vs `\` (literal trailing) rather than splitting on `|` and merging. Or, accept the limitation and add a test that asserts trailing backslash either round-trips correctly or raises a clear `ValueError` on parse.

---

### WR-03: `--overrides-file` argument is not validated against a path whitelist

**File:** `scripts/audit_signal_role.py:553`
**Issue:** `cmd_apply_run` applies a strict path-traversal guard to `review_file` (must resolve under `.planning/phases/30-msp-outlet-coverage-sweep/`), but `overrides_file` is freely set:

```python
overrides_file = Path(overrides_file or _DEFAULT_OVERRIDES).resolve()
```

An attacker (or a benign typo in a CI invocation) passing `--overrides-file=/tmp/foo.json` causes `cmd_apply_run` to read that path, parse it as JSON, mutate it, and atomically write back. The post-write loader-acceptance check (line 664) is skipped for non-default paths — the comment is honest about this — so no defense-in-depth catches a wrong-target write.

Realistic threat: a developer running `--apply` from the wrong cwd or with a stale shell variable could silently overwrite an arbitrary JSON file rather than the canonical overrides. Not exploitable remotely, but a footgun.

**Fix:** Either (a) require `overrides_file` to resolve under `.claude/max-objects/`, mirroring the review-file guard, or (b) document that `--overrides-file` is for tests only and emit a `UserWarning` (or refuse without an `--allow-non-default-overrides` flag) when the resolved path is not `_DEFAULT_OVERRIDES`. Tests can opt in via the explicit flag.

```python
if overrides_file != _DEFAULT_OVERRIDES.resolve() and not allow_non_default_overrides:
    print(
        f"ERROR: --overrides-file must resolve to {_DEFAULT_OVERRIDES}; "
        f"got {overrides_file}. Pass --allow-non-default-overrides for tests.",
        file=sys.stderr,
    )
    return 2
```

---

### WR-04: Path-traversal guard rejects valid paths nested deeper inside the phase directory

**File:** `scripts/audit_signal_role.py:560-562`
**Issue:** The guard checks exactly the three nearest parents:

```python
parents = list(review_file.parents)[:3]
parent_names = [p.name for p in parents]
if parent_names != ["30-msp-outlet-coverage-sweep", "phases", ".planning"]:
    return 2
```

A path like `.planning/phases/30-msp-outlet-coverage-sweep/subdir/REVIEW.md` resolves to parents `["subdir", "30-msp-outlet-coverage-sweep", "phases"]`, which fails the equality check and is rejected. If the intent is "anywhere under the phase dir" the guard should use `Path.is_relative_to(_PHASE_DIR)` (3.9+) or a `commonpath` check. If the intent is "exactly at the phase-dir root" (likely, given the constant `_DEFAULT_REVIEW_FILE`), the comment should say so.

This is mostly a documentation/expressiveness issue rather than a security gap — the current guard IS strict enough to reject real attacks (`/etc/passwd`, `../etc/passwd`, etc.). But it bakes in an undocumented constraint that any future "split the review file by domain" enhancement (e.g., `SIGNAL-ROLE-REVIEW-mc.md` in a `mc/` subdir) would silently break.

**Fix:** Use a clearer, more flexible check:

```python
try:
    review_file.relative_to(_PHASE_DIR.resolve())
except ValueError:
    print(
        f"ERROR: review file must live under {_PHASE_DIR}; got {review_file}",
        file=sys.stderr,
    )
    return 2
```

This also has the side-benefit of failing closed regardless of how many path components separate the review file from the phase root.

## Info

### IN-01: `_apply_signal_role_writethrough` defensive `isinstance` check is unreachable

**File:** `src/maxpat/db_lookup.py:289-295`
**Issue:** `_apply_signal_role_writethrough` runs after `_validate_schema_extensions` (which rejects non-dict outlets at line 235-239) and after the deep-merge. The `if not isinstance(outlet, dict): continue` branch is documented as "defensive only" but is dead in the current call chain — there is no path that produces a non-dict outlet at that point. The comment correctly notes "this branch is defensive only -- skip silently rather than crash if validation is ever bypassed", which is fine, but it would be worth adding a `# pragma: no cover` or a test that bypasses validation to actually exercise it. Otherwise it accumulates as untested dead code.

**Fix:** Either annotate as `# pragma: no cover` to make the dead-code intent explicit, or add an `assert isinstance(outlet, dict), f"validator should have rejected {name}"` to fail fast if invariants are ever broken.

### IN-02: `_classify_outlet` uses both `outlet_idx` and `outlet.get("id", outlet_idx)` for the same concept

**File:** `scripts/audit_signal_role.py:155-191`
**Issue:** The function takes `outlet_idx` (positional index into the outlets array) and computes `outlet.get("id", outlet_idx)` for the row's `outlet_id`. In the live DB outlet `id` matches array index for every entry, but if they ever diverged the row's `outlet_id` would point to the JSON-declared id while `_classify_db` and `_propose_inherited_roles` walk by array index. `cmd_apply_run` then matches on `o.get("id") == outlet_id`, so the apply step uses the JSON id. The classifier and walker are inconsistent about which is canonical.

**Fix:** Decide whether `outlet_id` in row dicts means "array index" or "JSON `id` field" and document it in the `ClassifiedRow` typedef comment. If they always equal in the real DB, add a test asserting that invariant and remove the `outlet.get("id", outlet_idx)` fallback (use `outlet_idx` everywhere for clarity).

### IN-03: `_propose_inherited_roles`'s `trailing-fallthrough` branch is unreachable today

**File:** `scripts/audit_signal_role.py:218-227`
**Issue:** The docstring describes a `"trailing-fallthrough"` confidence value emitted "when MC has MORE outlets than sibling at this index" but the strict parity gate at line 260 returns `None` whenever sibling and MC outlet counts differ, so the branch that would emit `trailing-fallthrough` never executes. The docstring acknowledges this ("this branch is currently unreachable but the test fixture covers it for forward compatibility"), and `test_trailing_outlet_fallthrough` explicitly asserts `None` (the parity-gate path) rather than testing the unreachable branch.

This is fine as a forward-compatibility hook, but the dead branch + dead value will diverge from the docstring as the code evolves. Recommend either removing the unreachable code path entirely (YAGNI) or adding a feature flag (`strict_parity: bool = True`) so the branch is exercisable.

**Fix:** Either remove the `"trailing-fallthrough"` confidence value and its docstring entry, or expose a `strict_parity` parameter so a test can exercise the relaxed branch. Current state is misleading documentation.

### IN-04: `_PROJECTED_SIGNAL_BOOL_EXPECTATIONS` ordering is fragile

**File:** `tests/test_signal_role_migration.py:47-99`
**Issue:** The hand-maintained tuple list has 50 entries with hardcoded outlet indexes. A future migration that re-orders outlets (e.g., adds a new outlet 0 to `vst~` and shifts the existing ones) would silently reorder the expectations and the parametrize would still pass (or fail) opaquely. Consider keying the expectations by `(name, outlet_id_field)` and asserting the outlet exists by id rather than by positional index.

**Fix:** Use the JSON `id` field for the lookup and assert position-independent semantics:

```python
def _outlet_by_id(outlets, outlet_id):
    for o in outlets:
        if isinstance(o, dict) and o.get("id") == outlet_id:
            return o
    return None
```

This makes the test resilient to outlet reordering.

### IN-05: `tests/test_inlet_types.py:111-124` exception list grows opaquely

**File:** `tests/test_inlet_types.py:103-124`
**Issue:** `TILDE_UI_EXCEPTIONS` accumulates `mc.capture~`, `mc.send~`, `mcs.loudness~` with a long inline comment about a "raw-vs-overrides gap" because the conftest `all_objects` fixture reads raw domain JSON and doesn't apply overrides. The comment is honest about the deficit ("Adding to the exception set documents the raw-vs-overrides gap explicitly until conftest is enriched in a future phase") but the workaround compounds — every override that flips a `signal:bool` field on an inlet now needs an entry here. A small fixture enhancement to `tests/conftest.py` that exposes an `overridden_objects` fixture would let this test use the merged shape and shrink the exception list.

**Fix:** Add a `db_objects` fixture to `tests/conftest.py` that returns objects post-override-merge (use `ObjectDatabase()._objects.values()`), and migrate the tilde-IO test to use it. The exception list can then collapse to genuine UI-only objects.

---

_Reviewed: 2026-04-29_
_Reviewer: Claude (gsd-code-reviewer)_
_Depth: standard_
