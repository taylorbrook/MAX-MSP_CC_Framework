# Phase 29: Validator Depth - Research

**Researched:** 2026-04-28
**Domain:** Validator pipeline extension (db_lookup.py, validation.py, code_validation.py)
**Confidence:** HIGH

## Summary

Phase 29 is implementation-only. Every architectural decision is locked in CONTEXT.md (D-01..D-20); the schema fields it consumes are all shipped and verified in Phase 28. The job is to wire four new check families through the existing pipeline:

1. **Layer 3 role-mismatch tier** — runs ahead of the legacy `signal:bool` check, dispatched from `_validate_connections` (validation.py:420), tier-table-driven.
2. **Layer 4 domain-restricted guard** — sibling to `_validate_domain_rules` (validation.py:582), top-level `boxes` walk only.
3. **`db.lookup()` install-state warning** — once-per-name `UserWarning` mirroring `_maybe_warn_empty_io` (db_lookup.py:377).
4. **GenExpr Checks 7/8/9 + embedded codebox walker** — three new pattern checks added to `validate_genexpr` (code_validation.py:40), plus a new walker in validation.py that pipes embedded `code` strings through the same function.

**Primary recommendation:** Keep every change inside the three named files. Hoist the existing in-function `_DECL_PREFIXES` constant in code_validation.py:129 to module scope so Check 9 can reuse it. Reuse the `_extract_codebox_code` helper pattern from dsp_critic.py:150 for the embedded-codebox walker. Two existing Layer-4 GenExpr checks (`_check_genexpr_io_syntax`, `_check_genexpr_delay_usage` at validation.py:954/979) overlap with the new code-layer checks — keep them; they fire on `.maxpat`-embedded codeboxes and do not duplicate the .gendsp path. The new walker in this phase makes them redundant for the embedded path, but removal is out of scope (Phase 33-class cleanup).

## User Constraints (from CONTEXT.md)

### Locked Decisions

#### Role-Mismatch Action Tiering (VALID-01, VALID-05)
- **D-01:** Tiered by mismatch class with suggestion-driven severity. ERROR + auto-remove for canonical mechanical fixes (`status` → signal-only inlet → `"use snapshot~"`; `trigger` → signal-only → `"use sig~ or click~"`; `data`/`list` → signal-only → still reject). WARNING + preserve for judgment-laden intent (`trigger`/`list` → float inlet). Silent for legitimate per-CLAUDE.md cases (`float`/`audio` → signal inlet).
- **D-02:** Role check runs FIRST; falls through to legacy on `None`. When `get_signal_role(src, outlet)` returns non-None, run tier check; skip legacy `signal:bool`. When None (unaudited per Phase 28 D-02), run legacy `signal:bool` check unchanged. No double-emission.
- **D-03:** Auto-remove keeps `auto_fixed=True` for ERROR tier (consistent with current Layer 3 signal→control). WARNING tier never removes — `auto_fixed=False`, line preserved.
- **D-04:** Error message format: `"{src_role} outlet → {dst_kind} inlet: {suggestion}"`. Examples: `"status outlet → signal inlet: use snapshot~"`, `"trigger outlet → float inlet: trigger feeding float; user may intend bang counting"`.

#### Domain-Restricted Guard (VALID-02, VALID-05)
- **D-05:** Explicit `domain_restricted` only — no canonical-domain inference.
- **D-06:** New Layer 4 check `_validate_domain_restrictions` in validation.py, sibling to `_validate_domain_rules` (line 582).
- **D-07:** Top-level scope only. No subpatcher / rnbo~ inner recursion.
- **D-08:** Always ERROR severity, never auto-fixed.

#### Install-State Warning (VALID-03, VALID-05)
- **D-09:** `db.lookup()` once-per-name with cached suppression. Mirrors `_maybe_warn_empty_io`. New `_install_warned: set[str]`.
- **D-10:** Phase 28 D-10 reaffirmed: warn ONLY on explicit `False`. `None` (unaudited) stays silent.
- **D-11:** Match empty-IO message shape + suggestion line. Same `UserWarning`, same `stacklevel=4`.
- **D-12:** No `ValidationResult` emission for install-state. The `db.lookup()` warning IS the surface.

#### .gendsp / Embedded Codebox Validation (VALID-04, VALID-05)
- **D-13:** Extend `validate_genexpr` in code_validation.py with three new ERROR-level checks. Single entry point covers `.gendsp` and embedded codeboxes.
- **D-14:** Check 7 — `delay()` rejection: `\bdelay\s*\(` → ERROR `"delay() is not supported in GenExpr codebox; use Delay.read/write (declare Delay myDelay(max_samples) first)"`.
- **D-15:** Check 8 — `clip()` rejection: `\bclip\s*\(` → ERROR `"clip() does not exist in expr/GenExpr; use min(max(x, lo), hi)"`.
- **D-16:** Check 9 — init-before-if/else: light flow analysis; for each variable assigned inside an if/else block, verify it's assigned before the block (or declared via Param/History). ERROR `"variable '{name}' used inside if/else without prior init; GenExpr errors with 'not defined'"`.
- **D-17:** Wire embedded gen~ codeboxes to `validate_genexpr` this phase. New call site walks every gen~ box's embedded `patcher`, finds `maxclass: "codebox"` boxes with a `code` attribute, and runs `validate_genexpr` on each. ValidationResult `layer="code"`.

#### Severity Vocabulary & Two-Channel Contract (VALID-05)
- **D-18:** Keep two existing vocabularies. `ValidationResult.level ∈ {error, warning, info, fixed}`; `CriticResult.severity ∈ {blocker, warning, note}`. No unification.
- **D-19:** Per-family severity table (canonical):
  | Family | ERROR | WARNING |
  |---|---|---|
  | Role mismatch (Layer 3) | status/trigger/data/list → signal-only inlet | trigger/list → float inlet |
  | Domain restriction (Layer 4) | always | n/a |
  | Install state (db.lookup) | n/a | always when `verified_installed: false` |
  | GenExpr (.gendsp + embedded) | `delay()`, `clip()`, init-before-if/else, declaration ordering | missing semicolon, Param missing min/max |
- **D-20:** Init-before-if/else known limitations (documented, accepted): variables shadowed by inner declaration may flag; multi-return destructuring may not be detected as initialized. Suggestion line includes "if this is a false positive, restructure to assign before the if/else."

### Claude's Discretion

- **Tier-table location** — inline dict in `validation.py` near `_validate_connections`, OR module-level `_ROLE_TIER_TABLE` constant. Either works.
- **Test fixture choices** — pick 2–3 objects from existing fixtures plus add 1 explicit `verified_installed: false` example (e.g., `bach.llll2list`) and 1 `domain_restricted: ["rnbo"]` example (e.g., `floor~`). Re-use Phase 28's `tests/test_schema_extensions.py` fixture pattern.
- **Exact `_install_warned` placement** — instance set on `ObjectDatabase`, sibling to `_empty_io_warned`. Reset behavior in tests via `db._install_warned.clear()` if needed.
- **Where the embedded-codebox walker lives** — new private function in `validation.py` (e.g., `_validate_embedded_genexpr`) called from `validate_patch()` after Layer 4. Validation.py preferred because findings flow through `ValidationResult` pipeline.
- **Whether to emit single warning or many on init-before-if/else** — first-error-and-stop is fine (matches Check 5's `break` posture).
- **Embedded codebox walker recursion** — gen~ patchers can themselves contain nested gen~ subpatchers; recurse vs flat is up to the planner.

### Deferred Ideas (OUT OF SCOPE)

- Canonical-domain inference for `domain_restricted` — Phase 30+ if explicit annotations prove sparse.
- Recursive scope tracking inside subpatchers / nested rnbo~ — Phase 30+ if real misuse emerges.
- Patcher API construction-time fast-fail for domain-restricted objects.
- Validation `InstallWarning` subclass.
- `validate_patch()` per-box install-state ValidationResult.
- Severity vocabulary unification (v6.0+).
- Promoting structure-critic warnings to ERROR/blocker (Phase 33).
- Per-inlet `signal_role` (v6.0+).
- Full scope analysis for init-before-if/else.

## Phase Requirements

| ID | Description | Research Support |
|----|-------------|------------------|
| VALID-01 | Layer-3 connection validator emits role-aware errors instead of generic type-mismatch warnings | `_validate_connections` (validation.py:420) — splice tier dispatch ahead of existing legacy branch at line 505; consume `db.get_signal_role(name, outlet)` (db_lookup.py:553); legacy fall-through preserved when role is `None`. |
| VALID-02 | Domain-restricted guard fails hard when an `rnbo`-only object appears at MSP top level outside an `rnbo~` container | New `_validate_domain_restrictions` sibling of `_validate_domain_rules` (validation.py:582). Walks top-level `patch_dict["patcher"]["boxes"]` only (D-07). Consumes `db.is_domain_restricted` / `db.get_domain_restrictions` (db_lookup.py:627/612). |
| VALID-03 | Lookup-time install-state warnings fire when `verified_installed: false` is used | `db.lookup()` (db_lookup.py:300) — add `_maybe_warn_install_state` call mirroring `_maybe_warn_empty_io` (line 377). New `_install_warned: set[str]` in `__init__` (line 90 sibling). Consumes `obj.get("verified_installed") is False` (verbatim guard from D-09/D-10). |
| VALID-04 | External `.gendsp` files validated with same rigor as embedded codeboxes | Three new ERROR checks in `validate_genexpr` (code_validation.py:40). New walker `_validate_embedded_genexpr` in validation.py recurses into gen~ inner patchers, calls `validate_genexpr` on each codebox `code`. Hooks: `validate_code_file` (hooks.py:273) already routes .gendsp → `validate_genexpr`; the new checks fire automatically. |
| VALID-05 | Validation outputs distinguish error/warning consistently across role-aware checks, domain guard, install warnings, and `.gendsp` checks | Per-family severity table from D-19. Implementation guarantee: each check site asserts the `level` value at construction time. Test plan asserts severity per family. |

## Implementation Approaches

### VALID-01: Role-Mismatch Tier Dispatch

**Splice point:** `_validate_connections()` in validation.py at line 505 (the `if is_signal_source:` branch).

**New flow inside `_validate_connections` per-line loop:**

```python
# After existing bounds checks (lines 475-495) and BEFORE the existing
# signal-source branch at line 505, dispatch to role-aware check first.
src_name = _extract_object_name(src_box)
if src_name is not None:
    src_role = db.get_signal_role(src_name, src_outlet)
    if src_role is not None:
        # Role check runs FIRST per D-02; tier dispatch handles all four
        # outcomes (ERROR+auto-remove, WARNING+preserve, silent, fall-through).
        tier_result = _classify_role_mismatch(
            src_role, dst_box, dst_inlet, db
        )
        if tier_result is not None:
            level, message_suffix, auto_fix = tier_result
            results.append(ValidationResult(
                "connections", level,
                f"{src_role} outlet → {dst_kind} inlet: {message_suffix}",
                auto_fixed=auto_fix,
            ))
            if auto_fix:
                remove_this = True
            # Skip legacy signal:bool branch (D-02: clean separation).
            if remove_this:
                to_remove.append(idx)
            continue  # Move to next line — role result is final.
        # role returned None or "audio matches signal inlet" silent path:
        # fall through to legacy signal:bool branch unchanged.
```

**`_classify_role_mismatch` helper signature:**

```python
def _classify_role_mismatch(
    src_role: str,
    dst_box: dict,
    dst_inlet: int,
    db: ObjectDatabase,
) -> tuple[str, str, bool] | None:
    """Return (level, message_suffix, auto_fix) or None to fall through.

    None means 'no role-aware finding — let the legacy signal:bool branch run.'
    """
    dst_kind = _classify_dst_inlet(dst_box, dst_inlet, db)  # "signal", "float", "control", "signal/float"
    return _ROLE_TIER_TABLE.get((src_role, dst_kind))
```

**Tier table (recommended: module-level constant for grep-ability and one-line edits):**

```python
# Locked per D-04 / D-19. Maps (src_role, dst_kind) -> (level, suggestion, auto_fix).
# None entries (or absence from table) mean 'fall through to legacy signal:bool check'.
# "audio" -> "signal" is intentionally absent: the legacy branch already handles it.
_ROLE_TIER_TABLE: dict[tuple[str, str], tuple[str, str, bool]] = {
    # ERROR + auto-remove (mechanical fix exists)
    ("status",  "signal"): ("error", "use snapshot~", True),
    ("trigger", "signal"): ("error", "use sig~ or click~", True),
    ("data",    "signal"): ("error", "role mismatch; data outlet cannot drive signal inlet", True),
    ("list",    "signal"): ("error", "role mismatch; list outlet cannot drive signal inlet", True),
    # WARNING + preserve (judgment-laden intent)
    ("trigger", "float"):  ("warning", "trigger feeding float; user may intend bang counting", False),
    ("list",    "float"):  ("warning", "list outlet feeding float; bach.* often does this — verify", False),
    # Silent paths (per D-01) are NOT in this table:
    #   ("float", "signal")  — CLAUDE.md exception: signal/float inlets accept both.
    #   ("audio", "signal")  — legacy behavior; legacy branch handles it.
}
```

**`_classify_dst_inlet` helper** (returns the `dst_kind` token used in the message):

```python
def _classify_dst_inlet(dst_box: dict, dst_inlet: int, db: ObjectDatabase) -> str:
    """Return inlet kind: 'signal', 'float', 'signal/float', or 'control'.

    Mirrors _inlet_accepts_signal (validation.py:543) but returns a label
    instead of a bool. Used only for error message formatting.
    """
    name = _extract_object_name(dst_box)
    if name is None:
        return "control"  # structural maxclass; conservative
    obj = db.lookup(name)
    if obj is None:
        return "control"
    inlets = obj.get("inlets", [])
    if dst_inlet >= len(inlets):
        return "control"
    inlet = inlets[dst_inlet]
    inlet_type = (inlet.get("type") or "").lower()
    if inlet.get("signal") and "float" in inlet_type:
        return "signal/float"
    if inlet.get("signal"):
        return "signal"
    if "float" in inlet_type or inlet.get("type", "").lower() == "float":
        return "float"
    return "control"
```

**Why module-level table over inline dict:** The table is the literal D-19 contract. A grep for `_ROLE_TIER_TABLE` is the canonical way to inspect/audit it; inline dicts inside a 100-line function are harder to find on review and lock the constant inside the function namespace. Recommendation: module-level.

### VALID-02: Domain-Restricted Guard

**New function in validation.py, sibling to `_validate_domain_rules` (line 582).** Add it to the `validate_patch` orchestration after Layer 4 domain rules:

```python
# In validate_patch() at line 143 (after _validate_domain_rules):
results.extend(_validate_domain_restrictions(patch_dict, db))


def _validate_domain_restrictions(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """D-06: Hard-block top-level boxes whose domain_restricted whitelist
    forbids the outer (non-rnbo, non-m4l, non-gen) MSP/Max context.

    Top-level only per D-07 — no recursion into subpatchers or rnbo~ inner
    patchers. Always ERROR + auto_fixed=False per D-08.
    """
    results: list[ValidationResult] = []
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        name = _extract_object_name(box)
        if name is None:
            continue
        restrictions = db.get_domain_restrictions(name)
        if not restrictions:
            continue
        # Top-level patcher is by definition NOT inside any rnbo~/m4l/gen~
        # container. Any restriction list is a violation here.
        results.append(ValidationResult(
            "domain", "error",
            f"'{name}' is restricted to {restrictions}; "
            f"not allowed at MSP/Max top level. "
            f"Wrap in {restrictions[0]}~ container or use a non-restricted equivalent.",
            auto_fixed=False,
        ))
    return results
```

**Note on layer label:** Use `layer="domain"` to align with the existing Layer 4 sibling pattern. The CONTEXT.md text says "ValidationResult('domain', 'error', ...)" — match that exactly.

**Top-level scope rationale (D-07):** A box appears at the top level iff it lives in `patch_dict["patcher"]["boxes"]` directly, not inside any `box["patcher"]` sub-dict. We are guaranteed correctness by simply not recursing — `floor~` inside a `gen~`'s embedded patcher is not iterated by this loop, so no false positive fires.

### VALID-03: Install-State Warning in db.lookup()

**Mirror `_maybe_warn_empty_io` (db_lookup.py:377) exactly.** Two surgical edits to db_lookup.py:

1. **Init the cache set** (line 90 sibling, in `__init__`):
   ```python
   self._install_warned: set[str] = set()
   ```

2. **Wire a new helper** (sibling of `_maybe_warn_empty_io`, after line 400):
   ```python
   def _maybe_warn_install_state(self, canonical: str, obj: dict) -> None:
       """Emit a one-time UserWarning if this canonical is explicitly
       verified_installed: false. Dedup via _install_warned. Per D-10,
       absent (None) is silent — only explicit False fires.
       """
       if obj.get("verified_installed") is not False:
           return
       if canonical in self._install_warned:
           return
       self._install_warned.add(canonical)
       warnings.warn(
           f"{canonical} marked verified_installed: false — not present "
           f"in this install. Run package extraction or remove from "
           f"overrides.json if intentional.",
           UserWarning,
           stacklevel=4,
       )
   ```

3. **Call it from `lookup()` at every existing `_maybe_warn_empty_io` site** (db_lookup.py lines 329, 333, 337):
   ```python
   if allowed_packages is None:
       self._maybe_warn_empty_io(canonical, obj)
       self._maybe_warn_install_state(canonical, obj)  # <-- new
       return obj
   if "package" not in obj:
       self._maybe_warn_empty_io(canonical, obj)
       self._maybe_warn_install_state(canonical, obj)  # <-- new
       return obj
   if obj.get("package") in allowed_packages:
       self._maybe_warn_empty_io(canonical, obj)
       self._maybe_warn_install_state(canonical, obj)  # <-- new
       return obj
   ```

**Why three sites instead of one:** Each early-return path in `lookup()` is the gate where we hand the obj back to the caller. Putting the warning at the call site (not at the top of the function) ensures we don't warn on package-filtered-out objects that the caller never receives.

**stacklevel=4 rationale (D-11):** matches `_maybe_warn_empty_io`. Call path is user → `lookup()` → `_maybe_warn_install_state` → `warnings.warn`; stacklevel=4 points to the user's call frame (one level deeper than the lookup).

### VALID-04: GenExpr Checks 7/8/9 + Embedded Codebox Walker

#### Check 7 (delay() rejection) and Check 8 (clip() rejection) — code_validation.py

Add after Check 6 (line 181), before `return results`:

```python
    # Check 7: delay() rejection (D-14) — compile-fatal, ERROR.
    if re.search(r"\bdelay\s*\(", code):
        results.append(ValidationResult(
            "code", "error",
            "delay() is not supported in GenExpr codebox; use Delay.read/write "
            "(declare Delay myDelay(max_samples) first)",
        ))

    # Check 8: clip() rejection (D-15) — compile-fatal, ERROR.
    if re.search(r"\bclip\s*\(", code):
        results.append(ValidationResult(
            "code", "error",
            "clip() does not exist in expr/GenExpr; use min(max(x, lo), hi)",
        ))
```

**Important comment-stripping caveat:** D-14/D-15 say "outside comments". The simplest treatment: strip `//` line comments from `code` once at the top of `validate_genexpr` and run all regex checks against the stripped form. Block comments (`/* ... */`) are not used in GenExpr and need not be handled. A single helper `_strip_line_comments(code)` solves both checks at once.

#### Check 9 (init-before-if/else) — code_validation.py

**Hoist `_DECL_PREFIXES` to module scope first** (currently scoped inside `validate_genexpr` at line 129). Other code in the same file (`decl_pattern` at line 159) implicitly needs it too — module-level dedup is a small win.

```python
# At module top, alongside _GENEXPR_KEYWORDS:
_DECL_PREFIXES = ("Param ", "History ", "Delay ", "Buffer ", "Data ")
```

**Check 9 implementation** (light flow analysis, first-error-and-stop per discretion):

```python
    # Check 9: init-before-if/else (D-16) — variables assigned only inside
    # if/else blocks fail GenExpr compilation. Light flow analysis with
    # documented false-positive limitations (D-20).
    #
    # Strategy:
    #   1. Walk lines, track brace depth (opened by 'if'/'else { ' or 'else {').
    #   2. For each assignment "name = ..." at depth >= 1, collect name.
    #   3. For each such name, scan lines BEFORE the if/else block for either
    #      a depth-0 assignment "name = ..." OR a declaration matching
    #      _DECL_PREFIXES that introduces 'name'.
    #   4. If neither is found -> ERROR with name + line number.
    declared = set()
    for match in re.finditer(
        r"(?:Param|History|Delay|Buffer|Data)\s+(\w+)\s*\(", code
    ):
        declared.add(match.group(1))

    if_else_inits: list[tuple[str, int]] = []   # (var_name, line_no_of_block_start)
    pre_block_inits: set[str] = set()
    depth = 0
    block_start_line = -1
    assign_pattern = re.compile(r"^(\w+)\s*=")

    for i, line in enumerate(lines):
        stripped = line.strip()
        if not stripped or stripped.startswith("//") or stripped.startswith("#"):
            continue
        # Track if/else block entry
        opens = stripped.count("{")
        closes = stripped.count("}")
        if depth == 0 and re.match(r"\b(if|else)\b", stripped) and opens > 0:
            block_start_line = i
        m = assign_pattern.match(stripped)
        if m:
            name = m.group(1)
            if depth == 0:
                pre_block_inits.add(name)
            else:
                # only flag if not already initialized at depth 0 or declared
                if name not in pre_block_inits and name not in declared:
                    if_else_inits.append((name, block_start_line))
        depth += opens - closes
        if depth < 0:
            depth = 0  # unbalanced; another check already flags it

    # Emit one ERROR per uninitialized name (first occurrence).
    seen = set()
    for name, line_no in if_else_inits:
        if name in seen:
            continue
        seen.add(name)
        results.append(ValidationResult(
            "code", "error",
            f"variable '{name}' used inside if/else without prior init "
            f"(line {line_no + 1}); GenExpr errors with 'not defined'. "
            f"If this is a false positive (e.g., shadowed inner declaration), "
            f"restructure to assign '{name}' before the if/else.",
        ))
        break  # first-error-and-stop per discretion (matches Check 5)
```

**Documented limitations (D-20):** the `break` after first finding matches Check 5's posture. Variables shadowed by inner declarations and multi-return destructuring are accepted false-positive sources, surfaced via the suggestion line.

#### Embedded Codebox Walker — validation.py

**Where:** new private function in validation.py, called from `validate_patch()` after Layer 4. Per discretion, validation.py is preferred so findings flow through the `ValidationResult` pipeline (consistent with `.gendsp` going through `hooks.validate_code_file`).

**Recursion decision:** **flat (top-level gen~ only)**, mirroring D-07's domain-guard scope rule. Survey of 28 real patches shows zero nested `gen~` inside `gen~` inner patchers, and zero `codebox` boxes at depths > 1. Recursive walking adds complexity for an empirically zero-case. If a Phase 30+ regression demonstrates real nested codeboxes, recursion is a one-line change.

```python
# In validate_patch() at line 143 (after the new domain-restricted guard):
results.extend(_validate_embedded_genexpr(patch_dict, db))


def _validate_embedded_genexpr(
    patch_dict: dict,
    db: ObjectDatabase,
) -> list[ValidationResult]:
    """D-17: Walk top-level gen~ boxes; for each embedded codebox with a
    'code' attribute, run validate_genexpr and surface findings as
    ValidationResult(layer='code', ...).

    Top-level only — does not recurse into nested gen~. Survey of real
    patches shows no nested case in v5.0; revisit if Phase 30 surfaces one.
    """
    from src.maxpat.code_validation import validate_genexpr

    results: list[ValidationResult] = []
    for box_entry in patch_dict["patcher"]["boxes"]:
        box = box_entry.get("box", {})
        if box.get("maxclass") != "gen~":
            continue
        inner = box.get("patcher")
        if not inner:
            continue
        for inner_entry in inner.get("boxes", []):
            inner_box = inner_entry.get("box", {})
            if inner_box.get("maxclass") != "codebox":
                continue
            code = inner_box.get("code")
            if not code:
                continue
            # Tag findings with the gen~ box id for debuggability
            gen_id = box.get("id", "<unknown>")
            for r in validate_genexpr(code, db=db):
                results.append(ValidationResult(
                    r.layer, r.level,
                    f"gen~ '{gen_id}' codebox: {r.message}",
                    auto_fixed=r.auto_fixed,
                ))
    return results
```

**Reuse note:** dsp_critic.py:150 has `_extract_codebox_code(gen_box)`. The walker above intentionally inlines the search rather than reusing it because:
1. We need to handle multiple codeboxes inside a single gen~ (the helper returns the first one).
2. We need the gen~ box id for the tagged message.
3. The walker stays self-contained in validation.py without importing from critics/.

**Interaction with existing Layer 4 GenExpr checks:** `_check_genexpr_io_syntax` (validation.py:954) and `_check_genexpr_delay_usage` (line 979) already fire on embedded codeboxes. The new walker re-runs `validate_genexpr` on the same code, which performs the same delay() check (Check 7) plus the new ones. This is **duplicate emission** for embedded codeboxes (`delay()` will fire from both Layer 4 and the walker). Two options:

   - **Recommended:** Remove the two existing Layer 4 checks (`_check_genexpr_io_syntax`, `_check_genexpr_delay_usage`) and let the walker handle them. The walker's `validate_genexpr` covers `delay()` (Check 7), Param syntax (Check 4), declaration ordering (Check 5), and now `clip()` (Check 8) and init-before-if/else (Check 9). This is strictly more rigorous.
   - **Alternative:** Keep both. Duplicate emission is loud but harmless (caller dedup is trivial via `set(r.message for r in results)`).

   Since CONTEXT.md does not lock removal, **recommend the first option but document the call path so the planner can decide**. Removing the two old checks is a 30-line deletion from validation.py and removes two test cases from test_validation.py — manageable in a single Wave.

### VALID-05: Severity Vocabulary

Per-check-site assertions ensure the contract holds:

| Site | Level | Auto-fix | Source |
|------|-------|----------|--------|
| Role tier ERROR (status/trigger/data/list → signal) | `"error"` | True | _ROLE_TIER_TABLE |
| Role tier WARNING (trigger/list → float) | `"warning"` | False | _ROLE_TIER_TABLE |
| Domain restriction | `"error"` | False | `_validate_domain_restrictions` |
| Install state | (n/a — UserWarning, not ValidationResult) | n/a | `_maybe_warn_install_state` |
| GenExpr Check 7 (delay) | `"error"` | False | `validate_genexpr` |
| GenExpr Check 8 (clip) | `"error"` | False | `validate_genexpr` |
| GenExpr Check 9 (init) | `"error"` | False | `validate_genexpr` |
| GenExpr Check 4 (Param min/max) | `"warning"` | False | existing — unchanged |
| GenExpr Check 5 (decl order) | `"error"` | False | existing — unchanged |

## Codebase Anchors Verified

Every extension point confirmed by direct file inspection. Line numbers are absolute in the as-of-2026-04-28 main HEAD.

| Anchor | File | Line | Purpose | Status |
|--------|------|------|---------|--------|
| `_SIGNAL_ROLE_ENUM` | db_lookup.py | 41 | Six-value enum for role validation | shipped |
| `_DOMAIN_ENUM` | db_lookup.py | 48 | Three-value enum for restriction validation | shipped |
| `_DOMAIN_TO_FIELD` | db_lookup.py | 56 | Maps enum → domain JSON field | shipped |
| `ObjectDatabase.__init__` | db_lookup.py | 71 | Add `self._install_warned` here, line 90 sibling | extension point |
| `_load()` | db_lookup.py | 94 | No edit needed — schema already loads | confirmed |
| `_validate_schema_extensions` | db_lookup.py | 213 | Already validates the three new fields; no change | shipped |
| `_apply_signal_role_writethrough` | db_lookup.py | 275 | Already projects role → signal:bool | shipped |
| `lookup()` | db_lookup.py | 300 | Add `_maybe_warn_install_state` calls at lines 329, 333, 337 | extension point |
| `_maybe_warn_empty_io` | db_lookup.py | 377 | Template for new `_maybe_warn_install_state` | reuse template |
| `get_signal_role(name, outlet)` | db_lookup.py | 553 | Returns role string / None per D-02; consumed by Layer 3 | shipped |
| `get_install_state(name)` | db_lookup.py | 587 | Returns Optional[bool]; consumed by `_maybe_warn_install_state` | shipped |
| `is_verified_installed(name)` | db_lookup.py | 602 | Bool collapse; not used directly in Phase 29 | shipped |
| `get_domain_restrictions(name)` | db_lookup.py | 612 | List copy per T-28-04; consumed by Layer 4 | shipped |
| `is_domain_restricted(name)` | db_lookup.py | 627 | Bool sugar; consumed by Layer 4 | shipped |
| `validate_patch()` | validation.py | 84 | Orchestrator — add 2 new layer calls (Layer 4b domain restriction, Layer 5 embedded gen~) | extension point |
| `_validate_connections()` | validation.py | 420 | Splice tier dispatch ahead of legacy branch at line 505 | extension point |
| `_inlet_accepts_signal()` | validation.py | 543 | Reused as inspiration for new `_classify_dst_inlet` helper | template |
| `_validate_domain_rules()` | validation.py | 582 | Sibling pattern for `_validate_domain_restrictions` | reuse template |
| `_check_genexpr_io_syntax` | validation.py | 954 | EXISTING — overlaps with new code-layer; consider removing | overlap |
| `_check_genexpr_delay_usage` | validation.py | 979 | EXISTING — overlaps with new Check 7 in code_validation.py | overlap |
| `validate_genexpr()` | code_validation.py | 40 | Add Checks 7, 8, 9 after Check 6 (after line 181) | extension point |
| `_DECL_PREFIXES` | code_validation.py | 129 | LOCAL constant — hoist to module level for Check 9 reuse | refactor |
| `validate_code_file()` | hooks.py | 273 | Already routes .gendsp → validate_genexpr; no edit needed | confirmed |
| `_extract_codebox_code` | dsp_critic.py | 150 | Helper pattern for embedded-codebox walker (don't import; inline) | template |
| Phase 28 fixtures | overrides.json | 11058, 11066, 11074, 2142 | `floor~` (domain), `bach.llll2list` (install), `snapshot~` + `cycle~` (role) | confirmed present |

**Key verification commands run:**

```python
>>> db = ObjectDatabase()
>>> db.get_signal_role("cycle~", 0)        # "audio"
>>> db.get_signal_role("snapshot~", 0)     # "float"
>>> db.get_signal_role("trigger", 0)       # None (legacy signal:false; D-02)
>>> db.get_install_state("bach.llll2list") # False
>>> db.is_domain_restricted("floor~")      # True
>>> db.get_domain_restrictions("floor~")   # ["rnbo"]
```

All four canonical fixtures are present and behaving correctly. Phase 29 implementation can proceed against the stable schema-extension surface.

## Discretion Items Resolved

### 1. Where should `_validate_embedded_genexpr` live?

**Recommendation:** New private function in **validation.py**, called from `validate_patch()` after Layer 4. Reasons:

- `ValidationResult` is the consumer-facing pipeline — emitting `CriticResult` from a critic file (dsp_critic.py) would create a second channel that downstream tooling (`has_blocking_errors`, `validate_file`) does not check.
- `.gendsp` file validation already routes through `validate_genexpr` via `hooks.validate_code_file` (hooks.py:273). Mirroring that path for embedded codeboxes is the smallest delta.
- dsp_critic.py is explicitly NOT modified per CONTEXT.md ("do NOT modify; reference only"). validation.py is the logical home.

### 2. Should the embedded-codebox walker recurse into nested gen~ subpatchers?

**Recommendation: No — flat top-level walk only.**

Empirical evidence: surveyed 28 real `.maxpat` files in `/Users/taylorbrook/Dev/MAX/patches/`. **Zero** contain nested `gen~` inside another `gen~`'s inner patcher. Codeboxes appear exclusively at depth 1 (inside top-level `gen~`). Adding recursion now is YAGNI; mirroring D-07's "top-level only" stance keeps the rule consistent across both Phase 29 walkers. If Phase 30 surfaces a real nested case, the recursion change is a 4-line edit.

### 3. Tier-table location: inline dict vs. module-level constant?

**Recommendation: module-level `_ROLE_TIER_TABLE` constant** in validation.py.

The table IS the literal D-19 contract — it should be greppable by name, locatable for code review, and trivially testable in isolation (e.g., a unit test that asserts `set(_ROLE_TIER_TABLE.keys())` matches the locked decision matrix). Inline dicts in 100+-line functions are harder to find and lock the constant inside the function namespace. Module-level also lets a future `tests/test_validation.py::test_role_tier_table_locked()` assert the table contents against the D-19 spec verbatim.

### 4. Test fixture choices

All four canonical fixtures already exist in overrides.json:

| Fixture | Annotation | Phase 29 use |
|---------|------------|--------------|
| `floor~` (line 11058) | `domain_restricted: ["rnbo"]` | Domain-guard ERROR test |
| `bach.llll2list` (line 11066) | `verified_installed: false` | Install-warning test |
| `snapshot~` (line 11074) | `signal_role: "float"` outlet 0 | Role-mismatch tier (status outlet feeds float, etc.) |
| `cycle~` (line 2142) | `signal_role: "audio"` outlet 0 | Legacy signal:bool / write-through anchor |

**No new overrides.json fixtures needed.** Phase 29 tests reuse the production DB via `ObjectDatabase()` for integration tests and `_make_db_root` (test_schema_extensions.py:40) for isolated fail-fast / warning tests. Mirror the `TestSchemaValidation`, `TestGetters`, `TestAuditFunctions` class structure with new `TestRoleAwareValidation`, `TestDomainGuard`, `TestInstallWarning`, `TestGenExprChecks`.

**Additional fixture for tier-table tests:** None needed. The `_make_db_root` helper from test_schema_extensions.py builds an isolated DB with one cycle~ entry; `domain_restricted` and `signal_role` overrides on cycle~ exercise every tier-table cell without touching production overrides.

### 5. Phase 28 getter signatures and edge cases

Verified against db_lookup.py:

| Getter | Signature | Returns | Edge cases |
|--------|-----------|---------|-----------|
| `get_signal_role` | `(name: str, outlet: int) -> str \| None` | role string or None | Out-of-range outlet → None; unknown name → None; legacy `signal: false` → None per D-02; legacy `signal: true` → `"audio"` (reverse derivation) |
| `get_install_state` | `(name: str) -> bool \| None` | tri-state | Unknown name → None; absent field → None; explicit True → True; explicit False → False |
| `is_verified_installed` | `(name: str) -> bool` | bool | True ONLY when `state is True`; False when None or False |
| `get_domain_restrictions` | `(name: str) -> list[str]` | list copy | Unknown name → []; absent → []; T-28-04: returns fresh `list(...)` copy |
| `is_domain_restricted` | `(name: str) -> bool` | bool | `bool(get_domain_restrictions(name))` |

Phase 29 consumers MUST honor the None-vs-False distinction:

- **Layer 3:** when `get_signal_role(src, outlet) is None` → fall through to legacy `signal:bool` branch unchanged (D-02). Do NOT emit a role-mismatch finding; the data is uncurated.
- **`_maybe_warn_install_state`:** check `obj.get("verified_installed") is False` (not `is None`, not falsy). Avoiding the `is False` typo is what D-10 locks.
- **`get_domain_restrictions`** returns a list copy — Layer 4 may mutate freely without polluting the schema.

### 6. Existing legacy signal:bool tests that the new ordering must preserve

In tests/test_validation.py, three tests exercise the legacy fall-through path that role-first ordering must NOT break:

| Test | Line | Scenario | Why it stays green |
|------|------|----------|--------------------|
| `test_signal_to_signal_passes` | 243 | `cycle~` → `*~` (signal-to-signal) | `cycle~` has `signal_role: "audio"` (curated) — role-first path returns silent (audio→signal not in `_ROLE_TIER_TABLE`); legacy branch never runs but the result is the same: no error. |
| `test_signal_to_control_only_inlet_detected` | 257 | `cycle~` outlet → `print` inlet (control-only) | `cycle~` role is `"audio"`; `print` inlet is control. `("audio", "control")` is not in tier table → fall through to legacy `signal:bool` branch → existing auto-remove fires. Test passes unchanged. |
| `test_control_to_signal_inlet_passes` | 271 | `message` → `cycle~` inlet 0 (signal/float) | `message` outlet has no curated role → `get_signal_role` returns None → fall through to legacy branch unchanged. Test passes. |

**Critical invariant for the planner:** **`("audio", "signal")` and `("audio", "control")` MUST be absent from `_ROLE_TIER_TABLE`** so the legacy branch retains exclusive control of the audio-source path. The tier table is for non-audio roles ONLY (status/trigger/data/list). Otherwise we'd silently change the auto-fix behavior of every existing audio-source test.

A new defensive test is recommended: `test_role_tier_table_excludes_audio_keys` asserting `("audio", k) not in _ROLE_TIER_TABLE` for all k. Cheap insurance.

### 7. Regex patterns for Checks 7, 8, 9

**Reuse `_DECL_PREFIXES`:** hoist to module-level at code_validation.py top.

| Check | Pattern | Notes |
|-------|---------|-------|
| Check 7 (delay) | `r"\bdelay\s*\("` | Word-boundary prevents matching `Delay.read(`, `mydelay(`, etc. |
| Check 8 (clip) | `r"\bclip\s*\("` | Same word-boundary discipline. |
| Check 9 (init) | `r"^(\w+)\s*="` (assignment) + brace-depth tracking | See implementation block above. Names already in `declared` (matches `_DECL_PREFIXES` declarations) are skipped. |

**Comment stripping:** apply once at the start of `validate_genexpr` via a 3-line helper:

```python
def _strip_line_comments(code: str) -> str:
    return "\n".join(re.sub(r"//.*$", "", line) for line in code.split("\n"))
```

This solves "outside comments" for Checks 7/8 with one pass; Check 9's line-by-line walk already skips `//`-prefixed lines.

## Validation Architecture

Nyquist validation enabled (`workflow.nyquist_validation: true` in `.planning/config.json`). Test sampling strategy maps to the four new check families.

### Test Framework

| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 (per `tests/__pycache__/test_schema_extensions.cpython-314-pytest-9.0.2.pyc` evidence) |
| Config file | none — pytest auto-discovers from `tests/` |
| Quick run command | `python3 -m pytest tests/test_validation.py tests/test_code_validation.py tests/test_schema_extensions.py -x -q` |
| Full suite command | `python3 -m pytest -x -q` |

### Phase Requirements → Test Map

| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|--------------|
| VALID-01 | status outlet → signal inlet emits role-aware ERROR with `"use snapshot~"` suggestion | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_status_to_signal_emits_use_snapshot -x` | ❌ Wave 0 (new) |
| VALID-01 | trigger outlet → signal inlet emits role-aware ERROR with `"use sig~ or click~"` suggestion | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_trigger_to_signal_emits_use_sig -x` | ❌ Wave 0 (new) |
| VALID-01 | data/list outlet → signal inlet emits ERROR with no canonical fix language | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_data_list_to_signal_emits_role_mismatch -x` | ❌ Wave 0 (new) |
| VALID-01 | trigger outlet → float inlet emits WARNING and PRESERVES connection | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_trigger_to_float_warning_preserves -x` | ❌ Wave 0 (new) |
| VALID-01 | list outlet → float inlet emits WARNING + bach hint, preserves connection | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_list_to_float_warning_bach_hint -x` | ❌ Wave 0 (new) |
| VALID-01 (regression) | audio outlet → signal inlet remains silent (legacy path) | unit | `pytest tests/test_validation.py::TestLayer3SignalTypes::test_signal_to_signal_passes -x` | ✅ existing (line 243) |
| VALID-01 (regression) | uncurated outlet (None role) falls through to legacy signal:bool branch | unit | `pytest tests/test_validation.py::TestLayer3SignalTypes::test_signal_to_control_only_inlet_detected -x` | ✅ existing (line 257) |
| VALID-01 (table) | `_ROLE_TIER_TABLE` excludes audio keys (defensive) | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_role_tier_table_excludes_audio -x` | ❌ Wave 0 (new) |
| VALID-02 | floor~ at top level → ERROR, no auto-fix | unit | `pytest tests/test_validation.py::TestDomainGuard::test_floor_tilde_top_level_error -x` | ❌ Wave 0 (new) |
| VALID-02 | floor~ inside gen~ subpatcher → silent (top-level only) | unit | `pytest tests/test_validation.py::TestDomainGuard::test_floor_tilde_in_gen_subpatcher_silent -x` | ❌ Wave 0 (new) |
| VALID-02 | non-domain-restricted object → silent | unit | `pytest tests/test_validation.py::TestDomainGuard::test_unrestricted_object_silent -x` | ❌ Wave 0 (new) |
| VALID-03 | bach.llll2list lookup() emits UserWarning once | unit | `pytest tests/test_schema_extensions.py::TestInstallWarning::test_bach_emits_warning_once -x` | ❌ Wave 0 (new) |
| VALID-03 | repeat lookups suppress warning (cache) | unit | `pytest tests/test_schema_extensions.py::TestInstallWarning::test_warning_cached_per_name -x` | ❌ Wave 0 (new) |
| VALID-03 | absent verified_installed (None) → silent | unit | `pytest tests/test_schema_extensions.py::TestInstallWarning::test_unaudited_silent -x` | ❌ Wave 0 (new) |
| VALID-03 | warning category + stacklevel match _maybe_warn_empty_io | unit | `pytest tests/test_schema_extensions.py::TestInstallWarning::test_userwarning_category_matches -x` | ❌ Wave 0 (new) |
| VALID-04 | validate_genexpr emits ERROR for `delay(` (Check 7) | unit | `pytest tests/test_code_validation.py::TestGenExprChecks::test_check7_delay_rejection -x` | ❌ Wave 0 (new) |
| VALID-04 | validate_genexpr emits ERROR for `clip(` (Check 8) | unit | `pytest tests/test_code_validation.py::TestGenExprChecks::test_check8_clip_rejection -x` | ❌ Wave 0 (new) |
| VALID-04 | validate_genexpr emits ERROR for var assigned only inside if/else (Check 9) | unit | `pytest tests/test_code_validation.py::TestGenExprChecks::test_check9_init_before_if -x` | ❌ Wave 0 (new) |
| VALID-04 | Check 9 false-positive limitation documented (suggestion text) | unit | `pytest tests/test_code_validation.py::TestGenExprChecks::test_check9_suggestion_documents_limitations -x` | ❌ Wave 0 (new) |
| VALID-04 | Checks 7/8 ignore `delay`/`clip` inside `// comments` | unit | `pytest tests/test_code_validation.py::TestGenExprChecks::test_checks_skip_comments -x` | ❌ Wave 0 (new) |
| VALID-04 | embedded codebox walker fires on .maxpat with delay() | integration | `pytest tests/test_validation.py::TestEmbeddedGenExpr::test_embedded_delay_emits_error -x` | ❌ Wave 0 (new) |
| VALID-04 | hooks.validate_code_file('.gendsp' with delay()) emits ERROR (round-trip) | integration | `pytest tests/test_code_validation.py::TestValidateCodeFile::test_gendsp_with_delay_blocks -x` | ❌ Wave 0 (new) |
| VALID-05 | role-mismatch ERROR has `auto_fixed=True`; WARNING has `auto_fixed=False` | unit | `pytest tests/test_validation.py::TestRoleAwareValidation::test_severity_auto_fix_contract -x` | ❌ Wave 0 (new) |
| VALID-05 | domain restriction: always ERROR + auto_fixed=False | unit | `pytest tests/test_validation.py::TestDomainGuard::test_severity_contract -x` | ❌ Wave 0 (new) |
| VALID-05 | install warning: never emits a ValidationResult (UserWarning channel only) | unit | `pytest tests/test_schema_extensions.py::TestInstallWarning::test_no_validation_result_emitted -x` | ❌ Wave 0 (new) |
| Phase 28 (regression) | 39 schema-extension tests stay green | regression | `pytest tests/test_schema_extensions.py -x -q` | ✅ existing |
| Validation pipeline (regression) | 84 validation tests stay green | regression | `pytest tests/test_validation.py -x -q` | ✅ existing |
| Code validation (regression) | existing GenExpr/JS/N4M tests stay green | regression | `pytest tests/test_code_validation.py -x -q` | ✅ existing |

### Sampling Rate

- **Per task commit:** `python3 -m pytest tests/test_validation.py tests/test_code_validation.py tests/test_schema_extensions.py -x -q` (~1s)
- **Per wave merge:** `python3 -m pytest -x -q` (full suite, ~10–30s)
- **Phase gate:** Full suite green before `/gsd-verify-work`. Mandatory: zero new test failures from the existing 84 + 39 + Code Validation tests (regression anchor per VALID-01 spec).

### Wave 0 Gaps

- [ ] `tests/test_validation.py` — add `TestRoleAwareValidation`, `TestDomainGuard`, `TestEmbeddedGenExpr` classes (all new)
- [ ] `tests/test_code_validation.py` — add `TestGenExprChecks` class for Checks 7/8/9 (extending existing `TestGenExprValidator`)
- [ ] `tests/test_schema_extensions.py` — add `TestInstallWarning` class (Phase 28 fixture pattern)

No new conftest fixtures needed — `_make_db_root` from test_schema_extensions.py:40 covers isolated-DB tests; production `ObjectDatabase()` covers integration tests via the four canonical fixtures.

No framework install needed — pytest 9.0.2 already in use.

## Risks & Landmines

### R1: Duplicate emission for `delay()` in embedded codeboxes
**Symptom:** A `.maxpat` with embedded `delay(` produces TWO ValidationResult errors — one from existing `_check_genexpr_delay_usage` (validation.py:979), one from the new walker calling `validate_genexpr` Check 7.
**Mitigation:** Either remove the existing Layer 4 GenExpr checks (recommended; cleaner) OR document the duplication and rely on caller dedup. Phase 29 should pick one explicitly in the plan, not paper over it.

### R2: Tier-table audio keys silently override legacy auto-fix
**Symptom:** If `("audio", "signal")` or `("audio", "control")` accidentally lands in `_ROLE_TIER_TABLE`, the existing legacy `signal:bool` branch (validation.py:498-531) is bypassed and three regression tests (test_validation.py:243, 257, 271) flip behavior.
**Mitigation:** Add `test_role_tier_table_excludes_audio_keys` as a defensive unit test. Document the invariant in a module-level comment above `_ROLE_TIER_TABLE`.

### R3: Init-before-if/else false positive on shadowed variables
**Symptom:** Real-world GenExpr with `Param x(0); if (cond) { Param y(0); ... }` may flag `y` as uninitialized (we don't track inner Param declarations).
**Mitigation:** D-20 documented limitation. The suggestion line includes "if this is a false positive, restructure to assign before the if/else." Acceptable for v5.0; Phase 30+ may upgrade to scope-aware analysis.

### R4: `_install_warned` cache leaks across test runs
**Symptom:** Tests sharing a session-scoped `ObjectDatabase` see only the first warning; subsequent tests see no warning even when they should.
**Mitigation:** Tests reset via `db._install_warned.clear()` (per Claude's Discretion item 3). Mirror the pattern from existing `_empty_io_warned` tests if any exist; otherwise establish the pattern in Phase 29.

### R5: `_DECL_PREFIXES` hoist breaks existing imports
**Symptom:** Hoisting `_DECL_PREFIXES` from inside `validate_genexpr` to module-level changes the binding. If anything imports it (it shouldn't — it's local), refactor breaks.
**Mitigation:** Verified via `grep _DECL_PREFIXES src/`. Two hits: `code_validation.py:129` (the local) and `codegen.py:90` (an unrelated module-level constant). No imports of the local. Hoist is safe.

### R6: floor~ in gen~ embedded patcher gives false negative if walker recurses
**Symptom:** If a future change adds recursion to `_validate_domain_restrictions`, `floor~` inside a gen~ inner patcher (which is legal — gen~ subsumes the rnbo restriction in some contexts) starts erroring.
**Mitigation:** D-07 locks top-level only. Add `test_floor_tilde_in_gen_subpatcher_silent` as a regression anchor that asserts the silence.

### R7: stacklevel=4 doesn't surface the user's call site
**Symptom:** `_maybe_warn_install_state` warning shows `db_lookup.py:NNN` instead of the user's lookup call.
**Mitigation:** Verify with a sentinel test that captures the warning frame. If wrong, adjust to stacklevel=3 or 5; aligning with `_maybe_warn_empty_io` (stacklevel=4 there) is the precedent and is what D-11 locks.

### R8: `bach.llll2list` lookup() warning fires on collection-iteration tests
**Symptom:** Existing tests that bulk-iterate `db._objects` and call `lookup()` on every name will emit warnings during test runs, polluting captured-warning assertions.
**Mitigation:** Use `warnings.catch_warnings()` context in any test that does bulk iteration. The 39 existing schema-extension tests already pass with the verified_installed: false fixture in place; the new warning is one extra emission per process and should not cascade.

### R9: GenExpr Check 9 brace-depth tracking miscounts on multi-line expressions
**Symptom:** `out1 = (a + \n b);` opens no brace but the walker may misinterpret a stray `}` from the line above.
**Mitigation:** The walker only reacts to lines that *contain* `if`/`else` AND `{`. Multi-line expressions without if/else don't trigger any state change. Test with the canonical bassoon-model and minitaur codebox fixtures (real production code) to confirm zero false positives.

### R10: tier dispatch silent-on-audio leaves audio→control connections to legacy branch
**Symptom:** `cycle~` (audio) → `print` (control inlet) is the canonical "auto-remove signal-to-control" case. If the new tier dispatch *processes* audio without finding a tier-table entry but accidentally `continue`s past the legacy branch, the auto-remove fails.
**Mitigation:** The implementation pseudocode above explicitly says: *"role returned None or 'audio matches signal inlet' silent path: fall through to legacy signal:bool branch unchanged."* The `continue` only fires when `tier_result is not None` (i.e., we emitted a finding). Audio sources never hit the tier table → never get a tier result → fall through naturally. Add `test_audio_to_control_legacy_branch_runs` as a regression anchor.

## Project Constraints (from CLAUDE.md)

- **Rule #1 (Never Guess Objects):** RESEARCH.md cites only objects verified in the production DB (`floor~`, `bach.llll2list`, `cycle~`, `snapshot~`, `print`, `trigger`, `delay`, `Delay`, `clip`, `*~`, `ezdac~`, `gen~`, `codebox`). All confirmed via `db.lookup()` probes during research.
- **Rule #5 (No Generator Scripts):** Phase 29 adds no generator scripts. All edits are to `db_lookup.py`, `validation.py`, `code_validation.py`, and tests. No new Python entry points.
- **Rule #7 (Commit After Every Save):** Test commits per task per Wave; full-suite green per phase gate. Standard.
- **Domain-Specific Rules → MSP:** `floor~` is RNBO-only, `expr` has no `clip()`, `delay()` not supported in GenExpr — all three are the AUTHORITATIVE source for the new error messages (D-14, D-15, D-16). Messages must match the wording in CLAUDE.md verbatim where possible.
- **Domain-Specific Rules → Gen~:** Declaration ordering, init-before-if/else rationale, `Delay.read/write` syntax — Check 9 implementation must respect the documented exemption for `Param`/`History`/`Delay`/`Buffer`/`Data` names.

## Sources

### Primary (HIGH confidence)
- `/Users/taylorbrook/Dev/MAX/src/maxpat/db_lookup.py` — read in full; line numbers verified
- `/Users/taylorbrook/Dev/MAX/src/maxpat/validation.py` — read in full; line numbers verified
- `/Users/taylorbrook/Dev/MAX/src/maxpat/code_validation.py` — read in full; line numbers verified
- `/Users/taylorbrook/Dev/MAX/src/maxpat/hooks.py` — read in full; line numbers verified
- `/Users/taylorbrook/Dev/MAX/src/maxpat/critics/dsp_critic.py` — read first 165 lines for `_extract_codebox_code` template
- `/Users/taylorbrook/Dev/MAX/src/maxpat/critics/base.py` — read in full; severity vocab confirmed
- `/Users/taylorbrook/Dev/MAX/.planning/phases/29-validator-depth/29-CONTEXT.md` — D-01 through D-20 verbatim
- `/Users/taylorbrook/Dev/MAX/.planning/phases/28-schema-foundation/28-CONTEXT.md` — Phase 28 D-02, D-10, D-13 reaffirmed
- `/Users/taylorbrook/Dev/MAX/.planning/phases/28-schema-foundation/28-VERIFICATION.md` — getter signatures and behavior verified
- `/Users/taylorbrook/Dev/MAX/.planning/REQUIREMENTS.md` — VALID-01..05 verbatim
- `/Users/taylorbrook/Dev/MAX/.planning/ROADMAP.md` — Phase 29 success criteria
- `/Users/taylorbrook/Dev/MAX/.planning/STATE.md` — milestone position
- `/Users/taylorbrook/Dev/MAX/tests/test_schema_extensions.py` — fixture patterns verified
- `/Users/taylorbrook/Dev/MAX/tests/test_validation.py` — Layer 3/4 conventions verified
- `/Users/taylorbrook/Dev/MAX/tests/test_code_validation.py` — TestGenExprValidator class for new sibling
- `/Users/taylorbrook/Dev/MAX/tests/conftest.py` — fixtures inventory
- `/Users/taylorbrook/Dev/MAX/tests/test_critics.py` — codebox fixture shape (depth-1 codeboxes confirmed)
- `/Users/taylorbrook/Dev/MAX/.claude/max-objects/overrides.json` — fixtures verified at lines 11058, 11066, 11074, 2142
- `/Users/taylorbrook/Dev/MAX/CLAUDE.md` — MSP / Gen~ / Domain rules sections
- `/Users/taylorbrook/Dev/MAX/.planning/config.json` — `nyquist_validation: true` confirmed

### Verification probes (HIGH confidence)
- `python3 -c "from src.maxpat.db_lookup import ObjectDatabase; db = ObjectDatabase(); ..."` — confirmed all four canonical fixtures behave per Phase 28 contract
- 28-patch survey via Python: zero nested gen~ in real patches; codeboxes only at depth 1
- `grep _DECL_PREFIXES src/`: confirmed safe to hoist (no external imports)

### Memory References (HIGH confidence — empirical)
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_floor_tilde_rnbo.md`
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_expr_no_clip.md`
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_genexpr_delay_syntax.md`
- `~/.claude/projects/-Users-taylorbrook-Dev-MAX/memory/feedback_bach_no_llll2list.md`

## Assumptions Log

| # | Claim | Section | Risk if Wrong |
|---|-------|---------|---------------|
| (none) | All claims verified via direct file reads, in-process `ObjectDatabase` probes, or production fixture inspection. No `[ASSUMED]` tags issued. | — | — |

**Empty assumptions log:** every implementation detail in this research is grounded in an exact file/line citation, a probe result, or a CONTEXT.md decision. The planner can proceed without user confirmation on any deferred questions.

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH — all code anchors read at exact line numbers
- Architecture: HIGH — every D-01..D-20 decision maps to a concrete extension point
- Pitfalls: HIGH — 10 risks identified, each with named regression test or mitigation

**Research date:** 2026-04-28
**Valid until:** 2026-05-28 (stable schema; v5.0 milestone in flight)

RESEARCH COMPLETE
