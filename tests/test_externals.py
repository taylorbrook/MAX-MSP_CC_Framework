"""Tests for C/C++ external scaffolding, code generation, and help patches.

Covers requirements EXT-01 through EXT-04:
- Three Min-DevKit C++ archetypes (message, DSP, scheduler)
- CMakeLists.txt generation with correct min-api paths
- External project scaffolding (directory structure)
- Help patch generation (.maxhelp valid JSON)
"""

import json

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
