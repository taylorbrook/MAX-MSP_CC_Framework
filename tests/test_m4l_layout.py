"""Tests for M4L presentation layout engine.

Covers LAYOUT-01, LAYOUT-02, LAYOUT-03: column-packing algorithm that groups controls
by semantic function and positions them within Ableton's 169px device height,
plus tabbed layout pattern with live.tab and script hide/show wiring.

Test classes:
  TestLayoutBasics -- empty patch, returns same dict, presentation flag
  TestGroupLayout -- controls grouped by function, group labels, ordering
  TestColumnPacking -- vertical column layout, height budget, horizontal gaps
  TestDeviceWidth -- auto-expansion, stays at 300 when fits
  TestWholePixels -- all coords are int type
  TestPreserveExisting -- controls with presentation_rect untouched
  TestSpecialCases -- live.gain~ tall control handling
  TestLayoutPatternSelection -- threshold detection: single vs tabbed
  TestTabbedLayout -- full tabbed layout: live.tab creation, page visibility, positioning
  TestTabWiring -- wiring chain: live.tab -> select -> messages -> thispatcher
  TestTabSpecialCases -- live.gain~ on first page, varname handling
"""

from __future__ import annotations

import pytest


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_live_control(
    box_id: str = "obj-1",
    maxclass: str = "live.dial",
    varname: str | None = None,
    longname: str | None = None,
    shortname: str | None = None,
    parameter_enable: int = 1,
    text: str | None = None,
    presentation_rect: list | None = None,
) -> dict:
    """Build a live.* control box dict with configurable naming."""
    box: dict = {
        "id": box_id,
        "maxclass": maxclass,
        "numinlets": 1,
        "numoutlets": 2,
        "outlettype": ["", "float"],
        "parameter_enable": parameter_enable,
    }
    if varname is not None:
        box["varname"] = varname
    if text is not None:
        box["text"] = text
    if presentation_rect is not None:
        box["presentation"] = 1
        box["presentation_rect"] = presentation_rect

    # Build saved_attribute_attributes.valueof
    valueof: dict = {}
    if longname is not None:
        valueof["parameter_longname"] = longname
    if shortname is not None:
        valueof["parameter_shortname"] = shortname
    if valueof:
        box["saved_attribute_attributes"] = {"valueof": valueof}

    return box


def _make_patch_with_controls(controls: list[dict], **patcher_props) -> dict:
    """Wrap control box dicts in proper patch_dict structure."""
    patcher = {
        "boxes": [{"box": c} for c in controls],
        "lines": [],
        "rect": [0.0, 0.0, 300.0, 169.0],
    }
    # Default devicewidth for M4L
    patcher.setdefault("devicewidth", 300)
    patcher.update(patcher_props)
    return {"patcher": patcher}


def _make_m4l_patch(control_specs: list[tuple[str, str]]) -> dict:
    """Convenience: takes list of (maxclass, longname) tuples.

    Builds a full patch_dict with parameter_enable=1 and
    saved_attribute_attributes for each control.
    """
    controls = []
    for i, (maxclass, longname) in enumerate(control_specs):
        controls.append(_make_live_control(
            box_id=f"obj-{i + 1}",
            maxclass=maxclass,
            longname=longname,
            varname=longname.lower().replace(" ", "_"),
        ))
    return _make_patch_with_controls(controls)


# ===========================================================================
# TestLayoutBasics
# ===========================================================================

class TestLayoutBasics:
    """Basic layout engine behavior."""

    def test_returns_same_dict(self):
        """layout_m4l_presentation returns the same dict (mutates in place)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([("live.dial", "Filter Cutoff")])
        result = layout_m4l_presentation(patch)
        assert result is patch

    def test_empty_patch_unchanged(self):
        """Empty patch (no controls) returns unchanged."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_patch_with_controls([])
        result = layout_m4l_presentation(patch)
        assert result is patch
        assert len(result["patcher"]["boxes"]) == 0

    def test_presentation_set_on_laid_out_controls(self):
        """presentation=1 set on all laid-out controls."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([("live.dial", "Filter Cutoff")])
        layout_m4l_presentation(patch)

        # Find the control box (not the label)
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if box.get("maxclass") == "live.dial":
                assert box.get("presentation") == 1
                assert "presentation_rect" in box
                break
        else:
            pytest.fail("live.dial control not found after layout")


# ===========================================================================
# TestPreserveExisting
# ===========================================================================

class TestPreserveExisting:
    """Controls with existing presentation_rect are NOT repositioned (D-14)."""

    def test_existing_rect_preserved(self):
        """Control with presentation_rect already set keeps its values."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        ctrl = _make_live_control(
            box_id="obj-1",
            maxclass="live.dial",
            longname="Filter Cutoff",
            varname="filter_cutoff",
            presentation_rect=[100, 50, 44, 66],
        )
        patch = _make_patch_with_controls([ctrl])
        layout_m4l_presentation(patch)

        box = patch["patcher"]["boxes"][0]["box"]
        assert box["presentation_rect"] == [100, 50, 44, 66]

    def test_mixed_existing_and_new(self):
        """Patch with some controls having rect and some without.

        Controls with rect stay put; those without get positioned.
        """
        from src.maxpat.m4l_layout import layout_m4l_presentation

        ctrl_with_rect = _make_live_control(
            box_id="obj-1",
            maxclass="live.dial",
            longname="Filter Cutoff",
            varname="filter_cutoff",
            presentation_rect=[100, 50, 44, 66],
        )
        ctrl_without_rect = _make_live_control(
            box_id="obj-2",
            maxclass="live.dial",
            longname="Amp Volume",
            varname="amp_volume",
        )
        patch = _make_patch_with_controls([ctrl_with_rect, ctrl_without_rect])
        layout_m4l_presentation(patch)

        box1 = patch["patcher"]["boxes"][0]["box"]
        box2 = patch["patcher"]["boxes"][1]["box"]
        # First box unchanged
        assert box1["presentation_rect"] == [100, 50, 44, 66]
        # Second box now has a rect
        assert "presentation_rect" in box2
        assert box2["presentation_rect"] != [100, 50, 44, 66]

    def test_all_existing_rects_no_changes(self):
        """If all controls have presentation_rect, no new labels or changes."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        ctrl = _make_live_control(
            box_id="obj-1",
            maxclass="live.dial",
            longname="Filter Cutoff",
            varname="filter_cutoff",
            presentation_rect=[10, 10, 44, 66],
        )
        patch = _make_patch_with_controls([ctrl])
        box_count_before = len(patch["patcher"]["boxes"])
        layout_m4l_presentation(patch)
        # No new boxes added (no labels created)
        assert len(patch["patcher"]["boxes"]) == box_count_before


# ===========================================================================
# TestGroupLayout
# ===========================================================================

class TestGroupLayout:
    """Controls grouped by semantic function (D-01), labels added (D-02)."""

    def test_filter_controls_grouped(self):
        """Filter-related controls end up in same column."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Amp Volume"),
        ])
        layout_m4l_presentation(patch)

        # Get presentation_rect for filter controls
        filter_boxes = []
        amp_boxes = []
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            saa = box.get("saved_attribute_attributes", {})
            ln = saa.get("valueof", {}).get("parameter_longname", "")
            if "Filter" in ln:
                filter_boxes.append(box)
            elif "Amp" in ln:
                amp_boxes.append(box)

        # All filter controls should share the same x position (same column)
        filter_xs = [b["presentation_rect"][0] for b in filter_boxes]
        assert len(set(filter_xs)) == 1, f"Filter controls not in same column: {filter_xs}"

        # Amp control should be in a different column
        amp_x = amp_boxes[0]["presentation_rect"][0]
        assert amp_x != filter_xs[0], "Amp and Filter should be in different columns"

    def test_group_label_added(self):
        """Each group gets a live.comment label with group name text (D-02)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
        ])
        layout_m4l_presentation(patch)

        # Find live.comment boxes added as labels
        labels = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "live.comment"
        ]
        assert len(labels) >= 1, "No live.comment group label found"
        # Label should contain group name
        label_texts = [l.get("text", "") for l in labels]
        assert any("Filter" in t for t in label_texts), \
            f"No 'Filter' label found in: {label_texts}"

    def test_group_label_dimensions(self):
        """live.comment label height is 18px (D-07)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
        ])
        layout_m4l_presentation(patch)

        labels = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "live.comment"
        ]
        assert len(labels) >= 1
        for label in labels:
            rect = label["presentation_rect"]
            assert rect[3] == 18, f"Label height should be 18, got {rect[3]}"

    def test_label_gap_before_controls(self):
        """Gap between label bottom and first control top is 4px (D-07)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
        ])
        layout_m4l_presentation(patch)

        label = None
        control = None
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if box.get("maxclass") == "live.comment":
                label = box
            elif box.get("maxclass") == "live.dial":
                control = box

        assert label is not None and control is not None
        label_bottom = label["presentation_rect"][1] + label["presentation_rect"][3]
        control_top = control["presentation_rect"][1]
        gap = control_top - label_bottom
        assert gap == 4, f"Gap between label and control should be 4px, got {gap}"

    def test_group_ordering_signal_flow(self):
        """Groups ordered by signal flow priority: Pitch before Filter before Amp."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Amp Volume"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Pitch Tune"),
        ])
        layout_m4l_presentation(patch)

        # Collect x positions by group
        group_x = {}
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            saa = box.get("saved_attribute_attributes", {})
            ln = saa.get("valueof", {}).get("parameter_longname", "")
            if "Pitch" in ln:
                group_x["Pitch"] = box["presentation_rect"][0]
            elif "Filter" in ln:
                group_x["Filter"] = box["presentation_rect"][0]
            elif "Amp" in ln:
                group_x["Amp"] = box["presentation_rect"][0]

        assert group_x["Pitch"] < group_x["Filter"], \
            f"Pitch ({group_x['Pitch']}) should be left of Filter ({group_x['Filter']})"
        assert group_x["Filter"] < group_x["Amp"], \
            f"Filter ({group_x['Filter']}) should be left of Amp ({group_x['Amp']})"

    def test_multiple_groups_all_labeled(self):
        """Each distinct group gets its own label."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Pitch Tune"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Amp Volume"),
        ])
        layout_m4l_presentation(patch)

        labels = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "live.comment"
        ]
        label_texts = [l.get("text", "") for l in labels]
        assert len(labels) == 3, f"Expected 3 labels, got {len(labels)}: {label_texts}"


# ===========================================================================
# TestColumnPacking
# ===========================================================================

class TestColumnPacking:
    """Vertical column layout, height budget, horizontal gaps."""

    def test_groups_flow_left_to_right(self):
        """Second group x > first group x (D-03)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Amp Volume"),
        ])
        layout_m4l_presentation(patch)

        xs = {}
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            saa = box.get("saved_attribute_attributes", {})
            ln = saa.get("valueof", {}).get("parameter_longname", "")
            if "Filter" in ln:
                xs["Filter"] = box["presentation_rect"][0]
            elif "Amp" in ln:
                xs["Amp"] = box["presentation_rect"][0]

        assert xs["Filter"] < xs["Amp"], \
            f"Filter group ({xs['Filter']}) should be left of Amp group ({xs['Amp']})"

    def test_horizontal_gap_between_groups(self):
        """Horizontal gap between group columns is within expected range (D-09)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Amp Volume"),
        ])
        layout_m4l_presentation(patch)

        filter_right = 0
        amp_left = 999
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            saa = box.get("saved_attribute_attributes", {})
            ln = saa.get("valueof", {}).get("parameter_longname", "")
            if not ln:
                continue
            rect = box["presentation_rect"]
            if "Filter" in ln:
                right = rect[0] + rect[2]
                if right > filter_right:
                    filter_right = right
            elif "Amp" in ln:
                if rect[0] < amp_left:
                    amp_left = rect[0]

        gap = amp_left - filter_right
        # Account for group gap (between columns, not within)
        # The gap includes the label widths, so measure from rightmost
        # control edge of left group to leftmost control edge of right group
        assert gap >= 4, f"Gap too small: {gap}px"
        assert gap <= 20, f"Gap too large: {gap}px"

    def test_controls_fit_within_device_height(self):
        """All controls fit within 169px device height (LAYOUT-01)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Amp Volume"),
            ("live.slider", "Mod Depth"),
        ])
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if "presentation_rect" in box:
                rect = box["presentation_rect"]
                bottom = rect[1] + rect[3]
                assert bottom <= 169, \
                    f"Control {box.get('id', '?')} bottom at {bottom} exceeds 169px"

    def test_control_dimensions_match_sizing(self):
        """Control dimensions match UI_SIZES exactly (D-08)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.slider", "Mod Depth"),
        ])
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            maxclass = box.get("maxclass", "")
            if maxclass == "live.dial" and "presentation_rect" in box:
                rect = box["presentation_rect"]
                assert rect[2] == 44, f"live.dial width should be 44, got {rect[2]}"
                assert rect[3] == 66, f"live.dial height should be 66, got {rect[3]}"
            elif maxclass == "live.slider" and "presentation_rect" in box:
                rect = box["presentation_rect"]
                assert rect[2] == 39, f"live.slider width should be 39, got {rect[2]}"
                assert rect[3] == 87, f"live.slider height should be 87, got {rect[3]}"

    def test_stacked_small_controls(self):
        """Small controls (live.numbox, live.toggle) can stack vertically in one column."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.numbox", "Filter Cutoff"),
            ("live.numbox", "Filter Resonance"),
            ("live.toggle", "Filter Enable"),
        ])
        layout_m4l_presentation(patch)

        # All filter controls should be in the same column (same x)
        filter_boxes = []
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            saa = box.get("saved_attribute_attributes", {})
            ln = saa.get("valueof", {}).get("parameter_longname", "")
            if "Filter" in ln:
                filter_boxes.append(box)

        xs = set(b["presentation_rect"][0] for b in filter_boxes)
        assert len(xs) == 1, f"Filter controls should share x position, got {xs}"


# ===========================================================================
# TestDeviceWidth
# ===========================================================================

class TestDeviceWidth:
    """Device width auto-expansion (D-11)."""

    def test_stays_at_300_when_fits(self):
        """devicewidth stays at 300 if groups fit within it."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Amp Volume"),
        ])
        layout_m4l_presentation(patch)

        assert patch["patcher"]["devicewidth"] <= 300

    def test_auto_expands_when_needed(self):
        """devicewidth expands when groups don't fit in 300px."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        # Create many groups to exceed 300px
        # Each live.dial is 44px wide, plus gaps and labels
        patch = _make_m4l_patch([
            ("live.dial", "Pitch Tune"),
            ("live.dial", "Pitch Detune"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Amp Volume"),
            ("live.dial", "Amp Velocity"),
            ("live.dial", "Envelope Attack"),
            ("live.dial", "Envelope Decay"),
            ("live.dial", "Mod Depth"),
            ("live.dial", "Mod Rate"),
            ("live.dial", "FX Delay"),
            ("live.dial", "Mix Dry"),
        ])
        layout_m4l_presentation(patch)

        # Should have expanded beyond 300
        assert patch["patcher"]["devicewidth"] > 300, \
            f"devicewidth should expand beyond 300, got {patch['patcher']['devicewidth']}"


# ===========================================================================
# TestWholePixels
# ===========================================================================

class TestWholePixels:
    """All presentation_rect values are whole integers (D-10, LAYOUT-03)."""

    def test_all_coords_are_int(self):
        """Every x, y, w, h in presentation_rect is int type."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Amp Volume"),
            ("live.slider", "Mod Depth"),
            ("live.numbox", "Mix Level"),
        ])
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if "presentation_rect" in box:
                rect = box["presentation_rect"]
                for i, val in enumerate(rect):
                    assert isinstance(val, int), \
                        f"presentation_rect[{i}] = {val} ({type(val).__name__}) " \
                        f"on {box.get('id', '?')} -- must be int"

    def test_no_float_coords(self):
        """Coords are never float, even when computed from float UI_SIZES."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
        ])
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if "presentation_rect" in box:
                rect = box["presentation_rect"]
                for val in rect:
                    assert not isinstance(val, float), \
                        f"Float coord {val} found in {box.get('id', '?')}"


# ===========================================================================
# TestSpecialCases
# ===========================================================================

class TestSpecialCases:
    """Special handling for tall controls like live.gain~ (Pitfall 1)."""

    def test_tall_control_skips_label(self):
        """live.gain~ (136px) skips group label to fit within 169px."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.gain~", "Amp Volume"),
        ])
        layout_m4l_presentation(patch)

        # live.gain~ should have presentation_rect
        gain_box = None
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if box.get("maxclass") == "live.gain~":
                gain_box = box
                break

        assert gain_box is not None
        assert "presentation_rect" in gain_box
        rect = gain_box["presentation_rect"]
        # Must fit within 169px
        assert rect[1] + rect[3] <= 169, \
            f"live.gain~ bottom ({rect[1] + rect[3]}) exceeds 169px"

        # Check: no live.comment label for this group (or label is placed
        # differently). The key constraint is height compliance.
        labels = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "live.comment"
        ]
        # If a label exists, the total including label must still fit in 169px
        for label in labels:
            label_bottom = label["presentation_rect"][1] + label["presentation_rect"][3]
            assert label_bottom + 136 <= 169 or len(labels) == 0, \
                "Label + live.gain~ would exceed 169px -- label should be skipped"

    def test_tall_control_fits_in_height(self):
        """live.gain~ at 136px + margins must fit within 169px."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = _make_m4l_patch([
            ("live.gain~", "Amp Volume"),
            ("live.dial", "Filter Cutoff"),
        ])
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if "presentation_rect" in box:
                rect = box["presentation_rect"]
                bottom = rect[1] + rect[3]
                assert bottom <= 169, \
                    f"{box.get('maxclass')} bottom at {bottom} exceeds 169px"


# ---------------------------------------------------------------------------
# Helper for tabbed layout tests
# ---------------------------------------------------------------------------

def _make_many_controls(n: int, groups: list[str]) -> list[tuple[str, str]]:
    """Create N control specs distributed across specified groups.

    Returns list of (maxclass, longname) tuples suitable for _make_m4l_patch.
    """
    specs = []
    for i in range(n):
        group = groups[i % len(groups)]
        specs.append(("live.dial", f"{group} Param {i}"))
    return specs


# ===========================================================================
# TestLayoutPatternSelection
# ===========================================================================

class TestLayoutPatternSelection:
    """Threshold detection: single vs tabbed based on control/group count."""

    def test_single_for_few_controls(self):
        """<= 8 total controls returns 'single'."""
        from src.maxpat.m4l_layout import _select_layout_pattern, _group_controls

        patch = _make_m4l_patch([
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Amp Volume"),
        ])
        controls = []
        for entry in patch["patcher"]["boxes"]:
            controls.append(entry["box"])
        groups = _group_controls(controls)
        result = _select_layout_pattern(groups, patch["patcher"])
        assert result == "single"

    def test_tabbed_for_many_controls(self):
        """More than 8 total controls returns 'tabbed' (D-05)."""
        from src.maxpat.m4l_layout import _select_layout_pattern, _group_controls

        specs = _make_many_controls(12, ["Filter", "Amp", "Mod"])
        patch = _make_m4l_patch(specs)
        controls = [entry["box"] for entry in patch["patcher"]["boxes"]]
        groups = _group_controls(controls)
        result = _select_layout_pattern(groups, patch["patcher"])
        assert result == "tabbed"

    def test_tabbed_for_many_groups(self):
        """More than 3 groups returns 'tabbed' (research recommendation)."""
        from src.maxpat.m4l_layout import _select_layout_pattern, _group_controls

        # 4 groups with 2 controls each = 8 controls but 4 groups
        specs = [
            ("live.dial", "Pitch Tune"),
            ("live.dial", "Pitch Detune"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Amp Volume"),
            ("live.dial", "Amp Velocity"),
            ("live.dial", "Mod Depth"),
            ("live.dial", "Mod Rate"),
        ]
        patch = _make_m4l_patch(specs)
        controls = [entry["box"] for entry in patch["patcher"]["boxes"]]
        groups = _group_controls(controls)
        result = _select_layout_pattern(groups, patch["patcher"])
        assert result == "tabbed"

    def test_exactly_8_controls_is_single(self):
        """Exactly 8 controls stays single (threshold is >8)."""
        from src.maxpat.m4l_layout import _select_layout_pattern, _group_controls

        specs = _make_many_controls(8, ["Filter", "Amp"])
        patch = _make_m4l_patch(specs)
        controls = [entry["box"] for entry in patch["patcher"]["boxes"]]
        groups = _group_controls(controls)
        result = _select_layout_pattern(groups, patch["patcher"])
        assert result == "single"

    def test_exactly_3_groups_is_single(self):
        """Exactly 3 groups stays single (threshold is >3)."""
        from src.maxpat.m4l_layout import _select_layout_pattern, _group_controls

        specs = [
            ("live.dial", "Pitch Tune"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Amp Volume"),
        ]
        patch = _make_m4l_patch(specs)
        controls = [entry["box"] for entry in patch["patcher"]["boxes"]]
        groups = _group_controls(controls)
        result = _select_layout_pattern(groups, patch["patcher"])
        assert result == "single"


# ===========================================================================
# TestTabbedLayout
# ===========================================================================

class TestTabbedLayout:
    """Full tabbed layout: live.tab creation, page visibility, positioning."""

    def _make_tabbed_patch(self):
        """Create a patch that triggers tabbed layout (>8 controls, 4 groups)."""
        specs = [
            ("live.dial", "Pitch Tune"),
            ("live.dial", "Pitch Detune"),
            ("live.dial", "Pitch Fine"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Filter Drive"),
            ("live.dial", "Amp Volume"),
            ("live.dial", "Amp Velocity"),
            ("live.dial", "Amp Pan"),
            ("live.dial", "Mod Depth"),
            ("live.dial", "Mod Rate"),
            ("live.dial", "Mod Shape"),
        ]
        return _make_m4l_patch(specs)

    def test_adds_live_tab_box(self):
        """Tabbed layout adds a live.tab box with maxclass='live.tab'."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        tab_boxes = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "live.tab"
        ]
        assert len(tab_boxes) == 1, f"Expected 1 live.tab, found {len(tab_boxes)}"

    def test_live_tab_livemode(self):
        """live.tab has livemode=1 for pixel snapping (Pitfall 6)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        tab = None
        for entry in patch["patcher"]["boxes"]:
            if entry["box"].get("maxclass") == "live.tab":
                tab = entry["box"]
                break
        assert tab is not None
        assert tab.get("livemode") == 1

    def test_live_tab_at_top(self):
        """live.tab presentation_rect y=TOP_MARGIN (at top of device)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation, TOP_MARGIN

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        tab = None
        for entry in patch["patcher"]["boxes"]:
            if entry["box"].get("maxclass") == "live.tab":
                tab = entry["box"]
                break
        assert tab is not None
        rect = tab.get("presentation_rect")
        assert rect is not None
        assert rect[1] == TOP_MARGIN, f"Tab y should be {TOP_MARGIN}, got {rect[1]}"

    def test_live_tab_parameter_enable(self):
        """live.tab has parameter_enable=1, parameter_type=2 (ENUM), parameter_enum=group names."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        tab = None
        for entry in patch["patcher"]["boxes"]:
            if entry["box"].get("maxclass") == "live.tab":
                tab = entry["box"]
                break
        assert tab is not None
        assert tab.get("parameter_enable") == 1
        saa = tab.get("saved_attribute_attributes", {})
        valueof = saa.get("valueof", {})
        assert valueof.get("parameter_type") == 2, "parameter_type should be 2 (ENUM)"
        enum = valueof.get("parameter_enum", [])
        assert len(enum) >= 2, f"Expected at least 2 enum values, got {len(enum)}"

    def test_live_tab_parameter_names(self):
        """live.tab has parameter_longname='Page' and parameter_shortname='Page'."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        tab = None
        for entry in patch["patcher"]["boxes"]:
            if entry["box"].get("maxclass") == "live.tab":
                tab = entry["box"]
                break
        assert tab is not None
        saa = tab.get("saved_attribute_attributes", {})
        valueof = saa.get("valueof", {})
        assert valueof.get("parameter_longname") == "Page"
        assert valueof.get("parameter_shortname") == "Page"

    def test_first_page_visible_others_hidden(self):
        """First tab page controls have hidden=0, other pages have hidden=1."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        # Collect controls by group
        first_page_found = False
        other_page_hidden = False
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            maxclass = box.get("maxclass", "")
            if not maxclass.startswith("live.") or maxclass in ("live.tab", "live.comment"):
                continue
            saa = box.get("saved_attribute_attributes", {})
            ln = saa.get("valueof", {}).get("parameter_longname", "")
            if not ln:
                continue
            hidden = box.get("hidden", 0)
            # Find which page this control is on by checking group
            if "Pitch" in ln:
                # Pitch should be on the first page (lowest GROUP_PRIORITY)
                first_page_found = True
                assert hidden == 0, f"First page control {ln} should have hidden=0, got {hidden}"
            else:
                # Other pages should have hidden=1 (at least some)
                if hidden == 1:
                    other_page_hidden = True

        assert first_page_found, "No first-page (Pitch) controls found"
        assert other_page_hidden, "No hidden controls found on non-first pages"

    def test_all_controls_have_presentation(self):
        """All tab page controls still have presentation=1 and valid presentation_rect."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            maxclass = box.get("maxclass", "")
            if not maxclass.startswith("live.") or maxclass in ("live.tab", "live.comment"):
                continue
            saa = box.get("saved_attribute_attributes", {})
            if not saa.get("valueof", {}).get("parameter_longname"):
                continue
            assert box.get("presentation") == 1, \
                f"{box.get('id')} missing presentation=1"
            assert "presentation_rect" in box, \
                f"{box.get('id')} missing presentation_rect"

    def test_controls_positioned_below_tab(self):
        """Tab page controls positioned below live.tab (y starts after tab height + gap)."""
        from src.maxpat.m4l_layout import (
            layout_m4l_presentation, TOP_MARGIN, TAB_HEIGHT, TAB_GAP,
        )

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        min_control_y = TOP_MARGIN + TAB_HEIGHT + TAB_GAP
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            maxclass = box.get("maxclass", "")
            if not maxclass.startswith("live.") or maxclass in ("live.tab", "live.comment"):
                continue
            saa = box.get("saved_attribute_attributes", {})
            if not saa.get("valueof", {}).get("parameter_longname"):
                continue
            rect = box["presentation_rect"]
            # Control y must be at or below the tab + gap
            assert rect[1] >= min_control_y, \
                f"Control at y={rect[1]} overlaps tab area (min y={min_control_y})"

    def test_all_coords_whole_integers_tabbed(self):
        """All presentation_rect values in tabbed layout are whole integers (D-10)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if "presentation_rect" in box:
                rect = box["presentation_rect"]
                for i, val in enumerate(rect):
                    assert isinstance(val, int), \
                        f"presentation_rect[{i}] = {val} ({type(val).__name__}) " \
                        f"on {box.get('id', '?')} -- must be int"

    def test_devicewidth_updated_for_tab_content(self):
        """devicewidth updated to fit tab content."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        # All controls must fit within devicewidth
        dw = patch["patcher"].get("devicewidth", 300)
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if "presentation_rect" in box:
                rect = box["presentation_rect"]
                right = rect[0] + rect[2]
                assert right <= dw, \
                    f"Control right edge {right} exceeds devicewidth {dw}"


# ===========================================================================
# TestTabWiring
# ===========================================================================

class TestTabWiring:
    """Wiring chain: live.tab -> select -> messages -> thispatcher."""

    def _make_tabbed_patch(self):
        """Create a patch that triggers tabbed layout."""
        specs = _make_many_controls(12, ["Pitch", "Filter", "Amp", "Mod"])
        return _make_m4l_patch(specs)

    def test_thispatcher_added(self):
        """Tabbed layout adds thispatcher box to the patch."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        tp_boxes = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "thispatcher"
        ]
        assert len(tp_boxes) == 1, f"Expected 1 thispatcher, found {len(tp_boxes)}"

    def test_select_added(self):
        """Tabbed layout creates select object with N outputs for N tab pages."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        select_boxes = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "newobj"
            and "select" in (entry["box"].get("text", ""))
        ]
        assert len(select_boxes) >= 1, "No select object found in patch"

    def test_message_boxes_contain_script_commands(self):
        """Message boxes contain 'script show' / 'script hide' text."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        messages = [
            entry["box"] for entry in patch["patcher"]["boxes"]
            if entry["box"].get("maxclass") == "message"
        ]
        show_found = any("script show" in m.get("text", "") for m in messages)
        hide_found = any("script hide" in m.get("text", "") for m in messages)
        assert show_found, "No 'script show' message found"
        assert hide_found, "No 'script hide' message found"

    def test_wiring_chain_exists(self):
        """Patchlines connect live.tab -> select -> messages -> thispatcher."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        patch = self._make_tabbed_patch()
        layout_m4l_presentation(patch)

        lines = patch["patcher"].get("lines", [])
        # Must have patchlines connecting the wiring chain
        assert len(lines) >= 3, f"Expected at least 3 patchlines for wiring, got {len(lines)}"

        # Verify chain by collecting source->dest pairs
        box_ids = {}
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            box_ids[box.get("id")] = box.get("maxclass", "")

        # Check that live.tab connects to something
        tab_id = None
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if box.get("maxclass") == "live.tab":
                tab_id = box.get("id")
                break

        assert tab_id is not None, "live.tab not found"
        tab_connects = [
            l for l in lines
            if l.get("patchline", {}).get("source", [None])[0] == tab_id
        ]
        assert len(tab_connects) >= 1, "live.tab has no outgoing connections"

    def test_varnames_with_layout_prefix(self):
        """Each tab page's controls get varname with _layout_ prefix if no existing varname."""
        from src.maxpat.m4l_layout import layout_m4l_presentation, LAYOUT_VARNAME_PREFIX

        # Create controls without varnames
        controls = []
        for i in range(12):
            group = ["Pitch", "Filter", "Amp", "Mod"][i % 4]
            controls.append(_make_live_control(
                box_id=f"obj-{i + 1}",
                maxclass="live.dial",
                longname=f"{group} Param {i}",
                # No varname set
            ))
        patch = _make_patch_with_controls(controls)
        layout_m4l_presentation(patch)

        # Controls should now have varnames with _layout_ prefix
        varnames = []
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            vn = box.get("varname", "")
            if vn and box.get("maxclass") == "live.dial":
                varnames.append(vn)

        assert len(varnames) > 0, "No varnames assigned to controls"
        for vn in varnames:
            assert vn.startswith(LAYOUT_VARNAME_PREFIX), \
                f"Varname '{vn}' should start with '{LAYOUT_VARNAME_PREFIX}'"

    def test_existing_varnames_preserved(self):
        """Controls with existing varname keep it (Pitfall 3)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        # Create enough controls to trigger tabbed, some with varnames
        controls = []
        for i in range(12):
            group = ["Pitch", "Filter", "Amp", "Mod"][i % 4]
            vn = f"my_param_{i}" if i < 3 else None
            controls.append(_make_live_control(
                box_id=f"obj-{i + 1}",
                maxclass="live.dial",
                longname=f"{group} Param {i}",
                varname=vn,
            ))
        patch = _make_patch_with_controls(controls)
        layout_m4l_presentation(patch)

        # First 3 controls should keep original varnames
        for i in range(3):
            box = patch["patcher"]["boxes"][i]["box"]
            assert box.get("varname") == f"my_param_{i}", \
                f"Existing varname overwritten: {box.get('varname')}"


# ===========================================================================
# TestTabSpecialCases
# ===========================================================================

class TestTabSpecialCases:
    """live.gain~ on first page, special control handling."""

    def test_gain_always_first_page(self):
        """live.gain~ always placed on first page, never hidden (Pitfall 1)."""
        from src.maxpat.m4l_layout import layout_m4l_presentation

        # Put live.gain~ in "Amp" group, which may not be the first tab page
        specs = [
            ("live.dial", "Pitch Tune"),
            ("live.dial", "Pitch Detune"),
            ("live.dial", "Pitch Fine"),
            ("live.dial", "Filter Cutoff"),
            ("live.dial", "Filter Resonance"),
            ("live.dial", "Filter Drive"),
            ("live.gain~", "Amp Volume"),
            ("live.dial", "Mod Depth"),
            ("live.dial", "Mod Rate"),
            ("live.dial", "Mod Shape"),
        ]
        patch = _make_m4l_patch(specs)
        layout_m4l_presentation(patch)

        # live.gain~ should NOT be hidden
        for entry in patch["patcher"]["boxes"]:
            box = entry["box"]
            if box.get("maxclass") == "live.gain~":
                assert box.get("hidden", 0) == 0, \
                    "live.gain~ should never be hidden (always first page)"
                break
        else:
            pytest.fail("live.gain~ not found in patch")
