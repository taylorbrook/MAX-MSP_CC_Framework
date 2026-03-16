# Phase 13: Round-Trip Foundation - Research

**Researched:** 2026-03-15
**Domain:** .maxpat JSON round-trip fidelity (load and write-back with zero data loss)
**Confidence:** HIGH

## Summary

The existing `Patcher.from_dict()` and `Box/Patchline.to_dict()` code in `src/maxpat/patcher.py` provides the skeleton for loading and saving .maxpat files, but empirical testing against all 10 project .maxpat files reveals six categories of data loss during round-trip. The root cause is a mismatch between what `from_dict()` extracts as "handled" and what `to_dict()` emits -- keys are absorbed into named fields on load but not re-emitted for all maxclass types on save. Additionally, `to_dict()` unconditionally emits keys that MAX sometimes omits (parameter_enable, outlettype, patchline order), and patcher-level key ordering is not preserved because `boxes`/`lines` are appended at the end instead of being placed at their original position.

The good news: Python 3.14's `dict` preserves insertion order, and `json.load()` preserves int/float distinction natively. The project needs no external dependencies. The fix strategy is: (1) track original key presence/order during `from_dict()`, (2) make `to_dict()` emit only keys that were present in the original (or are required for new objects), and (3) preserve key ordering at both patcher and box levels.

**Primary recommendation:** Restructure `from_dict()`/`to_dict()` to use a "preserve everything, emit what was there" strategy rather than the current "extract known fields, reconstruct from scratch" approach. Track original key order and presence as metadata on each object.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Key-order preserving: JSON keys written in same order as original file -- unchanged portions produce zero diff lines
- Numeric precision preserved: int stays int (numinlets: 2), float stays float (fontsize: 12.0) -- track original types during parse
- Tab indentation matching MAX's output format -- not spaces
- New objects (added after loading) follow MAX's canonical key ordering (id, maxclass, numinlets, numoutlets, outlettype, patching_rect, text, ...) so they blend in with existing objects
- Round-trip must handle ANY valid .maxpat file -- framework-generated, MAX-edited, downloaded from forums, third-party externals, legacy MAX 7/8
- .amxd (Max for Live) wrapper parsing deferred to a future phase -- but the inner patcher structure round-trips if extracted
- Unknown objects (third-party externals, packages) loaded silently -- no DB lookup, no warnings, all data preserved as-is
- Unknown top-level patcher keys stored in patcher.props dict (existing pattern, confirm and test)
- Unknown box keys stored in extra_attrs dict (existing pattern, confirm and test)
- Patchline gets extra_attrs dict mirroring Box pattern -- plus named `color` field for the known color attribute
- Error mode: fail fast on structural errors (missing "patcher" key, "boxes" not an array), lenient on content (accept any maxclass, missing fields, weird attrs)
- Add `color: list | None` as named field on Patchline class
- Add `extra_attrs: dict` catch-all for any other patchline attributes
- from_dict() extracts color and unknown keys; to_dict() emits them -- fixes the verified color-drop bug

### Claude's Discretion
- Whether to reconstruct bpatcher_attrs from loaded data or just preserve via extra_attrs -- pick based on downstream Phase 14+ needs
- Internal representation strategy for key-order tracking (OrderedDict, list of tuples, or other approach)
- parameter_enable reconstruction strategy -- ensure it survives round-trip regardless of maxclass
- ID tracking strategy for subpatcher scoping

### Deferred Ideas (OUT OF SCOPE)
- .amxd (Max for Live) wrapper format parsing -- future phase
- Batch operations with transaction semantics (checkpoint/rollback) -- v3.0 ADV-01
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| RW-01 | Patcher can load any .maxpat file into fully populated Patcher/Box/Patchline objects -- all maxclass types, recursive subpatchers, bpatcher attrs, unknown objects handled gracefully | Empirical testing of from_dict() against all 10 project patches identifies exact bugs: bpatcher_attrs=None, text/font dropped for UI maxclasses, codebox font lost. Fix strategy documented in Architecture Patterns. |
| RW-02 | Loaded Patcher writes back to .maxpat with minimal diff -- unchanged portions byte-for-byte identical, key ordering preserved, numeric precision maintained | Six categories of diff identified with root causes. Key-order tracking strategy, conditional emission of optional keys, and indentation standardization documented. |
| RW-06 | All user state preserved on edit -- positions, colors, presentation rects, varnames, scripting names, custom attrs, unknown keys survive load-edit-save cycle | extra_attrs catch-all works for most cases already. Identified gaps: text on UI widgets, fontname/fontsize on non-newobj boxes, parameter_enable handling, patchline color/attrs. Fix for each documented. |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python stdlib `json` | 3.14 | JSON parsing and serialization | Preserves int/float distinction, preserves dict key insertion order. No external deps needed. |
| Python stdlib `copy` | 3.14 | Deep copy for props | Already used in codebase |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| `pytest` | 9.0.2 | Test framework | Already installed, used for all existing tests |
| `deepdiff` | -- | NOT recommended | Tempting for diff assertions but adds dependency. Use `json.dumps(sort_keys=False)` string comparison or recursive dict compare instead. |

### Alternatives Considered
| Instead of | Could Use | Tradeoff |
|------------|-----------|----------|
| dict key-order tracking via metadata | OrderedDict | Unnecessary -- Python 3.7+ dicts preserve insertion order natively. Just preserve the dict as-is from json.load(). |
| Custom JSON encoder for int/float | json.dumps default | Default encoder already preserves int/float distinction correctly. No custom encoder needed. |

**Installation:**
```bash
# No new packages needed -- pure stdlib + existing pytest
```

## Architecture Patterns

### Recommended Approach: "Preserve-First" Round-Trip

The current code follows a "decompose and reconstruct" pattern: `from_dict()` extracts known fields into named attributes, and `to_dict()` builds a new dict from those attributes. This is lossy by design because `to_dict()` only knows about fields it was coded to emit.

**New approach:** `from_dict()` should preserve the original box dict as metadata, and `to_dict()` should start from that preserved dict, overlaying any changes made to named fields. This ensures unknown keys and key ordering survive automatically.

### Pattern 1: Raw Dict Preservation on Box

Store the original box dict on each Box during `from_dict()`:

```python
# In from_dict():
box._raw = dict(box_data)  # shallow copy of original box dict (without nested patcher)

# In to_dict():
def to_dict(self) -> dict[str, Any]:
    if hasattr(self, '_raw') and self._raw is not None:
        # Round-trip path: start from original, overlay mutations
        d = dict(self._raw)
        # Update mutable fields that may have changed
        d["patching_rect"] = self.patching_rect
        d["numinlets"] = self.numinlets
        d["numoutlets"] = self.numoutlets
        d["outlettype"] = self.outlettype
        if self.presentation:
            d["presentation"] = 1
            if self.presentation_rect is not None:
                d["presentation_rect"] = self.presentation_rect
        elif "presentation" in d:
            del d["presentation"]
            d.pop("presentation_rect", None)
        # Handle inner patcher
        if self._inner_patcher is not None:
            d["patcher"] = self._inner_patcher.to_dict()["patcher"]
        if self._saved_object_attributes is not None:
            d["saved_object_attributes"] = self._saved_object_attributes
        return {"box": d}
    else:
        # Creation path: build from scratch (existing logic)
        ...
```

**Key insight:** The raw dict already has the correct key ordering from `json.load()`. By starting from it and overlaying changes, we get key-order preservation, unknown-key preservation, and correct presence/absence of optional keys for free.

### Pattern 2: Raw Dict Preservation on Patchline

Same principle for Patchline:

```python
class Patchline:
    def __init__(self, ..., _raw: dict | None = None):
        ...
        self._raw = _raw  # original patchline dict from JSON

    def to_dict(self) -> dict[str, Any]:
        if self._raw is not None:
            d = dict(self._raw)
            d["source"] = [self.source_id, self.source_outlet]
            d["destination"] = [self.dest_id, self.dest_inlet]
            # Only update mutable fields
            return {"patchline": d}
        else:
            # Creation path
            d = {"source": [...], "destination": [...], "order": self.order}
            ...
```

### Pattern 3: Patcher-Level Key Order Preservation

The current `to_dict()` rebuilds props then appends `boxes` and `lines` at the end. But the original file may have `boxes`/`lines` in the middle (before `dependency_cache`, `autosave`).

```python
# In Patcher.to_dict():
def to_dict(self) -> dict[str, Any]:
    # Start from preserved props (which already has correct key order)
    result = {}
    for key, val in self.props.items():
        if key == "boxes":
            result["boxes"] = [box.to_dict() for box in self.boxes]
        elif key == "lines":
            result["lines"] = [line.to_dict() for line in self.lines]
        else:
            result[key] = copy.deepcopy(val)
    # If boxes/lines weren't in props (new patcher), append them
    if "boxes" not in result:
        result["boxes"] = [box.to_dict() for box in self.boxes]
    if "lines" not in result:
        result["lines"] = [line.to_dict() for line in self.lines]
    return {"patcher": result}
```

**Critical change:** `from_dict()` should include `"boxes"` and `"lines"` as placeholder keys in `props` during loading (e.g., `props["boxes"] = []` and `props["lines"] = []`), preserving their position in the key order. Then `to_dict()` replaces them with actual data.

### Pattern 4: Patchline Color and Extra Attrs

```python
class Patchline:
    def __init__(self, ..., color: list | None = None, extra_attrs: dict | None = None):
        ...
        self.color = color
        self.extra_attrs = extra_attrs or {}

# In from_dict():
_handled_line_keys = {"source", "destination", "order", "hidden", "midpoints", "color"}
pl_extra = {k: v for k, v in line_data.items() if k not in _handled_line_keys}
pl = Patchline(..., color=line_data.get("color"), extra_attrs=pl_extra, _raw=line_data)

# In to_dict() creation path:
if self.color is not None:
    d["color"] = self.color
d.update(self.extra_attrs)
```

### Pattern 5: Bpatcher Attrs -- Recommend Preserve via extra_attrs

**Recommendation for Claude's Discretion item:** Do NOT reconstruct `_bpatcher_attrs` from loaded data. Instead, let all bpatcher-specific keys (args, bgmode, border, clickthrough, etc.) live in `extra_attrs` as they already do. The current code already handles this correctly -- bpatcher attrs are not in `_handled_keys`, so they go to `extra_attrs` and survive round-trip.

Evidence: The rhythmic-sampler round-trip is already PERFECT for bpatcher boxes. The `_bpatcher_attrs` field is only needed for the creation path (when building bpatchers programmatically).

For downstream Phase 14+ mutation needs: Phase 14 can add typed accessors (e.g., `box.bpatcher_name`, `box.bpatcher_args`) that read/write to `extra_attrs` without requiring a separate `_bpatcher_attrs` dict.

### Pattern 6: parameter_enable Handling

**Recommendation:** Do NOT add `parameter_enable` to `_handled_keys`. Remove it from `_handled_keys` so it goes to `extra_attrs` like any other optional key. Then remove the unconditional `parameter_enable = 0` emission in the `to_dict()` "else" branch.

For the creation path, `parameter_enable = 0` should be added to `extra_attrs` during Box creation, not hardcoded in `to_dict()`.

### Pattern 7: JSON Serialization for Write

```python
# For round-trip (load-save):
json.dumps(data, indent="\t", ensure_ascii=False)

# For new patches (create-save):
json.dumps(data, indent="\t", ensure_ascii=False)
```

**Note on indentation:** The CONTEXT.md locks "Tab indentation matching MAX's output format." However, empirical testing shows MAX 9.1.2 actually uses 4-space indentation (comp-band.maxpat, FDNVerb.maxpat, granularsynthtest.maxpat). The framework-generated files use 2-space indentation. This should be verified against MAX's actual output. For round-trip, matching the original file's indentation style would be ideal. For new files, use whatever MAX uses.

**Update:** After checking all MAX-saved files in the project, MAX 9.1.2 uses **4-space indentation, not tabs**. The CONTEXT.md decision says "Tab indentation matching MAX's output format" -- this needs clarification with the user. The research recommendation is to **match MAX's actual output: 4-space indentation** (or, even better, detect and preserve the original file's indentation on round-trip).

### Anti-Patterns to Avoid

- **Reconstructing data from named fields:** The current `to_dict()` builds dicts from scratch, losing key ordering and optional-key presence. Use raw dict preservation instead.
- **Hardcoding optional keys in to_dict():** `parameter_enable`, `outlettype`, `order` should only appear in output if they were in the input (for round-trip) or are required (for new objects).
- **Separate handling of bpatcher attrs:** Don't add special-case code for bpatcher keys. Let `extra_attrs` handle them -- it already works.
- **Global `_handled_keys` set:** Different maxclasses have different "standard" keys. A single `_handled_keys` set causes keys like `text` to be consumed for ALL maxclasses but only emitted for some. With raw dict preservation, this problem goes away.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| JSON key ordering | Custom key-ordering logic | Python 3.7+ dict insertion order + `json.load()` | Python dicts already preserve insertion order. Just don't rebuild the dict from scratch. |
| Int/float distinction | Custom number type tracking | `json.load()` + `json.dumps()` default behavior | Python json module already preserves `2` as int and `12.0` as float correctly. |
| Deep comparison for tests | Custom recursive diff | `original == result` dict equality, supplemented by `json.dumps()` string comparison | Python dict equality is recursive and handles nested structures. |
| Indentation detection | Regex-based indent parser | Read first indented line, count leading spaces/tabs | Simple heuristic sufficient for the three known patterns (2-space, 4-space, tab). |

**Key insight:** Python's stdlib json module already does most of the hard work. The main engineering challenge is NOT parsing/serialization -- it's preserving the original structure through the object model layer.

## Common Pitfalls

### Pitfall 1: Text Field Loss on UI Widgets
**What goes wrong:** `textbutton` boxes have `text: "MIDI"` in the original, but after round-trip the text field vanishes.
**Why it happens:** `text` is in `_handled_keys` (extracted to `box.text`), but `to_dict()` only emits `text` for maxclass `newobj`, `comment`, `message`. Textbutton, codebox, attrui, etc. lose their text.
**How to avoid:** With raw dict preservation, text stays in `_raw` and is emitted automatically. For the creation path, ensure `text` is added to the dict for any maxclass that needs it.
**Warning signs:** Textbutton displays go blank after round-trip.

### Pitfall 2: Font Fields Lost on Non-Standard Maxclasses
**What goes wrong:** `codebox` has `fontname: "Arial"` and `fontsize: 12.0` in the original, but they vanish after round-trip.
**Why it happens:** Same mechanism as text -- `fontname`/`fontsize` are in `_handled_keys`, consumed into `box.fontname`/`box.fontsize`, but only emitted by `to_dict()` for `newobj`, `comment`, `message`.
**How to avoid:** Raw dict preservation. For creation path, add font fields to the dict when relevant.
**Warning signs:** Codebox text renders in default font instead of specified font.

### Pitfall 3: Spurious parameter_enable on Every UI Widget
**What goes wrong:** Loading a MAX-saved file that doesn't have `parameter_enable` on inlet/outlet/dial boxes, then saving adds `parameter_enable: 0` to all of them.
**Why it happens:** `to_dict()` unconditionally adds `parameter_enable: 0` for all non-newobj/comment/message/bpatcher maxclasses.
**How to avoid:** Only emit `parameter_enable` if it was in the original or explicitly set during creation.
**Warning signs:** Diff shows hundreds of added `parameter_enable` lines.

### Pitfall 4: Spurious outlettype on Zero-Outlet Boxes
**What goes wrong:** Comment boxes in MAX-saved files don't have `outlettype` key. After round-trip, `outlettype: []` appears.
**Why it happens:** `from_dict()` defaults `outlettype` to `[]`, and `to_dict()` always emits it.
**How to avoid:** Raw dict preservation. For creation path, include outlettype.
**Warning signs:** Diff shows `outlettype: []` on comment boxes.

### Pitfall 5: Patchline Order Always Emitted
**What goes wrong:** MAX-saved files omit `"order"` on patchlines (it defaults to 0). After round-trip, every patchline gets `"order": 0`.
**Why it happens:** `to_dict()` always includes order in the output dict.
**How to avoid:** Only emit `order` if it was in the original or non-zero.
**Warning signs:** Every patchline in diff has added `order` field.

### Pitfall 6: Patcher Key Order Mismatch
**What goes wrong:** Original file has `boxes` and `lines` before `dependency_cache` and `autosave`. After round-trip, they appear at the end.
**Why it happens:** `from_dict()` strips `boxes`/`lines` from props, and `to_dict()` appends them after all props.
**How to avoid:** Keep placeholder entries in props during load to preserve position. Replace with actual data during save.
**Warning signs:** Large diff at patcher level despite identical content.

### Pitfall 7: Indentation Mismatch
**What goes wrong:** Original MAX-saved file uses 4-space indent. Framework writes with 2-space indent. Entire file shows as changed in diff.
**Why it happens:** `hooks.py` hardcodes `json.dumps(indent=2)`.
**How to avoid:** Detect original indentation, preserve it on write. Use MAX's native indentation for new files.
**Warning signs:** Every line in diff is a whitespace change.

## Code Examples

### Current from_dict() Bug Locations (verified by testing)

**Bug 1: Patchline color/attrs drop (lines 1106-1119)**
```python
# Current code - drops ALL patchline attributes except source/destination/order/hidden/midpoints
pl = Patchline(
    source_id=src[0],
    source_outlet=src[1],
    dest_id=dst[0],
    dest_inlet=dst[1],
    order=line_data.get("order", 0),
    hidden=bool(line_data.get("hidden", 0)),
    midpoints=line_data.get("midpoints"),
)
# FIX: pass _raw=line_data, color=line_data.get("color"), extra_attrs={leftover keys}
```

**Bug 2: bpatcher_attrs always None (line 1078)**
```python
# Current code
box._bpatcher_attrs = None
# ANALYSIS: This is actually NOT a bug for round-trip because bpatcher attrs
# go to extra_attrs and survive. It IS a bug for creation-then-load workflows
# but that's not Phase 13 scope.
```

**Bug 3: text/font/parameter_enable handling (lines 1085-1093, 188-241)**
```python
# from_dict extracts these as handled:
_handled_keys = {
    "id", "maxclass", "text", "numinlets", "numoutlets",
    "outlettype", "patching_rect", "fontname", "fontsize",
    "presentation", "presentation_rect", "patcher",
    "saved_object_attributes", "parameter_enable",
}
# But to_dict only emits text/fontname/fontsize for newobj/comment/message
# and parameter_enable only for the "else" (UI) branch
# FIX: Use raw dict preservation to bypass this entire problem
```

### Test Approach: Golden File Comparison

```python
def test_round_trip_kicksynth():
    """Load kicksynth.maxpat and write back -- output must equal input."""
    import json
    from src.maxpat.patcher import Patcher

    with open("patches/kicksynth/generated/kicksynth.maxpat") as f:
        original = json.load(f)

    p = Patcher.from_dict(original)
    result = p.to_dict()

    assert result == original, (
        f"Round-trip mismatch. Use json.dumps to find diffs."
    )
```

### All 10 Test Fixtures Available

| File | Source | Boxes | Lines | Key Features |
|------|--------|-------|-------|--------------|
| kicksynth/kicksynth.maxpat | Framework | 146 | 126 | subpatcher(gen~), presentation, varname, param_enable, panel |
| scala-synth/scala-synth.maxpat | Framework | 135 | 110 | subpatcher, presentation, mixed patchline order |
| scala-synth/scala-synth-voice.maxpat | Framework | 50 | 34 | subpatcher, number~ |
| performancepatchtest/performancepatchtest.maxpat | Framework | 68 | 43 | subpatcher, presentation, textbutton |
| performancepatchtest/comp-band.maxpat | MAX 9.1.2 | 38 | 34 | MAX-saved, no order on patchlines, 4-space indent |
| rhythmic-sampler/rhythmic-sampler.maxpat | Framework | 45 | 33 | bpatcher (8 instances), presentation |
| rhythmic-sampler/slot.maxpat | Framework | 82 | 82 | presentation, varname, waveform~ |
| minitaur/minitaur.maxpat | Framework | 183 | 109 | subpatcher (5), textbutton with text, presentation |
| FDNVerb/FDNVerb.maxpat | MAX 9.1.2 | 25 | 18 | MAX-saved, attrui, 4-space indent |
| granularsynthtest/granularsynthtest.maxpat | MAX 9.1.2 | 26 | 18 | MAX-saved, attrui, waveform~, 4-space indent |

### Current Round-Trip Status Per File

| File | Status | Issues |
|------|--------|--------|
| rhythmic-sampler.maxpat | PERFECT | None (already passes) |
| kicksynth.maxpat | 2 box diffs | Subpatcher inner patcher key order, codebox font |
| scala-synth.maxpat | 2 box diffs, 17 line diffs | Subpatcher diffs, mixed patchline order |
| scala-synth-voice.maxpat | 1 box diff | Subpatcher key order |
| performancepatchtest.maxpat | 6 box diffs | Subpatcher diffs, textbutton text |
| slot.maxpat | 2 box diffs | Subpatcher key order |
| minitaur.maxpat | 13 box diffs | Subpatcher diffs, textbutton text |
| comp-band.maxpat | 13 box diffs, 34 line diffs | parameter_enable added, outlettype added, order added |
| FDNVerb.maxpat | 10 box diffs, 14 line diffs | outlettype on comments, order on lines, patcher key order |
| granularsynthtest.maxpat | 8 box diffs, 18 line diffs | outlettype, parameter_enable, order, patcher key order |

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Binary .mxt format | JSON .maxpat format | MAX 5 (2008) | All patches are human-readable JSON |
| 2-space indent (framework) | 4-space indent (MAX 9.1.2) | Unknown | Framework files and MAX-saved files differ in whitespace |
| patchline always has "order" | MAX omits "order" when 0 | MAX 9.x | Leaner JSON, but breaks naive round-trip |

**No official .maxpat specification exists.** The format is reverse-engineered. All research findings are based on empirical analysis of files generated by MAX 9.0.0 and MAX 9.1.2.

## Open Questions

1. **Indentation: tabs or 4-space?**
   - What we know: CONTEXT.md says "Tab indentation matching MAX's output format." But all MAX 9.1.2-saved files in the project use 4-space indentation, not tabs.
   - What's unclear: Whether MAX uses tabs in some versions/configurations, or if the user intended "tab" as shorthand for "whatever MAX uses."
   - Recommendation: Use 4-space indentation (matching MAX 9.1.2 observed behavior). If the user prefers tabs, adjust the json.dumps indent parameter. For round-trip, detect and preserve the original file's indentation.

2. **ID scoping for subpatchers**
   - What we know: Each Patcher tracks `_next_id` based on max ID found. Subpatchers have their own ID namespace in MAX (obj-1 in parent and obj-1 in subpatcher are different objects).
   - What's unclear: Whether `_next_id` needs to be scoped per-patcher or global.
   - Recommendation: Keep per-patcher `_next_id` (current behavior). This correctly handles subpatcher ID namespacing. Phase 14 mutation code just needs to use the right patcher's `_gen_id()`.

3. **How MAX orders keys in saved files**
   - What we know: MAX 9.1.2 saves only keys that differ from defaults (minimal output). Key order appears to be: maxclass, id, numinlets, numoutlets, outlettype, patching_rect, then other attrs alphabetically.
   - What's unclear: Exact canonical key order for all box types.
   - Recommendation: For new objects added to loaded patches, use the order observed in MAX-saved files: `id, maxclass, numinlets, numoutlets, outlettype, patching_rect, text, fontname, fontsize, ...rest`. For loaded objects, preserve original order.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | None (pytest auto-discovers tests/) |
| Quick run command | `python3 -m pytest tests/test_patcher.py -x -q` |
| Full suite command | `python3 -m pytest tests/ -x -q` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| RW-01 | Load any .maxpat into Patcher/Box/Patchline objects with all data | unit | `python3 -m pytest tests/test_round_trip.py::TestFromDict -x` | Wave 0 |
| RW-01 | Recursive subpatcher loading | unit | `python3 -m pytest tests/test_round_trip.py::TestSubpatcherLoading -x` | Wave 0 |
| RW-01 | Bpatcher attrs preserved on load | unit | `python3 -m pytest tests/test_round_trip.py::TestBpatcherLoading -x` | Wave 0 |
| RW-01 | Unknown objects loaded silently | unit | `python3 -m pytest tests/test_round_trip.py::TestUnknownObjects -x` | Wave 0 |
| RW-02 | Load-save produces identical output | unit | `python3 -m pytest tests/test_round_trip.py::TestRoundTripIdentity -x` | Wave 0 |
| RW-02 | Key ordering preserved | unit | `python3 -m pytest tests/test_round_trip.py::TestKeyOrdering -x` | Wave 0 |
| RW-02 | Numeric precision preserved | unit | `python3 -m pytest tests/test_round_trip.py::TestNumericPrecision -x` | Wave 0 |
| RW-06 | Patchline color survives round-trip | unit | `python3 -m pytest tests/test_round_trip.py::TestPatchlineAttrs -x` | Wave 0 |
| RW-06 | Presentation rects, varnames, scripting names preserved | unit | `python3 -m pytest tests/test_round_trip.py::TestUserState -x` | Wave 0 |
| RW-06 | Extra/unknown attrs preserved | unit | `python3 -m pytest tests/test_round_trip.py::TestExtraAttrs -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_round_trip.py -x -q`
- **Per wave merge:** `python3 -m pytest tests/ -x -q`
- **Phase gate:** Full suite green before `/gsd:verify-work`

### Wave 0 Gaps
- [ ] `tests/test_round_trip.py` -- new test file covering all RW-01, RW-02, RW-06 behaviors
- [ ] Test fixtures: copy 3 MAX-saved .maxpat files to `tests/fixtures/` for deterministic testing (comp-band.maxpat, FDNVerb.maxpat, granularsynthtest.maxpat)
- [ ] Test fixture: create a synthetic .maxpat with colored patchlines for RW-06 color test (no project patches currently have colored patchlines)

## Sources

### Primary (HIGH confidence)
- Empirical analysis of 10 .maxpat files in the project codebase (3 MAX-saved, 7 framework-generated)
- Direct code reading of `src/maxpat/patcher.py` (from_dict lines 1012-1122, to_dict lines 59-70, 188-241, Patchline lines 31-70)
- Round-trip testing with `Patcher.from_dict()` -> `Patcher.to_dict()` -> dict equality comparison
- Python 3.14 json module behavior verification (int/float preservation, key order preservation)

### Secondary (MEDIUM confidence)
- [Cycling '74 forum: Specification for .maxpat JSON format](https://cycling74.com/forums/specification-for-maxpat-json-format) - confirms no official spec exists
- [py2max GitHub](https://github.com/shakfu/py2max) - community library for .maxpat generation, confirms reverse-engineering approach

### Tertiary (LOW confidence)
- MAX indentation format: observed 4-space in MAX 9.1.2 files, but CONTEXT.md says tabs. Needs user clarification.

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH - pure stdlib, no external deps, verified behavior
- Architecture: HIGH - raw dict preservation pattern is well-understood; all 6 diff categories have clear root causes and fix strategies
- Pitfalls: HIGH - all 7 pitfalls verified empirically against real .maxpat files with exact line numbers

**Research date:** 2026-03-15
**Valid until:** Indefinite (stdlib behavior, .maxpat format both stable)
