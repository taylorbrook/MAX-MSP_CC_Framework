"""Tests that CLAUDE.md has all required sections and content (FRM-04)."""

import re
from pathlib import Path

import pytest

CLAUDE_MD = Path(__file__).resolve().parent.parent / "CLAUDE.md"


@pytest.fixture(scope="module")
def claude_content() -> str:
    """Load CLAUDE.md content."""
    assert CLAUDE_MD.exists(), f"CLAUDE.md not found at {CLAUDE_MD}"
    return CLAUDE_MD.read_text()


def test_claude_md_exists():
    """CLAUDE.md exists at project root."""
    assert CLAUDE_MD.exists()


def test_claude_md_min_length(claude_content: str):
    """CLAUDE.md is at least 100 lines long."""
    lines = claude_content.strip().splitlines()
    assert len(lines) >= 100, f"CLAUDE.md has only {len(lines)} lines, expected >= 100"


def test_object_database_section(claude_content: str):
    """Contains '## Object Database' section."""
    assert "## Object Database" in claude_content


def test_rules_section(claude_content: str):
    """Contains '## Rules' section."""
    assert "## Rules" in claude_content


def test_never_guess_rule(claude_content: str):
    """Contains Rule #1 about never guessing objects."""
    content_lower = claude_content.lower()
    assert "never guess" in content_lower, "CLAUDE.md must contain 'never guess' rule"
    assert "rule #1" in content_lower, "CLAUDE.md must have Rule #1"


def test_domain_specific_rules_section(claude_content: str):
    """Contains '## Domain-Specific Rules' section."""
    assert "## Domain-Specific Rules" in claude_content


def test_msp_subsection(claude_content: str):
    """Contains MSP subsection under Domain-Specific Rules."""
    assert "### MSP" in claude_content


def test_gen_subsection(claude_content: str):
    """Contains Gen~ subsection under Domain-Specific Rules."""
    assert "### Gen~" in claude_content


def test_rnbo_subsection(claude_content: str):
    """Contains RNBO subsection under Domain-Specific Rules."""
    assert "### RNBO" in claude_content


def test_n4m_subsection(claude_content: str):
    """Contains Node for Max subsection under Domain-Specific Rules."""
    assert "### Node for Max" in claude_content or "### N4M" in claude_content


def test_pd_confusion_guard_section(claude_content: str):
    """Contains '## PD Confusion Guard' section."""
    assert "## PD Confusion Guard" in claude_content


def test_version_compatibility_section(claude_content: str):
    """Contains '## Version Compatibility' section."""
    assert "## Version Compatibility" in claude_content


def test_variable_io_section(claude_content: str):
    """Contains '## Variable I/O Objects' section."""
    assert "## Variable I/O Objects" in claude_content


def test_references_object_database_path(claude_content: str):
    """CLAUDE.md references the .claude/max-objects/ path."""
    assert ".claude/max-objects/" in claude_content


def test_verify_before_connect_rule(claude_content: str):
    """Contains Rule #2 about verifying connections."""
    assert "Rule #2" in claude_content
    assert "Verify Before Connect" in claude_content


def test_hot_cold_inlet_rule(claude_content: str):
    """Contains Rule #3 about hot/cold inlet ordering."""
    assert "Rule #3" in claude_content
    assert "Hot/Cold" in claude_content


def test_file_conventions_section(claude_content: str):
    """Contains file conventions section."""
    assert "## File Conventions" in claude_content
    assert ".maxpat" in claude_content


# ── Q18: slim CLAUDE.md without losing a rule (review S11) ─────────

REPO_ROOT = CLAUDE_MD.parent
SKILLS_ROOT = REPO_ROOT / ".claude" / "skills"

# Ratchet: base 725f568f was 49,752 bytes; Q18 cuts it by at least 40%.
# 261112-dci: four section bodies moved to skill homes, 29,891 -> 27,293 bytes.
CLAUDE_BUDGET_BYTES = 27_500

BASE_HEADINGS = [
    "# MAX Development Framework",
    "## Object Database",
    "### Supplementary Files",
    "### How to Use the Database",
    "## Rules",
    "### Rule #1: Never Guess Objects",
    "### Rule #2: Verify Before Connect",
    "### Rule #3: Hot/Cold Inlet Ordering",
    "### Rule #4: Patch Style",
    "#### Text Contrast: Resolve Against the Displayed Surface",
    "#### Multislider as Labeled Parameter Bank",
    "### Rule #5: No Generator Scripts",
    "### Rule #6: Z-Order Awareness",
    "### Rule #7: Commit After Every Save",
    "### Rule #8: `replace_box()` Orphans Connections — Always Rewire",
    "### Rule #9: Presentation Mode Parity",
    "## Domain-Specific Rules",
    "### MSP (Audio/Signal)",
    "### Gen~ (GenExpr DSP Code)",
    "### Subpatcher Inlet/Outlet Access",
    "### RNBO (Export-Ready Patches)",
    "### Node for Max (N4M / node.script)",
    "### js / v8 (JavaScript inside MAX)",
    "### Max for Live (M4L / .amxd)",
    "### bach (package)",
    "## PD Confusion Guard",
    "## Version Compatibility",
    "## Bpatcher and Abstraction Arguments (`#N` Substitution)",
    "## Variable I/O Objects",
    "## File Conventions",
]

# One literal per distinct imperative of base CLAUDE.md (177-anchor seed plus
# the rule-inventory additions). Every anchor must survive the slimming.
RULE_ANCHORS = [
    ".claude/max-objects/", "ObjectDatabase", "src.maxpat.db_lookup", "db.messages(name)", "db.selectors(name)",
    "relationships.json", "pd-blocklist.json", "aliases.json", "overrides.json", "groups.json",
    "audit_empty_io()", "audit_half_empty_io()", "UI_MAXCLASSES", "invalid attribute maxclass", "<c74object name>",
    "help box wins", "audit_db.py", "sync_max_bundle.py",
    "UNKNOWN OBJECT", "get_effective_restrictions", "No such object", "lookup()['domain']",
    "signal/float inlets accept both signal and control connections", "severity-contract.md", "variable_io",
    "Send to cold inlets FIRST", "Send to hot inlet LAST",
    "Use explicit `trigger` objects for fan-out", "~20px vertical, ~15px horizontal gutter", "~5px horizontal gap", "len(text) * 8 + 25",
    "MIN_CONTRAST_RATIO", "4.5:1", "ensure_text_contrast", "repair_text_contrast", "luminance > 0.5", "finalize_patch(is_new=True)",
    "add_labeled_param_bank", "fetch $1",
    "generate.py", "box._raw", "Box.to_dict()", "Patcher.to_dict()", "git show A:file",
    "add_overlay_readout", "bring_to_front", "send_to_back", "set_z_index", "ignoreclick=1", "background=1",
    "auto_commit_patch()", "StaleFileError", "PatchValidationError", "SaveGateWarning", "force=True", "git stash", "git add -A", "patches/<project>/", "git stash list",
    "replace_box_safe", "result.orphaned", 'rewire="auto"', "keep the box's identity", "a no-op save is byte-identical", "edits an existing `.gendsp` in place",
    "add_to_presentation", "presentation_rect", "Presentation coverage", "Low contrast text", "set_canvas_background()", "context.md", "`bgcolor`",
    "dac~", "*~ 0.", "scale 0 127 0. 1.", "scale 0. 127. 0. 1.", "slider position", "snapshot~", "meter~", "mc.pack~", "line~", "space-delimited list",
    "fluid.buf2list", "jit.buffer~", "peek~", "uzi", "replacechannel", "min(max(x, lo), hi)", "trunc~", "floor~", '"items": ["LP", ","',
    "in1", "out1", "Param", "History", "Delay myDelay", "delay()", "Delay.read", "initialized before", "Declaration ordering", "param_name $1", "attrui",
    "Waveguide loop filters", "POST-LOOP", "phase delay", "group delay", "mc.gen~", "Pre-flight any new in-loop waveguide filter", "tanh(x*g)/g",
    "No local aliases in Param-only expressions", "Hoisted temps can be emitted out of order", "History one(1)", "twopi", "sqrt1_2", "radtodeg",
    "tab characters", "else if", "peek(buf, idx, 0)", "poke(buf, val, idx, 0)", "CONSTANT bounds", "Amortize", "Max 9.2's Gen compiler fixes do NOT retire",
    "get_inlets()", "get_outlets()", "inlet~", 'extra_attrs={"comment":',
    "rnbo_compatible: true", "rnbo~",
    "node.script", "node.codebox", "max-api", "maxAPI.outlet", "1 inlet / 2 outlets",
    "Legacy Engine", "ES5", "v8", "messagename", "arrayfromargs(arguments)", "Task",
    "plugout~", "param_connect", "add_m4l_gen_synth",
    "bach.llll2list", "bach.nth", "@out t",
    "osc~", "lop~", "hip~", "bp~", "tabread~", "throw~",
    "MAX 9", "min_version",
    "standalone token", "JSON numbers", "set Label #1",
    "variable_io_rules", "compute_io_counts", "IO_RESOLVERS", "trigger b i f", "pack 0 0 0 0", "route foo bar baz",
    ".maxpat", ".gendsp", ".maxproj", ".mxo",
    "Gen~ (GenExpr DSP Code)", "MSP (Audio/Signal)", "bach (package)", "Rule #6: Z-Order Awareness", "Multislider as Labeled Parameter Bank",
    "Bpatcher and Abstraction Arguments", "Subpatcher Inlet/Outlet Access", "PD Confusion Guard",
    # Q18 rule-inventory additions (RULE units the seed does not cover)
    "Every rule here is mandatory", "extraction-log.json", "single source of truth",
    "Before creating any connection", "signal outlets connect to signal inlets",
    "Always count from the database", "Use `trigger` (t)",
    "ordering does not apply for MSP signal connections",
    "Always use `trigger` for explicit ordering", "Top-to-bottom signal flow",
    "Add `comment` objects on non-obvious connections", "Prefer named `send`/`receive`",
    "Use `patcher` (subpatchers)", "`patching_rect`", "as fallback", "all three must be read",
    "Edits to loaded boxes and cords reach disk", "index 0 = topmost", "overlapping the dial",
    "re-read after every save", "commit your current work first",
    "does NOT preserve connections", "must-fix before save",
    "never connect raw oscillators to `dac~` at full volume", "process at audio rate",
    "do not generate it", "non-primary outlet", "do NOT have a `clip()` function",
    "`Buffer` and `Data`", "once per sample", "both branches always execute", "add_gen()",
    "1/tanh(drive)", "built-in constant names", "Codebox safe-construct rules", "proven-safe",
    "self-contained",
    "network requests", "add_js()", "add_v8()", "only when the task asks for them",
    "check the PD blocklist",
    "do not ask users to choose a version", "MAX 8.1+", "NOT version-tagged",
    "`args` attribute", "separate argument",
    "applies equally to newobj boxes and message boxes",
    "Comment boxes do NOT perform `#N` substitution",
    "Always compute actual I/O count from arguments", "referenced by `js` object",
]

# Detail moved out of CLAUDE.md must exist verbatim at its new home.
MOVED_DETAIL = {
    "dbmaint": (".claude/skills/references/db-maintenance.md",
                ["813 of 2156", "640 of 1175", "jit.gl.tex2mat", "jit.unpack.geomat", "--apply groups", "--refresh-log",
                 "--min-version", "alpha_mode", "2 inlets / 1 outlet", "by_source", "Last synced against Max 9.2.0",
                 "define-mapped", "TEXT_HERE", "jit.web~", "Merged per port", "mcwrapper", "kbm.data",
                 "If a control connection from an MSP object's non-primary outlet"]),
    "genexpr": (".claude/skills/references/genexpr-rules.md",
                ["pd_samples = atan(b*sin(w) / (1 - b*cos(w))) / max(w, 0.0001)", "PB_re", "mode-competition problem",
                 "bassoon-model", "[0, 64]", "ji-harmonizer v0.1.2", "stereo-feedback-delay v0.1.0", "reverse-delay v0.2.1",
                 "reverse-delay v0.3.3", "sample-layers v0.3.0", "spectraldetector v0.1.x", "scala-synth", "kicksynth",
                 "maxb_NN", "gmax_raw", "srs = samplerate * one;", "dead-code elimination", "History one(1)",
                 "tanh(x*g)/g", "else if"]),
    "uicontrast": (".claude/skills/references/ui-presets.md",
                   ["## Text Contrast Resolution", "bgfillcolor", "grad1", "maximizes the MINIMUM contrast",
                    "Presentation coordinates", "Patcher background", "MIN_CONTRAST_RATIO"]),
    "jsagent": (".claude/skills/max-js-agent/SKILL.md",
                ["dump out", "node.codebox", "not a Rule #5 violation", "messagename", "arrayfromargs(arguments)"]),
    "severity": (".claude/skills/references/severity-contract.md",
                 ["StaleFileError", "SaveGateWarning", "x-rank", "force=True", "PatchValidationError"]),
    "max92": (".claude/skills/references/max-9.2-changes.md",
              ["dspstress~", "abl.dsp.djfilter~", "replacechannel_samples", "trim_samples", "MaxFFT2D", "IOBuffer", "setTimeout"]),
    # 261112-dci: CLAUDE.md section bodies moved verbatim to skill-loaded homes
    "bach": (".claude/skills/references/shared-capabilities.md",
             ["## bach (package) Rules", "bach.llll2list", "bach.nth", "@unwrap 1", "@out t",
              "Flat sublists then arrive as regular lists (`unpack f f` works)"]),
    "multislider": (".claude/skills/references/shared-capabilities.md",
                    ["#### Multislider as Labeled Parameter Bank", "Reading values by index", "fetchindex", "outlet 1",
                     "orientation: 0", "size * 24", "contdata: 1", "setstyle: 1", "named subpatchers",
                     "fetch $1", "add_labeled_param_bank",
                     "Don't insert `split` between multislider and the consumer"]),
    "m4l": (".claude/skills/references/shared-capabilities.md",
            ["## Max for Live Device Rules", "parameter_enable: 1", "saved_attribute_attributes.valueof",
             "not Live-automatable", "signal-rate exception", "plugout~", "param_connect", "add_m4l_gen_synth",
             "`gain~` defaults to 0, silence on load",
             "refuses a `live.thisdevice`-only helper abstraction without `kind=`"]),
    "rnbo": (".claude/skills/max-rnbo-agent/SKILL.md",
             ["## RNBO Export Rules", "rnbo_compatible: true", "self-contained", "VST3/AU",
              "RNBO-specific definitions", "`param` objects in RNBO",
              "no external file dependencies for export targets (VST3/AU plugin, Web Audio, C++)"]),
}

# CLAUDE.md must name each detail home by its full path.
DETAIL_HOMES = {
    "dbmaint": ".claude/skills/references/db-maintenance.md",
    "genexpr": ".claude/skills/references/genexpr-rules.md",
    "uicontrast": ".claude/skills/references/ui-presets.md",
    "jsagent": ".claude/skills/max-js-agent/SKILL.md",
    "severity": ".claude/skills/references/severity-contract.md",
    "max92": ".claude/skills/references/max-9.2-changes.md",
    "shared": ".claude/skills/references/shared-capabilities.md",
    "troubleshooting": ".claude/skills/references/troubleshooting.md",
    "provenforms": ".claude/skills/references/proven-forms.md",
    "rnbo": ".claude/skills/max-rnbo-agent/SKILL.md",
}

ALLOWED_BARE_MD = {"context.md", "CONTEXT.md"}

_REPO_PATH_RE = re.compile(r"(?<![\w/.-])((?:\.claude|src|tools|tests)/[\w./<>{}*-]*)")
_BARE_MD_RE = re.compile(r"(?<![\w/.-])([\w.-]+\.md)\b")
_MEMORY_NOTE_RE = re.compile(r"\b(feedback|project|reference)_[a-z0-9_]+\.md\b")


def _lines_outside_fences(text: str) -> list:
    out = []
    in_fence = False
    for line in text.split("\n"):
        if line.startswith("```"):
            in_fence = not in_fence
            continue
        if not in_fence:
            out.append(line)
    return out


def _private_path_findings(text: str) -> list:
    found = []
    if ".planning/" in text:
        found.append(".planning/ path")
    if "/Users/" in text:
        found.append("/Users/ path")
    found += [f"memory-note filename {m.group(0)}" for m in _MEMORY_NOTE_RE.finditer(text)]
    return found


def test_claude_md_size_budget():
    """Q18/S11: CLAUDE.md is loaded every session; keep it within the ratchet."""
    size = len(CLAUDE_MD.read_bytes())
    assert size <= CLAUDE_BUDGET_BYTES, (
        f"CLAUDE.md is {size} bytes, budget {CLAUDE_BUDGET_BYTES}"
    )


def test_claude_md_headings_preserved(claude_content: str):
    """Q18: every base heading survives verbatim (skills, src and MEM cite them)."""
    lines = set(_lines_outside_fences(claude_content))
    missing = [h for h in BASE_HEADINGS if h not in lines]
    assert missing == [], f"headings missing from CLAUDE.md: {missing}"


@pytest.mark.parametrize(
    "anchor", RULE_ANCHORS, ids=[f"a{i:03d}" for i in range(1, len(RULE_ANCHORS) + 1)]
)
def test_rule_anchor_present(claude_content: str, anchor: str):
    """Q18: no rule is lost while slimming; each imperative keeps its anchor."""
    assert anchor in claude_content, f"rule anchor missing from CLAUDE.md: {anchor!r}"


_MOVED_CASES = [
    (key, path, anchor)
    for key, (path, anchors) in MOVED_DETAIL.items()
    for anchor in anchors
]
_MOVED_IDS = []
for _key, _anchors in ((k, v[1]) for k, v in MOVED_DETAIL.items()):
    _MOVED_IDS += [f"{_key}-{i:02d}" for i in range(1, len(_anchors) + 1)]


@pytest.mark.parametrize("key,path,anchor", _MOVED_CASES, ids=_MOVED_IDS)
def test_moved_detail_present(key: str, path: str, anchor: str):
    """Q18: detail moved out of CLAUDE.md exists verbatim at its new home."""
    target = REPO_ROOT / path
    assert target.is_file(), f"{key}: detail home {path} does not exist"
    assert anchor in target.read_text(encoding="utf-8"), (
        f"{key}: {anchor!r} missing from {path}"
    )


@pytest.mark.parametrize("key", list(DETAIL_HOMES), ids=list(DETAIL_HOMES))
def test_claude_md_points_to_detail_home(claude_content: str, key: str):
    """Q18: CLAUDE.md names every detail home by its full path."""
    assert DETAIL_HOMES[key] in claude_content, (
        f"CLAUDE.md does not point to {DETAIL_HOMES[key]}"
    )


def test_claude_md_pointer_paths_exist(claude_content: str):
    """Q18: every repo path and bare *.md name CLAUDE.md cites resolves."""
    bad = []
    for m in _REPO_PATH_RE.finditer(claude_content):
        path = m.group(1)
        if any(c in path for c in "<{*"):
            continue
        path = path.rstrip(".,)")
        if not (REPO_ROOT / path).exists():
            bad.append(path)
    skill_basenames = {p.name for p in SKILLS_ROOT.rglob("*") if p.is_file()}
    for m in _BARE_MD_RE.finditer(claude_content):
        name = m.group(1)
        if name not in skill_basenames and name not in ALLOWED_BARE_MD:
            bad.append(name)
    assert bad == [], f"CLAUDE.md cites paths that do not exist: {bad}"


def test_claude_md_no_private_paths(claude_content: str):
    """Q18/§3.8: shipped CLAUDE.md never points into .planning/, /Users/ or MEM."""
    found = _private_path_findings(claude_content)
    assert found == [], f"CLAUDE.md cites unshipped locations: {found}"


@pytest.mark.parametrize(
    "key", ["dbmaint", "genexpr"], ids=["dbmaint", "genexpr"]
)
def test_shipped_doc_has_no_private_paths(key: str):
    """Q18: the new reference docs ship, so they carry no private paths."""
    target = REPO_ROOT / DETAIL_HOMES[key]
    assert target.is_file(), f"{DETAIL_HOMES[key]} does not exist"
    found = _private_path_findings(target.read_text(encoding="utf-8"))
    assert found == [], f"{DETAIL_HOMES[key]} cites unshipped locations: {found}"


def test_builder_docstrings_carry_recipes():
    """Q18: the multislider and overlay recipes live in the builder docstrings."""
    from src.maxpat.patcher import Patcher

    bank = Patcher.add_labeled_param_bank.__doc__ or ""
    for anchor in ("p drift", '"size": 14', "fetchindex", "outlet 1", "contdata"):
        assert anchor in bank, f"add_labeled_param_bank docstring lacks {anchor!r}"
    overlay = Patcher.add_overlay_readout.__doc__ or ""
    for anchor in ("background=1", "add_step_marker", "bring_to_front", "ignoreclick"):
        assert anchor in overlay, f"add_overlay_readout docstring lacks {anchor!r}"
