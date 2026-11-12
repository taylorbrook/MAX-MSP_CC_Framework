"""Tests for manual test checklist generation from patch structure."""

from pathlib import Path

import pytest

from src.maxpat.testing import generate_test_checklist, save_test_results


def _make_patch(*object_names: str) -> dict:
    """Helper: build a minimal patch_dict with the given object names."""
    boxes = []
    for i, name in enumerate(object_names):
        boxes.append({
            "box": {
                "id": f"obj-{i}",
                "maxclass": "newobj",
                "text": name,
            }
        })
    return {
        "patcher": {
            "boxes": boxes,
            "lines": [],
        }
    }


class TestGenerateTestChecklist:
    """Tests for generate_test_checklist function."""

    def test_audio_patch_includes_audio_output_test(self):
        patch = _make_patch("cycle~", "*~ 0.5", "dac~")
        checklist = generate_test_checklist(patch, "audio-test")

        assert "audio" in checklist.lower() or "Audio" in checklist
        assert "dac~" in checklist or "sound" in checklist.lower() or "speakers" in checklist.lower()

    def test_midi_patch_includes_midi_test(self):
        patch = _make_patch("notein", "stripnote", "mtof")
        checklist = generate_test_checklist(patch, "midi-test")

        assert "MIDI" in checklist or "midi" in checklist

    def test_ui_patch_includes_toggle_test(self):
        patch = _make_patch("toggle", "metro 500")
        checklist = generate_test_checklist(patch, "ui-test")

        assert "toggle" in checklist.lower() or "click" in checklist.lower()

    def test_includes_setup_section(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "setup-test", patch_path="/path/to/patch.maxpat")

        assert "setup" in checklist.lower() or "Setup" in checklist
        assert "/path/to/patch.maxpat" in checklist or "patch.maxpat" in checklist

    def test_includes_audio_on_for_signal_objects(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "audio-setup")

        assert "audio on" in checklist.lower() or "Audio On" in checklist or "turn on audio" in checklist.lower()

    def test_numbered_format_with_action_expected(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "format-test")

        # Should have numbered steps
        assert "1." in checklist
        # Should have Action and Expected markers
        assert "Action" in checklist or "action" in checklist
        assert "Expected" in checklist or "expected" in checklist

    def test_empty_patch_returns_minimal_checklist(self):
        patch = _make_patch()
        checklist = generate_test_checklist(patch, "empty-test")

        # Should still have setup (open in MAX)
        assert "MAX" in checklist or "open" in checklist.lower()
        # Should have at least one test step
        assert "1." in checklist

    def test_gen_patch_includes_gen_test(self):
        patch = _make_patch("gen~", "dac~")
        checklist = generate_test_checklist(patch, "gen-test")

        assert "gen~" in checklist or "Gen" in checklist

    def test_button_includes_ui_test(self):
        patch = _make_patch("button", "message")
        checklist = generate_test_checklist(patch, "button-test")

        assert "button" in checklist.lower() or "click" in checklist.lower()

    def test_metro_includes_metro_test(self):
        patch = _make_patch("metro 500", "toggle")
        checklist = generate_test_checklist(patch, "metro-test")

        assert "metro" in checklist.lower() or "interval" in checklist.lower()

    def test_number_box_includes_number_test(self):
        patch = _make_patch("number", "print")
        checklist = generate_test_checklist(patch, "number-test")

        assert "number" in checklist.lower() or "value" in checklist.lower()

    def test_pass_fail_checkboxes(self):
        patch = _make_patch("cycle~", "dac~")
        checklist = generate_test_checklist(patch, "checkbox-test")

        assert "[ ] Pass" in checklist or "[  ] Pass" in checklist or "Pass" in checklist
        assert "[ ] Fail" in checklist or "[  ] Fail" in checklist or "Fail" in checklist


class TestSaveTestResults:
    """Tests for save_test_results function."""

    def test_writes_file_to_correct_location(self, tmp_path: Path):
        test_results_dir = tmp_path / "test-results"
        test_results_dir.mkdir()

        results_md = "# Test Results\n\n- [x] Pass: Audio output\n"
        result_path = save_test_results(tmp_path, "audio-check", results_md)

        assert result_path == test_results_dir / "audio-check.md"
        assert result_path.is_file()
        assert result_path.read_text() == results_md

    def test_creates_test_results_dir_if_missing(self, tmp_path: Path):
        results_md = "# Test Results\n\n- [x] Pass: Basic open\n"
        result_path = save_test_results(tmp_path, "basic-check", results_md)

        assert result_path.is_file()
        assert result_path.read_text() == results_md


class TestRecursiveChecklist:
    """G10 (Q20): the checklist recurses and counts object boxes only."""

    def test_g10_repro(self):
        patch = {"patcher": {"boxes": [
            {"box": {"id": "obj-1", "maxclass": "newobj", "text": "p synth", "patcher": {
                "boxes": [{"box": {"id": "obj-1", "maxclass": "newobj", "text": "dac~"}}],
                "lines": [],
            }}},
            {"box": {"id": "obj-2", "maxclass": "comment", "text": "metro speed and gen~ notes"}},
        ], "lines": []}}
        result = generate_test_checklist(patch, "G10")
        assert "Audio Output" in result
        assert "Turn on audio" in result
        assert "Metro Timing" not in result
        assert "gen~ Processing" not in result

    def test_message_box_not_counted(self):
        patch = {"patcher": {"boxes": [
            {"box": {"id": "obj-1", "maxclass": "message", "text": "metro 500"}},
        ], "lines": []}}
        assert "Metro Timing" not in generate_test_checklist(patch, "msg")

    def test_nested_ui_toggle_counted(self):
        patch = {"patcher": {"boxes": [
            {"box": {"id": "obj-1", "maxclass": "newobj", "text": "p ui", "patcher": {
                "boxes": [{"box": {"id": "obj-1", "maxclass": "toggle"}}], "lines": [],
            }}},
        ], "lines": []}}
        assert "Toggle Interaction" in generate_test_checklist(patch, "ui")

    def test_gen_operator_ignored(self):
        patch = {"patcher": {"boxes": [
            {"box": {"id": "obj-1", "maxclass": "newobj", "text": "gen~", "patcher": {
                "classnamespace": "dsp.gen",
                "boxes": [{"box": {"id": "obj-1", "maxclass": "newobj", "text": "button"}}],
                "lines": [],
            }}},
        ], "lines": []}}
        result = generate_test_checklist(patch, "gen")
        assert "Button Click" not in result
        assert "gen~ Processing" in result

    @pytest.mark.parametrize("text", ["", "   ", None, 5])
    def test_odd_text_never_raises(self, text):
        patch = {"patcher": {"boxes": [
            {"box": {"id": "obj-1", "maxclass": "newobj", "text": text}},
            {"box": {"id": "obj-2", "maxclass": "comment", "text": text}},
            "junk",
        ], "lines": []}}
        assert "# Test Checklist" in generate_test_checklist(patch, "odd")


# ---------------------------------------------------------------------------
# Q37 (quick 261022-ksz): confirmation lifecycle and proven-forms entries
# ---------------------------------------------------------------------------

import difflib  # noqa: E402
import json  # noqa: E402
import shutil  # noqa: E402
import subprocess  # noqa: E402
import warnings  # noqa: E402

from src.maxpat import testing as testing_mod  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parent.parent
LIFECYCLE_SKILL = REPO_ROOT / ".claude" / "skills" / "max-lifecycle" / "SKILL.md"
MAX_TEST_CMD = REPO_ROOT / ".claude" / "commands" / "max-test.md"
TROUBLESHOOTING = REPO_ROOT / ".claude" / "skills" / "references" / "troubleshooting.md"


# Git helpers copied from tests/test_save_gate.py (not imported).


@pytest.fixture()
def _isolate_git_env(monkeypatch):
    """Make sure no inherited git env var can redirect git to another repo."""
    for var in ("GIT_DIR", "GIT_WORK_TREE", "GIT_INDEX_FILE"):
        monkeypatch.delenv(var, raising=False)


def _git(root: Path, *args: str) -> str:
    result = subprocess.run(["git", *args], cwd=str(root), capture_output=True,
                            text=True, check=True)
    return result.stdout


def _repo(tmp_path: Path) -> Path:
    root = tmp_path / "repo"
    root.mkdir()
    hooks = tmp_path / "empty-hooks"
    hooks.mkdir()
    _git(root, "init", "-q")
    _git(root, "config", "user.email", "test@example.com")
    _git(root, "config", "user.name", "Confirmation Test")
    _git(root, "config", "commit.gpgsign", "false")
    _git(root, "config", "core.hooksPath", str(hooks))
    return root.resolve()


def _staged(root: Path) -> list:
    return [l for l in _git(root, "diff", "--cached", "--name-only").splitlines() if l]


def _head_files(root: Path) -> list:
    return [l for l in _git(root, "show", "--name-only", "--format=", "HEAD").splitlines() if l]


def _project(base: Path, name: str = "demo", version: str | None = "0.2.1") -> Path:
    proj = base / "patches" / name
    (proj / "generated").mkdir(parents=True)
    (proj / "generated" / f"{name}.maxpat").write_text("{}", encoding="utf-8")
    if version is not None:
        (proj / "versions.json").write_text(json.dumps(
            {"versions": [{"version": version, "description": "x", "timestamp": "t"}]}),
            encoding="utf-8")
    return proj


def _record(proj, **kw):
    kw.setdefault("date", "2026-10-22")
    kw.setdefault("commit", False)
    return testing_mod.record_confirmation(proj, kw.pop("feature", "LFO sync"),
                                           kw.pop("evidence", "User: the LFO syncs."), **kw)


class TestRecordConfirmation:
    def test_content(self, tmp_path):
        proj = _project(tmp_path)
        path = _record(proj, max_version="9.2.0", files=["generated/demo.maxpat"],
                       lesson="sync lfo to transport")
        assert path == proj / "test-results" / "v0.2.1-lfo-sync-confirmed.md"
        text = path.read_text(encoding="utf-8")
        assert text.startswith("# Confirmed in MAX: LFO sync\n")
        for frag in ("- Project: demo", "- Version: v0.2.1", "- Date: 2026-10-22",
                     "- MAX: 9.2.0", "- Files: `generated/demo.maxpat`",
                     "- Proven-forms lesson: sync lfo to transport",
                     "## Evidence\n\nUser: the LFO syncs."):
            assert frag in text, frag
        assert text.endswith("\n")

    def test_defaults(self, tmp_path):
        proj = _project(tmp_path)
        text = _record(proj).read_text(encoding="utf-8")
        assert "- MAX: not recorded" in text
        assert "- Files: none listed" in text
        assert "- Proven-forms lesson: none proposed" in text

    def test_unversioned(self, tmp_path):
        proj = _project(tmp_path, version=None)
        path = _record(proj)
        assert path.name == "2026-10-22-lfo-sync-confirmed.md"
        assert "- Version: unversioned" in path.read_text(encoding="utf-8")

    def test_never_overwrites(self, tmp_path):
        proj = _project(tmp_path)
        first = _record(proj)
        before = first.read_bytes()
        second = _record(proj, evidence="again")
        third = _record(proj, evidence="third")
        assert second.name == "v0.2.1-lfo-sync-confirmed-2.md"
        assert third.name == "v0.2.1-lfo-sync-confirmed-3.md"
        assert first.read_bytes() == before

    def test_traversal_feature_slug(self, tmp_path):
        proj = _project(tmp_path)
        path = _record(proj, feature="../../etc passwd")
        assert path.parent == proj / "test-results"
        assert path.name == "v0.2.1-etc-passwd-confirmed.md"

    def test_slug_rules(self):
        assert testing_mod._slug("!!!") == "feature"
        assert len(testing_mod._slug("a" * 100)) <= 48
        assert testing_mod._slug("Gain  Fader / L+R") == "gain-fader-l-r"

    @pytest.mark.parametrize("files", [["../outside.txt"], ["generated/missing.maxpat"]])
    def test_bad_files(self, tmp_path, files):
        proj = _project(tmp_path)
        (tmp_path / "patches" / "outside.txt").write_text("x", encoding="utf-8")
        with pytest.raises(ValueError):
            _record(proj, files=files)
        assert not (proj / "test-results").exists()

    @pytest.mark.parametrize("evidence", ["seen at /Users/someone/x",
                                          "see project_ambire.md for details"])
    def test_private_paths(self, tmp_path, evidence):
        proj = _project(tmp_path)
        with pytest.raises(ValueError):
            _record(proj, evidence=evidence)
        assert not (proj / "test-results").exists()

    @pytest.mark.parametrize("kw", [{"version": "1.2"}, {"version": "x.y.z"},
                                    {"date": "22-10-2026"}, {"date": "2026-10-22x"}])
    def test_bad_version_or_date(self, tmp_path, kw):
        proj = _project(tmp_path)
        with pytest.raises(ValueError):
            _record(proj, **kw)

    @pytest.mark.parametrize("kw", [{"feature": ""}, {"feature": "   "},
                                    {"evidence": ""}, {"feature": "two\nlines"}])
    def test_empty_or_multiline(self, tmp_path, kw):
        proj = _project(tmp_path)
        with pytest.raises(ValueError):
            _record(proj, **kw)

    def test_missing_project_dir(self, tmp_path):
        with pytest.raises(FileNotFoundError):
            _record(tmp_path / "nope")

    def test_commit_false_no_warning(self, tmp_path):
        proj = _project(tmp_path)
        with warnings.catch_warnings(record=True) as caught:
            warnings.simplefilter("always")
            _record(proj, commit=False)
        assert not caught

    def test_commit_outside_repo_warns(self, tmp_path, _isolate_git_env):
        if shutil.which("git") is None:
            pytest.skip("git is not installed")
        proj = _project(tmp_path)
        with pytest.warns(UserWarning, match="not auto-committed"):
            path = _record(proj, commit=True)
        assert path.is_file()

    def test_commit_path_scoped(self, tmp_path, _isolate_git_env):
        if shutil.which("git") is None:
            pytest.skip("git is not installed")
        root = _repo(tmp_path)
        (root / "README").write_text("seed\n", encoding="utf-8")
        _git(root, "add", "README")
        _git(root, "commit", "-q", "-m", "seed")
        proj = _project(root)
        (proj / "notes.txt").write_text("unrelated\n", encoding="utf-8")
        _git(root, "add", "patches/demo/notes.txt")
        path = _record(proj, commit=True)
        assert _head_files(root) == ["patches/demo/test-results/" + path.name]
        assert _staged(root) == ["patches/demo/notes.txt"]


def _form_args(**kw):
    args = dict(
        title="dial step size",
        rule="set the dial's step explicitly.",
        form="`dial @size 128`",
        why="the default range hides fine steps.",
        evidence="[confirmed] demo v0.2.1 (2026-10-22)",
    )
    args.update(kw)
    return args


class TestProvenForms:
    @pytest.fixture(scope="class")
    def committed(self):
        return testing_mod.parse_proven_forms(
            testing_mod.PROVEN_FORMS_PATH.read_text(encoding="utf-8"))

    def test_committed_file_parses(self, committed):
        assert len(committed) >= 15
        assert not [e for e in committed if e.section == "Evidence tiers"]
        for e in committed:
            assert e.rule and e.form and e.why and e.evidence, e.title
            assert e.tiers and set(e.tiers) <= set(testing_mod.PROVEN_TIERS), e.title

    def test_voice_forms_nested(self, committed):
        voice = [e for e in committed if e.title == "voice forms"]
        assert len(voice) == 1
        items = [l for l in voice[0].form.splitlines() if l.startswith("- ")]
        assert len(items) >= 7

    @pytest.mark.parametrize("path", [testing_mod.PROVEN_FORMS_PATH, TROUBLESHOOTING])
    def test_reference_docs_have_no_private_paths(self, path):
        assert testing_mod._private_path_findings(path.read_text(encoding="utf-8")) == []

    def test_private_path_rule(self):
        f = testing_mod._private_path_findings
        for bad in ("/Users/x", "/home/x", ".planning/x", "~/.claude/x",
                    "feedback_thing.md", "reference_max_x.md"):
            assert f(bad), bad
        assert f("CLAUDE.md and proven-forms.md") == []

    def test_round_trip(self):
        block = testing_mod.format_proven_form(**_form_args())
        assert block.startswith("### dial step size\n\n- **Rule:** ")
        parsed = testing_mod.parse_proven_forms("## UI\n\n" + block)
        assert len(parsed) == 1
        e = parsed[0]
        assert (e.section, e.title, e.rule, e.form, e.why, e.evidence) == (
            "UI", "dial step size", "set the dial's step explicitly.",
            "`dial @size 128`", "the default range hides fine steps.",
            "[confirmed] demo v0.2.1 (2026-10-22)")
        assert e.tiers == ("confirmed",)

    def test_list_form(self):
        block = testing_mod.format_proven_form(**_form_args(form=["`a`", "`b`"]))
        assert "- **Form:**\n  - `a`\n  - `b`\n" in block
        parsed = testing_mod.parse_proven_forms(block)
        assert parsed[0].form == "- `a`\n- `b`"

    @pytest.fixture()
    def copy(self, tmp_path):
        target = tmp_path / "proven-forms.md"
        target.write_bytes(testing_mod.PROVEN_FORMS_PATH.read_bytes())
        return target

    def test_append_to_section(self, copy):
        original = copy.read_text(encoding="utf-8")
        out = testing_mod.append_proven_form("UI", path=copy, **_form_args())
        assert out == copy
        new = copy.read_text(encoding="utf-8")
        ui = new.split("## UI\n", 1)[1].split("## Subpatchers and layout", 1)[0]
        assert ui.split("### ")[-1].startswith("dial step size\n")
        ops = {op for op, *_ in difflib.SequenceMatcher(
            a=original.splitlines(), b=new.splitlines(), autojunk=False).get_opcodes()}
        assert ops <= {"equal", "insert"}
        parsed = testing_mod.parse_proven_forms(new)
        entry = [e for e in parsed if e.title == "dial step size"]
        assert len(entry) == 1 and entry[0].section == "UI"
        assert all(e.rule and e.form and e.why and e.evidence for e in parsed)
        assert "\n\n### dial step size\n" in new
        assert "(2026-10-22)\n\n## Subpatchers and layout" in new

    def test_append_last_section(self, copy):
        original = copy.read_text(encoding="utf-8")
        testing_mod.append_proven_form("Framework workflow", path=copy, **_form_args())
        new = copy.read_text(encoding="utf-8")
        assert new.startswith(original.rstrip("\n"))
        assert new.rstrip("\n").endswith("(2026-10-22)")

    def test_duplicate_title_refused(self, copy):
        before = copy.read_bytes()
        with pytest.raises(ValueError):
            testing_mod.append_proven_form("UI", path=copy, **_form_args(title="Trigger Types"))
        assert copy.read_bytes() == before

    def test_unknown_section(self, copy):
        with pytest.raises(ValueError, match="Control and data"):
            testing_mod.append_proven_form("No Such Section", path=copy, **_form_args())

    def test_create_section(self, copy):
        testing_mod.append_proven_form("No Such Section", path=copy, create_section=True,
                                       **_form_args())
        new = copy.read_text(encoding="utf-8")
        assert "\n## No Such Section\n\n### dial step size\n" in new
        parsed = testing_mod.parse_proven_forms(new)
        assert parsed[-1].section == "No Such Section" and parsed[-1].title == "dial step size"

    def test_evidence_tiers_section_refused(self, copy):
        with pytest.raises(ValueError):
            testing_mod.append_proven_form("Evidence tiers", path=copy, **_form_args())

    @pytest.mark.parametrize("evidence", [
        "seen in demo",
        "[maybe] demo v0.1 (2026-10-22)",
        "[confirmed] demo (2026-10-22)",
        "[confirmed] demo v0.2.1",
        "[confirmed] demo v0.2.1; [confirmed] other (2026-10-22)",
    ])
    def test_bad_evidence(self, copy, evidence):
        with pytest.raises(ValueError):
            testing_mod.append_proven_form("UI", path=copy, **_form_args(evidence=evidence))

    def test_good_mixed_evidence(self):
        testing_mod.format_proven_form(**_form_args(
            evidence="[bundle] `C74/help/x.maxhelp`; [confirmed] demo v0.2.1 (2026-10-22)"))

    @pytest.mark.parametrize("field", ["title", "rule", "why", "evidence"])
    @pytest.mark.parametrize("value", ["two\nlines", "# heading", "x <!-- y -->", ""])
    def test_bad_field_text(self, copy, field, value):
        with pytest.raises(ValueError):
            testing_mod.append_proven_form("UI", path=copy, **_form_args(**{field: value}))

    @pytest.mark.parametrize("field", ["title", "rule", "form", "why", "evidence"])
    def test_private_path_in_field(self, field):
        value = "see /Users/someone/x"
        if field == "evidence":
            value = "[observed] see /Users/someone/x"
        with pytest.raises(ValueError):
            testing_mod.format_proven_form(**_form_args(**{field: value}))


class TestLifecycleDocs:
    def test_max_test_doc(self):
        text = MAX_TEST_CMD.read_text(encoding="utf-8")
        assert "record_confirmation(" in text
        assert "proven-forms.md" in text
        assert "-confirmed.md" in text

    def test_lifecycle_skill(self):
        text = LIFECYCLE_SKILL.read_text(encoding="utf-8")
        for frag in ("Confirmation Lifecycle", "record_confirmation",
                     "append_proven_form", "-confirmed.md"):
            assert frag in text, frag
