# Phase 20: DB Schema Foundation - Discussion Log

> **Audit trail only.** Do not use as input to planning, research, or execution agents.
> Decisions are captured in CONTEXT.md -- this log preserves the alternatives considered.

**Date:** 2026-04-13
**Phase:** 20-db-schema-foundation
**Areas discussed:** Package naming, Core object tagging, allowed_packages defaults, Migration approach

---

## Package Naming

| Option | Description | Selected |
|--------|-------------|----------|
| MAX folder name | Use exact folder name from MAX's Packages directory (BEAP, Vizzie, ableton-dsp, etc.) | ✓ |
| Lowercase kebab-case | Normalize all names to lowercase kebab-case (beap, vizzie, etc.) | |
| Prefix-based | Name packages by their object prefix (bp, vz, abl, etc.) | |

**User's choice:** MAX folder name
**Notes:** Matches what users see in MAX. No translation needed between DB names and MAX UI.

---

## Core Object Tagging

| Option | Description | Selected |
|--------|-------------|----------|
| Field absence = core | Don't add "package" to ~1400 core objects. Missing field = core. | ✓ |
| Explicit null on everything | Add "package": null to all ~1400 core objects for uniform schema. | |
| Explicit "core" string | Tag core objects with "package": "core" pseudo-package. | |

**User's choice:** Field absence = core
**Notes:** Zero churn on existing domain files. Only package objects get the field.

---

## allowed_packages Defaults

| Option | Description | Selected |
|--------|-------------|----------|
| All objects | No filter = return everything (core + all packages). Backward-compatible. | ✓ |
| Core only by default | No filter = only core objects. Packages require explicit opt-in. | |

**User's choice:** All objects (no filter = everything)
**Notes:** Package gating happens at the agent/generation layer (Phase 22), not the DB layer.

---

## Migration Approach

| Option | Description | Selected |
|--------|-------------|----------|
| Clean break | Delete packages/objects.json, split into per-package subdirs, update load order. | ✓ |
| Keep old file as fallback | Create subdirs but keep old file as read-only fallback. | |

**User's choice:** Clean break
**Notes:** One commit, done. No backward-compat shim needed.

---

## Claude's Discretion

- package_info.json schema details beyond decided fields
- Internal implementation of list_packages() and get_package_objects()
- Test structure and convenience methods

## Deferred Ideas

None.
