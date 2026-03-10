"""Tests for C/C++ external scaffolding, code generation, help patches,
build system integration, and .mxo validation.

Covers requirements EXT-01 through EXT-05:
- Three Min-DevKit C++ archetypes (message, DSP, scheduler)
- CMakeLists.txt generation with correct min-api paths
- External project scaffolding (directory structure)
- Help patch generation (.maxhelp valid JSON)
- Build invocation with auto-fix loop (EXT-05)
- .mxo Mach-O arm64 validation (EXT-05)
"""

import json
from pathlib import Path
from unittest.mock import patch, MagicMock

import pytest


# ── Task 1: C++ template tests ──────────────────────────────────────────


class TestMessageArchetype:
    """Message/data archetype renders valid Min-DevKit C++."""

    def test_message_archetype_has_include(self):
        from src.maxpat.ext_templates import render_message_template

        code = render_message_template(
            name="my_processor",
            description="A data processor",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang", "number"],
        )
        assert '#include "c74_min.h"' in code

    def test_message_archetype_has_inlet_outlet(self):
        from src.maxpat.ext_templates import render_message_template

        code = render_message_template(
            name="my_processor",
            description="A data processor",
            inlets=[
                {"comment": "(anything) input"},
                {"comment": "(int) secondary"},
            ],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang"],
        )
        assert "inlet<>" in code
        assert "outlet<>" in code

    def test_message_archetype_has_message_handlers(self):
        from src.maxpat.ext_templates import render_message_template

        code = render_message_template(
            name="my_processor",
            description="A data processor",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang", "number", "list"],
        )
        assert "message<>" in code
        assert "MIN_FUNCTION" in code
        # Each handler name should appear
        assert '"bang"' in code
        assert '"number"' in code
        assert '"list"' in code

    def test_message_archetype_has_min_external(self):
        from src.maxpat.ext_templates import render_message_template

        code = render_message_template(
            name="my_processor",
            description="A data processor",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang"],
        )
        assert "MIN_EXTERNAL(my_processor)" in code

    def test_message_custom_handlers(self):
        from src.maxpat.ext_templates import render_message_template

        code = render_message_template(
            name="my_tool",
            description="Custom tool",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang", "anything", "dictionary"],
        )
        assert '"anything"' in code
        assert '"dictionary"' in code

    def test_message_archetype_has_description(self):
        from src.maxpat.ext_templates import render_message_template

        code = render_message_template(
            name="my_processor",
            description="A custom data processor",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang"],
        )
        assert "A custom data processor" in code
        assert "MIN_DESCRIPTION" in code


class TestDSPArchetype:
    """DSP/signal archetype renders valid Min-DevKit C++."""

    def test_dsp_archetype_has_sample_operator(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A simple filter",
            num_inputs=1,
            num_outputs=1,
            params=[],
        )
        assert "sample_operator<1, 1>" in code

    def test_dsp_archetype_has_operator_perform(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A simple filter",
            num_inputs=1,
            num_outputs=1,
            params=[],
        )
        assert "operator()" in code
        assert "samples<1>" in code

    def test_dsp_archetype_has_signal_outlets(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A simple filter",
            num_inputs=2,
            num_outputs=2,
            params=[],
        )
        assert '"signal"' in code
        assert "sample_operator<2, 2>" in code

    def test_dsp_archetype_has_min_external(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A simple filter",
            num_inputs=1,
            num_outputs=1,
            params=[],
        )
        assert "MIN_EXTERNAL(my_filter)" in code

    def test_dsp_params(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A filter with params",
            num_inputs=1,
            num_outputs=1,
            params=[
                {"name": "cutoff", "default": 1000.0, "min": 20.0, "max": 20000.0},
                {"name": "resonance", "default": 0.5, "min": 0.0, "max": 1.0},
            ],
        )
        assert "attribute<" in code
        assert "cutoff" in code
        assert "resonance" in code

    def test_dsp_archetype_has_dspsetup(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A simple filter",
            num_inputs=1,
            num_outputs=1,
            params=[],
        )
        assert "dspsetup" in code

    def test_dsp_archetype_has_audio_tags(self):
        from src.maxpat.ext_templates import render_dsp_template

        code = render_dsp_template(
            name="my_filter",
            description="A simple filter",
            num_inputs=1,
            num_outputs=1,
            params=[],
        )
        assert '"audio"' in code
        assert "MIN_TAGS" in code


class TestSchedulerArchetype:
    """Scheduler archetype renders valid Min-DevKit C++."""

    def test_scheduler_archetype_has_timer(self):
        from src.maxpat.ext_templates import render_scheduler_template

        code = render_scheduler_template(
            name="my_metro",
            description="A metronome",
            interval_default=500.0,
            attributes=[],
        )
        assert "timer<>" in code

    def test_scheduler_archetype_has_interval_attribute(self):
        from src.maxpat.ext_templates import render_scheduler_template

        code = render_scheduler_template(
            name="my_metro",
            description="A metronome",
            interval_default=500.0,
            attributes=[],
        )
        assert "attribute<" in code
        assert "interval" in code
        assert "500.0" in code

    def test_scheduler_archetype_has_toggle(self):
        from src.maxpat.ext_templates import render_scheduler_template

        code = render_scheduler_template(
            name="my_metro",
            description="A metronome",
            interval_default=500.0,
            attributes=[],
        )
        # Toggle message for start/stop (int message)
        assert '"int"' in code
        assert "MIN_FUNCTION" in code

    def test_scheduler_archetype_has_min_external(self):
        from src.maxpat.ext_templates import render_scheduler_template

        code = render_scheduler_template(
            name="my_metro",
            description="A metronome",
            interval_default=500.0,
            attributes=[],
        )
        assert "MIN_EXTERNAL(my_metro)" in code

    def test_scheduler_additional_attributes(self):
        from src.maxpat.ext_templates import render_scheduler_template

        code = render_scheduler_template(
            name="my_metro",
            description="A metronome",
            interval_default=500.0,
            attributes=[
                {"name": "probability", "type": "double", "default": 1.0, "min": 0.0, "max": 1.0},
            ],
        )
        assert "probability" in code

    def test_scheduler_has_time_tags(self):
        from src.maxpat.ext_templates import render_scheduler_template

        code = render_scheduler_template(
            name="my_metro",
            description="A metronome",
            interval_default=500.0,
            attributes=[],
        )
        assert '"time"' in code
        assert "MIN_TAGS" in code


class TestCMakeGeneration:
    """CMakeLists.txt template generates correct build configuration."""

    def test_cmake_has_minimum_version(self):
        from src.maxpat.ext_templates import render_cmake_template

        cmake = render_cmake_template("my_ext")
        assert "cmake_minimum_required(VERSION 3.19)" in cmake

    def test_cmake_has_min_api_dir(self):
        from src.maxpat.ext_templates import render_cmake_template

        cmake = render_cmake_template("my_ext")
        assert "min-devkit/source/min-api" in cmake

    def test_cmake_has_pretarget(self):
        from src.maxpat.ext_templates import render_cmake_template

        cmake = render_cmake_template("my_ext")
        assert "min-pretarget.cmake" in cmake

    def test_cmake_has_posttarget(self):
        from src.maxpat.ext_templates import render_cmake_template

        cmake = render_cmake_template("my_ext")
        assert "min-posttarget.cmake" in cmake

    def test_cmake_has_module_library(self):
        from src.maxpat.ext_templates import render_cmake_template

        cmake = render_cmake_template("my_ext")
        assert "add_library" in cmake
        assert "MODULE" in cmake

    def test_cmake_has_source_file(self):
        from src.maxpat.ext_templates import render_cmake_template

        cmake = render_cmake_template("my_ext")
        assert "source/" in cmake
        assert ".cpp" in cmake


class TestAllTemplatesCommon:
    """Cross-cutting checks: all templates include c74_min.h and MIN_EXTERNAL."""

    def test_all_templates_include_c74_min(self):
        from src.maxpat.ext_templates import (
            render_message_template,
            render_dsp_template,
            render_scheduler_template,
        )

        msg = render_message_template("t1", "d", [{"comment": "in"}], [{"comment": "out"}], ["bang"])
        dsp = render_dsp_template("t2", "d", 1, 1, [])
        sch = render_scheduler_template("t3", "d", 500.0, [])

        for code in [msg, dsp, sch]:
            assert '#include "c74_min.h"' in code, f"Missing c74_min.h in:\n{code[:200]}"

    def test_all_templates_have_min_external(self):
        from src.maxpat.ext_templates import (
            render_message_template,
            render_dsp_template,
            render_scheduler_template,
        )

        msg = render_message_template("t1", "d", [{"comment": "in"}], [{"comment": "out"}], ["bang"])
        dsp = render_dsp_template("t2", "d", 1, 1, [])
        sch = render_scheduler_template("t3", "d", 500.0, [])

        assert "MIN_EXTERNAL(t1)" in msg
        assert "MIN_EXTERNAL(t2)" in dsp
        assert "MIN_EXTERNAL(t3)" in sch

    def test_all_templates_use_namespace(self):
        from src.maxpat.ext_templates import (
            render_message_template,
            render_dsp_template,
            render_scheduler_template,
        )

        msg = render_message_template("t1", "d", [{"comment": "in"}], [{"comment": "out"}], ["bang"])
        dsp = render_dsp_template("t2", "d", 1, 1, [])
        sch = render_scheduler_template("t3", "d", 500.0, [])

        for code in [msg, dsp, sch]:
            assert "using namespace c74::min;" in code


class TestTestTemplate:
    """Test template generates basic Catch2 scaffold."""

    def test_test_template_has_catch(self):
        from src.maxpat.ext_templates import render_test_template

        code = render_test_template("my_ext")
        assert "TEST_CASE" in code
        assert "my_ext" in code


# ── Task 2: External scaffolding and help patch tests ────────────────────


class TestScaffoldStructure:
    """scaffold_external creates correct Min-DevKit directory structure."""

    def test_scaffold_structure(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        result = scaffold_external(
            project_dir=tmp_path,
            name="my_ext",
            archetype="message",
            description="A test external",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang"],
        )
        root = tmp_path / "my_ext"
        assert root.exists()
        assert (root / "source").is_dir()
        assert (root / "help").is_dir()
        assert (root / "CMakeLists.txt").is_file()

    def test_scaffold_message(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        result = scaffold_external(
            project_dir=tmp_path,
            name="msg_ext",
            archetype="message",
            description="Message processor",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang", "number"],
        )
        cpp_file = tmp_path / "msg_ext" / "source" / "msg_ext.cpp"
        assert cpp_file.is_file()
        code = cpp_file.read_text()
        assert '#include "c74_min.h"' in code
        assert "message<>" in code
        assert "MIN_EXTERNAL(msg_ext)" in code

    def test_scaffold_dsp(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        result = scaffold_external(
            project_dir=tmp_path,
            name="dsp_ext",
            archetype="dsp",
            description="Audio processor",
            num_inputs=1,
            num_outputs=1,
            params=[],
        )
        cpp_file = tmp_path / "dsp_ext" / "source" / "dsp_ext.cpp"
        assert cpp_file.is_file()
        code = cpp_file.read_text()
        assert "sample_operator" in code
        assert "operator()" in code

    def test_scaffold_scheduler(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        result = scaffold_external(
            project_dir=tmp_path,
            name="sched_ext",
            archetype="scheduler",
            description="Timer external",
            interval_default=250.0,
            attributes=[],
        )
        cpp_file = tmp_path / "sched_ext" / "source" / "sched_ext.cpp"
        assert cpp_file.is_file()
        code = cpp_file.read_text()
        assert "timer<>" in code
        assert "250.0" in code

    def test_scaffold_returns_paths(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        result = scaffold_external(
            project_dir=tmp_path,
            name="my_ext",
            archetype="message",
            description="Test",
            inlets=[{"comment": "in"}],
            outlets=[{"comment": "out"}],
            handlers=["bang"],
        )
        assert "root" in result
        assert "source" in result
        assert "cmake" in result
        assert "help" in result
        # All paths should exist
        for key in ("root", "source", "cmake", "help"):
            assert result[key].exists(), f"{key} path does not exist: {result[key]}"

    def test_scaffold_invalid_archetype(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        with pytest.raises(ValueError, match="archetype"):
            scaffold_external(
                project_dir=tmp_path,
                name="bad_ext",
                archetype="unknown",
                description="Bad",
            )


class TestHelpPatch:
    """Help patch generation produces valid .maxpat JSON."""

    def test_help_patch_valid_json(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        scaffold_external(
            project_dir=tmp_path,
            name="help_test",
            archetype="message",
            description="Help test",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang"],
        )
        help_file = tmp_path / "help_test" / "help" / "help_test.maxhelp"
        assert help_file.is_file()
        data = json.loads(help_file.read_text())
        assert "patcher" in data
        assert "boxes" in data["patcher"]

    def test_help_patch_contains_external(self, tmp_path):
        from src.maxpat.externals import scaffold_external

        scaffold_external(
            project_dir=tmp_path,
            name="ext_in_help",
            archetype="message",
            description="Test external",
            inlets=[{"comment": "(anything) input"}],
            outlets=[{"comment": "(anything) output"}],
            handlers=["bang"],
        )
        help_file = tmp_path / "ext_in_help" / "help" / "ext_in_help.maxhelp"
        data = json.loads(help_file.read_text())
        # The external's name should appear in one of the box texts
        box_texts = [
            b["box"].get("text", "")
            for b in data["patcher"]["boxes"]
        ]
        assert any("ext_in_help" in t for t in box_texts), (
            f"External name not found in help patch boxes: {box_texts}"
        )


class TestGenerateExternalCode:
    """generate_external_code returns C++ string without file I/O."""

    def test_generate_external_code(self):
        from src.maxpat.externals import generate_external_code

        code = generate_external_code(
            name="code_gen_test",
            archetype="message",
            description="Test",
            inlets=[{"comment": "in"}],
            outlets=[{"comment": "out"}],
            handlers=["bang"],
        )
        assert isinstance(code, str)
        assert '#include "c74_min.h"' in code
        assert "MIN_EXTERNAL(code_gen_test)" in code

    def test_generate_external_code_dsp(self):
        from src.maxpat.externals import generate_external_code

        code = generate_external_code(
            name="dsp_gen",
            archetype="dsp",
            description="DSP test",
            num_inputs=2,
            num_outputs=2,
            params=[],
        )
        assert "sample_operator<2, 2>" in code

    def test_generate_external_code_scheduler(self):
        from src.maxpat.externals import generate_external_code

        code = generate_external_code(
            name="sched_gen",
            archetype="scheduler",
            description="Scheduler test",
            interval_default=100.0,
            attributes=[],
        )
        assert "timer<>" in code


# ── Plan 03 Task 1: .mxo validation, BuildResult, parse_compiler_errors ──


class TestBuildResult:
    """BuildResult dataclass captures build outcomes."""

    def test_build_result_success(self):
        from src.maxpat.ext_validation import BuildResult

        result = BuildResult(
            success=True,
            mxo_path=Path("/tmp/test.mxo"),
            errors=[],
            attempts=1,
            message="Build successful",
        )
        assert result.success is True
        assert result.mxo_path == Path("/tmp/test.mxo")
        assert result.errors == []
        assert result.attempts == 1
        assert result.message == "Build successful"

    def test_build_result_failure(self):
        from src.maxpat.ext_validation import BuildResult

        result = BuildResult(
            success=False,
            mxo_path=None,
            errors=["error: unknown type", "error: missing semicolon"],
            attempts=3,
            message="Build failed after 3 attempts",
        )
        assert result.success is False
        assert result.mxo_path is None
        assert len(result.errors) == 2
        assert result.attempts == 3


class TestMxoValidation:
    """validate_mxo checks .mxo bundle structure and Mach-O type."""

    def test_mxo_validation_not_found(self, tmp_path):
        from src.maxpat.ext_validation import validate_mxo

        nonexistent = tmp_path / "nonexistent.mxo"
        valid, msg = validate_mxo(nonexistent)
        assert valid is False
        assert "not" in msg.lower() or "exist" in msg.lower() or "mxo" in msg.lower()

    def test_mxo_validation_no_binary(self, tmp_path):
        from src.maxpat.ext_validation import validate_mxo

        # Create .mxo dir but no Contents/MacOS/binary
        mxo_dir = tmp_path / "test.mxo"
        mxo_dir.mkdir()
        valid, msg = validate_mxo(mxo_dir)
        assert valid is False
        assert "binary" in msg.lower() or "not found" in msg.lower() or "contents" in msg.lower()

    def test_mxo_validation_wrong_suffix(self, tmp_path):
        from src.maxpat.ext_validation import validate_mxo

        bad = tmp_path / "test.dylib"
        bad.mkdir()
        valid, msg = validate_mxo(bad)
        assert valid is False

    def test_mxo_validation_with_mock_binary(self, tmp_path):
        """Mock subprocess to simulate valid Mach-O binary check."""
        from src.maxpat.ext_validation import validate_mxo

        # Create mock .mxo bundle structure
        mxo_dir = tmp_path / "test.mxo"
        binary_dir = mxo_dir / "Contents" / "MacOS"
        binary_dir.mkdir(parents=True)
        binary = binary_dir / "test"
        binary.write_bytes(b"\xcf\xfa\xed\xfe")  # mock binary

        file_result = MagicMock()
        file_result.stdout = "test: Mach-O 64-bit bundle arm64"
        file_result.returncode = 0

        lipo_result = MagicMock()
        lipo_result.stdout = "Non-fat file: test is architecture: arm64"
        lipo_result.returncode = 0

        with patch("subprocess.run", side_effect=[file_result, lipo_result]):
            valid, msg = validate_mxo(mxo_dir)
            assert valid is True
            assert "arm64" in msg.lower() or "valid" in msg.lower()

    def test_mxo_validation_not_macho(self, tmp_path):
        """Mock file command returning non-Mach-O result."""
        from src.maxpat.ext_validation import validate_mxo

        mxo_dir = tmp_path / "test.mxo"
        binary_dir = mxo_dir / "Contents" / "MacOS"
        binary_dir.mkdir(parents=True)
        binary = binary_dir / "test"
        binary.write_bytes(b"not a binary")

        file_result = MagicMock()
        file_result.stdout = "test: ASCII text"
        file_result.returncode = 0

        with patch("subprocess.run", return_value=file_result):
            valid, msg = validate_mxo(mxo_dir)
            assert valid is False
            assert "mach-o" in msg.lower() or "not" in msg.lower()

    def test_mxo_validation_wrong_arch(self, tmp_path):
        """Mock lipo command returning x86_64 instead of arm64."""
        from src.maxpat.ext_validation import validate_mxo

        mxo_dir = tmp_path / "test.mxo"
        binary_dir = mxo_dir / "Contents" / "MacOS"
        binary_dir.mkdir(parents=True)
        binary = binary_dir / "test"
        binary.write_bytes(b"\xcf\xfa\xed\xfe")

        file_result = MagicMock()
        file_result.stdout = "test: Mach-O 64-bit bundle x86_64"
        file_result.returncode = 0

        lipo_result = MagicMock()
        lipo_result.stdout = "Non-fat file: test is architecture: x86_64"
        lipo_result.returncode = 0

        with patch("subprocess.run", side_effect=[file_result, lipo_result]):
            valid, msg = validate_mxo(mxo_dir)
            assert valid is False
            assert "arm64" in msg.lower() or "x86_64" in msg.lower()


class TestParseCompilerErrors:
    """parse_compiler_errors extracts structured error info from gcc/clang output."""

    def test_parse_compiler_errors(self):
        from src.maxpat.ext_validation import parse_compiler_errors

        stderr = (
            "/source/my_ext.cpp:15:10: error: unknown type name 'inlet'\n"
            "/source/my_ext.cpp:22:5: warning: unused variable 'x'\n"
        )
        errors = parse_compiler_errors(stderr)
        assert len(errors) == 2
        assert errors[0]["file"] == "/source/my_ext.cpp"
        assert errors[0]["line"] == 15
        assert errors[0]["column"] == 10
        assert errors[0]["severity"] == "error"
        assert "unknown type" in errors[0]["message"]
        assert errors[1]["severity"] == "warning"
        assert errors[1]["line"] == 22

    def test_parse_compiler_errors_empty(self):
        from src.maxpat.ext_validation import parse_compiler_errors

        errors = parse_compiler_errors("")
        assert errors == []

    def test_parse_compiler_errors_no_matches(self):
        from src.maxpat.ext_validation import parse_compiler_errors

        errors = parse_compiler_errors("Build succeeded.\nDone.")
        assert errors == []

    def test_parse_compiler_errors_fatal_error(self):
        from src.maxpat.ext_validation import parse_compiler_errors

        stderr = "/source/my_ext.cpp:1:10: fatal error: 'c74_min.h' file not found\n"
        errors = parse_compiler_errors(stderr)
        assert len(errors) == 1
        assert errors[0]["severity"] == "fatal error"
        assert "c74_min.h" in errors[0]["message"]
