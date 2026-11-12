# Changelog

All notable changes to the MAX/MSP Claude Code Framework. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the project uses
[Semantic Versioning](https://semver.org/). Each `## [X.Y.Z]` section is the body of
that version's GitHub release (`scripts/release_notes.sh`). Releases before 6.0.0
are summarized in the README milestone table.

## [6.2.0] - 2026-11-12

Object-DB fixes and rules from the Ambire, barnett-dbap and resonant-garden builds, a
smaller `CLAUDE.md`, and a faster validation path. No API changes.

### Added

- **`abc_3d_binaural3~` in the object DB** (`packages/abclib/objects.json`): 16 inlets,
  3 outlets, ACN channel order, N3D normalization, measured in MAX 9.2.
- **`jit.gl.multiple` variable I/O rule**: the first argument sets the number of matrix
  inlets, with 2 outlets (from shipped help boxes).
- **Jitter rule: `jit.expr` that reads a named matrix needs `@cache 0`** (`CLAUDE.md`,
  `proven-forms.md` "Jitter"). With the default `@cache 1`, sub-expressions without
  `in[N]` are computed once and stay constant.

### Changed

- **`CLAUDE.md` is shorter and no rule was dropped.** The multislider parameter-bank,
  Max for Live and bach rules moved to `shared-capabilities.md`, and the RNBO export
  rules moved to the `max-rnbo-agent` skill. `CLAUDE.md` names each rule's new home.
- **Validation and critics are faster on large patches**: `split_box_text` is memoized.

### Fixed

- **`sfplay~` outlet count** skips a leading `sflist~` name and counts the position
  outlets (`sfplay_outlets` formula): `sfplay~ sf.cues 2 0 1` has 4 outlets (L, R,
  position, done-bang). Cords from the position and bang outlets were flagged out of
  bounds before.

### Maintenance

- The test suite runs in parallel by default (`pytest-xdist`, `-n auto` in
  `pytest.ini`). `pytest.ini` is export-ignored, so release archives do not ship it.
- MAX bridge tests use virtual-time seams instead of real waits.
- Generated wavetable banks (ji-harmonizer, about 23 MB) are untracked and regenerated
  on demand.

## [6.1.0] - 2026-10-25

Object-DB additions from the face-tracker build (2026-10-23). No API changes.

### Added

- **Cycling '74 Vision 1.0.2 in the object DB** (`packages/Vision/objects.json`, 22
  `jit.vis.*` entries): 12 refpage trackers/processors plus 10 helpers (7 v8-define
  `*.parts` splitters, `jit.vis.debugdraw`, the `jit.vis.grab` bpatcher and the
  `jit.vis.tondc` abstraction). I/O is help-box verified. Every entry has `min_version`
  9.2 and `verified: false` until it is confirmed in MAX. Rule #1 and `validate_patch`
  now accept `jit.vis.*` chains.
- `db-maintenance.md` documents the user-installed package extraction path
  (`extract_objects.py --package NAME`, then help-box curation).

### Fixed

- **`dict.unpack` outlet count** is one outlet per key argument plus a rightmost
  unmatched/dumpout outlet (`variable_io_rules`, from shipped help boxes). Cords from
  its key outlets were flagged out of bounds before.

## [6.0.0] - 2026-10-23

The fix-plan Q1-Q40 round (2026-10-12 to 2026-10-22) plus its post-hoc review fixes
(quick 261022-ud6). The theme is that validation never destroys anything, the save
path never loses or restyles a user's work, and checks run in every scope of a patch.

### Breaking changes

- **`validate_patch` is non-destructive.** It never removes a cord. An invalid cord is an
  `error` whose `proposed_removal` is `(src_id, src_outlet, dst_id, dst_inlet)`. Only
  `apply_fixes(patch, results)` removes cords, and only in the scope the result's `path`
  names. It returns 4-tuples for top-level cords and 5-tuples
  `(path, src_id, src_outlet, dst_id, dst_inlet)` for nested ones.
- **Validation and critics run in every scope.** This covers `p`, embedded bpatchers,
  poly~, gen~ / mc.gen~ `data.patcher`, rnbo~ and the codeboxes of every embedded gen
  patcher. A nested finding carries `path` and a `[p name] ` prefix.
- **`ValidationResult` has a structured identity:** `rule`, `box_ids` and `port`, keyword-only.
  `CriticResult` carries the same fields.
- **The save gate refuses new problems.** `save_patch_roundtrip` and `write_gendsp` raise
  `PatchValidationError` without writing when a save introduces a validator error or a critic
  blocker, or changes the x-rank order of a subpatcher or abstraction port. Findings match the
  baseline on `rule + box_ids + port + path`, not message text. Removed cords emit
  `SaveGateWarning`. `force=True` is the only bypass. `StaleFileError` is raised when MAX
  saved the file after it was read.
- **The layout refuses MAX-saved or large patchers.** `finalize_patch(is_new=True)` raises
  `LayoutRefusedError` (a `ValueError`) on these before anything is restyled or moved. Pass
  `force_layout=True` for a large new build, and `is_new=False` (or `edit_patch`) for files
  read from disk.
- **Unknown objects block a save.** The save gate and `validate_file` pass `patch_path`, so an
  unknown name with no `NAME.maxpat` / `.js` / `.gendsp` beside the patch or in its
  `patches/<project>/` tree is an error. Without `patch_path` it is still a warning.
- **New validator errors:** `expr` / `vexpr` / `if` `clip()` (`expr_clip`); numeric bpatcher
  args stored as strings (`bpatcher_numeric_args`); a `line~` ramp followed by another comma
  segment (`line_tilde_comma`, previously a warning; a leading jump `0, 1 500` is no longer
  flagged); a GenExpr function after a statement; a tab in generated or edited codebox code.
- **`replace_box` / `replace_box_safe` keep the box id** (and its size, z-order, presentation
  rect, varname, colours and parameter blocks). An embedded patcher moves only for the same
  name or `gen~` <-> `mc.gen~`; any other replace of a box that has one raises `ValueError`.
- **`modify_box(args=)` on a UI box** other than textbutton / live.text / live.comment /
  textedit raises `ValueError`; use `extra_attrs`. `extra_attrs` keys `patching_rect`, `text`
  and `saved_object_attributes` now set the model fields. `id`, `maxclass`, `numinlets`,
  `numoutlets`, `outlettype` and `patcher` raise.
- **`write_gendsp` removes ports only when told to.** On an existing `.gendsp`,
  auto-detected counts never shrink ports. Pass `num_inputs` / `num_outputs` to remove
  `in N` / `out N` boxes.
- **`add_bpatcher` coerces numeric-string args** (`"0"` -> `0`).
- **Removed APIs:** `src/maxpat/memory.py` (the in-app memory library), `is_complex_patch`,
  `suggest_subpatchers`, `add_node_script`, `contrast_text_color`, the `bore_only` dsp_sim
  topology (`get_topology('bore_only')` raises `TopologyError`), `relayout_patch.py`,
  `validate_db.py`, `merge_sources.py`, the `MS_*` constants and `verified-objects.json`.
- **The legacy dsp_sim CLI** exits `64` on a usage error (was 2, which read as
  `mode_competition`).
- **`min_version` is a string** everywhere in the object DB (`"9.2"`, never `9.2`).
- **Releases publish to npm with trusted publishing (OIDC).** There is no `NPM_TOKEN` secret,
  and only full `vX.Y.Z` tags trigger a release.

### Added

- **`edit_patch(path)` edit sessions.** `with edit_patch(path) as p:` re-reads the file and
  routes only touched cords. It recolours only added boxes that carry an explicit textcolor,
  computes `session.diff` and saves through the gate; a no-op writes nothing. `Patcher.diff`
  gives a semantic diff, with the new `cord_attrs` kind.
- **Byte-identical no-op saves for every layout:** MAX 9.1+ inline arrays, the Max 5-9.0.x
  tab layout, CRLF and the framework's expanded layout. `maxjson` adds `dumps_legacy`,
  `dumps_expanded`, `detect_layout`, `RawSpellings` and `json_identical`.
- **Critic quick fixes** (`CriticResult.fix`) and `/max-iterate --fix`.
- **New commands:** `/max-diagnose` (read-only console-error diagnosis) and
  `/max-verify --live` (loads patches in the running MAX through the max-bridge, at
  `tools/max_bridge/max-bridge.maxpat`, which now ships in releases).
- **The GenExpr interpreter and the `python3 -m src.maxpat.dsp_sim smoke` codebox smoke test.**
  Audio vs control port kinds are inferred from the host patch graph, and `// smoke:`
  directives override them. The `gate` input spec, the `ports` JSON report, the WARN lints
  (`denormal`, `loop_bound_param`, `hoist_alias`, `implicit_channel`, `smoke_directive`) and a
  pinned verdict for every committed gen~ codebox are new.
- **Max for Live:** `Patcher.add_m4l_device(kind, params)` (instrument / audio_effect /
  midi_effect) and `m4l_device.export_amxd` (.amxd writer). EXPERIMENTAL: not yet confirmed
  in Live.
- **M4L critic rules:** `stereo_out`, `midi_passthrough`, `shortname_length`,
  `shortname_unique`, `int_param_range`, `param_range`, `bank_refs`, `device_height` and
  `duplicate_device_io`.
- **Structure critic rules:** `trigger_types`, `trigger_order`, `dollar_arity`,
  `uninitialized_state` (a blocker on new files), `unmatched_names`, `int_truncation` and
  `mc_bare_list`.
- **Validator Layer 4c vocabulary checks.** Besides the new errors listed above, they warn on a
  message selector the destination does not list and on a patcher with
  `editing_bgcolor` / `locked_bgcolor` but no `bgcolor`.
- **Object DB:**
  - shipped-idiom allowlist `idioms.json`, mined from bundle help cords;
  - per-version I/O `version_io.json`, with `validate_patch(target_version="9.0")`;
  - 232 objectfile aliases;
  - `groups.json` inherited names;
  - `db.messages` / `db.attributes` / `db.selectors`;
  - `variable_io_rules.trailing_inlets` and `ObjectDatabase.resolve_inlet`;
  - `is_shipped_signal_inlet`;
  - the MC `multichannelsignal` outlet flavour.
- **`audit_db.py --help-io`**, which checks the DB against MAX-saved help boxes, and the
  `sync_max_bundle.py --apply` steps.
- **The installers check dependencies.** `install.sh` and `npx create-max-framework` check
  numpy / scipy / pytest and git besides Python 3.10+, and both accept `--check-deps`.
- **CI:** the test workflow runs on Python 3.10 and 3.12, and a `vermin` step enforces the
  Python 3.10 floor.
- **References:** `severity-contract.md`, `troubleshooting.md`, `proven-forms.md`,
  `genexpr-rules.md`, `db-maintenance.md`, `max-9.2-changes.md` and this changelog.

### Fixed

- **Validation:**
  - signal-accepting inlets (`mc.sum~`, `phasor~` 1, `sig~`, `mc.tapout~` ...) are no longer
    flagged;
  - malformed port indices are reported as malformed cords instead of crashing;
  - a `*~ 0` with an unfed gain inlet counts as a mute terminator;
  - comment `#N` prose is skipped;
  - `record~ buf N`, `sfrecord~ N` and `jit.catch~ N` have the right I/O;
  - `inlet` / `outlet` have real 0/1 and 1/0 I/O;
  - `bach.slice`, `zplane~` and `mc.range~` port data is corrected.
- **Critics:**
  - `*~` is a gain stage only with an audio operand and no oscillator or filter-parameter
    target, so FM depth and LFO-to-cutoff pass;
  - fan-out reconvergence needs a hot and a cold hit and stops at cold entries;
  - gen~ I/O is read from `in N` / `out N` operators;
  - `live.thisdevice`-only helper abstractions are not judged as devices;
  - event-only RNBO patches get a note;
  - bach `@out` is mapped per llll outlet.
- **Contrast** (locked decision B11): edits never recolour default-text comments. Self-painted
  boxes (bach.roll, jit.cellblock, textedit) are skipped. Gradient panels are scored on both
  stops. Untinted number / flonum / textbutton boxes read against their theme fills.
- **GenExpr:** functions-first ordering (the C74 form is no longer an error); `phi` and the
  upper-case constant aliases; parser-driven semicolon and Param-range checks; tabs already in
  a loaded codebox are one warning.
- **dsp_sim:** the pitch detector no longer reads bright waveforms an octave low; `exp2` runs
  on Python 3.10; mc.gen~ `data.patcher` codeboxes are discovered.
- **The RNBO builder** writes MAX's `rnbo~` box shape and the positional `param` form.
  EXPERIMENTAL.
- **Tools:**
  - `audit_db.py` never writes into `--db-root` or its own DB / patches trees;
  - `max_bridge check` exits 2 cleanly on a malformed patch;
  - `extract_pkg_io` writes atomically in the file's JSON style;
  - the overrides merger never writes a file the loader rejects (`OverridesLoadError`).
- **Auto-commit is path-scoped:** `git commit -- <paths>` from the repo root, with checked
  return codes.

### Migration notes

- **Proposed removals.** Code that relied on `validate_patch` dropping cords must call
  `apply_fixes(patch, results)` explicitly, and only for a confirmed defect. Read
  `result.proposed_removal` and `result.path`.
- **Unpacking `apply_fixes`.** Callers that unpack its return value must handle nested
  5-tuples.
- **Gate refusals.** Catch `PatchValidationError` around saves (`.findings`,
  `.port_changes`, `.path`) and fix the findings. Use `force=True` only with the user's
  confirmation.
- **New builds.** Wrap `finalize_patch(is_new=True)` for large new builds with
  `force_layout=True`, and use `is_new=False` or `edit_patch` for anything loaded from disk.
- **Abstractions.** Save each abstraction (`NAME.maxpat`) before the patch that uses it, so the
  gate resolves it.
- **Edits.** Replace hand-rolled read -> edit -> finalize -> save loops with
  `with edit_patch(path) as p:`. Call `repair_text_contrast` only when a whole-patch repair is
  wanted; it is never run on edits.
- **Box ids.** Code that expected `replace_box` to mint a new box id must use the returned
  box, whose id is the old one.
- **UI attributes.** Change UI attributes (dial ranges, toggle colours, ...) through
  `modify_box(box, extra_attrs={...})`, not `args`.
- **`.gendsp` ports.** To drop ports from an existing `.gendsp`, pass explicit
  `num_inputs` / `num_outputs` to `write_gendsp`.
- **Removed APIs.** Replace `contrast_text_color` with `aesthetics.choose_text_color` /
  `ensure_text_contrast`, and `add_node_script` with `add_box("node.script", ...)`.
  `is_complex_patch`, `suggest_subpatchers` and `memory.py` have no replacement. Use the
  `reed_bore` topology instead of `bore_only`.
- **The legacy dsp_sim CLI.** Scripts that read its exit code must treat `64` as a usage
  error.
- **Publishing.** Link the trusted publisher on npmjs.com (`create-max-framework` -> Settings
  -> Trusted Publisher -> GitHub Actions, workflow `release.yml`) before the first 6.0.0 tag
  run. The `NPM_TOKEN` secret can then be deleted.
- **Pending confirmation.** Several items are still unconfirmed in MAX or Live: the M4L
  builders and RNBO shapes, the theme-fill values, and the legacy-layout writer on a Max 8
  file opened in MAX. They are tracked in the 261022-ud6 SUMMARY files and the project
  STATE.
