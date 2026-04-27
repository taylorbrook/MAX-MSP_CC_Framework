---
phase: quick-260427-hox
plan: 01
type: meta-review
date: 2026-04-27
scope: synthesis of feedback memories + recent patch work + framework state
---

# MAX System Meta-Review — Patterns, Root Causes, and Improvement Avenues

## Executive Summary

After v4.0 ship (2026-04-15), the framework's connection-level correctness is rock-solid. Where issues continue to surface — and where they cluster in 30 feedback memories plus the recent commit history — is in **four pressure points**:

1. **Object DB is a leaky abstraction.** Extraction defaulted ~600 outlet types wrong, dropped some objects entirely, and inherited stale aspirational entries (e.g. `bach.llll2list`). Override coverage is partial. 130 entries still have empty I/O.
2. **Validator catches connection-level bugs but not behavioral bugs.** Fan-out without trigger has 8–16 instances per patch yet only warns; external `.gendsp` files bypass GenExpr validation entirely; resonant-filter-in-loop architecture errors (the bassoon-model v0.4–0.5 saga) aren't catchable statically.
3. **CLAUDE.md / SKILL.md drift from reality.** Multiple feedback memories exist *because* CLAUDE.md is wrong (V_SPACING=20 vs 80–120, `in1` vs `in 1`, layout values). The fix loop is: agent follows CLAUDE.md → user catches → memory written → CLAUDE.md often unupdated.
4. **Editing API has sharp edges.** `replace_box` orphans connections silently. DB `lookup()` returns hits with empty I/O. Both have caused multi-hour debugging sessions.

The good news: most of these are addressable. Below is a prioritized punch list with specific commits/files to touch.

---

## Pattern Analysis: 30 Feedback Memories

| Category | Count | Recurrence Risk | Root Cause |
|---|---:|---|---|
| A. Object DB data quality | 12 | **HIGH** — extraction is partial, drift continues | Extractor defaults + stale aspirational entries + missing objects |
| B. Object behavior quirks (per-object gotchas) | 8 | MEDIUM — Claude generates from training prior | Documented behavior diverges from MAX implementation (`buffer~ info`, `expr clip`, `multislider fetch`) |
| C. GenExpr/codebox syntax | 4 | LOW — now in validator | Codebox dialect ≠ patcher dialect (`in1` vs `in 1`) |
| D. bpatcher/abstraction (#N) | 3 | LOW — caught by validator | Substitution rules are non-obvious (standalone-token, not in compound or comment) |
| E. M4L conventions | 2 | MEDIUM — depends on plugout~/param_connect path | Live integration patterns not in core docs |
| F. Layout / visual | 2 | LOW — defaults pinned | Generic spacing rules don't capture companion patterns (gain~/meter~) |
| G. Patcher API mistakes | 2 | **HIGH** — silent data loss | API surfaces returns successful values that aren't safe to use (`replace_box`, `lookup` empty I/O) |
| H. Process / git | 2 | MEDIUM — stash bans help | Worktree merges + concurrent instances |
| I. DSP architecture | 1 (large) | MEDIUM — needs new tooling | No static analysis can prove waveguide tuning correctness |

### Top recurring root causes

1. **Extraction over-trusted XML refpages.** The 2026-03-11 outlet-type bug, the 168 empty-I/O entries, the 667 wrong `maxclass` values, the missing `live.scope~` — all the same shape: extractor produced data the validator then trusted, and only the user caught the divergence at runtime.

2. **DB shape is too flat.** Outlets are `signal: bool`, but real MSP outlets carry roles like `audio | trigger | status | float | data` (e.g. `buffer~` outlet 0 is audio, outlet 1 is "done bang"; `info~` mixes both). The override-with-`signal:false` patch works but leaks meaning.

3. **Aspirational vs installed.** DB entries that exist in some "official" reference but not in the user's actual MAX install (`bach.llll2list`, `floor~` at MSP level). The DB doesn't track install state.

4. **Validator is mostly warning-not-error.** Fan-out without trigger = warning. Empty I/O = lookup returns success. Unverified outlet = warning. Soft signals that get drowned in patch noise.

5. **CLAUDE.md as second source of truth.** Several feedback memories exist purely to override CLAUDE.md statements. The two should never disagree.

---

## What's Already Working (don't break)

| Strength | Evidence |
|---|---|
| Connection validation | All sampled patches: 0 OOB indices, 0 PD objects, 0 missing boxes |
| Layered domain checks | 13 Layer-4 checks now cover most Category B/C/D feedback |
| `db_lookup.audit_empty_io()` | Self-reporting health check (added in 260419-w9l) |
| `variable_io_rules` consolidation | 260421-b3a: single source of truth in overrides.json |
| Tight default spacing | 260319: V_SPACING=20, H_GUTTER=15 in defaults.py |
| Box._raw round-trip | v3.0 architectural change eliminated 5 categories of bugs |
| Per-domain DB files + overrides | Right shape for extension; package work in v4.0 confirms this scales |
| Findings-first audit pattern | 260420-j15 / 260331-n24 produced clean punch lists with disposition (obvious/judgment/info) |

Don't refactor these.

---

## Open Gaps (prioritized)

### P0 — High ROI, addresses recurring problem

**P0-1. Promote fan-out-without-trigger from warning to error (or a new "code review" tier).**
Last review measured 8–16 instances per patch. Agents are not treating it as a hard requirement because the validator says it isn't. Either fail the patch or add a third tier ("code-review") that the critic loop actually escalates on. File: `src/maxpat/critics/structure_critic.py`, `src/maxpat/validation.py`.

**P0-2. Validate external `.gendsp` files referenced via `gen~ @gen file.gendsp`.**
The gen-eq engine bypasses GenExpr I/O validation. Load the referenced `.gendsp`, parse codebox content, run the same `_check_genexpr_*` battery. File: `src/maxpat/critics/dsp_critic.py` (extend `_check_gen_io_match`).

**P0-3. Per-outlet `signal_role` instead of `signal: bool`.**
The MSP outlet override saga is a direct symptom of an under-specified type. Add `signal_role: "audio" | "trigger" | "status" | "data" | "list"` (signal:bool stays for back-compat). MSP overrides become declarative. Connection validator can give richer errors ("status outlet → signal inlet without snapshot~"). Files: `.claude/max-objects/overrides.json` (schema), `src/maxpat/db_lookup.py` (loader), `src/maxpat/validation.py` (Layer 3).

**P0-4. Install-state tag on DB entries.**
Every package object knows its source `_pkg-source/<pkg>` directory. Add `verified_installed: true|false` per object. CI can re-verify against installed package files. Stale entries like `bach.llll2list` get auto-flagged. File: `.claude/max-objects/{packages,...}/objects.json` schema + `extract_objects.py`.

**P0-5. CLAUDE.md ↔ feedback memory drift audit.**
Walk the 30 memory files. For each, check whether CLAUDE.md (project) or `~/.claude/CLAUDE.md` (global) still contains the wrong instruction. Fix at the source. Recent examples: layout spacing values, GenExpr `in 1` vs `in1` (CLAUDE.md still says `in 1`), `delay()` vs `Delay.read/write`. File: `CLAUDE.md` + project skill files. **One-shot quick task, ~30 min.**

### P1 — Substantial improvement, moderate effort

**P1-1. `replace_box_safe(old, new, args, rewire="auto"|"manual")`.**
Current `replace_box` returns orphans without auto-rewiring. When the new box's I/O matches the old (same inlet/outlet count and types), automatic rewiring is safe. Make it the default; require `rewire="manual"` to opt out. File: `src/maxpat/patcher.py`. Mirrors the bassoon `ears.slice~ → ears.split~` lesson.

**P1-2. `lookup_strict()` that fails on empty-I/O entries.**
Patch builders should never get back a "successful" lookup with no I/O schema. Add `db.lookup_strict(name)` that returns None for empty-I/O entries (falls back to "not found" path, which already prompts override addition). Keep `lookup()` for inspection use cases. File: `src/maxpat/db_lookup.py`.

**P1-3. Companion-pair layout patterns.**
gain~/meter~ should sit *beside*, not *below*; dial+flonum overlay; live.dial+live.text labels. Encode known companions in `defaults.py` (or extend `relationships.json`); layout pass applies them. Reduces overlap fixes the user has to make manually. File: `src/maxpat/layout.py`, `defaults.py`, `.claude/max-objects/relationships.json`.

**P1-4. Domain-only-object guard.**
RNBO-only objects (`floor~`, `dcblock~`, etc.) at MSP top level should hard-error. Currently the validator warns but doesn't block. Flag `domain_restricted: ["rnbo"]` on those entries. File: `src/maxpat/validation.py` Layer 4 + `overrides.json`.

**P1-5. Maxclass-correctness check.**
Verify `maxclass == "newobj"` for any object whose name is not in `UI_MAXCLASSES`. Catches the residual maxclass-confusion class of bugs at validation time. File: `src/maxpat/validation.py` (extend Layer 2).

**P1-6. Fill remaining 130 critical empty-I/O entries.**
Most are community packages (`abc.*`) and pseudo-pages (`Jitter GL Object (OB3D) Messages` which isn't even an object — extractor caught a doc heading). Two-pass: (a) blacklist non-objects, (b) populate the rest from `_pkg-source` reference files. The 11 critical core objects from 260419-vy7 are already fixed; this is the cleanup tail.

### P2 — Strategic / nice-to-have

**P2-1. Pre-flight DSP simulation harness for waveguides/feedback.**
The bassoon v0.4–0.5 phase-delay saga took ~5 versions to land because the architecture-vs-tuning distinction only surfaces at runtime. A small numpy waveguide sim that sweeps a Param and measures pitch stability could catch high-Q-in-loop architecture bugs *before* the patch is built. The waveguide memory already documents the protocol. File: new `src/maxpat/dsp_sim/` module. Selectively invoked by max-dsp-agent for waveguide patches.

**P2-2. Split `patcher.py` (2094 lines).**
Already half-done since n24 review (2827→2094). Continue: `analysis.py` already extracted; could extract `box.py` (Box dataclass + maxclass logic) and `connections.py` (Patchline + connection helpers).

**P2-3. M4L pattern templates.**
Both M4L feedback memories (gain~ before plugout~, param_connect for gen~) imply a missing template. A reusable `m4l_gen_synth_skeleton(params=[...])` that wires gen~ + live.dial via param_connect correctly would prevent both classes of error. File: `src/maxpat/m4l_polish.py` exists; extend with skeleton builders.

**P2-4. Critic loop hard tier.**
Currently 3-round soft limit with user approval. Add a tier of checks that count as code-review-failed (hard fail) vs warnings (advisory). Fan-out, gain staging unsafe values, and unterminated MSP chains belong in the hard tier. File: `src/maxpat/critics/__init__.py`.

**P2-5. Audit pattern as standing process.**
The 260420-j15 disposition framework (obvious-correct / judgment-required / informational) is a reusable template. Run it as a standing monthly process: audit DB, audit validator coverage, audit feedback-memory→code-fix conversion. Can live as `/gsd-quick audit-system` skill or scheduled cron.

---

## Layout-Specific Observations

| Issue | Current state | Fix |
|---|---|---|
| Generic spacing | 20px V / 15px H pinned in defaults.py — good | — |
| Companion pairs (gain~/meter~) | Manual; layout-aware in some patches, not others | P1-3 above |
| Message box width | 8px/char + 25px chrome — captured in memory but not in `layout.py` | Encode in `box.estimated_render_width()` helper |
| Multislider as labeled bank | CLAUDE.md has the formula (size × 24, contdata=1, setstyle=1) | Promote to a `add_labeled_param_bank()` builder |
| Z-order overlay readouts | Manual via `bring_to_front` + `ignoreclick=1` | Add `add_overlay_readout(target, format)` builder that does both |
| Negative coords | Zero observed in sampled patches | — |
| Object overlaps | 3–8 per patch in tight rows | Layout critic catches them; promote to error in finalize_patch path |

---

## Object Database — Current Health

```
Critical empty I/O:        130   (down from 168 pre-260419-vy7)
  └─ Core objects:          ~5   (mostly fluid.* and a few jitter pseudo-pages)
  └─ Community packages:   ~125  (abc.*, etc. — populate from _pkg-source)
variable_io_ok:              34
covered_by_override:          0  (suggests overrides aren't tagged as 'covers')

Domains:    8 (max, msp, jitter, mc, gen, m4l, rnbo, packages)
Patcher:    src/maxpat/patcher.py = 2094 lines, 43 functions
Validator:  src/maxpat/validation.py = 1139 lines, 13 Layer-4 checks
Critics:    7 modules, ~2070 lines (dsp 524, package 430, m4l 358, layout 318, structure 270, rnbo 233, ext 123)
```

DB-side leverage points:
- The 130 critical entries are mostly community packages — bulk-populate from `_pkg-source` reference files.
- Schema upgrade (`signal_role`, `domain_restricted`, `verified_installed`) is the highest-leverage one-time investment.
- `audit_empty_io()` is good — but `covered_by_override: 0` is suspicious. Either the count is broken or no overrides are flagged as covering empty entries. Worth a 5-minute investigation.

---

## Top 10 Concrete Recommendations (ranked)

1. **Drift audit CLAUDE.md against the 30 feedback memories.** Single quick task, low risk, eliminates entire class of recurrences. *(P0-5)*
2. **Add `signal_role` per outlet to overrides + db_lookup + validator.** Highest-leverage schema improvement. *(P0-3)*
3. **Promote fan-out-without-trigger to hard error or "code review" tier.** Targets the most common structural defect. *(P0-1)*
4. **Validate external `.gendsp` files.** Closes the gen-eq blind spot. *(P0-2)*
5. **`replace_box_safe` with auto-rewire by default.** Prevents the silent-orphan trap. *(P1-1)*
6. **`lookup_strict()` rejecting empty-I/O entries.** Fail fast at lookup, not at connection time. *(P1-2)*
7. **Install-state DB tag.** Catches `bach.llll2list`-class drift on next extraction. *(P0-4)*
8. **Companion-pair layout patterns.** Reduces manual overlap fixes; users notice. *(P1-3)*
9. **Domain-restricted object guard (RNBO at MSP level).** Hard-error `floor~` etc. at top level. *(P1-4)*
10. **DSP simulation harness for waveguides.** Long-tail; pays off the next time a waveguide patch is built. *(P2-1)*

A single `--full` quick task can reasonably cover #1, #6, #9 in one pass. #2 + #3 + #4 each warrant their own phase.

---

## What I Did NOT Find

- No evidence of architectural rot in the patcher/validator core. The system is mature.
- No catastrophic data loss patterns in current code (the worktree-stash issue led to Rule #7 which appears effective; no recent stash incidents).
- No agent-prompt drift or stale SKILL.md references (260331-n24 confirmed clean; nothing has regressed).
- The recent v4.0 milestone executed cleanly per RETROSPECTIVE.md. No new milestone-scale gaps surfaced.

---

## Suggested Next Action

Run the **CLAUDE.md drift audit (P0-5)** as the next quick task — it's the cheapest win and seeds the others (each fix removes a row from the "things memories patch" list).

Then spec a v5.0 milestone proposal around schema improvements (P0-3 + P0-4) plus validator hardening (P0-1 + P0-2). That cluster is coherent enough for one milestone, big enough to deserve dependency-ordered phases, and addresses the genuine recurring-issue surface area.
