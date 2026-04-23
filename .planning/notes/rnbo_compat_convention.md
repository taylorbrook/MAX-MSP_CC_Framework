---
title: rnbo_compatible flag convention — three consumers map
date: 2026-04-20
context: explore-260420, closes DQ-04 from quick-260420-j15 REVIEW.md
---

# The convention

**rnbo-domain entries (`.claude/max-objects/rnbo/objects.json`) do NOT carry `rnbo_compatible: true`.** Being in the rnbo domain file is itself the compatibility signal. Core-domain entries (`max/`, `msp/`, `gen/`, `mc/`, `m4l/`, `jitter/`) carry an explicit `rnbo_compatible: bool` to mark whether the same-named core object is RNBO-safe.

# Why this matters

All 301 cross-domain duplicates between `rnbo/` and `{max, msp, gen}/` show up as schema mismatches in bulk audits purely because of this flag asymmetry. **The asymmetry is intentional**, not a bug. Flipping the 560 rnbo entries to `rnbo_compatible=true` would add noise and erode the self-evident "rnbo file = rnbo-compatible list" property.

# Three consumers, all convention-aware

### 1. Runtime (the one that matters)

`src/maxpat/rnbo.py:57` — `RNBODatabase._load()`:
```python
# Start with all RNBO domain objects as compatible
self._compat_objects = set(self._rnbo_objects.keys())

# Scan other domains for rnbo_compatible=true flags
for domain in ["max", "msp", "gen", "mc", "jitter"]:
    ...
    if obj.get("rnbo_compatible"):
        self._compat_objects.add(name)
```

`is_rnbo_compatible(name)` at `rnbo.py:68` returns `True` if either condition holds. Used by:
- `src/maxpat/rnbo.py:207` — generation gate in `generate_rnbo_wrapper()`
- `src/maxpat/rnbo_validation.py:138` — RNBO patch validator

**Neither path ever reads the flag off an rnbo-domain entry.** The lookup short-circuits on domain membership.

### 2. Validation script

`.claude/scripts/validate_db.py:361` — `check_rnbo_compatible_count()`:
```python
for domain in CORE_DOMAIN_DIRS:   # rnbo is excluded
    ...
    if obj.get("rnbo_compatible") is True:
        count += 1
# requires count >= 150
```

Iterates core domains only. Rnbo domain is not in `CORE_DOMAIN_DIRS`.

### 3. Test gate

`tests/test_rnbo_flag.py:16,37`:
```python
# Filter out RNBO-domain objects (they are the reference set)
core_objects = [o for o in all_objects if o.get("domain") != "RNBO"]
```

Every check in `TestRnboFlag` explicitly filters out the rnbo domain before asserting the flag exists or counting `True` values.

# What this means for future work

- **Do not flip the 560 rnbo entries** unless a new consumer emerges that needs the flag on rnbo-domain entries. None exists today.
- **When adding a new consumer of `rnbo_compatible`**, apply the same pattern: exclude the rnbo domain (because the flag is absent there by design) OR use `RNBODatabase.is_rnbo_compatible()` which handles both cases.
- **Audit tools that flag cross-domain schema mismatches should suppress the `rnbo_compatible`-only diff for rnbo↔core pairs** to avoid the 300-item noise floor. Optional enhancement, not required.

# Related

- Review: `.planning/quick/260420-j15-review-the-objects-database-entries-and-/260420-j15-REVIEW.md` DQ-04
- DQ-05 (adjacent): MSP symbolic math operators (`+~`, `*~`, etc.) are `rnbo_compatible=false` by convention because RNBO uses named variants (`add~`, `mul~`). Also deliberate, also no-action.
