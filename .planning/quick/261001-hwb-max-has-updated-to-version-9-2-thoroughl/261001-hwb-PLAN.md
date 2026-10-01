---
phase: quick-261001-hwb
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - tools/sync_max_bundle.py
  - tests/test_sync_max_bundle.py
  - .claude/max-objects/msp/objects.json
  - .claude/max-objects/jitter/objects.json
  - .claude/max-objects/max/objects.json
  - .claude/max-objects/mc/objects.json
  - .claude/max-objects/m4l/objects.json
  - .claude/max-objects/packages/ableton-dsp/objects.json
  - .claude/max-objects/packages/Jitter Tools/objects.json
  - .claude/max-objects/packages/jit.mo/objects.json
  - .claude/max-objects/package_info.json
  - .claude/max-objects/overrides.json
  - .claude/scripts/validate_db.py
  - tests/test_version_tags.py
  - tests/test_package_schema.py
  - tests/test_round_trip.py
  - CLAUDE.md
  - .claude/skills/references/max-9.2-changes.md
  - .claude/skills/references/shared-capabilities.md
  - .claude/skills/max-js-agent/SKILL.md
  - README.md
  - TECHNICAL.md
autonomous: true
requirements: [MAX92-01, MAX92-02, MAX92-03, MAX92-04, MAX92-05, MAX92-06]

estimate:
  tokens: 100000
  raw_tokens: 100000
  tasks: 3
  confidence: low

must_haves:
  truths:
    - "All 12 objects new in Max 9.2 resolve through ObjectDatabase().lookup() with I/O counts equal to what the installed 9.2 bundle ships, and Patcher().add_box() builds each one (the Rule #1 Unknown object error no longer fires for them)."
    - "Existing objects gained their 9.2 messages and attributes (buffer~ trim / replacechannel / url, udpsend / udpreceive port / host / active, coll minany / maxany, pattrstorage getstate / setstate, and the rest of the live delta) and no pre-existing object lost or changed any inlet, outlet, message, attribute or other field."
    - "overrides.json expert corrections are byte-for-byte intact apart from one added version_map key."
    - "Re-syncing the DB after any later Max update is one committed, idempotent command: tools/sync_max_bundle.py dry-run, then --apply."
    - "The 12 new objects carry min_version 9.2, and CLAUDE.md tells agents which objects and features need 9.2."
    - "CLAUDE.md, the js skill and a 9.2 reference describe the v8, buffer~, udp, Gen and Jitter changes with an evidence tier on every claim, and every gen~ workaround learned on 9.1.x is still present."
    - "The pytest failing set is identical to the pre-task baseline and no file under patches/ was touched."
  artifacts:
    - path: "tools/sync_max_bundle.py"
      provides: "Dry-run report plus additive apply modes (new, define, deltas) and the I/O snapshot guard"
      min_lines: 250
    - path: "tests/test_sync_max_bundle.py"
      provides: "Hermetic tests on a fake bundle and fake DB; green with no Max installed"
      min_lines: 120
    - path: ".claude/skills/references/max-9.2-changes.md"
      provides: "Evidence-tiered digest of what Max 9.2 changes for patch and code generation"
      contains: "Evidence tiers"
    - path: "CLAUDE.md"
      provides: "Re-synced object counts, 9.2 version-compat bullets, define-mapped refpage naming exception, buffer~ / v8 / gen~ 9.2 notes"
      contains: "9.2"
  key_links:
    - from: "tools/sync_max_bundle.py"
      to: ".claude/scripts/extract_objects.py"
      via: "importlib load of parse_standard_xml — the repo's one refpage parser is reused, not duplicated"
      pattern: "parse_standard_xml"
    - from: "tools/sync_max_bundle.py"
      to: ".claude/max-objects/overrides.json"
      via: "read-only through ObjectDatabase; the tool has no write path to this file"
      pattern: "overrides"
    - from: ".claude/max-objects/overrides.json"
      to: ".claude/scripts/merge_sources.py"
      via: "version_map key 9.2 (exact names) sorts above key 9, so a later re-merge keeps min_version 9.2 instead of reverting abl.* to 9"
      pattern: "\"9.2\""
    - from: "CLAUDE.md"
      to: ".claude/max-objects/*/objects.json"
      via: "object-count table lines must equal on-disk lengths — re-staling it is the regression pattern this user flags"
      pattern: "objects\\)"
---

<objective>
Bring this repo up to date with Max 9.2.0 (installed build `9.2.0 (e9c80e453de)`): land every new object and every new message / attribute in the object database from the installed bundle, record 9.2-only availability, and update the generation guidance (CLAUDE.md, skills) — all additively, with the existing suite and existing patches untouched.

Purpose: Rule #1 (Never Guess Objects) makes anything absent from the DB unusable. Twelve 9.2 objects currently raise `Unknown object`, 44 existing entries are missing messages / attributes the 9.2 bundle documents, and the js guidance still says the V8 object has no networking or timers. The release notes say what changed; the installed bundle says the exact shape; this plan takes shape only from the bundle.

Output: one committed sync tool plus tests, 12 new DB entries, an additive message / attribute delta, version tagging, a 9.2 reference doc, and targeted CLAUDE.md / skill edits. Three atomic commits (one per task).

Requirements (quick-task scoped; no ROADMAP phase or REQUIREMENTS.md entry exists):
- **MAX92-01** — the 12 new 9.2 objects resolve in the DB with bundle-verified I/O.
- **MAX92-02** — 9.2 messages / attributes on existing objects land additively.
- **MAX92-03** — the sync is reproducible from a committed, idempotent tool.
- **MAX92-04** — 9.2-only availability is recorded (`min_version`, `version_map`, guards).
- **MAX92-05** — CLAUDE.md, skills and counts reflect 9.2; hard-won gen~ workarounds stay.
- **MAX92-06** — patcher-format tolerance for unknown 9.2 keys is proven by test.
</objective>

<execution_context>
@~/.claude/gsd-core/workflows/execute-plan.md
@~/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
CLAUDE.md is already loaded as project instructions — do not re-read it whole. Read only the ranges each task names.

Source of truth for WHAT changed: `.planning/quick/261001-hwb-max-has-updated-to-version-9-2-thoroughl/261001-hwb-RELEASE-NOTES.md` (read it in Task 3, not before).
Source of truth for SHAPE: `/Applications/Max.app/Contents/Resources/C74` (abbreviated `C74/` below).

Scratch directory for baselines and reports (create with `mkdir -p`; never write these files into the repo):
`S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb`

**Context discipline (the DB files are huge):** never open any `objects.json`, `overrides.json` or `package_info.json` with the Read tool. Inspect and modify them only through Python (the tool, or short `python3 -c` probes that print the few fields needed).
</context>

<observed_facts>
Verified live by the planner on 2026-10-01 against the installed bundle and HEAD `ee93974`. The tool's dry-run at execution time is the authority: if a live value differs, the live value wins and the difference goes in the SUMMARY.

**New objects (12) and where their shape comes from**

| Object | DB destination | I/O (help-patch box) | Help `outlettype` | Naming evidence |
|---|---|---|---|---|
| `dspstress~` | `msp/objects.json` | 1 / 0 | — | refpage `docs/refpages/msp-ref`; methods `int`, `float`, `signal` |
| `jit.web` | `jitter/objects.json` | 1 / 2 | `jit_matrix`, `""` | refpage `docs/refpages/jit-ref` |
| `jit.web~` | `jitter/objects.json` | 1 / 4 | `signal`, `signal`, `jit_matrix`, `""` | refpage `docs/refpages/jit-ref`; methodlist has NO `signal` method |
| `jit.gl.web` | `jitter/objects.json` | 1 / 2 | `jit_gl_texture`, `""` | `C74/init/jitter-objectmappings.txt`: `max define jit.gl.web jit.web output_texture;` — no refpage, no own help file (boxes live in `jit.web.maxhelp`) |
| `jit.gl.web~` | `jitter/objects.json` | 1 / 4 | `signal`, `signal`, `jit_gl_texture`, `""` | same file: `max define jit.gl.web~ jit.web~ output_texture;` (boxes in `jit.web~.maxhelp`) |
| `abl.device.reverb2~` | `packages/ableton-dsp` | 4 / 2 | `signal` ×2 | refpage `C74/packages/ableton-dsp/docs` |
| `abl.device.stereocompressor~` | `packages/ableton-dsp` | 6 / 3 | `signal` ×3 | same |
| `abl.dsp.djfilter~` | `packages/ableton-dsp` | 4 / 1 | `signal` | same |
| `jit.message` | `packages/jit.mo` | 1 / 2 | `""`, `""` | refpage `C74/packages/jit.mo/docs` |
| `jit.path.ui` | `packages/Jitter Tools` | 1 / 4 | `jit_matrix` ×2, `""` ×2 | refpage `C74/packages/Jitter Tools/docs` (name attribute correct) |
| `jit.unpack.geomat` | `packages/Jitter Tools` | 1 / 5 | `jit_matrix` ×4, `""` | `C74/packages/Jitter Tools/init/jitter-tools-objectmappings.txt`: `max define jit.unpack.geomat jit.unpack 4 @jump 3 2 3 4 @offset 0 3 5 8;` — its refpage's name attribute is the typo `jit.unpackl.gl` |
| `jit.gl.tex2mat` | `packages/Jitter Tools` | 1 / 1 | `jit_matrix` | same file: `max define jit.gl.tex2mat v8 jit.gl.tex2mat.js;` — its refpage's name attribute is `v8` |

Every one of these boxes is `maxclass: newobj` in the shipped help patches, so `UI_MAXCLASSES` is not touched.

**The collision trap.** Two Jitter Tools refpages (`jit.gl.tex2mat.maxref.xml`, and the older `jit.gl.textureinfo.maxref.xml`) declare the name attribute `v8`. A sync keyed naively on the name attribute would merge Jitter Tools documentation into the core `v8` entry. `packages/Jitter Tools/objects.json` already carries a phantom `v8` key from exactly this (core `v8` wins lookup today, so it is harmless — leave it, list it as a follow-up).

**Existing-object delta (planner's pass over 1,385 resolved refpages), measured against the raw base-file entries the tool can write:** 23 objects gain 57 messages and 28 objects gain 110 attributes — 44 distinct objects, in `max`, `msp`, `mc`, `jitter`, `m4l`, `packages/Jitter Tools` and `packages/ableton-dsp`. Three more objects (`expr`, `funnel`, `waveform~`) differ only through `lookup`: their `overrides.json` entry carries its own `messages` list, which replaces the base list — those are report-only (S3). `overrides.json` replaces `messages` for 13 objects in all (`bpatcher`, `funnel`, `expr`, `expr~`, `vexpr`, `waveform~`, `codebox`, `codebox~`, `pan`, `pan~`, `xfade`, `xfade~`, `mc.sig~`) and `attributes` for none. Among the 44: `buffer~` (`crop_samples`, `replacechannel`, `replacechannel_samples`, `trim`, `trim_samples`, attr `url`), `udpsend` (msg `string`; attrs `active`, `host`, `port`), `udpreceive` (attrs `active`, `port`, `usestring`), `coll` / `coll.codebox` (`minany`, `maxany`), `pattrstorage` (`getstate`, `setstate`), `sfrecord~` / `mc.sfrecord~` (`start`, `stop`), `seq` (`insert`), `dict.pack` (`clear`, `reset`), `dict.deserialize` (`string`), `dict.serialize` (attr `stringmode`), `fftin~` / `fftout~` (`updatewindow`, `copyinput`, `copyoutput`), `jweb` (`bang`, `int`, `float`, `list`, `jit_matrix`), `mousefilter` (attr `button`), `rslider` (attr `inputrangemode`), `abl.device.spectralresonator~` (attr `quantize`), `abl.dsp.saturator~` (attr `bassthreshold`), `jit.gl.meshwarp`, `jit.gl.textmult`, `jit.gl.multiple`, `jit.gl.mesh`, `jit.gl.model`, `jit.gl.asyncread`, `jit.anim.node`. Part of the delta is older DB gaps closing (`waveform~`, `jit.gl.pbr`, `live.scope~`, `jit.fx.rota`) rather than 9.2 news — it is applied all the same because it is what the installed bundle documents.

**I/O of existing objects does not change.** The two I/O-flavoured release notes are runtime fixes: `mc.record~` is 3 / 1 and `stepfun~` is 2 / 2 in both the 9.2 refpage and the DB. 70 other objects show DB-vs-refpage count differences; those are pre-existing expert corrections and are out of bounds.

**Only 3 refpages carry `introduced 9.2.0` metadata** (`jit.gl.model`, `rslider`, `udpreceive`), so "new in 9.2" cannot be derived from that tag — the bundle-vs-DB diff is the detector.

**File serialization differs per file** (all are key-sorted, indent 2): `msp`, `max` and the three package files use `ensure_ascii=False` with a trailing newline; `jitter/objects.json` and `overrides.json` use `ensure_ascii=True` with NO trailing newline. A writer that normalizes style rewrites thousands of unrelated lines.

**Version guards that reject 9.2 today:** `tests/test_version_tags.py::test_abl_objects_are_max9` asserts `== 9`; `.claude/scripts/validate_db.py` `check_min_version_range` rejects anything above 9 and `check_max9_objects` requires exactly 9 for `abl.`; `tests/test_package_schema.py` pins `len(get_package_objects("ableton-dsp")) == 77`. `apply_version_tags` in `.claude/scripts/merge_sources.py` iterates `version_map` keys in reverse string order and checks `exact` before `prefixes`, so a `"9.2"` key with `exact` names takes priority over the `"9"` prefix rule.

**Patcher format.** `Patchline` and `Box` round-trip through `_raw`, and `tests/test_round_trip.py::TestPatchlineAttrs` already proves unknown patchline keys survive. None of the 36 help patches saved by 9.2 carries a new patchline key and no committed patch has been re-saved in 9.2, so the JSON key for background-layer patch cords is not observable yet.

**Baseline at HEAD `ee93974`:** 2211 passed, 3 failed, 2 xfailed, 1 xpassed. The 3 failures are pre-existing `tests/test_integration_patches.py::test_review_patch_no_blockers` cases for `minitaur`, `physics-composition` and `timestretch` — other work's patches, out of scope: neither fix nor worsen them.
</observed_facts>

<settled_decisions>
Resolved at planning. Do not re-litigate; if the live bundle contradicts one, stop and record the contradiction instead of improvising.

- **S1 — Additive only.** Nothing is removed or rewritten on a pre-existing entry. DB messages that 9.2 refpages no longer list (`udpsend` `port` / `host` as messages, `expr` `setall`, the `mc.sig~` wrapper messages, etc.) stay: they are still valid on older builds, and setting an attribute by message still works.
- **S2 — No I/O change on any pre-existing object**, from any source. Refpages are authoritative for counts far more than types and never overrule `overrides.json` (CLAUDE.md, Object Database section).
- **S3 — The tool never writes `overrides.json`.** The single `version_map` addition is a separate, verified, byte-preserving insertion in Task 2.
- **S4 — Placement mirrors siblings.** Core-refpage objects go to their core domain file; bundled-package objects go to that package's file with a `package` field (like `jit.gl.meshwarp`, `jit.mo.time`, `abl.dsp.saturator~`); define-mapped aliases whose mapping line lives in core `C74/init/` go to the domain file of their define target (`jit.gl.web` beside `jit.web`, precedent `jit.gl.movie`).
- **S5 — Names for define-mapped objects come from the objectmappings alias**, never from a refpage name attribute that disagrees with its own filename stem.
- **S6 — Outlet types come from the help-patch box Max itself serialized; counts are cross-checked against the refpage.** The `jit.web~` refpage types all four outlets `signal`; the help patch says `signal, signal, jit_matrix, ""`.
- **S7 — `min_version` is the float 9.2 on the 12 new objects only.** Messages and attributes are plain name lists in this schema; 9.2-only messages / attributes are recorded in prose (reference doc + CLAUDE.md), not by a schema change.
- **S8 — Generator output is unchanged.** `DEFAULT_PATCHER_PROPS` keeps `appversion` 9.0.0, `get_outlet_types` keeps emitting only `signal` / `""` / `multichannelsignal`, `codegen.py` and `code_validation.py` are not edited. No `.maxpat` under `patches/` or `tests/fixtures/` is edited.
- **S9 — Gen~ workarounds stay verbatim.** 9.2's compiler fixes are recorded as an annotation that explicitly keeps every existing rule in force until re-verified in MAX.
- **S10 — Left alone and listed as follow-ups in the SUMMARY:** `extraction-log.json` (timestamped artifact, precedent 260921-j0h); `tools/audit_db.py` (its package glob `packages/*/docs/refpages` cannot see flat `docs/` layouts — ableton-dsp, Jitter Tools, jit.mo, Jitter Geometry — which is why it reports only 3 of the 12); the phantom `v8` key and the unresolved `jit.gl.textureinfo` in Jitter Tools; the 3 pre-existing review-blocker failures.
</settled_decisions>

<tasks>

<task type="tracer" tdd="true">
  <name>Task 1: End-to-end bundle sync — tool, guards, and the three core-refpage objects</name>
  <files>tools/sync_max_bundle.py, tests/test_sync_max_bundle.py, .claude/max-objects/msp/objects.json, .claude/max-objects/jitter/objects.json, .claude/scripts/validate_db.py</files>
  <precondition>`/Applications/Max.app` reports short version 9.2.x (read through `audit_install` in tools/audit_db.py, which uses plistlib and never launches Max). If it does not, halt — every expected value in this plan was observed on 9.2.0.</precondition>
  <read_first>
    - tools/audit_db.py lines 60-225 (ROOT / sys.path pattern, CORE_REFPAGE_DIRS, `_refpage_roots`, `audit_install`) and lines 98-142 (`guard_output_path` style for a named write guard)
    - .claude/scripts/extract_objects.py lines 323-495 (`parse_standard_xml` — the output shape and the tilde inference this task must correct for one case)
    - tools/extract_pkg_io.py: grep for the help-patch box walk (newobj first-token match reading numinlets / numoutlets / outlettype) and reuse that approach
    - src/maxpat/db_lookup.py lines 102-190 (`_load`: domain load order and how package files and overrides merge)
  </read_first>
  <behavior>
    Hermetic tests in tests/test_sync_max_bundle.py build a tiny fake bundle (a handful of refpage XML files, one help patch) and a fake DB under tmp_path; they must pass with no Max installed.
    - New-object detection is keyed on the refpage name attribute; a refpage with no inletlist, outletlist or methodlist is classified as a documentation page, not an object.
    - Apply-new writes an entry whose key set equals that of an existing neighbor in the destination file, with `min_version` equal to the fake bundle's major.minor, `rnbo_compatible` false, keys still sorted, and the file's original serialization style preserved (cover both an ASCII-escaped no-trailing-newline file and a UTF-8 trailing-newline file).
    - Collision guard: a package refpage whose name attribute equals an existing core object and differs from its own filename stem never alters the core entry and is reported.
    - Inlet typing: a tilde-named object whose refpage inlet type is an unfilled template token and whose methodlist has no signal method gets a control inlet; with a signal method it gets a signal inlet.
    - Outlet typing: when a help box exists, its outlettype decides outlet types; a refpage-vs-help count disagreement aborts that object and writes nothing for it.
    - Deltas are additive: new messages / attributes are appended, DB-only messages are retained, and inlets, outlets, digest and every other field are untouched; the additive self-check rejects a hand-mutated field.
    - Idempotence: a second identical apply leaves every file byte-identical.
    - Write guard: after every apply mode the fake overrides.json has an unchanged sha256, and a destination outside the allow-list is refused.
    - Unavailable bundle: a nonexistent app path exits 0 and reports the bundle unavailable.
  </behavior>
  <action>
Step 0 — baselines, before any edit. Create the scratch directory S. Record `git rev-parse HEAD` into `S/base-sha.txt`. Run the full suite with `-rf`, keep the sorted `FAILED` lines as `S/baseline-failed.txt`, and note the pass / fail / xfail totals for the SUMMARY.

Step 1 — create `tools/sync_max_bundle.py`, a CLI that reports and applies the difference between the installed Max bundle and `.claude/max-objects/`. Module docstring: provenance quick-261001-hwb; companion to the read-only `tools/audit_db.py`; a JSON data tool, not a patch generator (Rule #5 only forbids regenerating .maxpat files); additive-only contract; never executes the Max binary and spawns no subprocess.

Reuse, do not duplicate: load `.claude/scripts/extract_objects.py` by file path with importlib and call its `parse_standard_xml`; import `audit_install` from tools/audit_db.py for the version string and core refpage roots; use `ObjectDatabase` from `src.maxpat.db_lookup` for every resolution question (it applies aliases and overrides).

Refpage roots walked: the four core dirs (max-ref, msp-ref, jit-ref, m4l-ref) plus, for every bundled package under `C74/packages` except Gen and RNBO, refpage files sitting directly in its `docs` directory and any under `docs/refpages`. Gen and RNBO use prefix-keyed refpages with their own parsers and are covered by audit_db.py, which reports none missing.

Define mappings: parse every `*objectmappings*.txt` under `C74/init` and `C74/packages/*/init` for lines of the form `max define ALIAS TARGET ARGS;` and keep alias, target, args and the owning package (or core).

Index classification for each refpage file, recorded with its filename stem, name attribute, source root and owning package: (a) alias document — the stem is a define alias and the name attribute differs from the stem; it documents the alias and is never merged into the object the name attribute points at; (b) collision — several files share a name attribute; the authoritative one is the file whose stem equals the name, otherwise the first core-root file, and the rest are reported and ignored; (c) normal. This is S5 and the `v8` trap from observed_facts.

Report (text summary on stdout; full JSON when `--json PATH` is given), top-level key `sections` with: `install`; `new_objects` (names that do not resolve, each with kind object or doc_page, source file, owning package, refpage I/O counts, help-box evidence, and a `names` list holding only kind object); `define_missing` (define aliases that do not resolve); `deltas` (per existing object: messages and attributes the refpage has and the RAW base-file entry lacks — the thing the tool can write — with the file holding that entry, plus integer totals `pending_messages` and `pending_attributes`); `collisions`; `alias_docs`; `shadowed_by_override` (objects whose `overrides.json` entry carries its own messages or attributes list, with the refpage names that list lacks — report-only, never applied, and not counted in the pending totals).

Apply modes: `--apply new`, `--apply define`, `--apply deltas` (repeatable). `--names` is an explicit allow-list and is mandatory for new and define — the tool never lands an object nobody named. Implement and test new and deltas in this task; define is Task 2.

Entry builder for a new refpage-backed object — start from the `parse_standard_xml` result, then apply these curation steps (each exists because the extractor cannot do it; cite the letter in a code comment):
- C1: set `rnbo_compatible` false.
- C2: blank any digest, description, or inlet / outlet / argument digest that still holds an unfilled Cycling '74 template token (TEXT_HERE, INLET_TYPE, OUTLET_TYPE, undefined, Dummy) to an empty string, and list the scrubbed fields in the report. Never write prose of your own into the DB.
- C3: inlet typing — an explicit refpage type is kept; an inlet whose refpage type was a template token is signal only when the methodlist contains a signal method, otherwise control. This deliberately overrides the extractor's blanket tilde inference (the `jit.web~` inlet takes messages, not audio).
- C4: outlet typing from the help-patch box when one exists (search the bundle help file named after the object, then the help file named after a define target). Help numinlets / numoutlets must equal the refpage counts; when the refpage declares no inlets and no outlets at all, take the counts from the help box and note the source in the report; when both declare counts and they disagree, abort that object and report it. Map help outlettype values: signal becomes type signal with signal true; jit_matrix becomes type matrix; every other value, including the empty string and jit_gl_texture, becomes type control — keep the raw help value in that outlet's digest when the refpage supplied no digest.
- C5: `min_version` is the installed major.minor as a float.
- C6: package objects get domain Packages and a `package` field equal to the DB package directory name. Before writing, assert the new entry's key set equals the key set of an existing entry in the destination file; abort on mismatch.
- C7: every inlet carries `hot` (inlet 0 true; others false, except signal inlets of msp-module objects, matching `infer_hot_cold`).

Writer: one named function is the only place the tool opens a file for writing. It accepts only core domain files `max`, `msp`, `jitter`, `mc`, `m4l` `objects.json`, `packages/NAME/objects.json`, and `package_info.json` under the DB root; anything else — `overrides.json` above all — raises. Per file it detects the existing style (indent 2; ensure_ascii on or off; trailing newline or not) by reproducing the original bytes from the parsed data and refuses to write when no combination reproduces them. It keeps keys sorted, writes through a temp file plus os.replace, and runs an additive self-check first: every pre-existing key keeps an identical value except that `messages` may only grow with the old list as a prefix and `attributes` may only gain keys.

Deltas target the one file holding the entry that `lookup` resolves to: the package file when the resolved entry has a `package` field, otherwise the core domain file matching the resolved entry's `domain` (Max, MSP, Jitter, MC, M4L). 221 names also exist in the `gen` and / or `rnbo` files (`abs`, `accum`, ...); those duplicates are never written.

I/O regression guard: `--snapshot-io PATH` writes, for every name in the DB, the inlets and outlets that `lookup` returns; `--compare-io PATH` exits non-zero when any name present in the snapshot now has different inlets or outlets (names absent from the snapshot are ignored).

Exit code 0 for any completed run including dry-run and unavailable bundle; non-zero for a write-guard refusal, an additive-check violation, or an unreproducible file style.

Step 2 — write tests/test_sync_max_bundle.py per the behavior block. Confirm at least the collision test and the additive test fail when the corresponding guard is disabled, then restore the guard.

Step 3 — the one real path. Run `--snapshot-io S/io-before.json` first. Run the dry-run with `--json S/sync-before.json` and confirm it lists `dspstress~`, `jit.web`, `jit.web~` as new objects, the three abl objects, `jit.path.ui` and `jit.message` as new objects, and `jit.gl.web`, `jit.gl.web~`, `jit.unpack.geomat`, `jit.gl.tex2mat` among the entries under define_missing (older unresolved aliases such as `jit.gl.textureinfo` will be listed there too — report only, per S10); record the delta totals. Then apply new with names `dspstress~`, `jit.web`, `jit.web~` only. Inspect the three written entries with a short Python probe (not the Read tool) and confirm `git diff --numstat` on the two domain files shows insertions only.

Step 4 — `.claude/scripts/validate_db.py`: in `check_min_version_range` accept any version from 4 up to but excluding 10, and update its docstring and pass message to match. Run the script before and after and confirm no check that passed before now fails.

Do not touch `overrides.json`, any package file, CLAUDE.md, or anything under `patches/` in this task. Commit with explicit paths only (the five files above); scope `quick-261001-hwb`. Never `git add .` / `-A`, never `git stash`; `patches/.active-project.json` and `.planning/tci-phase2/` belong to other work and stay unstaged.
  </action>
  <verify>
    <automated>python3 -m pytest -q -p no:cacheprovider tests/test_sync_max_bundle.py</automated>
    <automated>python3 -W ignore -c "
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.patcher import Patcher
db = ObjectDatabase()
exp = {'dspstress~': (1, 0), 'jit.web': (1, 2), 'jit.web~': (1, 4)}
for n, e in exp.items():
    o = db.lookup(n)
    assert o is not None, n
    assert (len(o['inlets']), len(o['outlets'])) == e, (n, len(o['inlets']), len(o['outlets']))
    assert o['min_version'] == 9.2, (n, o['min_version'])
    Patcher().add_box(n)
assert db.get_outlet_types('jit.web~') == ['signal', 'signal', '', ''], db.get_outlet_types('jit.web~')
assert db.lookup('jit.web~')['inlets'][0]['signal'] is False
assert db.lookup('dspstress~')['inlets'][0]['signal'] is True
print('TRACER-E2E-OK')"</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 tools/audit_db.py --json "$S/audit-t1.json" && python3 -c "import json; s=json.load(open('$S/audit-t1.json'))['sections']['missing_from_db']; assert s['count']==7, s; assert not {'dspstress~','jit.web','jit.web~'} & set(s['names']), s['names']; print('AUDIT-OK')"</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 tools/sync_max_bundle.py --compare-io "$S/io-before.json" && python3 tools/sync_max_bundle.py --max-app /nonexistent/Max.app && echo IO-UNCHANGED</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 -m pytest -q -p no:cacheprovider -rf 2>&1 | grep '^FAILED' | sort | diff "$S/baseline-failed.txt" - && echo SUITE-UNCHANGED</automated>
  </verify>
  <done>One command reports the full bundle-vs-DB difference on this machine; the three core-refpage objects resolve with bundle-verified I/O and build through Patcher.add_box; tools/audit_db.py's missing count drops from 10 to 7; no pre-existing object's I/O changed; overrides.json is untouched; the failing set equals the baseline. Committed.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Remaining nine objects, the additive message / attribute delta, and 9.2 version tagging</name>
  <files>tools/sync_max_bundle.py, tests/test_sync_max_bundle.py, .claude/max-objects/jitter/objects.json, .claude/max-objects/max/objects.json, .claude/max-objects/msp/objects.json, .claude/max-objects/mc/objects.json, .claude/max-objects/m4l/objects.json, .claude/max-objects/packages/ableton-dsp/objects.json, .claude/max-objects/packages/Jitter Tools/objects.json, .claude/max-objects/packages/jit.mo/objects.json, .claude/max-objects/package_info.json, .claude/max-objects/overrides.json, .claude/scripts/validate_db.py, tests/test_version_tags.py, tests/test_package_schema.py</files>
  <read_first>
    - tests/test_version_tags.py lines 36-46 and tests/test_package_schema.py lines 147-155 (the two pins this task updates)
    - .claude/scripts/validate_db.py lines 342-358 (`check_max9_objects`)
    - .claude/scripts/merge_sources.py lines 90-125 (`apply_version_tags` — why a "9.2" exact rule wins over the "9" prefix rule)
  </read_first>
  <behavior>
    Added to tests/test_sync_max_bundle.py:
    - Apply-define builds an entry from an objectmappings line plus a help-patch box: I/O counts and outlet types from the box, descriptive fields from a refpage whose filename stem equals the alias when one exists (whatever its name attribute says), else messages and attributes inherited from the define target's DB entry.
    - Apply-define aborts for an alias when the help boxes found disagree on inlet or outlet count, and when no mapping line exists for the name.
    - Apply-new into a package file sets the `package` field and updates that package's `object_count` in package_info.json.
    - The refpage of a define alias never changes the entry named by its name attribute.
  </behavior>
  <action>
Step 1 — implement `--apply define` in the tool. For each named alias: require its `max define` line (error when absent); find newobj boxes whose first text token is the alias in the bundle help file named after the alias, then in the help file named after the define target (core `C74/help` and `C74/packages/*/help`); require every found instance to agree on numinlets and numoutlets (error when none found or when they disagree) and build inlets / outlets with the C4 mapping and C7 hot flags from Task 1. Descriptive fields: when a refpage whose filename stem equals the alias exists, take digest, description, arguments, messages, attributes, seealso and tags from it regardless of its name attribute, after C2 scrubbing — except that when that refpage's message list is identical to the core entry its name attribute points at (a cloned template), store empty messages and attributes instead and report it. With no such refpage, inherit messages and attributes from the define target's resolved DB entry and set the digest to the target's digest followed by the define line in parentheses. Destination per S4: the package file of the package that owns the mapping line, or the core domain file that holds the define target. `maxclass` is newobj; `min_version` per C5; key set per C6.

Step 2 — extend apply-new for package destinations: map the bundle package directory to the DB package directory of the same name (it must already exist with an objects.json; otherwise report and refuse), add the `package` field, and after any package write set that package's `object_count` in package_info.json to the file's new length through the same style-preserving writer. Add the behavior-block tests.

Step 3 — land the remaining nine objects, named explicitly:
- apply new, names `abl.device.reverb2~`, `abl.device.stereocompressor~`, `abl.dsp.djfilter~`, `jit.path.ui`, `jit.message`;
- apply define, names `jit.gl.web`, `jit.gl.web~`, `jit.unpack.geomat`, `jit.gl.tex2mat`.
Expected I/O is the table in observed_facts. If the tool aborts on any of the nine (count disagreement, missing mapping line, disagreeing help boxes), do not hand-write that entry: stop, and report the evidence — Rule #1 applies to the DB itself.

Step 4 — apply the additive delta: run the dry-run, compare its totals with the planner's observation (23 objects / 57 messages, 28 objects / 110 attributes, 44 distinct objects; `expr`, `funnel`, `waveform~` under shadowed_by_override); a difference beyond a handful of items means the classification differs from the planner's — find out why before applying. Then `--apply deltas` with no name restriction. Re-run the dry-run: `pending_messages` and `pending_attributes` must both be 0; carry the shadowed_by_override list into the SUMMARY as a follow-up for expert review of those overrides. Confirm with `git status --porcelain .claude/max-objects` that only allow-listed files changed; the set of domain files actually touched is whatever the dry-run named — stage exactly those.

Step 5 — version tagging. In `overrides.json`, add a `"9.2"` key as the FIRST key of `version_map` with an `exact` list of the 12 new object names (sorted) and no prefixes. Do it with a short Python snippet run from the scratch directory, not the Read / Edit tools (the file is 360 KB): load the raw text, confirm that dumping the parsed data with indent 2, ensure_ascii on and no trailing newline reproduces the bytes exactly (abort if not), insert the key, dump in the same style, and assert that `objects`, `variable_io_rules`, `_uncovered_empty_io` and `_comment` are equal before and after. `git diff --numstat` on the file must show insertions only.

Step 6 — update the three guards so 9.2 is a legal Max 9 version: `tests/test_version_tags.py::test_abl_objects_are_max9` accepts any version from 9 up to but excluding 10 (docstring updated; the `array.` and `string.` tests stay as they are); `check_max9_objects` in `.claude/scripts/validate_db.py` accepts the same range for its three prefixes; `tests/test_package_schema.py` expects 80 ableton-dsp objects. If another count pin fails, update it only when it is a pure count; any other new failure means an entry is wrong — fix the entry.

Per S1 and S2: no removal, no I/O change on any pre-existing object, and nothing written to `overrides.json` beyond the version_map key. Commit with explicit paths only; scope `quick-261001-hwb`.
  </action>
  <verify>
    <automated>python3 -m pytest -q -p no:cacheprovider tests/test_sync_max_bundle.py tests/test_version_tags.py tests/test_package_schema.py tests/test_object_schema.py tests/test_inlet_types.py tests/test_db_lookup.py</automated>
    <automated>python3 -W ignore -c "
from src.maxpat.db_lookup import ObjectDatabase
from src.maxpat.patcher import Patcher
db = ObjectDatabase()
exp = {'abl.device.reverb2~': (4, 2), 'abl.device.stereocompressor~': (6, 3), 'abl.dsp.djfilter~': (4, 1), 'jit.message': (1, 2), 'jit.path.ui': (1, 4), 'jit.gl.web': (1, 2), 'jit.gl.web~': (1, 4), 'jit.unpack.geomat': (1, 5), 'jit.gl.tex2mat': (1, 1)}
for n, e in exp.items():
    o = db.lookup(n)
    assert o is not None, n
    assert (len(o['inlets']), len(o['outlets'])) == e, (n, len(o['inlets']), len(o['outlets']))
    assert o['min_version'] == 9.2, (n, o['min_version'])
    Patcher().add_box(n)
assert db.get_outlet_types('jit.gl.web~') == ['signal', 'signal', '', '']
assert db.lookup('v8')['domain'] == 'Max' and db.lookup('v8').get('package') is None
assert len(db.get_package_objects('ableton-dsp')) == 80
b = db.lookup('buffer~')
assert {'trim', 'trim_samples', 'replacechannel', 'replacechannel_samples'}.issubset(b['messages']) and 'url' in b['attributes']
u = db.lookup('udpsend')
assert {'port', 'host', 'active'}.issubset(u['attributes']) and {'port', 'host'}.issubset(u['messages'])
assert {'minany', 'maxany'}.issubset(db.lookup('coll')['messages'])
assert {'getstate', 'setstate'}.issubset(db.lookup('pattrstorage')['messages'])
assert 'start' in db.lookup('sfrecord~')['messages']
for n, e in {'buffer~': (1, 2), 'stepfun~': (2, 2), 'mc.record~': (3, 1), 'coll': (2, 4), 'sfrecord~': (2, 1), 'udpsend': (1, 0)}.items():
    assert db.compute_io_counts(n) == e, (n, db.compute_io_counts(n))
print('EXPANSION-E2E-OK')"</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 tools/sync_max_bundle.py --compare-io "$S/io-before.json" && python3 tools/sync_max_bundle.py --json "$S/sync-after.json" && python3 -c "import json; s=json.load(open('$S/sync-after.json'))['sections']; d=s['deltas']; assert d['pending_messages']==0 and d['pending_attributes']==0, (d['pending_messages'], d['pending_attributes']); new=set(s['new_objects']['names']); assert not new & {'abl.device.reverb2~','abl.device.stereocompressor~','abl.dsp.djfilter~','jit.path.ui','jit.message','dspstress~','jit.web','jit.web~'}, new; print('SYNC-CLEAN')"</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 -c "
import json, subprocess
base = open('$S/base-sha.txt').read().strip()
old = json.loads(subprocess.run(['git', 'show', base + ':.claude/max-objects/overrides.json'], capture_output=True, text=True, check=True).stdout)
new = json.load(open('.claude/max-objects/overrides.json'))
for k in ('objects', 'variable_io_rules', '_uncovered_empty_io', '_comment'):
    assert old.get(k) == new.get(k), k
vm = new['version_map']
assert list(vm)[0] == '9.2' and len(vm['9.2']['exact']) == 12, vm.get('9.2')
assert {k: v for k, v in vm.items() if k != '9.2'} == old['version_map']
print('OVERRIDES-INTACT')"</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 -m pytest -q -p no:cacheprovider -rf 2>&1 | grep '^FAILED' | sort | diff "$S/baseline-failed.txt" - && echo SUITE-UNCHANGED</automated>
  </verify>
  <done>All 12 new objects resolve and build; the dry-run shows nothing pending; buffer~, udpsend, coll, pattrstorage and sfrecord~ expose their 9.2 messages / attributes; no pre-existing object's I/O changed; overrides.json differs only by the version_map key; guards accept 9.2; the failing set equals the baseline. Committed.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 3: 9.2 guidance — reference doc, CLAUDE.md, js skill, counts, and format-tolerance test</name>
  <files>.claude/skills/references/max-9.2-changes.md, CLAUDE.md, .claude/skills/references/shared-capabilities.md, .claude/skills/max-js-agent/SKILL.md, README.md, TECHNICAL.md, tests/test_round_trip.py</files>
  <read_first>
    - .planning/quick/261001-hwb-max-has-updated-to-version-9-2-thoroughl/261001-hwb-RELEASE-NOTES.md (whole file — the list of what to account for)
    - CLAUDE.md by range only: lines 5-20 (count table), 51-57 (refpage naming / type rules), 191-197 (buffer~ bullet), the last six lines of the Gen~ section (find the "Codebox safe-construct rules" bullet with grep), 264-272 (js section), 300-306 (Version Compatibility)
    - .claude/skills/max-js-agent/SKILL.md lines 37-62
    - tests/test_round_trip.py lines 235-306 (`TestPatchlineAttrs`, the conventions for the new test)
    - `S/sync-before.json` — the delta list from Task 1, read through a Python probe that prints object names with their new messages / attributes
  </read_first>
  <behavior>
    One new test in tests/test_round_trip.py: a patch dict carrying an obviously synthetic unknown key on a patchline, on a box and at patcher level survives `Patcher.from_dict` then `to_dict` unchanged, and `validate_patch` run on a deep copy neither removes the line nor reports an error that names the unknown key. The key name is synthetic on purpose — the real 9.2 key for background-layer patch cords is not observable yet and must not be guessed.
  </behavior>
  <action>
Evidence rule for everything written in this task: every factual claim about Max carries one of three tiers — [bundle] (read from a file under /Applications/Max.app: refpage, help patch, objectmappings, example), [db] (follows from the synced DB), or [notes] (stated only by the release notes; unverified until tested in MAX). Never state an API name, argument form or enum value from memory.

Part A — create `.claude/skills/references/max-9.2-changes.md`, a compact on-demand reference (target under 200 lines) with these sections:
1. "Evidence tiers" — the three tiers above and the rule that [notes] items are not to be relied on without a MAX test.
2. "New objects" — the 12, each with home (core domain or package), I/O, outlet types, define mapping where applicable, and min_version 9.2.
3. "Existing objects: 9.2-only messages and attributes" — the intersection of the Task 1 delta with the release notes' New Features list, per object. List the rest of the delta separately as DB gaps closed that are not necessarily new in 9.2.
4. "buffer~" — for `replacechannel`, `replacechannel_samples`, `trim`, `trim_samples`, `crop_samples`, the retain argument of `setsize` / `sizeinsamps`, and the `url` attribute: the argument forms exactly as the method and attribute elements of `C74/docs/refpages/msp-ref/buffer~.maxref.xml` describe them (grep the specific elements; do not read the whole refpage).
5. "udpsend / udpreceive" — port and host are attributes in 9.2, plus `active`, `usestring` and the `string` message, from the two refpages including their objarglist.
6. "v8" — engine version, native timers, networking, Console, MaxFFT / MaxFFT2D, toJSON for Dict / MaxArray / MaxString. Ground the identifiers in the bundled examples under `/Applications/Max.app/Contents/Resources/Examples/javascript/v8-network` (seven patches: fetch, http client, http server, tcp, udp, websocket, xhr) and `v8-fft` (four .js files), by grepping them; anything named only by the release notes is [notes]. State which objects the additions belong to exactly as the digest and description of `C74/docs/refpages/max-ref/v8.maxref.xml` and `js.maxref.xml` put it.
7. "Gen" — the improved `require` system and the compiler-correctness fixes as [notes], followed by the explicit statement that none of CLAUDE.md's gen~ rules is retired (S9).
8. "Patcher format" — patch cords can sit in the background layer [notes]; unknown keys already round-trip and now have a validation-tolerance test (name it); the actual JSON key is unknown until a patch saved by 9.2 with a background cord is committed.
9. "Fixed bugs that touch this repo's guidance" — for each Fixed Bugs line whose object name appears in CLAUDE.md or in a skill file (find them by grepping the object names), one line: the fix, and whether our guidance changes (expected answer for most: no). `Param Connect` short-name fix, `jweb` single-argument outlet output, `counter`, `sfrecord~` sample rate, `preset` MC attributes and `mc.mixdown~` pans are the likely hits.
10. "No repo impact" — one line each for the editor / installer / Windows-only items (Monaco, Parameter Window, Themes, WMF engine, installer), so the review is visibly complete.
11. "Check in MAX before relying on it" — a short checklist for the user: instantiate each of the 12 objects; `jit.web~` outlet order; a gen~ codebox that today needs the de-hoist workaround; `buffer~ trim`; a background-layer patch cord saved and committed so the key can be read.

Part B — CLAUDE.md, targeted additive edits only (keep them terse; this file loads every session):
- Count table: re-sync every domain line and the packages line from disk.
- Refpage naming rule: re-sync the two statistics in that paragraph from a fresh `python3 tools/audit_db.py` run, and append the exception from S5 — define-mapped objects (the `max define` lines in the bundle's objectmappings files) can ship a refpage whose name attribute is the implementing class or a typo, citing the two 9.2 cases from observed_facts; for those the alias is the name and the refpage must never be merged into the object its name attribute points at.
- Refpage types rule: add the `jit.web~` case from S6 as one clause.
- Object Database section: one sentence on the post-update workflow — `tools/audit_db.py`, then `tools/sync_max_bundle.py` dry-run, then `--apply` with explicit names.
- MSP section: one new bullet after the existing `buffer~` bullet (which stays verbatim) naming the 9.2 additions and pointing to the reference.
- Gen~ section: one new final bullet — Max 9.2's gen compiler fixes do not retire the rules above; none has been re-tested on 9.2 and patches must still compile on collaborators' older 9.x builds, so every workaround stays until individually re-verified in MAX and recorded here. Do not alter or delete any existing Gen~ bullet.
- js section: one or two bullets on the 9.2 v8 additions with their object scope as established in Part A item 6, pointing to the reference; existing bullets stay.
- Version Compatibility: keep "All patches target MAX 9"; add that the 12 named objects are `min_version: 9.2`, that 9.2-only messages / attributes are not version-tagged in the DB and are listed in the reference, and that a patch meant to open on an older 9.x build must avoid both.

Part C — skills:
- `.claude/skills/max-js-agent/SKILL.md`: correct the three rows of the "Key Differences" table that say async is limited and file I/O and network are unavailable so they reflect Part A item 6 with the 9.2 requirement stated; add a short "Max 9.2 additions" subsection pointing to the reference, saying node.script remains the choice when a patch must run on an older build, and that network clients and servers are generated only when the task explicitly asks for them. Leave every function-signature line untouched (tests/test_agent_skills.py pins them).
- `.claude/skills/references/shared-capabilities.md`: a short "Max 9.2" section pointing every specialist to the reference and to the two tools.

Part D — README.md and TECHNICAL.md: re-sync every object-count figure (total, core, package, per-domain rows) from disk; change nothing else.

Part E — add the behavior-block test to tests/test_round_trip.py beside `TestPatchlineAttrs`.

Do not edit any `.maxpat`, `src/maxpat/defaults.py`, `codegen.py` or `code_validation.py` (S8). Commit with explicit paths only; scope `quick-261001-hwb`. In the SUMMARY, list the S10 follow-ups, the reference's "Check in MAX" list, and every place a live value differed from observed_facts.
  </action>
  <verify>
    <automated>python3 -c "
import json,re,pathlib
t=pathlib.Path('CLAUDE.md').read_text()
r=pathlib.Path('.claude/max-objects')
for d in ['max','msp','jitter','mc','gen','m4l','rnbo']:
    n=len(json.loads((r/d/'objects.json').read_text()))
    m=re.search(rf'{d}/objects\.json\s+#.*\((\d+) objects\)',t)
    assert m and int(m.group(1))==n,(d,n,m and m.group(1))
pk=[p for p in (r/'packages').iterdir() if (p/'objects.json').exists()]
tot=sum(len(json.loads((p/'objects.json').read_text())) for p in pk)
m=re.search(r'\((\d+) packages, (\d+) objects\)',t)
assert m and int(m.group(1))==len(pk) and int(m.group(2))==tot,(len(pk),tot,m and m.groups())
print('COUNTS-OK')"</automated>
    <automated>python3 -c "
import pathlib
c = pathlib.Path('CLAUDE.md').read_text()
for kept in ['History one(1)', 'No local aliases in Param-only expressions', 'Spaces only, NEVER tab characters', 'normalize by the drive gain', 'has no \`info\` query', 'Never use GenExpr built-in constant names']:
    assert kept in c, 'lost: ' + kept
for added in ['sync_max_bundle.py', 'max-9.2-changes.md', 'min_version: 9.2', 'jit.gl.tex2mat', 'jit.web~']:
    assert added in c, 'missing: ' + added
ref = pathlib.Path('.claude/skills/references/max-9.2-changes.md').read_text()
for s in ['Evidence tiers', '[bundle]', '[notes]', 'abl.device.reverb2~', 'replacechannel', 'MaxFFT', 'Check in MAX']:
    assert s in ref, 'reference missing: ' + s
assert 'max-9.2-changes.md' in pathlib.Path('.claude/skills/max-js-agent/SKILL.md').read_text()
assert 'max-9.2-changes.md' in pathlib.Path('.claude/skills/references/shared-capabilities.md').read_text()
assert '3,430' not in pathlib.Path('README.md').read_text()
print('DOCS-OK')"</automated>
    <automated>python3 -m pytest -q -p no:cacheprovider tests/test_claude_md.py tests/test_agent_skills.py tests/test_round_trip.py</automated>
    <automated>S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; python3 -m pytest -q -p no:cacheprovider -rf 2>&1 | grep '^FAILED' | sort | diff "$S/baseline-failed.txt" - && echo SUITE-UNCHANGED</automated>
  </verify>
  <done>The 9.2 reference exists with an evidence tier on every claim; CLAUDE.md's counts equal disk, its 9.2 bullets are present and every pre-existing gen~ / buffer~ rule is still there; the js skill no longer says the V8 object lacks networking and timers; README / TECHNICAL counts match disk; the format-tolerance test passes; the failing set equals the baseline. Committed.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| Max app bundle → sync tool | Refpage XML, help-patch JSON and objectmappings text are read from `/Applications/Max.app`: locally installed and trusted, but unvalidated and known to contain wrong names (`v8`, `jit.unpackl.gl`) and wrong types. |
| Sync tool → object database | The tool writes JSON that every later patch generation trusts under Rule #1. A bad write silently corrupts connection validation for all projects. |
| Object database ↔ `overrides.json` | Expert corrections must never be overwritten by extracted data. |
| Executor → git index | Unrelated uncommitted work sits in the tree (`patches/.active-project.json`, `.planning/tci-phase2/`). |
| Generated v8 scripts → network | 9.2's v8 can open network clients and servers from inside a patch. |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-hwb-01 | Tampering | `tools/sync_max_bundle.py` write path | high | mitigate | A single named writer function with a path allow-list (core domain files, per-package object files, package_info.json); `overrides.json` and everything else raises. Task 1 tests assert the overrides sha256 is unchanged after every apply mode and that an off-list path is refused. |
| T-hwb-02 | Tampering | Bundle data overwriting curated entries | high | mitigate | Additive self-check before every write (existing values identical; messages may only extend, attributes may only gain keys); collision and alias-document classification keeps mis-named refpages out of core entries; `--compare-io` snapshot proves no pre-existing object's inlets or outlets moved (Tasks 1 and 2 verify). |
| T-hwb-03 | Tampering | `overrides.json` version_map edit | high | mitigate | Byte-preserving insertion that aborts unless the original bytes reproduce; Task 2 verify asserts `objects`, `variable_io_rules`, `_uncovered_empty_io` and `_comment` equal the committed version and that only the "9.2" key was added. |
| T-hwb-04 | Tampering | Unsupported names entering the DB | high | mitigate | Apply modes for new and define-mapped objects require an explicit `--names` allow-list; on any evidence disagreement the tool aborts that object and the plan forbids hand-writing the entry. |
| T-hwb-05 | Repudiation | Git staging of unrelated work | medium | mitigate | Explicit-path staging per task; `git add .` / `-A` and `git stash` prohibited (project Rule #7); plan-level verification inspects the file list of this task's commits. |
| T-hwb-06 | Denial of Service | XML / help-JSON parsing | medium | mitigate | Per-file parse errors are tallied, never fatal; the help-patch box walk carries a depth cap; an unavailable bundle exits 0 with the fact reported (tested). |
| T-hwb-07 | Elevation of Privilege | Process execution | medium | mitigate | The tool spawns no subprocess and never launches Max; version comes from plistlib through `audit_install`. |
| T-hwb-08 | Information Disclosure | v8 networking guidance | low | mitigate | The js skill states that network clients and servers are generated only when the task explicitly asks for them. |
| T-hwb-09 | Tampering | XML entity expansion in refpages | low | accept | `xml.etree.ElementTree` resolves no external entities; input is the developer's own installed Max bundle. ASVS L1 for a local dev tool. |
| T-hwb-SC | Tampering | npm/pip/cargo installs | high | mitigate | No package-manager install in this plan: the tool and tests use the Python standard library and in-repo imports only, so no Package Legitimacy Audit is required. |

ASVS level 1, block on high (`security_asvs_level: 1`, `security_block_on: high`). Every high-severity threat is dispositioned `mitigate` with an automated check in the task that introduces it.
</threat_model>

<planner_contributions>
- **API coverage gate:** the detector was run over this plan's text and returned `detected: false` (no signals). Per the fragment, the checkpoint is skipped and no `COVERAGE.md` is written. On the merits: the task reads local files from the installed Max bundle and edits repo data and docs; the v8 networking features are documented, not integrated.
- **Assumption-delta:** the scan returned `skipped` (`phase_unresolved` — a quick task has no ROADMAP phase). Per the fragment's skip branch no verdict is asserted and nothing is raised.
- **Schema push gate:** no ORM-shaped files in scope → skipped silently.
- **Security:** applied as written above.
</planner_contributions>

<source_audit>
Sources: the task description, the release notes file, and the orchestrator's observations. No ROADMAP phase, REQUIREMENTS.md entry, CONTEXT.md or RESEARCH.md exists for this quick task.

| Source item | Covered by | Status |
|---|---|---|
| GOAL — repo reflects Max 9.2 changes, updates and new features | Tasks 1-3 | COVERED |
| New objects (ABL ×3, jit.web family ×4, jit.message, jit.unpack.geomat, jit.gl.tex2mat, jit.path.ui, dspstress~) | Tasks 1-2 (MAX92-01) | COVERED |
| Objects new in the bundle but not named by the notes | Tool dry-run over every bundled refpage root + define mappings | COVERED — none beyond the 12 observed |
| Changed messages / attributes on existing objects (buffer~, udp, coll, dict.*, pattrstorage, sfrecord~, fft, jweb, rslider, mousefilter, seq, ABL attrs, Jitter attrs) | Task 2 delta (MAX92-02) | COVERED |
| mc.record~ inlets, stepfun~ right outlet | observed_facts: counts already equal the 9.2 refpages; asserted in Task 2 verify | COVERED — no change needed |
| Items not expressible in the DB schema (enum values, message arguments: detonate, function mousemode, nrpnin, thispatcher showparameterwindow, gen~ @file, expr / vexpr constants, maxurl) | Task 3 reference, tiered [bundle] or [notes] | COVERED |
| v8 engine, timers, networking, Console, MaxFFT, toJSON | Task 3 (reference, CLAUDE.md, js skill) | COVERED |
| Gen require + compiler fixes; keep 9.1.x workarounds | Task 3, S9 | COVERED |
| Version compatibility / `min_version` | Tasks 1-2 (MAX92-04), Task 3 CLAUDE.md | COVERED |
| Patcher format (background-layer patch cords) | Task 3 test + reference (MAX92-06) | COVERED — key name deliberately not guessed |
| Reuse the existing extractor; never overwrite overrides | Task 1 (parse_standard_xml reuse), S3, T-hwb-01..03 | COVERED |
| Stability: additive, no patch edits, suite green | S1, S2, S8; baseline diff in every task | COVERED |
| Fixed-bug list reviewed against repo guidance | Task 3 reference section 9 | COVERED |
| Windows installer, WMF engine, editor UI features | Task 3 reference section 10 (no repo impact) | COVERED |

No item is MISSING. Explicitly not done and surfaced as follow-ups rather than dropped (S10): `tools/audit_db.py` flat-`docs/` blind spot, the Jitter Tools phantom `v8` key / unresolved `jit.gl.textureinfo`, `extraction-log.json` counts, and the 3 pre-existing review-blocker failures.
</source_audit>

<verification>
- `python3 tools/sync_max_bundle.py` (dry-run) reports no pending new messages or attributes and none of the 12 objects as unresolved.
- `python3 tools/audit_db.py` reports 7 unresolved refpage names (5 documentation pages plus `kbm.data` and `scl.data`).
- The pytest failing set equals `S/baseline-failed.txt`; the pass count rose only by this plan's new tests.
- This task's commits touch no `patches/` path and nothing outside `files_modified`:
  `S=/private/tmp/claude-501/-Users-taylorbrook-Dev-MAX/38b9b581-7280-44ac-958c-68803e29e8f5/scratchpad/hwb; git log --format=%H --grep="261001-hwb" "$(cat "$S/base-sha.txt")"..HEAD | xargs -n1 git show --name-only --format= | sort -u`
- `git status --short` still shows `patches/.active-project.json` modified and `.planning/tci-phase2/` untracked — untouched, unstaged.
- `git stash list` is unchanged from before the task.
</verification>

<success_criteria>
- MAX92-01: 12 / 12 new objects resolve with bundle-verified I/O and build via `Patcher().add_box()`.
- MAX92-02: dry-run delta is empty; the additive invariant held on every write.
- MAX92-03: `tools/sync_max_bundle.py` is committed, tested hermetically, idempotent, and structurally unable to write `overrides.json`.
- MAX92-04: the 12 objects carry `min_version` 9.2; `version_map` protects it; the three guards accept it.
- MAX92-05: CLAUDE.md, the js skill, shared-capabilities and the 9.2 reference are updated; all pre-existing gen~ and buffer~ rules remain; counts in CLAUDE.md, README.md and TECHNICAL.md equal disk.
- MAX92-06: unknown patchline / box / patcher keys survive round-trip and validation, proven by test.
- Zero regressions: failing set equals baseline, no pre-existing object's I/O changed, no patch file changed.
</success_criteria>

<output>
Create `.planning/quick/261001-hwb-max-has-updated-to-version-9-2-thoroughl/261001-hwb-SUMMARY.md` when done. It must include: the before / after dry-run totals, the per-file numstat for every DB file touched, baseline vs final pytest totals, every live value that differed from observed_facts, the S10 follow-ups, and the "Check in MAX before relying on it" list for the user.
</output>
