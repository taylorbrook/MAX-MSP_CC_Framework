# Phase 9: Object DB Corrections - Research

**Researched:** 2026-03-13
**Domain:** JSON data merging, Python scripting, object database corrections
**Confidence:** HIGH

## Summary

Phase 9 merges help-patch-sourced audit findings from Phase 8 into the production `overrides.json` file. The scope is data merging -- no changes to `db_lookup.py` load logic are needed. The audit pipeline already produced three output files: `proposed-overrides.json` (211 non-conflict proposals across HIGH/MEDIUM/HELP_PATCH tiers), `empty-io-coverage.json` (72 coverable objects out of 193 total empty-I/O), and `audit-report.json` (full discrepancy report). Eight objects conflict with existing manual overrides and require case-by-case field-level resolution.

The merger must be a rerunnable Python script at `src/maxpat/audit/merger.py`, integrated into the existing CLI as `audit --merge`. It reads `proposed-overrides.json`, handles conflict resolution, groups entries by domain, inserts audit metadata, and writes the updated `overrides.json`. The critical constraint is preserving the existing 23 manual override entries -- particularly their expert-crafted `digest` strings and `_note` annotations -- while adopting audit-verified I/O data where appropriate.

**Primary recommendation:** Build the merger as a focused class that reads proposed-overrides.json, resolves the 8 conflicts per user-approved field-level decisions, groups by domain using `_domain_header` separator keys, and writes an idempotent overrides.json. Wire into CLI as `--merge` flag.

<user_constraints>
## User Constraints (from CONTEXT.md)

### Locked Decisions
- Auto-merge ALL confidence tiers: HIGH (176), MEDIUM (29), and HELP_PATCH (6) proposals
- Each merged entry retains `_audit` metadata fields (_audit_confidence, _audit_instances, _audit_agreement, _audit_source) -- db_lookup.py already skips underscore-prefixed keys
- MEDIUM and HELP_PATCH entries are tagged so they're identifiable for future review if issues arise
- Case-by-case review for the 8 objects where audit contradicts existing manual overrides
- Conflicts presented inline during plan execution: show DB value, audit value, and help patch instance count for user approval
- Field-by-field merge when resolving -- preserve expert-correct fields, adopt audit-correct fields
- Resolved conflicts retain `_manual_original` field with the original manual entry for reference
- All 72 objects with empty I/O data AND help patch coverage get populated in this phase
- Same override format as outlet-type corrections: full inlets/outlets arrays with id, type, signal, digest fields
- Single overrides.json file with domain section comments (`_domain_header` keys between groups)
- No structural change to db_lookup.py merge logic required
- Rerunnable Python merge script at src/maxpat/audit/merger.py
- Reads proposed-overrides.json, applies confidence filters, detects conflicts, writes updated overrides.json
- Wired into existing audit CLI as --merge flag
- Merge script handles: confidence filtering, conflict detection, domain grouping, audit metadata insertion, manual entry preservation
- Existing 23 manual overrides represent expert knowledge -- must never be silently overwritten
- Merge script should be idempotent -- running it twice produces the same result

### Claude's Discretion
- Handling of 121 uncovered empty-I/O objects (document vs flag vs defer)
- Internal merge script architecture (class structure, helper functions)
- Test strategy for the merge script itself
- Exact domain ordering in overrides.json

### Deferred Ideas (OUT OF SCOPE)
None -- discussion stayed within phase scope
</user_constraints>

<phase_requirements>
## Phase Requirements

| ID | Description | Research Support |
|----|-------------|-----------------|
| DBCX-01 | High-confidence outlet type corrections merged into overrides.json and picked up automatically by db_lookup.py | 75 outlet-type proposals in proposed-overrides.json (all HIGH/MEDIUM); db_lookup.py deep-merge at lines 73-81 already handles the format; no code changes needed in db_lookup.py |
| DBCX-02 | Empty-I/O objects populated with help-patch-verified inlet/outlet data | 6 HELP_PATCH entries already in proposed-overrides.json; 43 of 72 empty-I/O objects already have proposals via io_count_finding; 29 have help data but no I/O proposals (proposed_inlets/outlets = None) |
| DBCX-03 | All existing tests continue to pass after DB corrections (regression gate) | Currently 750 passed, 3 pre-existing failures (test_codegen.py gen~ maxclass issue, unrelated). Requirements doc says 624 -- test count has grown. Regression gate means the same tests pass before and after |
| DBCX-04 | Corrections organized by domain for reviewability | Domain info available via ObjectDatabase.lookup() for 171 of 211 proposed objects; 40 objects not in any domain JSON; domain grouping uses `_domain_header` separator keys in overrides.json |
</phase_requirements>

## Standard Stack

### Core
| Library | Version | Purpose | Why Standard |
|---------|---------|---------|--------------|
| Python 3.14 | 3.14 | Runtime | Already used by project |
| json (stdlib) | builtin | JSON read/write | All data files are JSON |
| pathlib (stdlib) | builtin | File path handling | Used throughout existing code |
| argparse (stdlib) | builtin | CLI integration | Existing CLI uses argparse |
| pytest | 9.0.2 | Test runner | Already configured in project |

### Supporting
| Library | Version | Purpose | When to Use |
|---------|---------|---------|-------------|
| dataclasses (stdlib) | builtin | Structured data | If merger needs internal data types |
| collections.Counter | builtin | Counting/grouping | Domain grouping statistics |
| copy.deepcopy | builtin | Safe dict cloning | Preserving original manual entries |

No external dependencies needed. This is pure Python data transformation.

## Architecture Patterns

### Recommended Project Structure
```
src/maxpat/audit/
    __init__.py          # (existing) BoxInstance dataclass
    analyzer.py          # (existing) Audit analysis engine
    cli.py               # (modify) Add --merge flag
    merger.py            # (NEW) Merge script
    overrides.py         # (existing) Proposed override generator
    parser.py            # (existing) Help patch parser
    reporter.py          # (existing) Report generator

.claude/max-objects/
    overrides.json       # (modify) Target file -- grows from 23 to ~230+ entries
    audit/
        proposed-overrides.json   # (input) 211 proposals + 8 conflicts
        empty-io-coverage.json    # (input) 72 coverable empty-I/O objects

tests/
    test_merger.py       # (NEW) Tests for the merge script
```

### Pattern 1: OverrideMerger Class
**What:** A single class that encapsulates the entire merge workflow
**When to use:** For the merger.py module
**Example:**
```python
class OverrideMerger:
    """Merges proposed audit overrides into the production overrides.json.

    Handles: confidence filtering, conflict detection/resolution,
    domain grouping, audit metadata insertion, manual entry preservation.
    Idempotent -- running twice produces the same result.
    """

    def __init__(
        self,
        proposed_path: Path,
        overrides_path: Path,
        db: ObjectDatabase,
    ) -> None:
        self._proposed = json.loads(proposed_path.read_text())
        self._existing = json.loads(overrides_path.read_text())
        self._overrides_path = overrides_path
        self._db = db

    def merge(self, conflict_resolutions: dict | None = None) -> dict:
        """Execute the merge and return the new overrides dict.

        Args:
            conflict_resolutions: Dict mapping object name to resolution
                strategy per field. None = skip conflicts (report only).

        Returns:
            The merged overrides dict ready for writing.
        """
        ...

    def detect_conflicts(self) -> dict[str, dict]:
        """Return the 8 conflict entries with both sides for review."""
        ...

    def write(self, merged: dict) -> None:
        """Write merged overrides.json, preserving version_map and variable_io_rules."""
        ...
```

### Pattern 2: Domain Grouping with Separator Keys
**What:** Use underscore-prefixed keys as visual section separators in JSON
**When to use:** For organizing entries in overrides.json by domain
**Example:**
```python
# Domain ordering in overrides.json
DOMAIN_ORDER = ["max", "msp", "jitter", "mc", "gen", "m4l", "rnbo", "packages"]

def group_by_domain(objects: dict, db: ObjectDatabase) -> dict:
    """Group override entries by domain with separator keys."""
    grouped = {}
    for domain in DOMAIN_ORDER:
        domain_objects = {
            name: entry for name, entry in objects.items()
            if _get_domain(name, db) == domain
        }
        if domain_objects:
            grouped[f"_domain_{domain}"] = f"--- {domain.upper()} Objects ---"
            grouped.update(dict(sorted(domain_objects.items())))
    # Orphan objects (not in any domain JSON)
    orphans = {
        name: entry for name, entry in objects.items()
        if _get_domain(name, db) is None
    }
    if orphans:
        grouped["_domain_other"] = "--- Other Objects (not in domain JSONs) ---"
        grouped.update(dict(sorted(orphans.items())))
    return grouped
```

### Pattern 3: Field-Level Conflict Resolution
**What:** Merge conflicts field by field, preserving expert data where appropriate
**When to use:** For the 8 conflicting objects
**Example:**
```python
def resolve_conflict(
    manual_entry: dict,
    audit_entry: dict,
    fields_to_adopt: list[str],
) -> dict:
    """Merge a conflict by adopting specified fields from audit."""
    import copy
    resolved = copy.deepcopy(manual_entry)
    resolved["_manual_original"] = copy.deepcopy(manual_entry)
    for field in fields_to_adopt:
        if field in audit_entry:
            resolved[field] = audit_entry[field]
    # Add audit metadata
    if "_audit" in audit_entry:
        resolved["_audit"] = audit_entry["_audit"]
    return resolved
```

### Anti-Patterns to Avoid
- **Overwriting manual entries wholesale:** The audit's generic `"Control output"` digest strings are less informative than expert-written digests like `"bang when line reaches destination"`. Never replace a manual entry entirely with an audit entry.
- **Modifying db_lookup.py:** This phase is data-only. The load logic already handles the format correctly.
- **Hardcoding conflict resolutions:** The 8 conflicts should have their resolutions documented and reviewable, not baked into code silently.

## Don't Hand-Roll

| Problem | Don't Build | Use Instead | Why |
|---------|-------------|-------------|-----|
| JSON deep merge | Custom recursive merge | Simple dict update + copy.deepcopy | Override format is flat (one level of keys per object), not deeply nested |
| Domain detection | String parsing of object names | `db.lookup(name)` then read `domain` field | DB already knows domains; name parsing would miss edge cases |
| Idempotency checking | Diff-based change detection | Write deterministic output from source data | Re-reading proposed-overrides.json and producing same output = idempotent by construction |

**Key insight:** The merge is fundamentally a data transformation from `proposed-overrides.json` + `existing overrides.json` -> `new overrides.json`. It should be stateless and deterministic.

## Common Pitfalls

### Pitfall 1: Losing version_map and variable_io_rules
**What goes wrong:** Writing only the `objects` key to overrides.json, losing `version_map` and `variable_io_rules` sections.
**Why it happens:** The merger focuses on the `objects` dict and forgets the file has other top-level keys.
**How to avoid:** Read the full existing file, modify only the `objects` key, preserve all other top-level keys (`_comment`, `version_map`, `variable_io_rules`).
**Warning signs:** Tests that depend on variable_io_rules (trigger, pack, route, etc.) start failing.

### Pitfall 2: Objects Not in Domain JSONs (40 of 211)
**What goes wrong:** 40 proposed override objects (like `!`, `1`, `Bucket`, `Uzi`, `jit.fx.rota`, etc.) don't exist in any domain JSON file. If added to overrides.json, `db_lookup.py` line 77 checks `if name in self._objects` -- these entries will be silently skipped.
**Why it happens:** The audit found these objects in help patches but they weren't in the extracted domain files. They may be aliases, sub-objects, or objects missed during extraction.
**How to avoid:** The merger should still include them in overrides.json (they're valid corrections), but flag them with a `_note` indicating they have no base domain entry. Future work can add them to domain JSONs.
**Warning signs:** After merge, `db.lookup("Bucket")` still returns None despite having an override entry.

### Pitfall 3: Audit Generic Digests Replace Expert Digests
**What goes wrong:** The audit generates `"Control output"` and `"Signal output"` as generic digest strings. For the 8 conflicting objects, the manual entries have expert digests like `"bang when line reaches destination"`, `"Instance index of patcher (int)"`, etc.
**Why it happens:** The `_build_outlet_array` in overrides.py uses generic strings because it doesn't have help patch text descriptions.
**How to avoid:** During field-level conflict resolution, always preserve manual `digest` strings. Only adopt audit `signal`/`type` corrections.
**Warning signs:** Review the merged file and see "Control output" where "bang when done" used to be.

### Pitfall 4: Conflict Resolution for stash~ (Genuine Disagreement)
**What goes wrong:** `stash~` manual override says outlet 1 is control (`"Index (int)"`). Audit says outlet 1 is signal with HIGH confidence (100% agreement, 5 instances). This is a genuine disagreement where the help patch data may actually be more accurate than the manual correction.
**Why it happens:** Some manual overrides were based on documentation or limited testing; help patches compiled by Cycling '74 may reflect actual behavior more accurately.
**How to avoid:** Present this specific conflict to the user with all evidence. The audit has 5 instances with 100% agreement that stash~ outlet 1 is signal.
**Warning signs:** Accepting the manual override when the help patch data is actually correct causes connection validation errors downstream.

### Pitfall 5: Test Count Mismatch
**What goes wrong:** DBCX-03 references "624 existing tests" but the actual count is 750 passed (3 pre-existing failures in test_codegen.py for unrelated gen~ maxclass issue).
**Why it happens:** The test count grew during Phase 8 development.
**How to avoid:** The regression gate should be: all tests that passed before the merge still pass after. Run `pytest` before and after, compare. The 3 pre-existing failures are unrelated.
**Warning signs:** New test failures after overrides.json modification.

### Pitfall 6: Proposed-Overrides Overlap with Empty-IO Coverage
**What goes wrong:** 43 of the 72 empty-I/O objects already have entries in proposed-overrides.json. The remaining 29 have help data but no I/O proposals (both proposed_inlets and proposed_outlets are None). Blindly processing both files creates duplicates for the 43.
**Why it happens:** The OverrideGenerator already processes empty-I/O objects and includes them in proposed-overrides.json when they have viable data.
**How to avoid:** Use proposed-overrides.json as the single source. The 6 HELP_PATCH entries and 43 overlapping entries are already there. The 29 objects with no proposals need to be documented as "has help data but no viable I/O proposal" and deferred.
**Warning signs:** Duplicate entries in the merged overrides.json.

## Code Examples

### Conflict Analysis Summary (8 Conflicts)

Based on examination of all 8 conflicts:

```
coll:       Manual has expert inlets (2 hot). Audit proposes 1 inlet + 4 outlets.
            Resolution: Keep manual inlets (expert), adopt audit outlets.

curve~:     Manual has expert outlets (signal + control bang). Audit proposes 3 inlets + 2 control outlets.
            Resolution: Keep manual outlets (expert correct), adopt audit inlets.

info~:      Manual has 5 expert outlets (all control with good digests). Audit proposes 1 inlet + 5 control outlets.
            Resolution: Keep manual outlets (better digests), adopt audit inlets.

line~:      Manual has expert outlets (signal + control bang). Audit proposes 2 inlets + 2 control outlets.
            Resolution: Keep manual outlets (expert correct), adopt audit inlets.

stash~:     Manual says outlet 1 is control. Audit says outlet 1 is signal (HIGH, 5 instances, 100%).
            Resolution: NEEDS USER REVIEW -- genuine disagreement.

stretch~:   Manual has expert outlets (signal + control bang). Audit proposes 2 control outlets (HIGH, 2 instances).
            Resolution: Keep manual outlets (expert correct, small instance count).

thispoly~:  Manual has 2 expert control outlets. Audit proposes 1 inlet + 3 outlets.
            Resolution: Keep manual outlets (expert), adopt audit inlets if count matches.

vst~:       Manual has 4 expert outlets (2 signal + 2 control). Audit proposes 2 inlets + 4 control outlets.
            Resolution: Keep manual outlets (expert correct), adopt audit inlets.
```

### Existing Overrides.json Structure Preservation
```python
# The merged file MUST preserve these top-level sections:
{
    "_comment": "...",           # Update with merge info
    "objects": { ... },          # Merged objects (grows from 23 to ~230+)
    "version_map": { ... },      # PRESERVE EXACTLY
    "variable_io_rules": { ... } # PRESERVE EXACTLY
}
```

### Domain Detection for Grouping
```python
def _get_domain(obj_name: str, db: ObjectDatabase) -> str | None:
    """Get domain string for an object, or None if not in DB."""
    obj = db.lookup(obj_name)
    if obj is None:
        return None
    # Domain field varies: some use "Max", some "MSP", etc.
    return obj.get("domain", obj.get("module"))
```

### CLI Integration Pattern
```python
# In cli.py, add to argparse:
parser.add_argument(
    "--merge",
    action="store_true",
    help="Merge proposed overrides into production overrides.json",
)

# In main(), after existing pipeline:
if args.merge:
    from src.maxpat.audit.merger import OverrideMerger
    merger = OverrideMerger(
        proposed_path=args.output_dir / "proposed-overrides.json",
        overrides_path=db_root / "overrides.json",
        db=db,
    )
    conflicts = merger.detect_conflicts()
    if conflicts:
        # Present conflicts for review
        ...
    merged = merger.merge(conflict_resolutions=resolutions)
    merger.write(merged)
```

## State of the Art

| Old Approach | Current Approach | When Changed | Impact |
|--------------|------------------|--------------|--------|
| Manual overrides only (23 entries) | Audit-verified + manual (230+ entries) | Phase 9 | 10x more objects with correct I/O data |
| Empty I/O for 193 objects | 72 objects populated from help patches | Phase 9 | Fewer "unknown" objects during patch generation |
| No audit trail | `_audit` metadata on every correction | Phase 9 | Every correction traceable to source data |

## Open Questions

1. **stash~ outlet 1: signal or control?**
   - What we know: Manual override says control (`"Index (int)"`). Audit says signal (HIGH confidence, 5 instances, 100% agreement).
   - What's unclear: Which is actually correct in MAX 9. The help patches are authored by Cycling '74.
   - Recommendation: Present to user during conflict resolution with all evidence. Lean toward audit data given HIGH confidence.

2. **40 objects not in domain JSONs**
   - What we know: These objects appear in help patches but aren't in any `domain/objects.json` file. They include both likely aliases (`!`, `?`, `1`, `2`) and real objects (`Bucket`, `Uzi`, `jit.fx.rota`, etc.).
   - What's unclear: Whether these should be added to domain JSONs or just documented.
   - Recommendation: Include in overrides.json with `_note` flagging them as having no base entry. They won't be picked up by db_lookup.py until base entries exist, but the data is preserved for future phases.

3. **29 empty-I/O objects with help data but no viable proposals**
   - What we know: These objects have help patch coverage but the analyzer couldn't produce I/O count proposals (both proposed_inlets and proposed_outlets are None).
   - What's unclear: Why the analyzer couldn't extract I/O data -- possibly degenerate instances only, or I/O data exists in width/argument findings but not count findings.
   - Recommendation: Document these 29 as known gaps in the merge report. Defer to future manual investigation.

4. **121 uncovered empty-I/O objects (Claude's Discretion)**
   - What we know: No help patch data available. Domains: Gen (61), Max (42), RNBO (37), MSP (18), etc.
   - Recommendation: Document in a `_uncovered_objects` metadata key in the merged overrides.json or in a separate report file. These are future work items, not Phase 9 scope.

## Validation Architecture

### Test Framework
| Property | Value |
|----------|-------|
| Framework | pytest 9.0.2 |
| Config file | pyproject.toml (implicit) |
| Quick run command | `python3 -m pytest tests/test_merger.py -x` |
| Full suite command | `python3 -m pytest --tb=short` |

### Phase Requirements to Test Map
| Req ID | Behavior | Test Type | Automated Command | File Exists? |
|--------|----------|-----------|-------------------|-------------|
| DBCX-01 | Outlet type corrections in merged overrides.json | unit | `python3 -m pytest tests/test_merger.py::test_outlet_corrections_merged -x` | Wave 0 |
| DBCX-01 | db_lookup.py returns corrected data after merge | integration | `python3 -m pytest tests/test_merger.py::test_db_lookup_uses_merged_overrides -x` | Wave 0 |
| DBCX-02 | Empty-I/O objects populated in overrides.json | unit | `python3 -m pytest tests/test_merger.py::test_empty_io_populated -x` | Wave 0 |
| DBCX-03 | All existing tests pass after corrections | regression | `python3 -m pytest --tb=short` | Existing (750 tests) |
| DBCX-04 | Domain grouping in overrides.json | unit | `python3 -m pytest tests/test_merger.py::test_domain_grouping -x` | Wave 0 |
| -- | Merge is idempotent | unit | `python3 -m pytest tests/test_merger.py::test_idempotent -x` | Wave 0 |
| -- | Manual entries preserved in conflicts | unit | `python3 -m pytest tests/test_merger.py::test_conflict_preservation -x` | Wave 0 |
| -- | version_map and variable_io_rules preserved | unit | `python3 -m pytest tests/test_merger.py::test_non_object_sections_preserved -x` | Wave 0 |
| -- | CLI --merge flag integration | unit | `python3 -m pytest tests/test_merger.py::test_cli_merge_flag -x` | Wave 0 |

### Sampling Rate
- **Per task commit:** `python3 -m pytest tests/test_merger.py -x`
- **Per wave merge:** `python3 -m pytest --tb=short`
- **Phase gate:** Full suite green before verification

### Wave 0 Gaps
- [ ] `tests/test_merger.py` -- all merger unit tests (new file)
- [ ] No framework install needed -- pytest already configured

## Sources

### Primary (HIGH confidence)
- **Codebase inspection:** `src/maxpat/db_lookup.py` lines 73-81 -- confirms deep-merge skips underscore keys
- **Codebase inspection:** `src/maxpat/audit/overrides.py` -- confirms proposed override format
- **Codebase inspection:** `.claude/max-objects/overrides.json` -- confirms 23 existing manual entries with version_map and variable_io_rules sections
- **Data file inspection:** `.claude/max-objects/audit/proposed-overrides.json` -- confirmed 211 proposals, 8 conflicts, breakdown by confidence tier
- **Data file inspection:** `.claude/max-objects/audit/empty-io-coverage.json` -- confirmed 72 coverable, 121 uncoverable, 29 with help data but no I/O proposals
- **Test execution:** `pytest` run confirmed 750 passed, 3 pre-existing failures (unrelated)

### Secondary (MEDIUM confidence)
- None needed -- this phase is entirely within-codebase data transformation

### Tertiary (LOW confidence)
- None

## Metadata

**Confidence breakdown:**
- Standard stack: HIGH -- all stdlib Python, no external deps
- Architecture: HIGH -- pattern follows existing audit module conventions exactly
- Pitfalls: HIGH -- identified from direct codebase inspection and data analysis
- Conflict resolution: MEDIUM -- stash~ disagreement requires user judgment

**Research date:** 2026-03-13
**Valid until:** Indefinite -- data files are static artifacts from Phase 8
