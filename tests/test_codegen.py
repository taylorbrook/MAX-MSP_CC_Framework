"""Tests for GenExpr code builder, gen~ codebox embedding, and .gendsp generation.

Covers:
- CODE-01: GenExpr code generation with correct syntax
- CODE-02: gen~ codebox objects embedded correctly in .maxpat
- CODE-03: Standalone .gendsp file generation
"""

from __future__ import annotations

import json
import copy
from pathlib import Path

import pytest


# ---------------------------------------------------------------------------
# TestGenExpr -- parse_genexpr_io and build_genexpr
# ---------------------------------------------------------------------------

class TestGenExpr:
    """Tests for GenExpr code parsing and building (CODE-01)."""

    def test_parse_genexpr_io_no_inputs(self):
        """Code with no in references returns 0 inputs."""
        from src.maxpat.codegen import parse_genexpr_io

        code = "out1 = noise();"
        inputs, outputs = parse_genexpr_io(code)
        assert inputs == 0
        assert outputs == 1

    def test_parse_genexpr_io_one_input(self):
        """Code with in1 returns 1 input."""
        from src.maxpat.codegen import parse_genexpr_io

        code = "out1 = in1 * 0.5;"
        inputs, outputs = parse_genexpr_io(code)
        assert inputs == 1
        assert outputs == 1

    def test_parse_genexpr_io_two_inputs(self):
        """Code with in1 and in2 returns 2 inputs."""
        from src.maxpat.codegen import parse_genexpr_io

        code = "out1 = in1 + in2;"
        inputs, outputs = parse_genexpr_io(code)
        assert inputs == 2
        assert outputs == 1

    def test_parse_genexpr_io_three_outputs(self):
        """Code with out1, out2, out3 returns 3 outputs."""
        from src.maxpat.codegen import parse_genexpr_io

        code = "out1 = in1;\nout2 = in1 * 0.5;\nout3 = in1 * 0.25;"
        inputs, outputs = parse_genexpr_io(code)
        assert inputs == 1
        assert outputs == 3

    def test_parse_genexpr_io_no_io(self):
        """Code with no in/out returns (0, 0)."""
        from src.maxpat.codegen import parse_genexpr_io

        code = "// comment only"
        inputs, outputs = parse_genexpr_io(code)
        assert inputs == 0
        assert outputs == 0

    def test_parse_genexpr_io_ignores_variable_names(self):
        """Variables like 'index' or 'input' should NOT match in/out patterns."""
        from src.maxpat.codegen import parse_genexpr_io

        code = "index = 5;\ninput = 3;\nout1 = index + input;"
        inputs, outputs = parse_genexpr_io(code)
        assert inputs == 0
        assert outputs == 1

    def test_build_genexpr_with_params(self):
        """build_genexpr produces formatted GenExpr with Param declarations."""
        from src.maxpat.codegen import build_genexpr

        params = [
            {"name": "freq", "default": 440, "min": 20, "max": 20000},
            {"name": "amp", "default": 0.5, "min": 0, "max": 1},
        ]
        code_body = "osc_signal = cycle(freq);\nout1 = osc_signal * amp;"
        result = build_genexpr(params, code_body)

        # Must contain section headers
        assert "// ===" in result
        # Must contain Param declarations with full range specs
        assert "Param freq(440, min=20, max=20000);" in result
        assert "Param amp(0.5, min=0, max=1);" in result
        # Must contain the code body
        assert "osc_signal = cycle(freq);" in result
        assert "out1 = osc_signal * amp;" in result

    def test_build_genexpr_no_params(self):
        """build_genexpr with empty params omits PARAMETERS section."""
        from src.maxpat.codegen import build_genexpr

        code_body = "out1 = in1 * 0.5;"
        result = build_genexpr([], code_body)

        assert "Param" not in result
        assert "out1 = in1 * 0.5;" in result

    def test_build_genexpr_returns_string(self):
        """build_genexpr returns a string type."""
        from src.maxpat.codegen import build_genexpr

        result = build_genexpr([], "out1 = in1;")
        assert isinstance(result, str)


# ---------------------------------------------------------------------------
# TestGendsp -- generate_gendsp
# ---------------------------------------------------------------------------

class TestGendsp:
    """Tests for .gendsp file structure generation (CODE-03)."""

    def test_generate_gendsp_structure(self):
        """generate_gendsp returns dict with 'patcher' top-level key."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        assert "patcher" in result
        patcher = result["patcher"]
        assert "boxes" in patcher
        assert "lines" in patcher

    def test_generate_gendsp_box_count(self):
        """1 input + codebox + 1 output = 3 boxes."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        boxes = result["patcher"]["boxes"]
        assert len(boxes) == 3  # in + codebox + out

    def test_generate_gendsp_patchlines(self):
        """1 input, 1 output: 2 patchlines (in->codebox, codebox->out)."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        lines = result["patcher"]["lines"]
        assert len(lines) == 2

    def test_generate_gendsp_multi_io(self):
        """2 inputs, 2 outputs: 6 boxes (2 in + codebox + 2 out), 4 patchlines."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 + in2;\nout2 = in1 - in2;"
        result = generate_gendsp(code, num_inputs=2, num_outputs=2)

        boxes = result["patcher"]["boxes"]
        assert len(boxes) == 5  # 2 in + codebox + 2 out

        lines = result["patcher"]["lines"]
        assert len(lines) == 4  # 2 in->codebox + 2 codebox->out

    def test_generate_gendsp_autodetect_io(self):
        """When num_inputs/num_outputs are None, auto-detect from code."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;\nout2 = in1 * 0.25;"
        result = generate_gendsp(code)

        boxes = result["patcher"]["boxes"]
        # 1 input + codebox + 2 outputs = 4 boxes
        assert len(boxes) == 4

    def test_generate_gendsp_codebox_has_code(self):
        """Codebox box inside .gendsp has 'code' attribute."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        # Find the codebox
        codebox = None
        for box_wrapper in result["patcher"]["boxes"]:
            box = box_wrapper["box"]
            if box["maxclass"] == "codebox":
                codebox = box
                break

        assert codebox is not None
        assert codebox["code"] == code

    def test_generate_gendsp_bgcolor(self):
        """Gen patcher has the correct bgcolor."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        assert result["patcher"]["bgcolor"] == [0.9, 0.9, 0.9, 1.0]

    def test_generate_gendsp_in_objects(self):
        """in objects have maxclass 'newobj', numinlets=0, numoutlets=1."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        in_box = None
        for box_wrapper in result["patcher"]["boxes"]:
            box = box_wrapper["box"]
            if box.get("text") == "in 1":
                in_box = box
                break

        assert in_box is not None
        assert in_box["maxclass"] == "newobj"
        assert in_box["numinlets"] == 0
        assert in_box["numoutlets"] == 1

    def test_generate_gendsp_out_objects(self):
        """out objects have maxclass 'newobj', numinlets=1, numoutlets=0."""
        from src.maxpat.codegen import generate_gendsp

        code = "out1 = in1 * 0.5;"
        result = generate_gendsp(code, num_inputs=1, num_outputs=1)

        out_box = None
        for box_wrapper in result["patcher"]["boxes"]:
            box = box_wrapper["box"]
            if box.get("text") == "out 1":
                out_box = box
                break

        assert out_box is not None
        assert out_box["maxclass"] == "newobj"
        assert out_box["numinlets"] == 1
        assert out_box["numoutlets"] == 0


# ---------------------------------------------------------------------------
# TestMaxclassFix -- gen~ in UI_MAXCLASSES
# ---------------------------------------------------------------------------

class TestMaxclassFix:
    """Tests for gen~ maxclass resolution fix."""

    def test_resolve_maxclass_gen(self):
        """resolve_maxclass('gen~') returns 'gen~' (not 'newobj')."""
        from src.maxpat.maxclass_map import resolve_maxclass

        assert resolve_maxclass("gen~") == "gen~"

    def test_gen_in_ui_maxclasses(self):
        """gen~ is in the UI_MAXCLASSES set."""
        from src.maxpat.maxclass_map import UI_MAXCLASSES

        assert "gen~" in UI_MAXCLASSES


# ---------------------------------------------------------------------------
# TestGenBox -- add_gen method on Patcher (CODE-02)
# ---------------------------------------------------------------------------

class TestGenBox:
    """Tests for gen~ codebox embedding in Patcher (CODE-02)."""

    def test_add_gen_creates_box(self):
        """add_gen returns (Box, Patcher) tuple, outer box maxclass is 'gen~'."""
        from src.maxpat.patcher import Patcher, Box

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        assert isinstance(box, Box)
        assert isinstance(inner, Patcher)
        assert box.maxclass == "gen~"

    def test_add_gen_outer_box_io(self):
        """Outer gen~ box has correct numinlets, numoutlets, outlettype."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 + in2;"
        box, inner = p.add_gen(code, num_inputs=2, num_outputs=1)

        assert box.numinlets == 2
        assert box.numoutlets == 1
        assert box.outlettype == ["signal"]

    def test_add_gen_multi_output_signal(self):
        """Multi-output gen~ has all signal outlets."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1;\nout2 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=2)

        assert box.numoutlets == 2
        assert box.outlettype == ["signal", "signal"]

    def test_add_gen_inner_patcher(self):
        """Inner patcher has codebox + in + out objects."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        # inner should have 3 boxes: in 1, codebox, out 1
        assert len(inner.boxes) == 3

        maxclasses = [b.maxclass for b in inner.boxes]
        assert "codebox" in maxclasses

    def test_add_gen_patchlines(self):
        """Inner patcher has correct patchlines: in->codebox->out."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        # 2 patchlines: in->codebox, codebox->out
        assert len(inner.lines) == 2

    def test_add_gen_io_autodetect(self):
        """Code with in1 and out1 auto-detects 1 input, 1 output."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code)

        assert box.numinlets == 1
        assert box.numoutlets == 1

    def test_add_gen_multi_io_autodetect(self):
        """Code with in1, in2 and out1, out2 auto-detects correctly."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 + in2;\nout2 = in1 - in2;"
        box, inner = p.add_gen(code)

        assert box.numinlets == 2
        assert box.numoutlets == 2

    def test_add_gen_serialization(self):
        """to_dict() produces valid gen~ JSON structure with nested patcher."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        d = box.to_dict()
        assert d["box"]["maxclass"] == "gen~"
        assert "patcher" in d["box"]
        assert "boxes" in d["box"]["patcher"]
        assert "lines" in d["box"]["patcher"]

    def test_add_gen_codebox_in_serialization(self):
        """Serialized inner patcher contains codebox with 'code' attribute."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        d = box.to_dict()
        inner_boxes = d["box"]["patcher"]["boxes"]

        codebox = None
        for bw in inner_boxes:
            if bw["box"]["maxclass"] == "codebox":
                codebox = bw["box"]
                break

        assert codebox is not None
        assert codebox["code"] == code

    def test_add_gen_generate_patch(self):
        """Full pipeline: add_gen + generate_patch produces valid .maxpat."""
        from src.maxpat.patcher import Patcher
        from src.maxpat import generate_patch

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        # Add dac~ so patch is complete
        dac = p.add_box("dac~")
        p.add_connection(box, 0, dac, 0)

        patch_dict, results = generate_patch(p)

        assert "patcher" in patch_dict
        # Find the gen~ box in serialized output
        gen_boxes = [
            b for b in patch_dict["patcher"]["boxes"]
            if b["box"]["maxclass"] == "gen~"
        ]
        assert len(gen_boxes) == 1
        assert "patcher" in gen_boxes[0]["box"]

    def test_add_gen_zero_inputs(self):
        """Generator with no inputs (pure oscillator) creates gen~ with 0 inlets."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "Param freq(440, min=20, max=20000);\nout1 = cycle(freq);"
        box, inner = p.add_gen(code, num_inputs=0, num_outputs=1)

        assert box.numinlets == 0
        assert box.numoutlets == 1

    def test_add_gen_in_patcher_boxes(self):
        """add_gen appends the gen~ box to the patcher's boxes list."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        code = "out1 = in1 * 0.5;"
        box, inner = p.add_gen(code, num_inputs=1, num_outputs=1)

        assert box in p.boxes


# ---------------------------------------------------------------------------
# TestGendspFile -- .gendsp file write support (CODE-03 integration)
# ---------------------------------------------------------------------------

class TestGendspFile:
    """Tests for .gendsp file write and integration."""

    def test_write_gendsp_creates_file(self, tmp_path):
        """write_gendsp creates a .gendsp file on disk."""
        from src.maxpat.hooks import write_gendsp

        code = "out1 = in1 * 0.5;"
        output_path = tmp_path / "test.gendsp"

        write_gendsp(code, output_path, num_inputs=1, num_outputs=1)

        assert output_path.exists()

    def test_write_gendsp_valid_json(self, tmp_path):
        """Written .gendsp file is valid JSON with 'patcher' key."""
        from src.maxpat.hooks import write_gendsp

        code = "out1 = in1 * 0.5;"
        output_path = tmp_path / "test.gendsp"

        write_gendsp(code, output_path, num_inputs=1, num_outputs=1)

        data = json.loads(output_path.read_text())
        assert "patcher" in data
        assert "boxes" in data["patcher"]
        assert "lines" in data["patcher"]

    def test_write_gendsp_returns_dict(self, tmp_path):
        """write_gendsp returns the generated dict."""
        from src.maxpat.hooks import write_gendsp

        code = "out1 = in1 * 0.5;"
        output_path = tmp_path / "test.gendsp"

        result = write_gendsp(code, output_path, num_inputs=1, num_outputs=1)

        assert isinstance(result, dict)
        assert "patcher" in result

    def test_write_gendsp_creates_parent_dirs(self, tmp_path):
        """write_gendsp creates parent directories if needed."""
        from src.maxpat.hooks import write_gendsp

        code = "out1 = in1;"
        output_path = tmp_path / "nested" / "dir" / "test.gendsp"

        write_gendsp(code, output_path, num_inputs=1, num_outputs=1)

        assert output_path.exists()

    def test_write_gendsp_fixture_comparison(self, tmp_path):
        """Structural comparison against simple.gendsp fixture."""
        from src.maxpat.hooks import write_gendsp

        code = "Param freq(440, min=20, max=20000);\nParam amp(0.5, min=0, max=1);\nout1 = cycle(freq) * amp;"
        output_path = tmp_path / "simple.gendsp"

        result = write_gendsp(code, output_path)

        # Load fixture
        fixture_path = Path(__file__).parent / "fixtures" / "expected" / "simple.gendsp"
        fixture = json.loads(fixture_path.read_text())

        # Structural comparison: same box count, same object types, same patchline count
        assert len(result["patcher"]["boxes"]) == len(fixture["patcher"]["boxes"])
        assert len(result["patcher"]["lines"]) == len(fixture["patcher"]["lines"])

        # Same maxclass types
        result_types = sorted(b["box"]["maxclass"] for b in result["patcher"]["boxes"])
        fixture_types = sorted(b["box"]["maxclass"] for b in fixture["patcher"]["boxes"])
        assert result_types == fixture_types

    def test_gendsp_roundtrip(self, tmp_path):
        """Generate -> write -> read back -> verify structure matches."""
        from src.maxpat.hooks import write_gendsp

        code = "out1 = in1 + in2;"
        output_path = tmp_path / "roundtrip.gendsp"

        original = write_gendsp(code, output_path, num_inputs=2, num_outputs=1)

        # Read back
        loaded = json.loads(output_path.read_text())

        # Structure matches
        assert len(loaded["patcher"]["boxes"]) == len(original["patcher"]["boxes"])
        assert len(loaded["patcher"]["lines"]) == len(original["patcher"]["lines"])
        assert loaded["patcher"]["bgcolor"] == original["patcher"]["bgcolor"]


# ---------------------------------------------------------------------------
# TestPublicAPI -- verify public API exports
# ---------------------------------------------------------------------------

class TestPublicAPI:
    """Tests for public API exports."""

    def test_build_genexpr_importable(self):
        """build_genexpr is importable from src.maxpat."""
        from src.maxpat import build_genexpr
        assert callable(build_genexpr)

    def test_parse_genexpr_io_importable(self):
        """parse_genexpr_io is importable from src.maxpat."""
        from src.maxpat import parse_genexpr_io
        assert callable(parse_genexpr_io)

    def test_generate_gendsp_importable(self):
        """generate_gendsp is importable from src.maxpat."""
        from src.maxpat import generate_gendsp
        assert callable(generate_gendsp)

    def test_write_gendsp_importable(self):
        """write_gendsp is importable from src.maxpat."""
        from src.maxpat import write_gendsp
        assert callable(write_gendsp)


# ---------------------------------------------------------------------------
# TestN4M -- Node for Max code generation (CODE-04)
# ---------------------------------------------------------------------------

class TestN4M:
    """Tests for Node for Max code generation."""

    def test_generate_n4m_basic(self):
        """generates valid N4M with require and handler."""
        from src.maxpat.codegen import generate_n4m_script

        handlers = [{"name": "bang", "args": [], "body": 'maxAPI.outlet("processed");'}]
        result = generate_n4m_script(handlers)

        assert 'require("max-api")' in result
        assert 'addHandler("bang"' in result
        assert 'maxAPI.outlet("processed");' in result

    def test_generate_n4m_dict_access(self):
        """includes async dict access with try/catch."""
        from src.maxpat.codegen import generate_n4m_script

        handlers = [{"name": "bang", "args": [], "body": 'maxAPI.outlet("done");'}]
        result = generate_n4m_script(handlers, dict_access=["mydict"])

        assert "getDict" in result
        assert "setDict" in result
        assert "try" in result
        assert "catch" in result
        assert "maxAPI.post" in result
        assert "mydict" in result

    def test_generate_n4m_multiple_handlers(self):
        """multiple addHandler calls."""
        from src.maxpat.codegen import generate_n4m_script

        handlers = [
            {"name": "bang", "args": [], "body": 'maxAPI.outlet("bang");'},
            {"name": "set_value", "args": ["value"], "body": "maxAPI.outlet(value);"},
            {"name": "reset", "args": [], "body": 'maxAPI.outlet("reset");'},
        ]
        result = generate_n4m_script(handlers)

        assert result.count("addHandler") == 3
        assert 'addHandler("bang"' in result
        assert 'addHandler("set_value"' in result
        assert 'addHandler("reset"' in result

    def test_add_node_script_box(self):
        """creates box with correct maxclass and text."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        box, code = p.add_node_script("myscript.js")

        assert box.maxclass == "newobj"
        assert box.text == "node.script myscript.js"
        assert box.numinlets == 1
        assert code is None

    def test_add_node_script_outlets(self):
        """num_outlets parameter sets outlet count."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        box, code = p.add_node_script("test.js", num_outlets=3)

        assert box.numoutlets == 3
        assert box.outlettype == ["", "", ""]


# ---------------------------------------------------------------------------
# TestJsObject -- js object V8 code generation (CODE-05)
# ---------------------------------------------------------------------------

class TestJsObject:
    """Tests for js object V8 code generation."""

    def test_generate_js_basic(self):
        """generates valid js with inlets/outlets and handlers."""
        from src.maxpat.codegen import generate_js_script

        handlers = [
            {"type": "bang", "body": 'outlet(0, "ready");'},
            {"type": "msg_int", "body": "outlet(0, v * 2);"},
        ]
        result = generate_js_script(num_inlets=2, num_outlets=1, handlers=handlers)

        assert "inlets = 2;" in result
        assert "outlets = 1;" in result
        assert "function bang()" in result
        assert 'outlet(0, "ready");' in result
        assert "function msg_int(v)" in result

    def test_generate_js_default_handlers(self):
        """None handlers generates defaults."""
        from src.maxpat.codegen import generate_js_script

        result = generate_js_script(num_inlets=1, num_outlets=1)

        assert "inlets = 1;" in result
        assert "outlets = 1;" in result
        assert "function bang()" in result
        assert "function msg_int(v)" in result
        assert "function msg_float(v)" in result
        assert "function list()" in result

    def test_generate_js_custom_io(self):
        """custom inlet/outlet count in declarations."""
        from src.maxpat.codegen import generate_js_script

        result = generate_js_script(num_inlets=4, num_outlets=3)

        assert "inlets = 4;" in result
        assert "outlets = 3;" in result

    def test_add_js_box(self):
        """creates box with maxclass="newobj" and text="js filename.js"."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        box, code = p.add_js("myobject.js")

        assert box.maxclass == "newobj"
        assert box.text == "js myobject.js"
        assert code is None

    def test_add_js_io(self):
        """num_inlets/num_outlets set correctly on box."""
        from src.maxpat.patcher import Patcher

        p = Patcher()
        box, code = p.add_js("test.js", num_inlets=3, num_outlets=2)

        assert box.numinlets == 3
        assert box.numoutlets == 2
        assert box.outlettype == ["", ""]


# ---------------------------------------------------------------------------
# TestHookIntegration -- write_js and validate_code_file integration
# ---------------------------------------------------------------------------

class TestHookIntegration:
    """Integration tests for write_js and validate_code_file."""

    def test_write_js_n4m(self, tmp_path):
        """write_js writes N4M script, validate_code_file detects N4M and validates."""
        from src.maxpat.codegen import generate_n4m_script
        from src.maxpat.hooks import write_js, validate_code_file

        handlers = [{"name": "bang", "args": [], "body": 'maxAPI.outlet("done");'}]
        code = generate_n4m_script(handlers)
        output_path = tmp_path / "test_n4m.js"

        results = write_js(code, output_path)

        assert output_path.exists()
        assert output_path.read_text() == code

        # Validation should not have errors
        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

        # validate_code_file should also work
        results2 = validate_code_file(output_path)
        errors2 = [r for r in results2 if r.level == "error"]
        assert len(errors2) == 0

    def test_write_js_v8(self, tmp_path):
        """write_js writes js script, validate_code_file detects js and validates."""
        from src.maxpat.codegen import generate_js_script
        from src.maxpat.hooks import write_js, validate_code_file

        code = generate_js_script(num_inlets=2, num_outlets=1)
        output_path = tmp_path / "test_v8.js"

        results = write_js(code, output_path)

        assert output_path.exists()

        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

        # validate_code_file should detect js type
        results2 = validate_code_file(output_path)
        errors2 = [r for r in results2 if r.level == "error"]
        assert len(errors2) == 0

    def test_validate_gendsp_file(self, tmp_path):
        """validate_code_file on .gendsp extracts codebox code and validates GenExpr."""
        from src.maxpat.hooks import write_gendsp, validate_code_file

        code = "out1 = in1 * 0.5;"
        output_path = tmp_path / "test.gendsp"

        write_gendsp(code, output_path, num_inputs=1, num_outputs=1)

        results = validate_code_file(output_path)

        # Should have info-level I/O detection, no errors
        errors = [r for r in results if r.level == "error"]
        assert len(errors) == 0

        info = [r for r in results if r.level == "info"]
        assert any("1 input" in r.message and "1 output" in r.message for r in info)
