"""Smoke tests for src/maxpat/ext_templates.py Min-DevKit template renderers.

Assertions pin substring presence, not full-text equality, so incidental
formatting changes don't break the suite.
"""

from src.maxpat.ext_templates import (
    render_cmake_template,
    render_dsp_template,
    render_message_template,
    render_scheduler_template,
    render_test_template,
)


class TestMessageTemplate:
    def test_contains_name_and_min_devkit_class_decl(self):
        src = render_message_template(
            name="myext",
            description="A test external",
            inlets=[{"comment": "input"}],
            outlets=[{"comment": "output"}],
            handlers=["bang", "list"],
        )
        assert src
        assert "myext" in src
        assert "public object<" in src
        assert "MIN_EXTERNAL(myext);" in src

    def test_handlers_rendered(self):
        src = render_message_template(
            name="myext", description="d",
            inlets=[{}], outlets=[{}], handlers=["bang"],
        )
        assert '"bang"' in src
        assert "MIN_FUNCTION" in src


class TestDspTemplate:
    def test_contains_name_and_sample_operator_io(self):
        src = render_dsp_template(
            name="mydsp",
            description="A DSP external",
            num_inputs=2,
            num_outputs=2,
            params=[{"name": "gain", "default": 0.5, "min": 0.0, "max": 1.0}],
        )
        assert src
        assert "mydsp" in src
        assert "public object<" in src
        assert "sample_operator<2, 2>" in src
        assert "samples<2>" in src
        assert '"gain"' in src

    def test_mono_io_embedded(self):
        src = render_dsp_template(
            name="mono", description="d",
            num_inputs=1, num_outputs=1, params=[],
        )
        assert "sample_operator<1, 1>" in src


class TestSchedulerTemplate:
    def test_contains_name_timer_and_interval(self):
        src = render_scheduler_template(
            name="mytick",
            description="A scheduler external",
            interval_default=250.0,
            attributes=[],
        )
        assert src
        assert "mytick" in src
        assert "public object<" in src
        assert "timer<>" in src
        assert "250.0" in src


class TestCmakeTemplate:
    def test_returns_min_devkit_cmake_scaffold(self):
        # Note: the CMake template derives the project name from the
        # directory (get_filename_component) rather than embedding the
        # name argument -- pin that actual behavior.
        src = render_cmake_template("myext")
        assert src
        assert "min-api" in src
        assert "add_library(${PROJECT_NAME} MODULE ${SOURCE_FILES})" in src
        assert "min-pretarget.cmake" in src


class TestTestTemplate:
    def test_contains_name_and_catch2_scaffold(self):
        src = render_test_template("myext")
        assert src
        assert "myext" in src
        assert '#include "myext.cpp"' in src
        assert "TEST_CASE" in src
