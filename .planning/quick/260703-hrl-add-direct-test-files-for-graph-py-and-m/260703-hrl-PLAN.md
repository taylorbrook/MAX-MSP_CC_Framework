---
phase: quick-260703-hrl
plan: 01
type: execute
wave: 1
depends_on: []
files_modified:
  - tests/test_graph.py
  - tests/test_maxclass_map.py
  - tests/test_defaults.py
  - tests/test_utils.py
  - tests/test_rnbo_validation.py
  - tests/test_ext_validation.py
  - tests/test_ext_templates.py
  - tests/test_m4l_constants.py
autonomous: true
requirements: [QUICK-260703-HRL]
must_haves:
  truths:
    - "graph.py traversal behaviors (upstream, downstream, signal_only, signal_path, connected_components, subpatcher crossing, ValueError on foreign box) are asserted in a dedicated tests/test_graph.py"
    - "maxclass_map.py (resolve_maxclass, is_ui_object, UI_MAXCLASSES invariants) is asserted in a dedicated tests/test_maxclass_map.py"
    - "defaults, utils, rnbo_validation, ext_validation, ext_templates, m4l_constants each have a direct test file with at least smoke-level assertions"
    - "Full suite still passes with prior counts intact (2030 passed, 4 xfailed baseline plus new tests)"
  artifacts:
    - tests/test_graph.py
    - tests/test_maxclass_map.py
    - tests/test_defaults.py
    - tests/test_utils.py
    - tests/test_rnbo_validation.py
    - tests/test_ext_validation.py
    - tests/test_ext_templates.py
    - tests/test_m4l_constants.py
  key_links:
    - "tests import from src.maxpat.* exactly as existing tests do (e.g., from src.maxpat.patcher import Patcher)"
    - "tests run under the project's existing invocation: python3 -m pytest tests/ from repo root (no pytest.ini; rootdir default)"
---

<objective>
Add direct test files for the 8 untested modules under src/maxpat/: substantive coverage for graph.py and maxclass_map.py (both load-bearing — maxclass_map.py is the authoritative UI-class source per CLAUDE.md; graph.py is currently only covered transitively via test_patcher.py ED-04 and test_analysis.py connected_components tests), plus smoke tests for defaults.py, utils.py, rnbo_validation.py, ext_validation.py, ext_templates.py, m4l_constants.py.

Purpose: These modules have zero direct test files; regressions currently surface only indirectly (or not at all for defaults/utils/ext_* modules). Direct files pin behavior and give future refactors (like the recent BuildersMixin extraction) a parity baseline.
Output: 8 new test files in tests/, full suite green, atomic commit.
</objective>

<execution_context>
@$HOME/.claude/gsd-core/workflows/execute-plan.md
@$HOME/.claude/gsd-core/templates/summary.md
</execution_context>

<context>
@.planning/STATE.md
@src/maxpat/graph.py
@src/maxpat/maxclass_map.py
@src/maxpat/utils.py
@src/maxpat/defaults.py
@src/maxpat/m4l_constants.py
@src/maxpat/ext_templates.py
@src/maxpat/ext_validation.py
@src/maxpat/rnbo_validation.py
@tests/conftest.py
@tests/test_patcher.py
</context>

<tasks>

<task type="auto" tdd="true">
  <name>Task 1: Direct tests for graph.py and maxclass_map.py</name>
  <files>tests/test_graph.py, tests/test_maxclass_map.py</files>
  <behavior>
    tests/test_graph.py (exercise GraphMixin through Patcher instances, since GraphMixin requires the host class's boxes/lines/db):
    - downstream: linear chain A->B->C returns [B, C] in order; fan-out from one source returns neighbors ordered by outlet index (left to right)
    - upstream: chain A->B->C, upstream(C) returns [B, A]; starting box excluded from results
    - signal_only=True: mixed chain (e.g., cycle~ -> *~ with a control-rate number -> *~ branch) only follows connections where BOTH endpoint names end with ~
    - downstream/upstream raise ValueError when the box belongs to a different patcher
    - signal_path: for a ~ box mid-chain, returns reversed-upstream + [box] + downstream (sources first); for a non-~ box, box itself is excluded from the returned path
    - subpatcher crossing: patch with add_subpatcher(), downstream from a box wired into the subpatcher includes the inner inlet objects (use inner.get_inlets(), never search by box.text)
    - connected_components: empty patcher returns []; two disjoint chains + one unconnected box yields 3 components sorted largest-first; unconnected box is a single-element component
    - _build_adj: forward/reverse adjacency ignore lines referencing removed/unknown box ids (construct via public API where possible)

    tests/test_maxclass_map.py:
    - resolve_maxclass returns the object's own name for known UI widgets: toggle, dial, flonum, multislider, meter~, gain~, ezdac~, live.dial, comment, message, inlet, outlet
    - resolve_maxclass returns "newobj" for non-UI objects: cycle~, pack, route, expr, gen~, click~, trigger
    - is_ui_object mirrors membership (True for toggle, False for cycle~)
    - UI_MAXCLASSES invariants: it is a frozenset; "newobj" is NOT a member; every entry is a non-empty lowercase string with no leading/trailing whitespace
    - consistency with Patcher: adding a UI object (e.g., toggle) via Patcher.add_box yields box dict with maxclass == its own name and no meaningful text-based name mismatch; adding cycle~ yields maxclass "newobj" with name in text (this pins the CLAUDE.md rule that UI_MAXCLASSES, not the DB maxclass field, is authoritative)
  </behavior>
  <action>
    Write the two test files following existing repo conventions observed in tests/test_patcher.py: `from src.maxpat.patcher import Patcher`, `from src.maxpat.maxclass_map import UI_MAXCLASSES, resolve_maxclass, is_ui_object`, class-based grouping (e.g., TestDownstream, TestUpstream, TestSignalPath, TestConnectedComponents, TestResolveMaxclass, TestUIMaxclassesInvariants), plain asserts, no new fixtures needed (conftest.py fixtures are DB-oriented and not required here). Build graph fixtures inline with Patcher(), add_box(), add_connection() — only use objects that exist in the DB (cycle~, *~, dac~, number, trigger, toggle, gain~). Do NOT duplicate the exact ED-04 scenarios already in tests/test_patcher.py (lines ~1801+) — cover upstream, signal_only, signal_path, subpatcher crossing, and edge cases that the transitive tests miss. Do NOT modify src/maxpat/graph.py or maxclass_map.py; if a test reveals a genuine bug, report it in the SUMMARY rather than changing production code (stability directive: never modify working functionality unasked).
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_graph.py tests/test_maxclass_map.py -q</automated>
  </verify>
  <done>Both files pass; tests/test_graph.py covers downstream, upstream, signal_only filtering, signal_path, connected_components, subpatcher crossing, and ValueError cases; tests/test_maxclass_map.py covers resolve_maxclass both branches, is_ui_object, and UI_MAXCLASSES invariants.</done>
</task>

<task type="auto" tdd="true">
  <name>Task 2: Smoke tests for the six remaining untested modules</name>
  <files>tests/test_defaults.py, tests/test_utils.py, tests/test_rnbo_validation.py, tests/test_ext_validation.py, tests/test_ext_templates.py, tests/test_m4l_constants.py</files>
  <behavior>
    tests/test_utils.py — get_box_name:
    - maxclass "newobj" with text "cycle~ 440" returns "cycle~"
    - maxclass "newobj" with empty/missing text returns ""
    - UI maxclass (e.g., "toggle") returns the maxclass itself
    - missing maxclass key returns ""

    tests/test_defaults.py:
    - numeric constants sane: FONT_SIZE > 0, CHAR_WIDTH > 0, MIN_BOX_WIDTH > 0, DEFAULT_HEIGHT > 0, V_SPACING == 20 and H_GUTTER == 15 (pins CLAUDE.md Rule #4 spacing)
    - LayoutOptions instantiates with defaults
    - DEFAULT_PATCHER_PROPS is a dict containing expected keys (e.g., fontname/fontsize-family keys as present in the module)
    - AESTHETIC_PALETTE values are well-formed (each entry a 4-element RGBA list of floats in 0..1)
    - FONTFACE_* and BUBBLE_* constants have distinct expected integer values (0-3)

    tests/test_m4l_constants.py:
    - ParamType, UnitStyle, ModMode, ParamVisibility are IntEnums with expected representative members
    - struct.calcsize(AMXD_HEADER_FORMAT) == AMXD_HEADER_SIZE (32)
    - AMXD_MAGIC == b"ampf"; the three AMXD_TYPE_* markers are distinct 4-byte values

    tests/test_ext_templates.py:
    - render_message_template, render_dsp_template, render_scheduler_template each return a non-empty string containing the given external name and "public object<" (Min-DevKit class decl)
    - render_dsp_template embeds the requested num_inputs/num_outputs in the sample_operator template args
    - render_cmake_template and render_test_template return non-empty strings containing the name

    tests/test_ext_validation.py:
    - validate_mxo on a nonexistent path returns (False, msg) mentioning it does not exist
    - validate_mxo on an existing dir without .mxo suffix (tmp_path) returns (False, ...) mentioning the suffix
    - validate_mxo on a tmp .mxo dir missing Contents/MacOS binary returns (False, ...) — no subprocess reached
    - parse_compiler_errors extracts file/line/message dicts from a representative clang stderr string; returns [] for empty stderr
    - BuildResult dataclass instantiates

    tests/test_rnbo_validation.py:
    - validate_rnbo_patch on a minimal patch dict with only RNBO-compatible boxes (e.g., a cycle~ newobj box) returns a list with no error-severity findings for the rnbo-objects layer
    - validate_rnbo_patch flags a known non-RNBO object (pick one with rnbo_compatible false in the DB via RNBODatabase, or a fabricated unknown name) as a finding
    - RNBO_TARGET_CONSTRAINTS contains the three targets "plugin", "web", "cpp"
  </behavior>
  <action>
    Write six small smoke-test files matching repo conventions (class-grouped, `from src.maxpat.<module> import ...`). Use pytest's tmp_path fixture for ext_validation filesystem cases; never invoke real compilers or subprocess-dependent paths beyond the early-return branches. For rnbo_validation, inspect the actual ValidationResult shape and RNBODatabase API in src/maxpat/rnbo.py before writing assertions — assert on structure actually returned, not guessed field names. Keep each file focused: pin current behavior, don't over-specify incidental formatting (e.g., assert substring presence in templates, not full-text equality). Do NOT modify any production module. After all six files pass, run the full suite to confirm zero regressions against the 2030-passed / 4-xfailed baseline.
  </action>
  <verify>
    <automated>python3 -m pytest tests/test_defaults.py tests/test_utils.py tests/test_rnbo_validation.py tests/test_ext_validation.py tests/test_ext_templates.py tests/test_m4l_constants.py -q && python3 -m pytest tests/ -q</automated>
  </verify>
  <done>All six smoke files pass; full suite passes with no new failures (prior 4 xfails unchanged); every previously-untested module in src/maxpat/ named in the objective now has a direct tests/test_<module>.py.</done>
</task>

</tasks>

<threat_model>
## Trust Boundaries

| Boundary | Description |
|----------|-------------|
| none | Test-only change; no untrusted input, no new dependencies, no runtime surface |

## STRIDE Threat Register

| Threat ID | Category | Component | Severity | Disposition | Mitigation Plan |
|-----------|----------|-----------|----------|-------------|-----------------|
| T-quick-hrl-01 | Tampering | tests invoking subprocess paths (ext_validation) | low | mitigate | Tests only exercise early-return branches (nonexistent path, wrong suffix, missing binary) so no `file`/`lipo` subprocess runs on attacker-controlled input |
</threat_model>

<verification>
- `python3 -m pytest tests/test_graph.py tests/test_maxclass_map.py tests/test_defaults.py tests/test_utils.py tests/test_rnbo_validation.py tests/test_ext_validation.py tests/test_ext_templates.py tests/test_m4l_constants.py -q` — all new files pass
- `python3 -m pytest tests/ -q` — full suite green, no regressions vs 2030 passed / 4 xfailed baseline
- `ls tests/test_graph.py tests/test_maxclass_map.py tests/test_defaults.py tests/test_utils.py tests/test_rnbo_validation.py tests/test_ext_validation.py tests/test_ext_templates.py tests/test_m4l_constants.py` — all 8 artifacts exist
- No files under src/ modified (git diff --stat shows tests/ only)
</verification>

<success_criteria>
- 8 new test files exist and pass under `python3 -m pytest`
- graph.py and maxclass_map.py have substantive direct coverage (traversal semantics, UI-class resolution both branches, invariants)
- Remaining 6 modules have at least smoke-level direct coverage
- Zero production-code changes; zero regressions in the existing suite
- Work committed atomically (tests only — per CLAUDE.md Rule #7 multi-instance safety, no `git add -A`)
</success_criteria>

<output>
Create `.planning/quick/260703-hrl-add-direct-test-files-for-graph-py-and-m/260703-hrl-SUMMARY.md` when done
</output>
