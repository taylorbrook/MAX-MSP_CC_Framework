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
# TestGenExprChecks -- VALID-04 / D-14, D-15, D-16, D-19, D-20
# Three new ERROR-level checks: delay() (Check 7), clip() (Check 8),
# init-before-if/else (Check 9). All severity 'error', no auto-fix.
# ---------------------------------------------------------------------------

class TestGenExprChecks:
    """VALID-04 / D-14, D-15, D-16, D-19, D-20: Three new ERROR-level checks
    in validate_genexpr -- delay() (Check 7), clip() (Check 8),
    init-before-if/else (Check 9). All severity 'error', no auto-fix.
    """

    def test_check7_delay_rejection(self):
        from src.maxpat.code_validation import validate_genexpr
        code = "Delay myDelay(1024);\nout1 = delay(in1, 100);"
        results = validate_genexpr(code)
        delay_errors = [
            r for r in results
            if r.level == "error" and "delay()" in r.message
        ]
        assert len(delay_errors) >= 1
        assert "Delay.read/write" in delay_errors[0].message

    def test_check7_skips_capital_Delay(self):
        """Word-boundary regex must not match Delay() or myDelay.read()."""
        from src.maxpat.code_validation import validate_genexpr
        code = "Delay myDelay(1024);\nout1 = myDelay.read(100);"
        results = validate_genexpr(code)
        delay_errors = [
            r for r in results
            if r.level == "error" and "delay()" in r.message
        ]
        assert delay_errors == [], (
            f"Word-boundary failure -- Delay() or myDelay.read() falsely "
            f"matched: {delay_errors}"
        )

    def test_check8_clip_rejection(self):
        from src.maxpat.code_validation import validate_genexpr
        code = "out1 = clip(in1, 0., 1.);"
        results = validate_genexpr(code)
        clip_errors = [
            r for r in results
            if r.level == "error" and "clip()" in r.message
        ]
        assert len(clip_errors) >= 1
        assert "min(max(x, lo), hi)" in clip_errors[0].message

    def test_check9_init_before_if(self):
        from src.maxpat.code_validation import validate_genexpr
        code = "if (in1 > 0) {\n    y = in1 * 2;\n}\nout1 = y;"
        results = validate_genexpr(code)
        init_errors = [
            r for r in results
            if r.level == "error" and "without prior init" in r.message
        ]
        assert len(init_errors) >= 1
        assert "variable 'y'" in init_errors[0].message

    def test_check9_param_exempt(self):
        """Names declared via Param/History/Delay/Buffer/Data are exempt
        from Check 9 init detection (D-16)."""
        from src.maxpat.code_validation import validate_genexpr
        code = (
            "Param y(0, min=0, max=1);\n"
            "if (in1 > 0) {\n    y = 2;\n}\n"
            "out1 = y;"
        )
        results = validate_genexpr(code)
        init_errors = [
            r for r in results
            if r.level == "error" and "without prior init" in r.message
        ]
        assert init_errors == []

    def test_check9_pre_init_exempt(self):
        """Depth-0 assignment before the if/else block exempts the name."""
        from src.maxpat.code_validation import validate_genexpr
        code = "y = 0;\nif (in1 > 0) {\n    y = 2;\n}\nout1 = y;"
        results = validate_genexpr(code)
        init_errors = [
            r for r in results
            if r.level == "error" and "without prior init" in r.message
        ]
        assert init_errors == []

    def test_checks_skip_comments(self):
        """delay/clip inside // comments must NOT trigger Check 7/8."""
        from src.maxpat.code_validation import validate_genexpr
        code = (
            "// out1 = delay(in1, 100);\n"
            "// out1 = clip(in1, 0, 1);\n"
            "out1 = in1;"
        )
        results = validate_genexpr(code)
        check_7_8 = [
            r for r in results
            if r.level == "error" and (
                "delay()" in r.message or "clip()" in r.message
            )
        ]
        assert check_7_8 == [], (
            f"Comment-stripping failure -- // comments triggered checks: "
            f"{check_7_8}"
        )

    def test_check9_suggestion_documents_limitations(self):
        """D-20: error message includes 'if this is a false positive'."""
        from src.maxpat.code_validation import validate_genexpr
        code = "if (in1 > 0) {\n    y = 2;\n}\nout1 = y;"
        results = validate_genexpr(code)
        init_errors = [
            r for r in results
            if "without prior init" in r.message
        ]
        assert len(init_errors) >= 1
        assert "if this is a false positive" in init_errors[0].message

    def test_check6_ignores_allcaps_comment_banner(self):
        """Check 6 must not treat an ALL-CAPS section-banner word that sits
        before a '(' inside a // comment as a GenExpr operator call. The
        token scan runs over comment-stripped code, so a banner like
        '// === SATURATION (Pade tanh) ===' produces zero operator errors.
        Regression for tape-wobble (DRIFT/EQ/LFO/ROLLOFF/SATURATION/SIGNAL).
        """
        from src.maxpat.code_validation import validate_genexpr
        code = (
            "// === SATURATION (Pade tanh) ===\n"
            "// === HF ROLLOFF (Butterworth LPF) ===\n"
            "out1 = tanh(in1);"
        )
        results = validate_genexpr(code)
        op_errors = [
            r for r in results
            if r.level == "error" and "Unknown GenExpr operator" in r.message
        ]
        assert op_errors == [], (
            f"Comment banner misparsed as GenExpr operator: {op_errors}"
        )

    def test_check9_block_local_assign_before_use(self):
        """A variable assigned then read entirely within the same branch is
        valid GenExpr and must NOT be flagged as used-without-init. The real
        'not defined' error is a READ before any assignment on the taken
        path, not an in-block write. Mirrors the wormhole morph else-block
        (morphL = ...; outL = ... + morphL * blend;). Regression for
        scala-synth-voice, timestretch, wormhole.
        """
        from src.maxpat.code_validation import validate_genexpr
        code = (
            "outL = 0;\n"
            "if (mode < 0.5) {\n"
            "    outL = in1;\n"
            "} else {\n"
            "    morphL = in1 * clamp(in2, 0, 1);\n"
            "    outL = in1 + morphL * 0.5;\n"
            "}\n"
            "out1 = outL;"
        )
        results = validate_genexpr(code)
        init_errors = [
            r for r in results
            if r.level == "error" and "without prior init" in r.message
        ]
        assert init_errors == [], (
            f"Block-local assign-before-use falsely flagged: {init_errors}"
        )

    def test_check9_single_line_if_block_false_negative(self):
        """D-20 documented limitation: single-line `if (cond) { y = 1; }`
        constructs are missed by the line-by-line depth walker.

        The assignment `y = 1` lives on the same line as the `if`, so
        `assign_pattern.match(stripped)` (anchored at start-of-line) sees
        `if`, not `y`, and the inner assignment is silently skipped.
        GenExpr would still error if `y` is later read without prior
        init, so this is a false-negative gap. The depth-walking heuristic
        is brittle by design; documenting the gap here ensures future
        contributors understand the limitation rather than assuming the
        check is exhaustive.
        """
        from src.maxpat.code_validation import validate_genexpr
        # Single-line if-block: walker misses the inner `y = 1` assignment.
        code = "if (in1 > 0) { y = 1; }\nout1 = y;"
        results = validate_genexpr(code)
        init_errors = [
            r for r in results
            if r.level == "error" and "without prior init" in r.message
        ]
        # Documented false-negative: no error emitted even though `y`
        # is used at depth 0 without a tracked init.
        assert init_errors == [], (
            "Check 9 unexpectedly caught single-line if-block init -- "
            "if you've added single-line scanning, update this test."
        )

    def test_severity_contract(self):
        """D-19: Checks 7/8/9 are always level='error', never 'warning'."""
        from src.maxpat.code_validation import validate_genexpr
        code = (
            "out1 = delay(in1, 100);\n"
            "out2 = clip(in1, 0, 1);\n"
            "if (in1 > 0) { z = 1; }\n"
            "out3 = z;"
        )
        results = validate_genexpr(code)
        for r in results:
            if (
                "delay()" in r.message
                or "clip()" in r.message
                or "without prior init" in r.message
            ):
                assert r.level == "error", (
                    f"D-19 violated: check emitted level='{r.level}' "
                    f"instead of 'error': {r.message}"
                )


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

    def test_gendsp_with_delay_blocks(self, tmp_path):
        """VALID-04 round-trip: a .gendsp containing delay( in its codebox
        produces an ERROR ValidationResult via the hooks.validate_code_file
        route -- confirms Check 7 pipes through with no extra wiring.
        """
        import json
        from src.maxpat.hooks import validate_code_file

        gendsp_data = {
            "patcher": {
                "boxes": [
                    {"box": {
                        "maxclass": "codebox",
                        "code": "out1 = delay(in1, 100);"
                    }}
                ]
            }
        }
        path = tmp_path / "test.gendsp"
        path.write_text(json.dumps(gendsp_data))
        results = validate_code_file(path)
        delay_errors = [
            r for r in results
            if r.level == "error" and "delay()" in r.message
        ]
        assert len(delay_errors) >= 1, (
            f"hooks.validate_code_file did not pipe Check 7 through. "
            f"Got: {[r.message for r in results]}"
        )
