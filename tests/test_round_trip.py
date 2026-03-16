"""Round-trip tests for Patcher.from_dict() -> to_dict() lossless fidelity.

Covers requirements:
  RW-01: Load any .maxpat into fully populated Patcher/Box/Patchline objects
  RW-02: Loaded Patcher writes back with minimal diff
  RW-06: All user state preserved on edit (colors, positions, attrs)
"""

import json
import pathlib

import pytest

from src.maxpat.patcher import Patcher, Box, Patchline

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

PROJECT_ROOT = pathlib.Path(__file__).resolve().parent.parent
FIXTURES_DIR = PROJECT_ROOT / "tests" / "fixtures"
PATCHES_DIR = PROJECT_ROOT / "patches"


def _load_fixture(name: str) -> dict:
    """Load a .maxpat fixture from tests/fixtures/."""
    path = FIXTURES_DIR / name
    with open(path, "r") as f:
        return json.load(f)


def _load_project_patch(relpath: str) -> dict:
    """Load a .maxpat from the project patches/ directory."""
    path = PATCHES_DIR / relpath
    with open(path, "r") as f:
        return json.load(f)


# ---------------------------------------------------------------------------
# All project .maxpat files for parametrized round-trip tests
# ---------------------------------------------------------------------------

_PROJECT_PATCHES = [
    "kicksynth/generated/kicksynth.maxpat",
    "scala-synth/generated/scala-synth.maxpat",
    "scala-synth/generated/scala-synth-voice.maxpat",
    "performancepatchtest/generated/performancepatchtest.maxpat",
    "performancepatchtest/generated/comp-band.maxpat",
    "rhythmic-sampler/generated/rhythmic-sampler.maxpat",
    "rhythmic-sampler/generated/slot.maxpat",
    "minitaur/generated/minitaur.maxpat",
    "FDNVerb/generated/FDNVerb.maxpat",
    "granularsynthtest/generated/granularsynthtest.maxpat",
]

# ---------------------------------------------------------------------------
# TestPatchlineAttrs -- RW-06: Patchline color and extra attrs
# ---------------------------------------------------------------------------


class TestPatchlineAttrs:
    """Patchline attributes (color, unknown keys) survive round-trip."""

    def test_patchline_color_preserved(self):
        """Patchline with color [1.0, 0.0, 0.0, 1.0] survives from_dict -> to_dict."""
        original = _load_fixture("colored_patchlines.maxpat")
        p = Patcher.from_dict(original)
        result = p.to_dict()

        orig_line = original["patcher"]["lines"][0]["patchline"]
        result_line = result["patcher"]["lines"][0]["patchline"]

        assert "color" in result_line, "color attribute dropped during round-trip"
        assert result_line["color"] == [1.0, 0.0, 0.0, 1.0]
        assert result_line["color"] == orig_line["color"]

    def test_patchline_extra_attrs_preserved(self):
        """Patchline with unknown extra key 'custom_line_attr' survives round-trip."""
        original = _load_fixture("colored_patchlines.maxpat")
        p = Patcher.from_dict(original)
        result = p.to_dict()

        result_line = result["patcher"]["lines"][0]["patchline"]

        assert "custom_line_attr" in result_line, (
            "custom_line_attr dropped during round-trip"
        )
        assert result_line["custom_line_attr"] == 42

    def test_patchline_raw_preserved(self):
        """Patchline _raw dict is preserved on load for round-trip output."""
        original = _load_fixture("colored_patchlines.maxpat")
        p = Patcher.from_dict(original)

        assert len(p.lines) == 1
        pl = p.lines[0]
        assert hasattr(pl, "_raw") and pl._raw is not None, (
            "Patchline._raw not preserved during from_dict()"
        )
        # _raw should contain color and custom_line_attr
        assert "color" in pl._raw
        assert "custom_line_attr" in pl._raw

    def test_patchline_color_field_accessible(self):
        """Patchline.color is a named field accessible after loading."""
        original = _load_fixture("colored_patchlines.maxpat")
        p = Patcher.from_dict(original)

        pl = p.lines[0]
        assert hasattr(pl, "color"), "Patchline missing color field"
        assert pl.color == [1.0, 0.0, 0.0, 1.0]

    def test_patchline_full_round_trip(self):
        """Colored patchline fixture round-trips identically."""
        original = _load_fixture("colored_patchlines.maxpat")
        p = Patcher.from_dict(original)
        result = p.to_dict()

        orig_line = original["patcher"]["lines"][0]["patchline"]
        result_line = result["patcher"]["lines"][0]["patchline"]

        assert result_line == orig_line, (
            f"Patchline round-trip mismatch.\n"
            f"Original: {json.dumps(orig_line, indent=2)}\n"
            f"Result:   {json.dumps(result_line, indent=2)}"
        )


# ---------------------------------------------------------------------------
# TestRoundTripIdentity -- RW-02: Load-save identity for all project patches
# ---------------------------------------------------------------------------


class TestRoundTripIdentity:
    """Load each project .maxpat, from_dict -> to_dict, assert == original."""

    @pytest.mark.parametrize("relpath", _PROJECT_PATCHES)
    def test_round_trip_identity(self, relpath):
        """Round-trip produces identical output for {relpath}."""
        original = _load_project_patch(relpath)
        p = Patcher.from_dict(original)
        result = p.to_dict()
        assert result == original, (
            f"Round-trip mismatch for {relpath}."
        )


# ---------------------------------------------------------------------------
# TestKeyOrdering -- RW-02: Key position preserved after round-trip
# ---------------------------------------------------------------------------


class TestKeyOrdering:
    """Boxes and lines appear at same key position in output as in input."""

    def test_patcher_key_order_preserved(self):
        """Keys in patcher dict maintain their position after round-trip."""
        # Construct a dict where "boxes" appears before "dependency_cache"
        original = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [],
                "lines": [],
                "dependency_cache": [],
                "autosave": 0,
            }
        }

        p = Patcher.from_dict(original)
        result = p.to_dict()

        orig_keys = list(original["patcher"].keys())
        result_keys = list(result["patcher"].keys())

        # boxes and lines should be at the same position
        assert orig_keys.index("boxes") == result_keys.index("boxes"), (
            f"boxes moved from position {orig_keys.index('boxes')} "
            f"to {result_keys.index('boxes')}"
        )
        assert orig_keys.index("lines") == result_keys.index("lines"), (
            f"lines moved from position {orig_keys.index('lines')} "
            f"to {result_keys.index('lines')}"
        )

    def test_all_patcher_keys_in_order(self):
        """All patcher keys maintain exact original order."""
        original = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [],
                "lines": [],
                "dependency_cache": [],
                "autosave": 0,
            }
        }

        p = Patcher.from_dict(original)
        result = p.to_dict()

        orig_keys = list(original["patcher"].keys())
        result_keys = list(result["patcher"].keys())
        assert orig_keys == result_keys, (
            f"Key order changed:\n  original: {orig_keys}\n  result:   {result_keys}"
        )


# ---------------------------------------------------------------------------
# TestSubpatcherLoading -- RW-01: Recursive subpatcher loading
# ---------------------------------------------------------------------------


class TestSubpatcherLoading:
    """Subpatcher inner patcher is recursively loaded with all boxes."""

    def test_kicksynth_has_subpatchers(self):
        """kicksynth.maxpat loads with subpatcher boxes that have inner patchers."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)

        # Find boxes with inner patchers
        subpatch_boxes = [b for b in p.boxes if b._inner_patcher is not None]
        assert len(subpatch_boxes) > 0, (
            "No subpatcher boxes found in kicksynth.maxpat"
        )

    def test_subpatcher_inner_boxes_exist(self):
        """Subpatcher inner patcher has boxes loaded recursively."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)

        subpatch_boxes = [b for b in p.boxes if b._inner_patcher is not None]
        for box in subpatch_boxes:
            inner = box._inner_patcher
            assert len(inner.boxes) > 0, (
                f"Subpatcher {box.id} ({box.text}) has no inner boxes"
            )


# ---------------------------------------------------------------------------
# TestBpatcherLoading -- RW-01: Bpatcher attrs preserved
# ---------------------------------------------------------------------------


class TestBpatcherLoading:
    """Bpatcher attrs (args, offset, name, bgmode) present in loaded box."""

    def test_bpatcher_attrs_in_extra(self):
        """Bpatcher keys live in extra_attrs for round-trip preservation."""
        original = _load_project_patch(
            "rhythmic-sampler/generated/rhythmic-sampler.maxpat"
        )
        p = Patcher.from_dict(original)

        bpatch_boxes = [b for b in p.boxes if b.maxclass == "bpatcher"]
        assert len(bpatch_boxes) > 0, "No bpatcher boxes found"

        for box in bpatch_boxes:
            # bpatcher keys should be in extra_attrs
            assert "offset" in box.extra_attrs, (
                f"bpatcher {box.id} missing 'offset' in extra_attrs"
            )
            assert "name" in box.extra_attrs or "bgmode" in box.extra_attrs, (
                f"bpatcher {box.id} missing bpatcher-specific keys in extra_attrs"
            )


# ---------------------------------------------------------------------------
# TestUnknownObjects -- RW-01: Unknown maxclass loaded without error
# ---------------------------------------------------------------------------


class TestUnknownObjects:
    """A box with unknown maxclass loads without error, all data preserved."""

    def test_unknown_maxclass_loads(self):
        """Box with maxclass 'com.foo.external~' loads without error."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "com.foo.external~",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 3,
                            "outlettype": ["signal", "signal", ""],
                            "patching_rect": [100.0, 100.0, 120.0, 22.0],
                            "custom_param": "hello",
                            "custom_list": [1, 2, 3],
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        assert len(p.boxes) == 1

        box = p.boxes[0]
        assert box.maxclass == "com.foo.external~"
        assert box.numinlets == 2
        assert box.numoutlets == 3

    def test_unknown_maxclass_round_trips(self):
        """Unknown maxclass box data preserved through round-trip."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "com.foo.external~",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 3,
                            "outlettype": ["signal", "signal", ""],
                            "patching_rect": [100.0, 100.0, 120.0, 22.0],
                            "custom_param": "hello",
                            "custom_list": [1, 2, 3],
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        orig_box = data["patcher"]["boxes"][0]["box"]
        result_box = result["patcher"]["boxes"][0]["box"]

        assert result_box.get("custom_param") == "hello"
        assert result_box.get("custom_list") == [1, 2, 3]


# ---------------------------------------------------------------------------
# TestNumericPrecision -- RW-02: int stays int, float stays float
# ---------------------------------------------------------------------------


class TestNumericPrecision:
    """Numeric types preserved after round-trip: int stays int, float stays float."""

    def test_int_stays_int(self):
        """numinlets: 2 stays as int 2 (not float 2.0) after round-trip."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        box = result["patcher"]["boxes"][0]["box"]
        assert isinstance(box["numinlets"], int), (
            f"numinlets is {type(box['numinlets']).__name__}, expected int"
        )
        assert box["numinlets"] == 2

    def test_float_stays_float(self):
        """fontsize: 12.0 stays as float 12.0 (not int 12) after round-trip."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        box = result["patcher"]["boxes"][0]["box"]
        assert isinstance(box["fontsize"], float), (
            f"fontsize is {type(box['fontsize']).__name__}, expected float"
        )
        assert box["fontsize"] == 12.0


# ---------------------------------------------------------------------------
# TestUserState -- RW-06: Presentation, varname, scripting_name survive
# ---------------------------------------------------------------------------


class TestUserState:
    """presentation, presentation_rect, varname, scripting_name survive round-trip."""

    def test_presentation_survives(self):
        """Box with presentation=1 and presentation_rect survives round-trip."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "slider",
                            "id": "obj-1",
                            "numinlets": 1,
                            "numoutlets": 1,
                            "outlettype": [""],
                            "patching_rect": [100.0, 100.0, 20.0, 140.0],
                            "presentation": 1,
                            "presentation_rect": [20.0, 20.0, 20.0, 140.0],
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        box = result["patcher"]["boxes"][0]["box"]
        assert box.get("presentation") == 1
        assert box.get("presentation_rect") == [20.0, 20.0, 20.0, 140.0]

    def test_varname_survives(self):
        """Box with varname in extra_attrs survives round-trip."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                            "varname": "my_osc",
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        box = result["patcher"]["boxes"][0]["box"]
        assert box.get("varname") == "my_osc"

    def test_scripting_name_survives(self):
        """Box with scripting_name in extra_attrs survives round-trip."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                            "scripting_name": "osc_script",
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        box = result["patcher"]["boxes"][0]["box"]
        assert box.get("scripting_name") == "osc_script"


# ---------------------------------------------------------------------------
# TestExtraAttrs -- RW-06: Unknown box keys go to extra_attrs
# ---------------------------------------------------------------------------


class TestExtraAttrs:
    """Unknown box keys go to extra_attrs and survive round-trip."""

    def test_unknown_keys_in_extra_attrs(self):
        """Keys not in _handled_keys land in box.extra_attrs."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                            "custom_key": "custom_value",
                            "another_attr": [1, 2, 3],
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        box = p.boxes[0]

        assert "custom_key" in box.extra_attrs
        assert box.extra_attrs["custom_key"] == "custom_value"
        assert "another_attr" in box.extra_attrs
        assert box.extra_attrs["another_attr"] == [1, 2, 3]

    def test_extra_attrs_survive_round_trip(self):
        """Unknown box keys survive from_dict -> to_dict."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "cycle~ 440",
                            "id": "obj-1",
                            "numinlets": 2,
                            "numoutlets": 1,
                            "outlettype": ["signal"],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                            "custom_key": "custom_value",
                            "another_attr": [1, 2, 3],
                        }
                    }
                ],
                "lines": [],
            }
        }

        p = Patcher.from_dict(data)
        result = p.to_dict()

        box = result["patcher"]["boxes"][0]["box"]
        assert box.get("custom_key") == "custom_value"
        assert box.get("another_attr") == [1, 2, 3]


# ---------------------------------------------------------------------------
# TestStructuralErrors -- RW-01: Fail-fast on invalid input
# ---------------------------------------------------------------------------


class TestStructuralErrors:
    """from_dict raises on structurally invalid input."""

    def test_missing_patcher_key(self):
        """from_dict with dict missing 'patcher' key AND no 'boxes' key raises ValueError."""
        with pytest.raises(ValueError, match="patcher"):
            Patcher.from_dict({"not_patcher": {}})

    def test_boxes_not_array(self):
        """from_dict with 'boxes' that is not a list raises TypeError."""
        with pytest.raises(TypeError, match="boxes"):
            Patcher.from_dict({"patcher": {"boxes": "not_a_list"}})


# ---------------------------------------------------------------------------
# TestEdgeCases -- Plan 03: Additional edge-case coverage
# ---------------------------------------------------------------------------


class TestEdgeCases:
    """Edge-case round-trip tests for unknown externals, empty patchers, nesting."""

    def test_round_trip_with_unknown_external(self):
        """Synthetic .maxpat with unknown maxclass and various keys round-trips."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "com.acme.widget~",
                            "id": "obj-1",
                            "numinlets": 3,
                            "numoutlets": 2,
                            "outlettype": ["signal", ""],
                            "patching_rect": [100.0, 200.0, 120.0, 22.0],
                            "text": "com.acme.widget~ 440",
                            "fontname": "Arial",
                            "fontsize": 12.0,
                            "vendor_param": "foo",
                            "vendor_list": [1, 2, 3],
                            "vendor_nested": {"a": 1, "b": [4, 5]},
                        }
                    }
                ],
                "lines": [],
            }
        }
        p = Patcher.from_dict(data)
        result = p.to_dict()
        assert result == data

    def test_round_trip_empty_patcher(self):
        """Empty patcher (zero boxes, zero lines) round-trips identically."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [],
                "lines": [],
            }
        }
        p = Patcher.from_dict(data)
        result = p.to_dict()
        assert result == data

    def test_round_trip_deeply_nested_subpatchers(self):
        """3-level nested subpatcher round-trips with correct key ordering."""
        data = {
            "patcher": {
                "fileversion": 1,
                "appversion": {"major": 9, "minor": 0, "revision": 0},
                "classnamespace": "box",
                "rect": [100.0, 100.0, 640.0, 480.0],
                "boxes": [
                    {
                        "box": {
                            "maxclass": "newobj",
                            "text": "p level1",
                            "id": "obj-1",
                            "numinlets": 1,
                            "numoutlets": 1,
                            "outlettype": [""],
                            "patching_rect": [100.0, 100.0, 80.0, 22.0],
                            "fontname": "Arial",
                            "fontsize": 12.0,
                            "patcher": {
                                "fileversion": 1,
                                "appversion": {"major": 9, "minor": 0, "revision": 0},
                                "rect": [200.0, 200.0, 400.0, 300.0],
                                "boxes": [
                                    {
                                        "box": {
                                            "maxclass": "newobj",
                                            "text": "p level2",
                                            "id": "obj-1",
                                            "numinlets": 1,
                                            "numoutlets": 1,
                                            "outlettype": [""],
                                            "patching_rect": [50.0, 50.0, 80.0, 22.0],
                                            "fontname": "Arial",
                                            "fontsize": 12.0,
                                            "patcher": {
                                                "fileversion": 1,
                                                "appversion": {
                                                    "major": 9,
                                                    "minor": 0,
                                                    "revision": 0,
                                                },
                                                "rect": [300.0, 300.0, 300.0, 200.0],
                                                "boxes": [
                                                    {
                                                        "box": {
                                                            "maxclass": "newobj",
                                                            "text": "print level3",
                                                            "id": "obj-1",
                                                            "numinlets": 1,
                                                            "numoutlets": 0,
                                                            "outlettype": [],
                                                            "patching_rect": [
                                                                50.0,
                                                                50.0,
                                                                80.0,
                                                                22.0,
                                                            ],
                                                            "fontname": "Arial",
                                                            "fontsize": 12.0,
                                                        }
                                                    }
                                                ],
                                                "lines": [],
                                            },
                                        }
                                    }
                                ],
                                "lines": [],
                            },
                        }
                    }
                ],
                "lines": [],
            }
        }
        p = Patcher.from_dict(data)
        result = p.to_dict()
        assert result == data

    def test_creation_path_unchanged(self):
        """Programmatic Box/Patcher creation still produces expected format."""
        p = Patcher()
        osc = p.add_box("cycle~", args=["440"])
        dac = p.add_box("dac~")
        p.add_connection(osc, 0, dac, 0)

        d = p.to_dict()

        # Verify structural keys exist
        assert "patcher" in d
        patcher = d["patcher"]
        assert "boxes" in patcher
        assert "lines" in patcher
        assert len(patcher["boxes"]) == 2
        assert len(patcher["lines"]) == 1

        # Verify box format
        box0 = patcher["boxes"][0]["box"]
        assert box0["maxclass"] == "newobj"
        assert box0["text"] == "cycle~ 440"
        assert "id" in box0
        assert "numinlets" in box0
        assert "numoutlets" in box0
        assert "outlettype" in box0
        assert "patching_rect" in box0

        # Verify line format
        line0 = patcher["lines"][0]["patchline"]
        assert "source" in line0
        assert "destination" in line0
        assert line0["source"][0] == osc.id
        assert line0["destination"][0] == dac.id


# ---------------------------------------------------------------------------
# TestFileLevelRoundTrip -- Plan 03: Indentation-preserving file save
# ---------------------------------------------------------------------------


class TestFileLevelRoundTrip:
    """File-level round-trip preserves original indentation for zero-diff output."""

    def test_detect_indent_4space(self):
        """detect_indent identifies 4-space indentation."""
        from src.maxpat.hooks import detect_indent
        assert detect_indent('{\n    "patcher": {') == "    "

    def test_detect_indent_2space(self):
        """detect_indent identifies 2-space indentation."""
        from src.maxpat.hooks import detect_indent
        assert detect_indent('{\n  "patcher": {') == "  "

    def test_detect_indent_tab(self):
        """detect_indent identifies tab indentation."""
        from src.maxpat.hooks import detect_indent
        assert detect_indent('{\n\t"patcher": {') == "\t"

    def test_detect_indent_no_indent_defaults_4space(self):
        """detect_indent returns 4 spaces for file with no indented lines."""
        from src.maxpat.hooks import detect_indent
        assert detect_indent('{"patcher": {}}') == "    "

    def test_max_saved_file_byte_identical(self, tmp_path):
        """MAX-saved 4-space file round-trips to byte-identical output."""
        from src.maxpat.hooks import save_patch_roundtrip, detect_indent
        # Use a MAX-saved file (comp-band.maxpat has 4-space indent)
        path = PATCHES_DIR / "performancepatchtest" / "generated" / "comp-band.maxpat"
        original_text = path.read_text()
        original_data = json.loads(original_text)

        # Verify it uses 4-space indent
        assert detect_indent(original_text) == "    "

        # Round-trip through Patcher
        p = Patcher.from_dict(original_data)
        result = p.to_dict()

        # Write via save_patch_roundtrip
        out_path = tmp_path / "comp-band-rt.maxpat"
        save_patch_roundtrip(result, out_path, original_text=original_text)

        # Read back and compare
        roundtrip_text = out_path.read_text()
        assert roundtrip_text == original_text, (
            "File-level round-trip produced different output for MAX-saved file"
        )

    def test_framework_file_byte_identical(self, tmp_path):
        """Framework-generated 2-space file round-trips to byte-identical output."""
        from src.maxpat.hooks import save_patch_roundtrip, detect_indent
        # Use a framework-generated file (rhythmic-sampler.maxpat has 2-space indent)
        path = PATCHES_DIR / "rhythmic-sampler" / "generated" / "rhythmic-sampler.maxpat"
        original_text = path.read_text()
        original_data = json.loads(original_text)

        # Verify it uses 2-space indent
        assert detect_indent(original_text) == "  "

        # Round-trip through Patcher
        p = Patcher.from_dict(original_data)
        result = p.to_dict()

        # Write via save_patch_roundtrip
        out_path = tmp_path / "rhythmic-sampler-rt.maxpat"
        save_patch_roundtrip(result, out_path, original_text=original_text)

        # Read back and compare
        roundtrip_text = out_path.read_text()
        assert roundtrip_text == original_text, (
            "File-level round-trip produced different output for framework file"
        )

    def test_new_file_uses_max_default(self, tmp_path):
        """save_patch_roundtrip with no original_text uses 4-space indent."""
        from src.maxpat.hooks import save_patch_roundtrip
        data = {"patcher": {"fileversion": 1, "boxes": [], "lines": []}}

        out_path = tmp_path / "new.maxpat"
        save_patch_roundtrip(data, out_path)

        content = out_path.read_text()
        # Should use 4-space indent (MAX default)
        assert '\n    "' in content, (
            "New file should use 4-space indent (MAX default)"
        )


# ---------------------------------------------------------------------------
# TestMutationPreservesRoundTrip -- RW-03/04/05: Mutations don't disturb fidelity
# ---------------------------------------------------------------------------


class TestMutationPreservesRoundTrip:
    """Mutations on loaded patches do not disturb round-trip fidelity of untouched objects."""

    def test_add_box_preserves_existing_boxes(self):
        """Load kicksynth, add box, verify existing box dicts unchanged."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)
        original_boxes = p.to_dict()["patcher"]["boxes"]

        p.add_box("cycle~", args=["880"])

        result = p.to_dict()
        result_boxes = result["patcher"]["boxes"]

        # All original boxes should be unchanged
        assert len(result_boxes) == len(original_boxes) + 1
        for orig_box in original_boxes:
            assert orig_box in result_boxes, (
                f"Original box {orig_box['box']['id']} was modified after add_box"
            )

    def test_add_box_gets_unique_id(self):
        """Load kicksynth (max ID obj-146), add_box, verify no ID collision."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)

        existing_ids = {b.id for b in p.boxes}
        new_box = p.add_box("cycle~")

        assert new_box.id not in existing_ids, (
            f"New box ID {new_box.id} collides with existing ID"
        )

    def test_remove_box_preserves_remaining(self):
        """Load kicksynth, remove a box with connections, verify remaining boxes identical."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)

        # Find a box involved in connections (obj-14 has outgoing lines)
        target = p.find_box(id="obj-14")
        assert target is not None, "obj-14 not found in kicksynth"
        target_id = target.id

        # Snapshot all box dicts except the target
        original_result = p.to_dict()
        original_boxes = [
            bd for bd in original_result["patcher"]["boxes"]
            if bd["box"]["id"] != target_id
        ]
        original_lines_without_target = [
            ld for ld in original_result["patcher"]["lines"]
            if ld["patchline"]["source"][0] != target_id
            and ld["patchline"]["destination"][0] != target_id
        ]

        p.remove_box(target)

        result = p.to_dict()
        result_boxes = result["patcher"]["boxes"]
        result_lines = result["patcher"]["lines"]

        # Remaining boxes should be identical
        assert len(result_boxes) == len(original_boxes)
        for orig_box in original_boxes:
            assert orig_box in result_boxes, (
                f"Box {orig_box['box']['id']} was modified after remove_box"
            )
        # Remaining lines should be identical
        assert len(result_lines) == len(original_lines_without_target)
        for orig_line in original_lines_without_target:
            assert orig_line in result_lines, (
                f"Line was modified after remove_box"
            )

    def test_add_connection_preserves_existing_lines(self):
        """Load kicksynth, add connection, verify existing line dicts unchanged."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)
        original_lines = p.to_dict()["patcher"]["lines"]

        # Find two boxes not connected: obj-12 (button, 1 outlet) and obj-15 (stripnote, 2 inlets)
        b1 = p.find_box(id="obj-12")
        b2 = p.find_box(id="obj-15")
        assert b1 is not None and b2 is not None

        # Add a new connection between them
        p.add_connection(b1, 0, b2, 0)

        result = p.to_dict()
        result_lines = result["patcher"]["lines"]

        assert len(result_lines) == len(original_lines) + 1
        for orig_line in original_lines:
            assert orig_line in result_lines, (
                "Existing line was modified after add_connection"
            )

    def test_full_mutation_cycle(self):
        """Load, add box, connect, remove different box -- verify full integrity."""
        original = _load_project_patch("kicksynth/generated/kicksynth.maxpat")
        p = Patcher.from_dict(original)

        original_count = len(p.boxes)

        # Add a new box
        new_box = p.add_box("noise~")

        # Connect the new box to an existing box (ezdac~ or similar)
        # Use the first box with at least 1 inlet
        target_box = None
        for b in p.boxes:
            if b is not new_box and b.numinlets > 0 and b.numoutlets > 0:
                target_box = b
                break
        assert target_box is not None
        p.add_connection(new_box, 0, target_box, 0)

        # Remove a different box (obj-14 which has connections)
        remove_target = p.find_box(id="obj-14")
        assert remove_target is not None
        remove_id = remove_target.id
        p.remove_box(remove_target)

        result = p.to_dict()
        result_boxes = result["patcher"]["boxes"]
        result_lines = result["patcher"]["lines"]

        # New box should be present
        new_box_dicts = [
            bd for bd in result_boxes if bd["box"]["id"] == new_box.id
        ]
        assert len(new_box_dicts) == 1, "New box not found in output"

        # New connection should be present
        new_conn = [
            ld for ld in result_lines
            if ld["patchline"]["source"][0] == new_box.id
        ]
        assert len(new_conn) == 1, "New connection not found in output"

        # Removed box should be absent
        removed_dicts = [
            bd for bd in result_boxes if bd["box"]["id"] == remove_id
        ]
        assert len(removed_dicts) == 0, "Removed box still in output"

        # Removed box's connections should be absent
        removed_lines = [
            ld for ld in result_lines
            if ld["patchline"]["source"][0] == remove_id
            or ld["patchline"]["destination"][0] == remove_id
        ]
        assert len(removed_lines) == 0, "Removed box's connections still in output"

        # Box count: original - 1 (removed) + 1 (added) = original
        assert len(result_boxes) == original_count


# --- Phase 15: Modify Round-Trip ---


class TestModifyPreservesRoundTrip:
    """ED-01: modify_box syncs _raw for lossless round-trip."""
    pass
