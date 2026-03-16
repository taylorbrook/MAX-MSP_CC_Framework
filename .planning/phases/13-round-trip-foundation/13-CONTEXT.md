# Phase 13: Round-Trip Foundation - Context

**Gathered:** 2026-03-15
**Status:** Ready for planning

<domain>
## Phase Boundary

Any .maxpat file can be loaded into Patcher/Box/Patchline objects and written back with zero data loss. This is the trust foundation for all direct editing in v2.0. Covers requirements RW-01, RW-02, RW-06.

Scope: from_dict() and to_dict() lossless round-trip. NOT search, mutation, or editing primitives (Phase 14+).

</domain>

<decisions>
## Implementation Decisions

### Diff fidelity standard
- Key-order preserving: JSON keys written in same order as original file — unchanged portions produce zero diff lines
- Numeric precision preserved: int stays int (numinlets: 2), float stays float (fontsize: 12.0) — track original types during parse
- Tab indentation matching MAX's output format — not spaces
- New objects (added after loading) follow MAX's canonical key ordering (id, maxclass, numinlets, numoutlets, outlettype, patching_rect, text, ...) so they blend in with existing objects

### Patch scope
- Round-trip must handle ANY valid .maxpat file — framework-generated, MAX-edited, downloaded from forums, third-party externals, legacy MAX 7/8
- .amxd (Max for Live) wrapper parsing deferred to a future phase — but the inner patcher structure round-trips if extracted
- This scope enables /max-onboard in Phase 16

### Unknown content behavior
- Unknown objects (third-party externals, packages) loaded silently — no DB lookup, no warnings, all data preserved as-is
- Unknown top-level patcher keys stored in patcher.props dict (existing pattern, confirm and test)
- Unknown box keys stored in extra_attrs dict (existing pattern, confirm and test)
- Patchline gets extra_attrs dict mirroring Box pattern — plus named `color` field for the known color attribute
- Error mode: fail fast on structural errors (missing "patcher" key, "boxes" not an array), lenient on content (accept any maxclass, missing fields, weird attrs)

### Patchline color fix
- Add `color: list | None` as named field on Patchline class
- Add `extra_attrs: dict` catch-all for any other patchline attributes
- from_dict() extracts color and unknown keys; to_dict() emits them — fixes the verified color-drop bug

### Claude's Discretion
- Whether to reconstruct bpatcher_attrs from loaded data or just preserve via extra_attrs — pick based on downstream Phase 14+ needs
- Internal representation strategy for key-order tracking (OrderedDict, list of tuples, or other approach)
- parameter_enable reconstruction strategy — ensure it survives round-trip regardless of maxclass
- ID tracking strategy for subpatcher scoping

</decisions>

<specifics>
## Specific Ideas

- Golden rule from research: "if a key exists in the input JSON, it must exist in the output JSON"
- JSON deep-equal is the test assertion: `from_dict(original) → to_dict() == original` — any difference is failure
- One MAX-edited fixture needed: open a project patch in MAX, make a trivial edit, save, commit as test fixture to capture MAX's actual serializer output and added metadata

</specifics>

<code_context>
## Existing Code Insights

### Reusable Assets
- `Box.extra_attrs`: dict catch-all for unknown keys — already works for boxes, pattern to mirror for patchlines
- `Box.__new__()` bypass: loads objects without DB validation — correct for from_dict() loading
- `Patcher.props`: dict for all patcher-level keys except boxes/lines — already preserves unknown top-level keys

### Established Patterns
- `_handled_keys` set in from_dict() controls what goes into extra_attrs vs named fields
- `to_dict()` branches by maxclass (newobj, comment, message, bpatcher, UI widgets) — each branch must emit all preserved fields
- `_saved_object_attributes` tracked separately for subpatchers

### Integration Points
- `patcher.py` lines 31-70: Patchline class — needs extra_attrs and color field
- `patcher.py` lines 1013-1122: from_dict() — main reconstruction method to harden
- `patcher.py` lines 59-70, 188-241: to_dict() methods — must emit all preserved data
- `patcher.py` line 1078: bpatcher_attrs always None on load — verified bug location

### Known Bugs to Fix (verified in STATE.md)
1. Patchline color drop: from_dict() silently drops color and other patchline attributes (lines 1110-1119)
2. Bpatcher attrs not reconstructed: _bpatcher_attrs always None after loading (line 1078)
3. parameter_enable conditionally lost: stripped from extra_attrs by _handled_keys but not re-emitted for all maxclass types

</code_context>

<deferred>
## Deferred Ideas

- .amxd (Max for Live) wrapper format parsing — future phase
- Batch operations with transaction semantics (checkpoint/rollback) — v3.0 ADV-01

</deferred>

---

*Phase: 13-round-trip-foundation*
*Context gathered: 2026-03-15*
