---
quick_id: 260427-j4e
slug: audit-claude-md-files-against-feedback-m
status: complete
date: 2026-04-27
files_changed:
  - CLAUDE.md (project)
files_unchanged:
  - ~/.claude/CLAUDE.md (developer profile only — no MAX content)
memories_audited: 27
edits_applied: 8
commit: f113e53
---

# Quick Task 260427-j4e — SUMMARY

**Goal:** Walk all `feedback_*.md` memories and reconcile them with `CLAUDE.md` so memory isn't the only source of truth for MAX framework rules. Reference: `.planning/quick/260427-hox-review-this-system-and-all-of-the-issues/260427-hox-FINDINGS.md` § P0-5.

**Result:** 8 edits applied to project `CLAUDE.md`. Global `~/.claude/CLAUDE.md` only contains the developer profile (no MAX-specific content) — no changes needed.

---

## Memory-by-memory disposition (27 memories)

| # | Memory | CLAUDE.md before | Disposition |
|---:|---|---|---|
| 1 | `feedback_assistance_comments` (use `comment` attribute, not comment objects) | Silent | **PROMOTED** — Subpatcher section |
| 2 | `feedback_bach_no_llll2list` | Silent | Skip — bach DB-data fix; memory is sufficient |
| 3 | `feedback_bach_out_attr` (@out t) | Silent | Skip — bach package-specific; memory is sufficient |
| 4 | `feedback_bpatcher_args` (#N standalone) | ✅ Correct | No change |
| 5 | `feedback_buffer_info_query` | Silent | **PROMOTED** — MSP section |
| 6 | `feedback_comment_no_hash_sub` | Bpatcher section silent (and "applies equally" implied otherwise) | **FIXED** — Bpatcher section |
| 7 | `feedback_db_empty_io` | Silent | **PROMOTED** — Object Database section |
| 8 | `feedback_expr_no_clip` | Silent | **PROMOTED** — MSP section |
| 9 | `feedback_floor_tilde_rnbo` | Silent | **PROMOTED** — MSP section |
| 10 | `feedback_gen_param_messages` (no `@` prefix) | Silent | **FIXED** — Gen~ section |
| 11 | `feedback_genexpr_delay_syntax` (Delay.read/write, not delay()) | Silent (mentioned `Delay` declaration only) | **FIXED** — Gen~ section |
| 12 | `feedback_genexpr_io_syntax` (in1 vs in 1) | ✅ Correct (line 144) | No change |
| 13 | `feedback_git_stash_prohibited` | ✅ Correct (Rule #7) | No change |
| 14 | `feedback_inlet_outlet_maxclass` (no inlet~/outlet~) | Silent | **PROMOTED** — Subpatcher section |
| 15 | `feedback_layout_spacing` (~20px V / ~15px H) | ✅ Correct (line 86) | No change |
| 16 | `feedback_line_tilde_comma` | Silent | **PROMOTED** — MSP section |
| 17 | `feedback_live_scope_tilde` | DB-only | Skip — DB has been updated; not a CLAUDE.md rule |
| 18 | `feedback_m4l_no_gain` | No M4L section existed | **PROMOTED** — new M4L section |
| 19 | `feedback_m4l_param_connect` | No M4L section existed | **PROMOTED** — new M4L section |
| 20 | `feedback_maxclass_newobj` | Silent | **PROMOTED** — Object Database section |
| 21 | `feedback_message_box_width` | Silent | Skip — minor layout detail; lives in `defaults.py`/memory |
| 22 | `feedback_msp_outlet_types` | DB-data concern | Skip — handled in `overrides.json` and DB extractor |
| 23 | `feedback_multislider_fetch` (use `fetch`, right outlet) | Multislider subsection silent | **FIXED** — Multislider subsection |
| 24 | `feedback_replace_box_orphans` | Silent | **PROMOTED** — new Rule #8 |
| 25 | `feedback_umenu_items_format` | Silent | **PROMOTED** — MSP section (close to other format gotchas) |
| 26 | `feedback_waveguide_loop_phase_comp` | Silent | Skip — highly DSP-specific; memory is the right home |
| 27 | `feedback_worktree_stash_danger` | ✅ Correct (Rule #7 + multi-instance note) | No change |

**Totals:** 5 already correct · 6 skipped (out of CLAUDE.md scope) · 16 fixed/promoted across 8 batched edits.

---

## Edits applied to `CLAUDE.md` (project)

### Edit 1 — Gen~ section (Delay.read/write + gen~ Param `@` syntax + variable-init in if/else)

Added bullets after the existing `Param`/`History` lines:
- `Delay myDelay(max_samples);` declaration; `myDelay.write(x)` / `myDelay.read(t)`. The `delay()` function is NOT supported in codebox — only in gen~ patcher (visual) mode. Includes the exact MAX error message.
- Multiple reads from the same Delay are allowed (dual-tap pitch shifter).
- Variables used inside `if`/`else` must be initialized before the block.
- gen~ Params are set via `param_name $1` messages (NO `@` prefix). `attrui` for auto-generated all-params interface.

Resolves: `feedback_genexpr_delay_syntax`, `feedback_gen_param_messages`.

### Edit 2 — Bpatcher section (comment-box `#N` exclusion)

Inserted after the existing "applies equally to newobj boxes and message boxes" sentence:
> **Comment boxes do NOT perform `#N` substitution.** Only `newobj` and `message` boxes do. Use `loadbang -> message "set Label #1" -> comment` chain for dynamic labels.

Resolves: `feedback_comment_no_hash_sub`.

### Edit 3 — Subpatcher Inlet/Outlet Access (no `inlet~`/`outlet~` + `comment` attribute)

Appended two paragraphs after the code example:
- No `inlet~` / `outlet~` objects exist; always use `inlet` / `outlet` (maxclass `"inlet"`/`"outlet"`).
- Label inlets/outlets via `extra_attrs={"comment": "..."}` (the "Assistance" tooltip), NOT freestanding comment objects.

Resolves: `feedback_inlet_outlet_maxclass`, `feedback_assistance_comments`.

### Edit 4 — Multislider subsection (fetch behavior)

Appended:
> Send `fetch $1` (NOT `fetchindex` — does not exist). Fetched value comes from outlet 1 (right), not outlet 0. Don't insert `split` between multislider and consumer.

Resolves: `feedback_multislider_fetch`.

### Edit 5 — MSP section (line~ comma, buffer~ no info, expr no clip, floor~ RNBO, umenu items format)

Added 5 bullets after the existing Multichannel bullet:
- `line~` replaces ramps; use single space-delimited list for multi-segment envelopes.
- `buffer~` has no `info` query; bridge through `fluid.buf2list` or `jit.buffer~` + `jit.matrixinfo`.
- `expr` / `expr~` have no `clip()` — use `min(max(x, lo), hi)`.
- `floor~` is RNBO-only — use `trunc~` in MSP, or do the math in Gen~.
- `umenu` items use comma-as-element format `["LP", ",", "HP", ...]`.

Resolves: `feedback_line_tilde_comma`, `feedback_buffer_info_query`, `feedback_expr_no_clip`, `feedback_floor_tilde_rnbo`, `feedback_umenu_items_format`.

### Edit 6 — New "Max for Live (M4L / .amxd)" section

Inserted between `js` and `PD Confusion Guard`. Three bullets:
- No `gain~`/`live.gain~`/`ezdac~` before `plugout~`.
- `live.dial`/`live.slider` bind to gen~ Params via `param_connect` (not message-box patching). Includes full attribute set: `param_connect`, `parameter_enable`, `saved_attribute_attributes.valueof` (with all 8 sub-fields), gen~ `varname` requirement.
- Slider → line~ → gen~ signal-rate exception: keep signal path, set `parameter_enable: 1` + `saved_attribute_attributes.valueof` on the slider.

Resolves: `feedback_m4l_no_gain`, `feedback_m4l_param_connect`.

### Edit 7 — Object Database section (empty I/O + maxclass="newobj")

Appended two paragraphs to "How to Use the Database":
- Verify lookup results have non-empty I/O; treat empty-I/O entries as missing; use `db.audit_empty_io()`.
- The `maxclass` field in the DB is NOT authoritative; most objects use `maxclass: "newobj"` with the name in `text`. Authoritative source is `UI_MAXCLASSES` in `src/maxpat/maxclass_map.py`.

Resolves: `feedback_db_empty_io`, `feedback_maxclass_newobj`.

### Edit 8 — New Rule #8 (replace_box orphans)

Inserted after Rule #7 multi-instance note: replace_box does NOT preserve connections; iterate `result.orphaned` and re-add via `add_connection()`.

Resolves: `feedback_replace_box_orphans`.

---

## Verification

- `wc -l CLAUDE.md` → 290 lines (was 258, +32 lines).
- All target rules grep-confirmed in the updated file.
- No existing instructions were removed or altered (only additions and one extension to the Bpatcher paragraph).

## Notes

- 6 memories deliberately skipped (DB-data, package-specific, niche DSP, layout micro-detail). Each retains its memory file as the source of truth — promotion to CLAUDE.md would either bloat the doc or duplicate code-level fixes.
- The user's global `~/.claude/CLAUDE.md` only contains a generated developer profile — no MAX-specific instructions exist there to drift from. No edits applied.
- This audit closes FINDINGS.md item P0-5. The four next-priority items (P0-1 fan-out enforcement, P0-2 external `.gendsp` validation, P0-3 `signal_role` per outlet, P0-4 install-state DB tag) remain open and warrant their own phases.
