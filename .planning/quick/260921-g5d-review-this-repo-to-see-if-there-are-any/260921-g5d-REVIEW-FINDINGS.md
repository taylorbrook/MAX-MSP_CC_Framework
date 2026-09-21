# Repo Review vs Installed Max 9.1.5 — Findings

**Quick task:** 260921-g5d
**Review date:** 2026-09-21
**Reviewed at:** `3b461aa9e258ba0737411047189861cfd70c456a` (branch `main`)

| Fact | Value | Source |
|---|---|---|
| Installed Max | **9.1.5** (build `3db35fa476d`) | `/Applications/Max.app/Contents/Info.plist` → `CFBundleShortVersionString` (read via `plistlib`; the Max binary was never executed) |
| Refpages on disk | 1932 files / 1588 distinct object names | `C74/docs/refpages/{max,msp,jit,m4l}-ref` + 4 bundled packages |
| DB extraction | 2026-07-01T21:43:50Z — **82 days old** | `.claude/max-objects/extraction-log.json` |
| DB objects loaded | 3075 canonical | `ObjectDatabase()._objects` |
| Test baseline (before) | **9 failed, 2169 passed, 4 xfailed** in 31.93s | `python3 -m pytest -q` |
| Test result (after) | **9 failed, 2169 passed, 4 xfailed** — identical failure set | re-run after the one candidate fix |
| Applied fixes | **0 committed** (see below) | — |

Raw evidence backing every claim below: `audit-260921-g5d.json` (342 KB, 12 sections) in the session scratchpad, produced by `audit_db.py`.

---

## Headline

**The object DB is in far better shape against 9.1.5 than the task assumed.** After correcting the audit's own name-derivation bug (see SF-07), only **9** installed objects fail to resolve — and 5 of those are documentation pages, not objects. **Zero** DB inlet/outlet counts contradict an unambiguous maxref. **Zero** objects referenced by a committed patch fail to resolve or carry empty I/O.

The real problems are not drift. They are (a) one stale entry that can silently generate a broken patch, (b) a 9-failure test baseline, and (c) a warning channel so noisy it hides its own signal.

---

## Applied fixes

> **Orchestrator update (2026-09-21, after the executor returned):** both qualifying fixes were applied on `main` by the orchestrator — `main` is this repo's only branch and the quick workflow resolved `branch_name: null` (commit on the current branch). Full suite re-run afterwards: `9 failed, 2169 passed, 4 xfailed` — failure set identical to baseline.
>
> | Fix | Commit |
> |---|---|
> | MF-01 — `bach.list2llll` → `verified_installed: false` in `overrides.json` | `9ddd8c4` |
> | SF-02 — CLAUDE.md object-count table + `packages/<Package>/objects.json` layout | `540b33a` |
>
> The executor's original account follows unchanged for the record.

**None committed by the executor.**

One fix qualified on the merits and was fully verified, then reverted unapplied for a process reason, not a technical one:

| Candidate | Change | Verification | Status |
|---|---|---|---|
| `bach.list2llll` (MF-01) | Add `verified_installed: false` + `_audit` block to `overrides.json`, matching its sibling `bach.llll2list` byte-for-shape | `overrides.json` parses; `get_install_state("bach.list2llll")` → `False`; `audit_empty_io()['critical']` unchanged at 9; **suite 9 failed / 2169 passed / 4 xfailed — failure set byte-identical to baseline** | **Verified, NOT committed** |

**Why it was not committed:** `HEAD` is on `main`, which resolves as the protected/default branch (`gsd-tools query git.base-branch --is-protected main` → `true`), and `.planning/config.json` carries no `git.allow_default_branch_commits: true`. The executor's mandatory pre-commit assertion refuses to commit to a protected branch, and an orchestrator instruction is not user consent. Creating a feature branch was rejected as the more dangerous option: a second Claude instance is concurrently editing `patches/scala-synth/generated/scala-synth.maxpat` in this same working tree, and switching branches underneath it risks their uncommitted work.

The working tree was restored to pristine so nothing dangles. The exact verified diff is saved at `fix-01-bach-list2llll.patch` in the scratchpad and reproduced under MF-01.

**To unblock:** either set `git.allow_default_branch_commits: true` in `.planning/config.json` (matches this repo's actual single-branch history — all 12 prior quick tasks committed to `main`, and `main` is the only branch that has ever existed), or say the word and the patch is a 10-second re-apply.

---

## Must-fix

### MF-01 — `bach.list2llll` resolves with full I/O but does not exist in the installed bach package

**Blast radius:** silent generation of a patch that fails at load.

`bach.llll2list` carries `verified_installed: false` in `overrides.json`. Its sibling `bach.list2llll` does not — `get_install_state("bach.list2llll")` returns `None` (unaudited). Yet `lookup("bach.list2llll")` returns a complete, plausible entry (1 inlet, 1 outlet, `digest: "Convert MAX list to llll"`), so a generator will happily emit it and the resulting patch fails in MAX with "No such object".

This is an oversight, not a deliberate asymmetry — **the existing entry's own provenance names both objects**:

> `"source": "memory/feedback_bach_no_llll2list.md -- bach.llll2list/list2llll do not exist in installed bach package"`

CLAUDE.md states the same under **bach (package)**. `src/maxpat/critics/package_critic.py:340` actively special-cases `bach.list2llll` as a valid list consumer, so the critic currently *endorses* an object that cannot instantiate.

No committed `.maxpat` uses it (only `.md`/`.json` prose in `patches/physics-composition/`), so this is a future-generation risk, not a live breakage.

**Recommended action** (verified, ready to apply — insert after the `bach.llll2list` block in `.claude/max-objects/overrides.json`):

```json
"bach.list2llll": {
  "verified_installed": false,
  "_audit": {
    "source": "memory/feedback_bach_no_llll2list.md -- bach.llll2list/list2llll do not exist in installed bach package; CLAUDE.md 'bach (package)' rule",
    "confidence": "HIGH",
    "finding": "quick-260921-g5d: sibling of bach.llll2list. ... Marked false to match the sibling and close the asymmetry."
  }
}
```

**Caveat recorded in the entry:** this was not independently re-verified against the installed bach package, because bach is a *user* package under `~/Documents/Max 9/Packages`, which macOS TCC blocks this process from reading (see SF-05). It rests on the existing HIGH-confidence audit note and CLAUDE.md.

---

### MF-02 — 9 pre-existing test failures in the baseline

**Blast radius:** the suite cannot certify a change, because "9 failed" is indistinguishable from "9 failed plus yours".

```
6x tests/test_integration_patches.py::test_review_patch_no_blockers
     [looper, reverse-delay-mono, reverse-delay, simple-fm,
      stereo-feedback-delay, terrain-osc-test]
2x tests/test_round_trip.py::TestSubpatcherByteIdentity::test_byte_identical_round_trip
     [performance-patch-template, scala-synth]
1x tests/test_signal_role_migration.py::TestBackCompatConsumerAnchors::
     test_dsp_critic_outlet_signal_read_pattern_unchanged
```

These are **not** caused by the concurrent instance's uncommitted edits. Verified non-invasively by round-tripping the committed blob from `git show HEAD:patches/scala-synth/generated/scala-synth.maxpat` in the scratchpad: the HEAD version fails byte-identity too (162823 → 162824 bytes).

STATE.md's deferred-items table already tracks a related "~48 pre-existing TestCommunityPackageBlock failures", so some of this is known debt — but the current set of 9 is not itemized anywhere.

**Recommended action:** one follow-up quick task to triage these 9 into fix-now vs. formally-xfail-with-reason, so the suite returns to a green baseline that can actually gate future work.

---

### MF-03 — The empty-I/O warning fires on 218 entries while the audit reports 9

**Blast radius:** the one channel designed to surface "this object cannot be connected" is buried in false positives.

Two predicates disagree:

| Mechanism | Predicate | Fires on |
|---|---|---|
| `audit_empty_io()` (`db_lookup.py:870`) | **both** sides empty | **9** |
| `_maybe_warn_empty_io()` (`db_lookup.py:404`) | **either** side empty | **218** |

The 209-entry gap is objects with exactly one side populated. **Most are correct data**: `dac~`, `ezdac~`, `scope~`, `send~`, `print`, `panel`, `outlet`, `out~`, `mc.dac~`, `out` are genuine zero-outlet sinks, and each was confirmed against its maxref (e.g. `msp-ref/dac~.maxref.xml` declares 2 inlets, 0 outlets — the DB matches exactly).

So every patch that uses `dac~` — 14 committed patches do — emits a spurious "patch generation may fail silently" warning. The baseline run logs **483 warnings**. Sixteen distinct objects referenced by committed patches trip this path, all of them correctly modelled.

**Recommended action:** align the warning predicate with the audit (`both` sides empty), or keep the stricter check but exempt known sink/source shapes. Either is a change to `src/maxpat/db_lookup.py` and therefore out of scope for this review — it needs its own task with test coverage.

---

## Should-fix

### SF-01 — `node.script` / `node.codebox` are the only genuinely missing installed objects

Of the 9 installed names that do not resolve, 5 are documentation pages rather than objects — `Jitter GL Object (OB3D) Messages`, `Jitter Matrix Operators`, `Parameter Properties`, `MC Wrapper Features`, `Snapshot Messages`. Two more are RNBO data fixtures (`kbm.data`, `scl.data`).

That leaves `node.script` and `node.codebox`, both real, both installed (`bundled-pkg/Node for Max` refpages **and** a matching binary on disk). CLAUDE.md's **Node for Max** rule correctly documents `node.script` as absent and forbids its use under Rule #1 — **this gap is confirmed still open**, not closed.

**Recommended action:** a scoped task to add both to `.claude/max-objects/`, with I/O taken from their refpages, which would retire the CLAUDE.md workaround (build-time Python emitting `coll`/`dict`).

### SF-02 — CLAUDE.md's object-count table is stale in 5 of 8 domains, and the `packages/` path is wrong

| Domain | CLAUDE.md | On disk | |
|---|---|---|---|
| max | 470 | **471** | mismatch |
| msp | 248 | **246** | mismatch |
| jitter | 210 | **218** | mismatch |
| mc | 215 | **222** | mismatch |
| gen | 189 | 189 | ok |
| m4l | 33 | **35** | mismatch |
| rnbo | 560 | 560 | ok |
| packages | 87 | **1489** | mismatch |

CLAUDE.md documents `packages/objects.json` as a single file. It does not exist. The real layout is **29 per-package directories** — `.claude/max-objects/packages/<Package>/objects.json` (e.g. `packages/Bach/objects.json`) — totalling 1489 objects, matching `extraction-log.json`.

This was the one doc correction that qualified under the plan's category 4, but it shares MF-01's commit blocker. Every other CLAUDE.md-named symbol and path was verified present: all 35 helpers (`ObjectDatabase`, `ensure_text_contrast`, `repair_text_contrast`, `replace_box_safe`, `add_labeled_param_bank`, `add_overlay_readout`, `add_m4l_gen_synth`, `MIN_CONTRAST_RATIO`, `UI_MAXCLASSES`, …) resolve to a definition site, and `tools/extract_pkg_io.py` + `scripts/audit_signal_role.py` both exist. **Doc drift is confined to the count table.**

### SF-03 — `codebox` is used by 24 patches but is not in `UI_MAXCLASSES`

Across 62 committed `.maxpat` files, 51 distinct `maxclass` values appear. Only two fall outside `UI_MAXCLASSES`: `newobj` (structural, correct) and **`codebox`** (24 files). `codebox` carries its own name as `maxclass` — the exact signature `UI_MAXCLASSES` is meant to enumerate, per CLAUDE.md's rule that only true UI widgets do this.

It works today because `add_gen()` constructs it directly. But the gap is the same shape as the `jit.pwindow` / `jit.cellblock` bug fixed in commit `fc3aa27`.

**Recommended action:** confirm against a MAX-saved patch whether `codebox` belongs in `UI_MAXCLASSES`, then add it. Touches `src/maxpat/maxclass_map.py` → out of scope here.

### SF-04 — CLAUDE.md's "`live.*` incompletely extracted" note describes a gap that is now closed

All **30** `live.*` objects documented in the installed bundle resolve via `lookup()`; the DB carries 33. None is unresolved. The 5 with one empty side (`live.comment`, `live.line`, `live.miditool.out`, `live.param~`, `live.push`) are label/decorative/source shapes whose counts contradict no unambiguous maxref.

The CLAUDE.md sentence is phrased as *advice* ("also grep existing `.maxpat` files…"), not a live claim, so it was deliberately **not** rewritten — the plan scopes category-4 edits to factual corrections and explicitly excludes rewriting rules.

### SF-05 — User packages are unreadable, leaving a 121-entry audit blind spot

`~/Documents/Max 9/Packages` exists but macOS TCC denies this process access (`PermissionError: [Errno 1] Operation not permitted`). Consequences:

- The `by_source` empty-I/O breakdown shows 0 refpages for **every** user package — `packages/abclib` (65 entries), `packages/Bach` (3), `packages/CNMAT` (5), `packages/FluCoMa` (2), `packages/grainflow` (7), `packages/jit.mo` (8), and 12 more. That "0 have refpage" is a **measurement artifact, not evidence of absence**.
- MF-01 could not be independently confirmed against the installed bach package.

**Recommended action:** grant Terminal/Claude Full Disk Access, or re-run the harness from a context that can read `~/Documents`, before trusting any user-package conclusion.

### SF-06 — 54.5% of core refpages carry unfilled Cycling '74 template placeholders

640 of 1175 core refpages contain at least one I/O entry with `TEXT_HERE`, `INLET_TYPE`, `OUTLET_TYPE`, `undefined`, or `Dummy` — `max-ref` worst at 429/473, then `jit-ref` 91/210, `msp-ref` 98/455, `m4l-ref` 22/37.

Two live examples that would have produced bad "fixes":

- `spectroscope~` — maxref declares 1 outlet of type `OUTLET_TYPE` described `undefined`; the DB says 0 outlets and is already an expert override.
- `in` — maxref declares 1 inlet described literally `Dummy`; the DB says 0 inlets, also an override.

**This is the hard ceiling on any re-extraction**: the maxref is authoritative for *counts* far more often than for *types*, and sometimes not even for counts.

### SF-07 — Refpage filenames are not object names (808 of 1932 differ)

The authoritative name is the root `<c74object name="...">` attribute, **not** the filename. `bitand.maxref.xml` documents `&`; `greaterthan.maxref.xml` documents `>`; `fswap.maxref.xml` documents `swap`; `gswitch2.maxref.xml` documents `ggate`; `gen_common_abs.maxref.xml` and `rnbo_abs.maxref.xml` both document `abs`.

Keying off filenames reported **804** objects "missing from DB". Keying off the `name` attribute reports **9**. The first draft of this review's own harness had this bug and was corrected mid-audit.

**Recommended action:** whoever runs the next extraction must read the `name` attribute. Recording this in CLAUDE.md or the extraction tooling would prevent a future audit from manufacturing ~795 phantom gaps and "fixing" them.

### SF-08 — 22 DB entries have no refpage; all 22 are explained, none is confirmed stale

`jitter` 10, `mc` 7, `m4l` 3, `max` 2; `gen`/`msp`/`rnbo` clean. Three have a matching installed binary and therefore **do** exist despite the missing refpage: `live.scope~`, `mira.frame`, `jit.gl.pbr`.

`jit.*` looked like a wildcard-glob junk key but is a **real object** — "Jitter matrix multiply" — documented under the `Jitter Matrix Operators` page rather than its own file.

**No deletion is recommended for any of the 22.** Absence of a refpage is suggestive, not proof, and this set demonstrates why.

---

## Nice-to-have

### NH-01 — Promote the audit harness into `tools/` with tests

`audit_db.py` (~600 lines, read-only) produces all 12 evidence sections in ~40s. As a scratchpad throwaway it is unreproducible; in `tools/` with a small test it makes DB drift measurable on demand and turns this review into a repeatable check.

### NH-02 — Add an `audit_half_empty_io()` to close the MF-03 gap

No existing `audit_*` function reports the 209 one-side-empty entries. Whatever is decided for MF-03's warning predicate, the audit surface should expose the same set so the two stop disagreeing.

### NH-03 — Re-extract against 9.1.5, bounded by SF-06 and SF-07

The DB is 82 days old, but this review found **no** count contradicting an unambiguous maxref, so re-extraction is low-urgency. If it happens, it must read the `name` attribute (SF-07) and must not overwrite expert overrides with placeholder-typed data (SF-06) — 36 curated outlets deliberately disagree with the maxref and would be silently reverted.

### NH-04 — Flag for the concurrent instance: `scala-synth.maxpat` working copy is 62 KB smaller than HEAD

`patches/scala-synth/generated/scala-synth.maxpat` is 100,771 bytes in the working tree vs **162,823** at HEAD. This matches CLAUDE.md's warning about "a transient degraded save from another instance". **Untouched by this review** — surfaced so its owner can confirm it is intentional before committing.

---

## Explicitly not changed

### Demoted candidate fixes (evidence-backed decisions not to act)

| Category | Candidates | Why demoted |
|---|---|---|
| Empty-I/O with a refpage | `dsp`, `jbox`, `jit_kernel`, `onecopy`, `project` | All 5 refpages declare **0 inlets / 0 outlets**. They are documentation pseudo-objects — digests read "DSP", "Common Box Attributes", "Jitter", "Prevent multiple copies…". Empty I/O is **correct**; populating it would invent data. |
| Empty-I/O without a refpage | `bp.Global Transport`, `bp.serialosc`, `opensoundcontrol`, `snorm` | No ground truth in the bundle. Unfixable without the user packages (SF-05). |
| Mis-typed MSP outlets | **36 outlet-type deltas** | All 36 are **already expert overrides**, and 34 run the direction where the DB deliberately *improves on* the maxref: `line~` out1 is a trigger bang at ramp end, `gain~` out1 a float, `sfplay~` out1 a trigger — the maxref lazily types all three `signal`. "Fixing" these would revert Phase 30's curation. |
| I/O count corrections | **0 actionable** of 504 raw deltas | Every delta is explained by: refpage declares no I/O at all (Gen/RNBO operator pages), placeholder-tainted refpage (SF-06), `variable_io_rules` exemption (argument-dependent by design), or an existing expert override. |
| Stale-entry deletion | the 22 of SF-08 | Absence of a refpage is not proof; 3 have installed binaries and `jit.*` is real. |
| CLAUDE.md rule rewrites | `live.*` advice (SF-04), Node for Max workaround (SF-01) | Plan scopes category-4 to factual corrections; rewriting or reorganizing rules is out of scope. |

### Deliberately out of scope

- **`patches/`** — read-only evidence for this review. Zero files written. The two pre-existing modifications (`.active-project.json`, `scala-synth.maxpat`) belonging to a concurrent instance were never staged, edited, or reverted.
- **Python modules under `src/`** — MF-03, SF-03 and NH-02 all land here and each needs its own task with test coverage.
- **Re-extraction** (NH-03) and **`UI_MAXCLASSES` additions** (SF-03) — explicitly excluded by the plan.
- **`node.script` admission to the DB** (SF-01) — excluded by the plan; recommended as a follow-up.

### Audit limitations

1. **User packages unreadable** (SF-05) — every conclusion is scoped to the app bundle.
2. **Placeholder-tainted refpages** (SF-06) — 54.5% of core refpages cannot adjudicate outlet types.
3. **Patch-object extraction** reads the first token of `newobj` text and the `maxclass` of UI boxes, recursing into nested patchers. Message-box contents, attribute arguments, and objects created at runtime via scripting are **not** covered.
4. **`absent_from_bundle`** scanned the 7 core domain files only; the 29 per-package files were not walked (they are TCC-blocked upstream anyway).

---

## Follow-up tasks this report can be cut into

| # | Scope | Findings |
|---|---|---|
| 1 | ~~Apply the verified `bach.list2llll` override + CLAUDE.md count-table correction~~ **DONE** (`9ddd8c4`, `540b33a`). Remaining: `package_critic.py:340` still special-cases `bach.list2llll` as a valid list consumer | MF-01, SF-02 |
| 2 | Triage the 9 baseline test failures to green or explicit xfail | MF-02 |
| 3 | Align the empty-I/O warning predicate with the audit + add `audit_half_empty_io()` | MF-03, NH-02 |
| 4 | Add `node.script` / `node.codebox` to the DB from their refpages | SF-01 |
| 5 | Confirm and add `codebox` to `UI_MAXCLASSES` | SF-03 |
| 6 | Promote the audit harness into `tools/` with tests | NH-01 |
