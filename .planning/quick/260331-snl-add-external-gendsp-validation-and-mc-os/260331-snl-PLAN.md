---
phase: quick-260331-snl
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - src/maxpat/validation.py
  - src/maxpat/critics/dsp_critic.py
  - src/maxpat/hooks.py
  - tests/test_validation.py
  - tests/test_integration_patches.py
autonomous: true
requirements: [QUICK-SNL]

must_haves:
  truths:
    - "gen~ boxes with @gen filename.gendsp get I/O validated against the referenced .gendsp file"
    - "MC oscillator objects (mc.cycle~, mc.saw~, mc.rect~, mc.tri~) trigger gain staging checks"
    - "Existing tests still pass with no regressions"
  artifacts:
    - path: "src/maxpat/validation.py"
      provides: "External .gendsp I/O validation in Layer 4 + MC oscillator names"
      contains: "_check_external_gendsp_io"
    - path: "src/maxpat/critics/dsp_critic.py"
      provides: "MC oscillator names in _OSCILLATOR_NAMES"
      contains: "mc.cycle~"
    - path: "tests/test_validation.py"
      provides: "Tests for external .gendsp validation and MC oscillator gain staging"
  key_links:
    - from: "src/maxpat/validation.py"
      to: ".gendsp files on disk"
      via: "json.load of resolved path from gen~ @gen attribute"
      pattern: "@gen.*\\.gendsp"
---

<objective>
Add external .gendsp file validation and MC oscillator gain staging checks.

Purpose: gen~ boxes using `@gen filename.gendsp` currently bypass I/O validation because the validator only checks embedded codebox objects. MC oscillator variants (mc.cycle~, mc.saw~, mc.rect~, mc.tri~) are missing from gain staging checks.

Output: Updated validation.py, dsp_critic.py, hooks.py, and corresponding tests.
</objective>

<execution_context>
@$HOME/.claude/get-shit-done/workflows/execute-plan.md
@$HOME/.claude/get-shit-done/templates/summary.md
</execution_context>

<context>
@src/maxpat/validation.py
@src/maxpat/critics/dsp_critic.py
@src/maxpat/hooks.py
@tests/test_validation.py
@tests/test_integration_patches.py
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Add external .gendsp I/O validation and MC oscillator names</name>
  <files>src/maxpat/validation.py, src/maxpat/critics/dsp_critic.py, src/maxpat/hooks.py, tests/test_validation.py, tests/test_integration_patches.py</files>
  <behavior>
    - Test: gen~ box with @gen pointing to .gendsp with matching I/O produces no error
    - Test: gen~ box with @gen pointing to .gendsp with mismatched I/O (more ins or outs in .gendsp than box) produces domain warning
    - Test: gen~ box with @gen pointing to non-existent .gendsp produces domain info (not error -- file may exist at runtime in MAX search path)
    - Test: gen~ box with @gen but no patch_dir passed to validate_patch skips check silently (backward compatible)
    - Test: mc.cycle~ connected directly to dac~ triggers gain staging warning
    - Test: mc.saw~, mc.rect~, mc.tri~ are in _OSCILLATOR_NAMES
  </behavior>
  <action>
**1. Add `patch_dir` parameter to `validate_patch()` in `src/maxpat/validation.py`:**

Add optional `patch_dir: str | Path | None = None` parameter after `db`. When a Patcher instance is passed, also try to get path from it if available (but Patcher doesn't store path, so this stays None unless explicitly provided). Pass `patch_dir` through to `_validate_domain_rules()`.

**2. Add `_check_external_gendsp_io()` in `src/maxpat/validation.py` Layer 4:**

New domain rule function called from `_validate_domain_rules()` (only when `patch_dir` is not None):

```python
def _check_external_gendsp_io(
    box_lookup: dict[str, dict],
    patch_dir: Path,
) -> list[ValidationResult]:
```

For each box in box_lookup:
- Check if `maxclass == "newobj"` and text matches `gen~ @gen <filename>.gendsp`
- Extract the filename from text using regex: `r'gen~\s+@gen\s+(\S+\.gendsp)'`
- Resolve the path: `patch_dir / filename`
- If file doesn't exist, emit info: "External .gendsp file '{filename}' not found at {resolved_path} -- cannot validate I/O"
- If file exists, load JSON, count `in N` and `out N` objects in the .gendsp patcher boxes (boxes where `maxclass == "newobj"` and text matches `r'^(in|out)\s+\d+$'`)
- Compare: if gendsp_inputs > box numinlets, emit warning. If gendsp_outputs > box numoutlets, emit warning
- Also check reverse: if box has more inlets/outlets than the .gendsp defines, emit warning (box won't receive data on those extra ports)

**3. Update `_validate_domain_rules()` signature** to accept `patch_dir` and call `_check_external_gendsp_io()` when `patch_dir is not None`.

**4. Add MC oscillators to `_OSCILLATOR_NAMES` in both files:**

In `src/maxpat/validation.py` line 34-36, add `"mc.cycle~", "mc.saw~", "mc.rect~", "mc.tri~"` to the frozenset.

In `src/maxpat/critics/dsp_critic.py` line 24-26, add the same four MC oscillator names.

**5. Update `validate_file()` in `src/maxpat/hooks.py`** to pass `patch_dir=path.parent` to `validate_patch()`.

**6. Update `test_integration_patches.py`** to pass `patch_dir=patch_path.parent` to `validate_patch()` so real patches with `@gen` references get validated.

**7. Add tests in `tests/test_validation.py`:**

Add a new test class `TestExternalGendspValidation` with:
- `test_gendsp_matching_io`: Create a temp .gendsp file with 1 in + 1 out, create a gen~ box with numinlets=1 numoutlets=1 text="gen~ @gen test.gendsp", call validate_patch with patch_dir=tmp_path. Assert no domain errors.
- `test_gendsp_io_mismatch`: Create .gendsp with 2 in + 3 out, gen~ box with numinlets=1 numoutlets=1. Assert domain warnings about mismatch.
- `test_gendsp_file_not_found`: gen~ box referencing nonexistent.gendsp. Assert info-level result.
- `test_gendsp_no_patch_dir`: gen~ with @gen but no patch_dir. Assert no errors (silently skipped).
- `test_mc_oscillator_gain_staging`: mc.cycle~ -> dac~ without *~ triggers gain staging warning.

Use `tmp_path` fixture for creating temporary .gendsp files. Use `src.maxpat.codegen.generate_gendsp` to create valid .gendsp dicts.
  </action>
  <verify>
    <automated>cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_validation.py tests/test_integration_patches.py tests/test_critics.py -x -q 2>&1 | tail -20</automated>
  </verify>
  <done>
    - validate_patch() accepts optional patch_dir parameter
    - gen~ @gen .gendsp references are loaded and I/O validated
    - mc.cycle~, mc.saw~, mc.rect~, mc.tri~ trigger gain staging checks
    - All existing tests pass, new tests cover the additions
    - Integration tests on real patches pass with patch_dir
  </done>
</task>

</tasks>

<verification>
```bash
cd /Users/taylorbrook/Dev/MAX && python -m pytest tests/test_validation.py tests/test_integration_patches.py tests/test_critics.py -x -q
```
</verification>

<success_criteria>
- gen~ @gen .gendsp I/O validation catches mismatches in test cases
- MC oscillator objects trigger gain staging warnings
- All existing tests pass with no regressions
- Integration tests on real patches (including gen-eq with @gen gen-eq-engine.gendsp) pass
</success_criteria>

<output>
After completion, create `.planning/quick/260331-snl-add-external-gendsp-validation-and-mc-os/260331-snl-SUMMARY.md`
</output>
