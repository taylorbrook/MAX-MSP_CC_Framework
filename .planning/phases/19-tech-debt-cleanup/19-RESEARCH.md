# Phase 19: Tech Debt Cleanup - Research

**Researched:** 2026-03-16
**Domain:** Python codebase maintenance, JSON round-trip fidelity, test coverage
**Confidence:** HIGH

## Summary

Phase 19 addresses three tech debt items and one test coverage gap identified by the v2.0 milestone audit (`v2.0-MILESTONE-AUDIT.md`). All items are precisely scoped, low-risk, and well-understood. The work requires:

1. **Subpatcher round-trip fix + test** -- A one-line fix in `patcher.py` `from_dict()` where `_raw.pop("patcher", None)` removes the `patcher` key from the preserved dict, causing it to be re-appended at the end of the dict during `to_dict()`. This shifts its position relative to `saved_object_attributes`, breaking byte-level fidelity. The fix: keep the key as a `None` sentinel instead of popping it. Then add a string-equality round-trip test for a subpatcher-containing patch.
2. **Stale docstring fix** -- One docstring line in `externals.py` references the removed `write_patch` function.
3. **Delete leftover script** -- `_fix2.py` is a one-off layout fix script that should have self-deleted but is still tracked in git.

**Primary recommendation:** Single plan with 4 surgical tasks. Total effort: ~5 minutes. Zero architectural decisions needed.

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| RW-02 (gap) | File-level byte-identical round-trip for subpatcher patches | Root cause identified: `_raw.pop("patcher")` in `patcher.py:1831` removes key position. Fix: sentinel preservation. Test: string-equality comparison on minitaur.maxpat |
| CL-05 (gap) | Stale docstring references removed `write_patch` | Exact location: `src/maxpat/externals.py:112`. Replace `write_patch` with `save_patch_roundtrip` |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| pytest | 9.0.2 | Test framework | Already in use, 1138 tests |
| Python stdlib json | 3.14 | JSON serialization | Already the serialization layer |

### Supporting
No new dependencies needed. All work is within existing codebase.

## Architecture Patterns

### Root Cause: Subpatcher Key Ordering Bug

**File:** `src/maxpat/patcher.py`, line 1831

**Current code (from_dict):**
```python
# Preserve raw box dict for lossless round-trip
# Exclude nested patcher -- handled separately via _inner_patcher
raw = dict(box_data)
raw.pop("patcher", None)  # BUG: removes key position
box._raw = raw
```

**Problem:** When `patcher` key is popped from `_raw`, its position in the ordered dict is lost. Later in `to_dict()` (line 361), `d["patcher"] = self._inner_patcher.to_dict()["patcher"]` inserts the key at the END of the dict, after `saved_object_attributes`. In the original .maxpat file, `patcher` comes BEFORE `saved_object_attributes`.

**Fix:**
```python
# Preserve raw box dict for lossless round-trip
# Replace nested patcher with None sentinel to preserve key position
# (actual patcher data reconstructed from _inner_patcher in to_dict())
raw = dict(box_data)
if "patcher" in raw:
    raw["patcher"] = None  # sentinel preserves key position
box._raw = raw
```

**Why this works:** Python dicts (3.7+) preserve insertion order. Reassigning an existing key's value does NOT change its position. Setting to `None` keeps the key in place; `to_dict()` then overwrites `None` with the reconstructed patcher dict at the same position.

**to_dict() compatibility check (lines 360-364):**
```python
# Inner patcher (subpatcher/bpatcher embed)
if self._inner_patcher is not None:
    d["patcher"] = self._inner_patcher.to_dict()["patcher"]  # overwrites None sentinel
elif "patcher" in self._raw:
    # Inner patcher was removed -- don't emit stale copy
    d.pop("patcher", None)  # removes None sentinel correctly
```

Both branches handle the sentinel correctly:
- Normal round-trip: `_inner_patcher` is not None, so line 361 overwrites the `None` sentinel at its original position
- Patcher removed: `_inner_patcher` is None, `"patcher" in self._raw` is True (sentinel), so line 364 pops it

### Affected Patches

Empirically verified which patches are affected:

| Patch | Has Subpatcher | Byte-Identical Before Fix | After Fix (expected) |
|-------|---------------|---------------------------|---------------------|
| kicksynth.maxpat | Yes | Yes (patcher is last key) | Yes |
| minitaur.maxpat | Yes | **No** (13114 line diffs) | Yes |
| performancepatchtest.maxpat | Yes | **No** (4654 line diffs) | Yes |
| scala-synth.maxpat | Yes | **No** (120 line diffs) | Yes |
| scala-synth-voice.maxpat | Yes | Yes (no soa after patcher) | Yes |

kicksynth and scala-synth-voice are byte-identical even with the bug because their subpatcher boxes have `patcher` as the last key (no `saved_object_attributes` after it).

### Test Strategy

The new test should verify **string-level equality** (not just dict equality) for a subpatcher-containing patch. The existing `TestRoundTripIdentity` uses `assert result == original` which is dict equality and passes even with key reordering.

**Test pattern:**
```python
def test_subpatcher_byte_identical_round_trip(self):
    """Subpatcher-containing patch is byte-identical after round-trip (RW-02 gap closure)."""
    path = PATCHES_DIR / "minitaur/generated/minitaur.maxpat"
    original_text = path.read_text()
    original = json.loads(original_text)

    p = Patcher.from_dict(original)
    result = p.to_dict()

    result_text = json.dumps(result, indent=detect_indent(original_text))
    if original_text.endswith("\n"):
        result_text += "\n"

    assert result_text == original_text, (
        "Subpatcher round-trip is not byte-identical -- "
        "JSON key ordering not preserved for embedded patchers"
    )
```

**Why minitaur:** It has the most subpatchers with `saved_object_attributes`, making it the strongest test. If byte-identical round-trip works for minitaur, it works for all.

### Docstring Fix

**File:** `src/maxpat/externals.py`, line 112
**Current:** `Patcher instance (caller writes via write_patch or manual JSON).`
**Fixed:** `Patcher instance (caller saves via save_patch_roundtrip or manual JSON).`

### Script Deletion

**File:** `patches/rhythmic-sampler/generated/_fix2.py`
**What it is:** A one-off layout fix script (176 lines) that manipulates slot.maxpat JSON directly. Line 176 contains `os.remove(__file__)` -- it was designed to self-delete after running but is still tracked in git.
**Action:** `git rm patches/rhythmic-sampler/generated/_fix2.py`

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| Key-ordered JSON comparison | Custom diff tool | `json.dumps()` string equality | json.dumps with same indent produces deterministic output; string == is sufficient |
| Indent detection | Manual parsing | `detect_indent()` from hooks.py | Already exists and tested |

## Common Pitfalls

### Pitfall 1: Dict Equality vs String Equality
**What goes wrong:** Tests using `assert dict_a == dict_b` pass even when key ordering differs
**Why it happens:** Python dict equality checks keys and values, not key ordering
**How to avoid:** Use `json.dumps()` to serialize both dicts, then compare strings
**Warning signs:** Test passes but `git diff` on saved file shows key reordering

### Pitfall 2: Sentinel Value in _raw Leaking to Output
**What goes wrong:** `None` sentinel for `patcher` key could leak into serialized output
**Why it happens:** If `to_dict()` doesn't handle the case where `_inner_patcher` is None but `patcher` key exists in _raw
**How to avoid:** Line 362-364 already handles this: `elif "patcher" in self._raw: d.pop("patcher", None)`
**Warning signs:** `"patcher": null` appearing in output JSON

### Pitfall 3: Indent Mismatch in Byte Comparison
**What goes wrong:** String comparison fails despite correct data because of indent differences
**Why it happens:** Using different indent for serialization than the original file
**How to avoid:** Use `detect_indent(original_text)` to match the original file's indentation
**Warning signs:** Files identical when viewed as dicts but differ in whitespace

## Code Examples

### The One-Line Fix
```python
# src/maxpat/patcher.py, line 1828-1832
# BEFORE:
raw = dict(box_data)
raw.pop("patcher", None)
box._raw = raw

# AFTER:
raw = dict(box_data)
if "patcher" in raw:
    raw["patcher"] = None  # sentinel preserves key position
box._raw = raw
```

### Byte-Identical Round-Trip Test
```python
# tests/test_round_trip.py -- new test class
class TestSubpatcherByteIdentity:
    """RW-02 gap closure: subpatcher key ordering preserved at byte level."""

    def test_subpatcher_byte_identical_round_trip(self):
        """Subpatcher-containing patch serializes byte-identically."""
        path = PATCHES_DIR / "minitaur/generated/minitaur.maxpat"
        original_text = path.read_text()
        original = json.loads(original_text)

        p = Patcher.from_dict(original)
        result = p.to_dict()

        from src.maxpat.hooks import detect_indent
        result_text = json.dumps(result, indent=detect_indent(original_text))
        if original_text.endswith("\n"):
            result_text += "\n"

        assert result_text == original_text
```

### Docstring Fix
```python
# src/maxpat/externals.py, line 112
# BEFORE:
#     Patcher instance (caller writes via write_patch or manual JSON).
# AFTER:
#     Patcher instance (caller saves via save_patch_roundtrip or manual JSON).
```

## State of the Art

No technology changes relevant to this phase. All work is within existing Python stdlib and project patterns.

## Open Questions

None. All items are fully scoped with known fixes.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | none (defaults) |
| Quick run command | `python3 -m pytest tests/test_round_trip.py -x -q` |
| Full suite command | `python3 -m pytest -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| RW-02 (gap) | Subpatcher byte-identical round-trip | unit | `python3 -m pytest tests/test_round_trip.py::TestSubpatcherByteIdentity -x` | Wave 0 (new test class) |
| CL-05 (gap) | No write_patch reference in externals.py | unit | `python3 -c "assert 'write_patch' not in open('src/maxpat/externals.py').read()"` | N/A (one-liner) |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_round_trip.py -x -q`
- **Per wave merge:** `python3 -m pytest -q`
- **Phase gate:** Full suite green (`python3 -m pytest -q` -- 1138+ tests pass)

### Wave 0 Gaps
None -- existing test infrastructure covers all needs. New test class added in the same plan that implements the fix.

## Sources

### Primary (HIGH confidence)
- **Direct code inspection** of `src/maxpat/patcher.py` lines 1828-1832 (from_dict) and 327-372 (to_dict) -- root cause verified
- **Empirical verification** -- ran `json.dumps` comparison on all 10 project patches, confirmed 3 of 5 subpatcher patches fail byte-level round-trip
- **`v2.0-MILESTONE-AUDIT.md`** -- defines the exact 3 tech debt items and 2 requirement gaps
- **Direct code inspection** of `src/maxpat/externals.py:112` -- confirmed stale `write_patch` reference
- **Direct file verification** of `patches/rhythmic-sampler/generated/_fix2.py` -- confirmed present and tracked in git

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - no new dependencies, all stdlib
- Architecture: HIGH - root cause identified and fix verified conceptually via Python dict ordering semantics
- Pitfalls: HIGH - all items trivial, well-understood risks

**Research date:** 2026-03-16
**Valid until:** indefinite (codebase-specific findings, no external dependency versioning concerns)
