"""Tests for code validation across GenExpr, js, and N4M domains.

Covers:
- CODE-01: GenExpr validation against gen/objects.json
- CODE-04: N4M validation for MAX API usage
- CODE-05: js validation for handler/outlet consistency
"""

from __future__ import annotations

import pytest


# ---------------------------------------------------------------------------
# TestGenExprValidator -- GenExpr code validation
# ---------------------------------------------------------------------------

class TestGenExprValidator:
    """Tests for GenExpr code validation."""

    def test_valid_genexpr(self):
        """valid code returns no errors."""
        from src.maxpat.code_validation import validate_genexpr

        code = "out1 = in1 * 0.5;"
        results = validate_genexpr(code)

        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_unbalanced_braces(self):
        """detects missing }."""
        from src.maxpat.code_validation import validate_genexpr

        code = "if (in1 > 0) {\n    out1 = in1;"
        results = validate_genexpr(code)

        errors = [r for r in results if r.level == "error"]
        assert any("brace" in r.message.lower() for r in errors)

    def test_unknown_operator(self):
        """'foobar(x)' flagged as unknown."""
        from src.maxpat.code_validation import validate_genexpr

        code = "out1 = foobar(in1);"
        results = validate_genexpr(code)

        errors = [r for r in results if r.level == "error"]
        assert any("foobar" in r.message for r in errors)

    def test_known_operators(self):
        """cycle, phasor, delay, history all pass."""
        from src.maxpat.code_validation import validate_genexpr

        code = "History h(0);\nout1 = cycle(in1, 0);"
        results = validate_genexpr(code)

        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_param_without_range(self):
        """warns on Param without min/max."""
        from src.maxpat.code_validation import validate_genexpr

        code = "Param freq(440);\nout1 = cycle(freq);"
        results = validate_genexpr(code)

        warnings = [r for r in results if r.level == "warning"]
        assert any("min" in r.message.lower() or "max" in r.message.lower() for r in warnings)

    def test_missing_semicolons(self):
        """warns on multi-statement without semicolons."""
        from src.maxpat.code_validation import validate_genexpr

        code = "x = in1 * 2\nout1 = x"
        results = validate_genexpr(code)

        warnings = [r for r in results if r.level == "warning"]
        assert any("semicolon" in r.message.lower() for r in warnings)


# ---------------------------------------------------------------------------
# TestJsValidator -- js object V8 validation
# ---------------------------------------------------------------------------

class TestJsValidator:
    """Tests for js object V8 code validation."""

    def test_valid_js(self):
        """valid code returns no errors."""
        from src.maxpat.code_validation import validate_js

        code = 'inlets = 2;\noutlets = 1;\n\nfunction bang() {\n    outlet(0, "ready");\n}\n'
        results = validate_js(code)

        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_missing_inlets(self):
        """error when inlets declaration missing."""
        from src.maxpat.code_validation import validate_js

        code = 'outlets = 1;\n\nfunction bang() {\n    outlet(0, "ready");\n}\n'
        results = validate_js(code)

        errors = [r for r in results if r.level == "error"]
        assert any("inlets" in r.message.lower() for r in errors)

    def test_missing_outlets(self):
        """error when outlets declaration missing."""
        from src.maxpat.code_validation import validate_js

        code = 'inlets = 1;\n\nfunction bang() {\n    outlet(0, "ready");\n}\n'
        results = validate_js(code)

        errors = [r for r in results if r.level == "error"]
        assert any("outlets" in r.message.lower() for r in errors)

    def test_outlet_index_out_of_bounds(self):
        """outlet(3, ...) with outlets = 2 flagged."""
        from src.maxpat.code_validation import validate_js

        code = 'inlets = 1;\noutlets = 2;\n\nfunction bang() {\n    outlet(3, "oops");\n}\n'
        results = validate_js(code)

        errors = [r for r in results if r.level == "error"]
        assert any("outlet" in r.message.lower() and ("bound" in r.message.lower() or "index" in r.message.lower()) for r in errors)

    def test_no_handlers(self):
        """warns when no handler functions found."""
        from src.maxpat.code_validation import validate_js

        code = 'inlets = 1;\noutlets = 1;\n\nvar x = 5;\n'
        results = validate_js(code)

        warnings = [r for r in results if r.level == "warning"]
        assert any("handler" in r.message.lower() for r in warnings)


# ---------------------------------------------------------------------------
# TestN4MValidator -- Node for Max validation
# ---------------------------------------------------------------------------

class TestN4MValidator:
    """Tests for Node for Max code validation."""

    def test_valid_n4m(self):
        """valid code returns no errors."""
        from src.maxpat.code_validation import validate_n4m

        code = 'const maxAPI = require("max-api");\n\nmaxAPI.addHandler("bang", () => {\n    maxAPI.outlet("done");\n});\n'
        results = validate_n4m(code)

        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_missing_require(self):
        """error when require('max-api') missing."""
        from src.maxpat.code_validation import validate_n4m

        code = 'maxAPI.addHandler("bang", () => {\n    maxAPI.outlet("done");\n});\n'
        results = validate_n4m(code)

        errors = [r for r in results if r.level == "error"]
        assert any("require" in r.message.lower() or "max-api" in r.message.lower() for r in errors)

    def test_no_outlet(self):
        """warns when no maxAPI.outlet() call."""
        from src.maxpat.code_validation import validate_n4m

        code = 'const maxAPI = require("max-api");\n\nmaxAPI.addHandler("bang", () => {\n    maxAPI.post("hello");\n});\n'
        results = validate_n4m(code)

        warnings = [r for r in results if r.level == "warning"]
        assert any("outlet" in r.message.lower() for r in warnings)

    def test_handler_detection(self):
        """detects registered handler names."""
        from src.maxpat.code_validation import validate_n4m

        code = 'const maxAPI = require("max-api");\n\nmaxAPI.addHandler("bang", () => { maxAPI.outlet("x"); });\nmaxAPI.addHandler("set_value", (v) => { maxAPI.outlet(v); });\n'
        results = validate_n4m(code)

        info = [r for r in results if r.level == "info"]
        assert any("bang" in r.message and "set_value" in r.message for r in info)


# ---------------------------------------------------------------------------
# TestDetectJsType -- js type detection
# ---------------------------------------------------------------------------

class TestDetectJsType:
    """Tests for JavaScript type detection."""

    def test_detect_n4m(self):
        """require('max-api') -> 'n4m'."""
        from src.maxpat.code_validation import detect_js_type

        code = 'const maxAPI = require("max-api");\n'
        assert detect_js_type(code) == "n4m"

    def test_detect_js(self):
        """inlets = 2 -> 'js'."""
        from src.maxpat.code_validation import detect_js_type

        code = 'inlets = 2;\noutlets = 1;\n'
        assert detect_js_type(code) == "js"

    def test_detect_unknown(self):
        """neither -> None."""
        from src.maxpat.code_validation import detect_js_type

        code = 'console.log("hello");\n'
        assert detect_js_type(code) is None


# ---------------------------------------------------------------------------
# TestValidateCodeFile -- hook integration tests
# ---------------------------------------------------------------------------

class TestValidateCodeFile:
    """Integration tests for validate_code_file hook."""

    def test_validate_code_file_gendsp(self, tmp_path):
        """validates a .gendsp file."""
        from src.maxpat.hooks import write_gendsp, validate_code_file

        code = "out1 = in1 * 0.5;"
        output_path = tmp_path / "test.gendsp"
        write_gendsp(code, output_path, num_inputs=1, num_outputs=1)

        results = validate_code_file(output_path)
        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_validate_code_file_n4m(self, tmp_path):
        """validates a N4M .js file."""
        from src.maxpat.hooks import validate_code_file

        code = 'const maxAPI = require("max-api");\n\nmaxAPI.addHandler("bang", () => {\n    maxAPI.outlet("done");\n});\n'
        output_path = tmp_path / "test_n4m.js"
        output_path.write_text(code)

        results = validate_code_file(output_path)
        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_validate_code_file_js(self, tmp_path):
        """validates a js .js file."""
        from src.maxpat.hooks import validate_code_file

        code = 'inlets = 1;\noutlets = 1;\n\nfunction bang() {\n    outlet(0, "ready");\n}\n'
        output_path = tmp_path / "test_v8.js"
        output_path.write_text(code)

        results = validate_code_file(output_path)
        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

    def test_validate_code_file_not_found(self):
        """raises FileNotFoundError."""
        from src.maxpat.hooks import validate_code_file

        import pytest
        with pytest.raises(FileNotFoundError):
            validate_code_file("/nonexistent/path/test.js")
