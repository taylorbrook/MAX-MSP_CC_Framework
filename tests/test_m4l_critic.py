"""Tests for M4L critic -- validates M4L device correctness.

Covers VALID-01 (gain~/plugout~), VALID-02 (device completeness),
VALID-03 (parameter uniqueness), auto-detection wiring, device quality,
and terminal/IO name set updates.
"""

from __future__ import annotations

import pytest

from src.maxpat.critics.base import CriticResult


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _make_patch(boxes: list[dict], lines: list[dict], **patcher_props) -> dict:
    """Build a minimal patch_dict."""
    patcher = {
        "boxes": [{"box": b} for b in boxes],
        "lines": [{"patchline": pl} for pl in lines],
    }
    patcher.update(patcher_props)
    return {"patcher": patcher}


def _make_m4l_patch(
    box_names: list[str],
    lines: list[dict] | None = None,
    maxclass_overrides: dict[str, str] | None = None,
    extra_boxes: list[dict] | None = None,
    **patcher_props,
) -> dict:
    """Build a minimal M4L patch with specified box names.

    Args:
        box_names: List of object names to include as newobj boxes.
        lines: Optional patchlines.
        maxclass_overrides: Map of box text -> maxclass (for live.thisdevice etc).
        extra_boxes: Additional fully-specified box dicts to include.
        **patcher_props: Extra patcher-level properties.
    """
    if maxclass_overrides is None:
        maxclass_overrides = {}
    boxes = []
    for i, name in enumerate(box_names):
        box = {
            "id": f"obj-{i + 1}",
            "maxclass": maxclass_overrides.get(name, "newobj"),
            "text": name,
            "numinlets": 2,
            "numoutlets": 1,
            "outlettype": ["signal"] if name.endswith("~") else [""],
        }
        # live.thisdevice uses its own maxclass
        if name == "live.thisdevice":
            box["maxclass"] = "live.thisdevice"
            box["outlettype"] = ["", ""]
            box["numoutlets"] = 2
        boxes.append(box)
    if extra_boxes:
        boxes.extend(extra_boxes)
    return _make_patch(boxes, lines or [], **patcher_props)


# ===========================================================================
# TestTerminalNames -- plugout~ in dsp_critic, validation, layout
# ===========================================================================

class TestTerminalNames:
    def test_plugout_in_dsp_critic_terminals(self):
        from src.maxpat.critics.dsp_critic import _TERMINAL_NAMES
        assert "plugout~" in _TERMINAL_NAMES

    def test_plugout_in_validation_terminals(self):
        from src.maxpat.validation import _TERMINAL_NAMES
        assert "plugout~" in _TERMINAL_NAMES

    def test_plugin_in_layout_io_names(self):
        from src.maxpat.layout import _IO_OBJECT_NAMES
        assert "plugin~" in _IO_OBJECT_NAMES

    def test_plugout_in_layout_io_names(self):
        from src.maxpat.layout import _IO_OBJECT_NAMES
        assert "plugout~" in _IO_OBJECT_NAMES


# ===========================================================================
# TestGainPlugout -- VALID-01
# ===========================================================================

class TestGainPlugout:
    def test_gain_directly_to_plugout_blocker(self):
        """gain~ connected to plugout~ should produce a blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "cycle~ 440",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "gain~",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "plugout~",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_m4l(patch, device_type="audio_effect")
        blockers = [r for r in results if r.severity == "blocker" and "gain~" in r.finding and "plugout~" in r.finding]
        assert len(blockers) >= 1, f"Expected gain~/plugout~ blocker, got: {results}"

    def test_proper_gain_staging_no_blocker(self):
        """*~ 0.5 before plugout~ should not trigger gain~/plugout~ blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "newobj",
                "text": "cycle~ 440",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "*~ 0.5",
                "numinlets": 2,
                "numoutlets": 1,
                "outlettype": ["signal"],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "plugout~",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        lines = [
            {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
            {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
        ]
        patch = _make_patch(boxes, lines)
        results = review_m4l(patch, device_type="audio_effect")
        gain_blockers = [r for r in results if r.severity == "blocker" and "gain~" in r.finding]
        assert len(gain_blockers) == 0, f"Expected no gain~ blocker, got: {gain_blockers}"


# ===========================================================================
# TestDeviceCompleteness -- VALID-02
# ===========================================================================

class TestDeviceCompleteness:
    def test_audio_effect_missing_plugout(self):
        """audio_effect without plugout~ -> blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["plugin~", "live.thisdevice"])
        results = review_m4l(patch, device_type="audio_effect")
        blockers = [r for r in results if r.severity == "blocker" and "plugout~" in r.finding]
        assert len(blockers) >= 1

    def test_audio_effect_complete(self):
        """audio_effect with all required objects -> no completeness blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["plugin~", "plugout~", "live.thisdevice"])
        results = review_m4l(patch, device_type="audio_effect")
        completeness_blockers = [r for r in results if r.severity == "blocker" and "missing" in r.finding.lower()]
        assert len(completeness_blockers) == 0, f"Got unexpected completeness blockers: {completeness_blockers}"

    def test_instrument_missing_midiin(self):
        """instrument without midiin -> blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["plugout~", "midiout", "live.thisdevice"])
        results = review_m4l(patch, device_type="instrument")
        blockers = [r for r in results if r.severity == "blocker" and "midiin" in r.finding]
        assert len(blockers) >= 1

    def test_instrument_missing_midiout(self):
        """instrument without midiout -> blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["plugout~", "midiin", "live.thisdevice"])
        results = review_m4l(patch, device_type="instrument")
        blockers = [r for r in results if r.severity == "blocker" and "midiout" in r.finding]
        assert len(blockers) >= 1

    def test_instrument_complete(self):
        """instrument with all required objects -> no completeness blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["plugout~", "midiin", "midiout", "live.thisdevice"])
        results = review_m4l(patch, device_type="instrument")
        completeness_blockers = [r for r in results if r.severity == "blocker" and "missing" in r.finding.lower()]
        assert len(completeness_blockers) == 0

    def test_midi_effect_missing_live_thisdevice(self):
        """midi_effect without live.thisdevice -> blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["midiin", "midiout"])
        results = review_m4l(patch, device_type="midi_effect")
        blockers = [r for r in results if r.severity == "blocker" and "live.thisdevice" in r.finding]
        assert len(blockers) >= 1

    def test_midi_effect_complete(self):
        """midi_effect with all required objects -> no completeness blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(["midiin", "midiout", "live.thisdevice"])
        results = review_m4l(patch, device_type="midi_effect")
        completeness_blockers = [r for r in results if r.severity == "blocker" and "missing" in r.finding.lower()]
        assert len(completeness_blockers) == 0


# ===========================================================================
# TestParameterUniqueness -- VALID-03
# ===========================================================================

class TestParameterUniqueness:
    def test_duplicate_longname_blocker(self):
        """Two boxes with same parameter_longname -> blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "Filter Cutoff",
                    },
                },
            },
            {
                "id": "obj-2",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "Filter Cutoff",
                    },
                },
            },
            {
                "id": "obj-3",
                "maxclass": "live.thisdevice",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", ""],
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_m4l(patch, device_type="audio_effect")
        blockers = [r for r in results if r.severity == "blocker" and "duplicate" in r.finding.lower()]
        assert len(blockers) >= 1
        # Both box IDs should be mentioned
        assert "obj-1" in blockers[0].finding or "obj-2" in blockers[0].finding

    def test_unique_longnames_no_blocker(self):
        """All unique parameter_longnames -> no blocker."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "Filter Cutoff",
                    },
                },
            },
            {
                "id": "obj-2",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "Filter Resonance",
                    },
                },
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_m4l(patch, device_type="audio_effect")
        dup_blockers = [r for r in results if r.severity == "blocker" and "duplicate" in r.finding.lower()]
        assert len(dup_blockers) == 0

    def test_empty_longname_warning(self):
        """Empty/missing parameter_longname -> warning, not counted as duplicate."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "",
                    },
                },
            },
            {
                "id": "obj-2",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "",
                    },
                },
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_m4l(patch, device_type="audio_effect")
        warnings = [r for r in results if r.severity == "warning" and "longname" in r.finding.lower()]
        assert len(warnings) >= 2  # Each empty one gets a warning
        dup_blockers = [r for r in results if r.severity == "blocker" and "duplicate" in r.finding.lower()]
        assert len(dup_blockers) == 0  # Empty not counted as dup

    def test_duplicate_in_subpatcher_blocker(self):
        """Duplicate longname in subpatcher vs top-level -> blocker (recursive)."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                "parameter_enable": 1,
                "saved_attribute_attributes": {
                    "valueof": {
                        "parameter_longname": "My Param",
                    },
                },
            },
            {
                "id": "obj-2",
                "maxclass": "newobj",
                "text": "p my_sub",
                "numinlets": 1,
                "numoutlets": 1,
                "outlettype": [""],
                "patcher": {
                    "boxes": [
                        {"box": {
                            "id": "sub-obj-1",
                            "maxclass": "live.slider",
                            "numinlets": 1,
                            "numoutlets": 2,
                            "outlettype": ["", "float"],
                            "parameter_enable": 1,
                            "saved_attribute_attributes": {
                                "valueof": {
                                    "parameter_longname": "My Param",
                                },
                            },
                        }},
                    ],
                    "lines": [],
                },
            },
            {
                "id": "obj-3",
                "maxclass": "live.thisdevice",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", ""],
            },
        ]
        patch = _make_patch(boxes, [])
        results = review_m4l(patch, device_type="audio_effect")
        blockers = [r for r in results if r.severity == "blocker" and "duplicate" in r.finding.lower()]
        assert len(blockers) >= 1


# ===========================================================================
# TestAutoDetection -- D-03
# ===========================================================================

class TestAutoDetection:
    def test_detect_audio_effect(self):
        """plugin~ + plugout~ + live.thisdevice -> audio_effect."""
        from src.maxpat.critics import _detect_m4l_device

        patch = _make_m4l_patch(["plugin~", "plugout~", "live.thisdevice"])
        assert _detect_m4l_device(patch) == "audio_effect"

    def test_detect_instrument(self):
        """plugout~ + midiin + live.thisdevice -> instrument."""
        from src.maxpat.critics import _detect_m4l_device

        patch = _make_m4l_patch(["plugout~", "midiin", "midiout", "live.thisdevice"])
        assert _detect_m4l_device(patch) == "instrument"

    def test_detect_midi_effect(self):
        """midiin + midiout + live.thisdevice, no plugout~ -> midi_effect."""
        from src.maxpat.critics import _detect_m4l_device

        patch = _make_m4l_patch(["midiin", "midiout", "live.thisdevice"])
        assert _detect_m4l_device(patch) == "midi_effect"

    def test_detect_none_for_non_m4l(self):
        """Non-M4L patch returns None."""
        from src.maxpat.critics import _detect_m4l_device

        patch = _make_m4l_patch(["cycle~", "dac~"])
        assert _detect_m4l_device(patch) is None

    def test_review_patch_includes_m4l_findings(self):
        """review_patch() on M4L device returns M4L critic findings."""
        from src.maxpat.critics import review_patch

        # audio_effect missing plugout~ -> should get M4L completeness blocker
        patch = _make_m4l_patch(
            ["plugin~", "live.thisdevice"],
            openinpresentation=1,
            devicewidth=300.0,
        )
        results = review_patch(patch)
        m4l_blockers = [r for r in results if r.severity == "blocker" and "plugout~" in r.finding]
        assert len(m4l_blockers) >= 1, f"Expected M4L blocker about plugout~, got: {results}"

    def test_review_patch_no_m4l_findings_for_normal_patch(self):
        """review_patch() on non-M4L patch returns no M4L findings."""
        from src.maxpat.critics import review_patch

        patch = _make_patch(
            [
                {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "text": "cycle~ 440",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": ["signal"],
                },
                {
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "text": "*~ 0.5",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": ["signal"],
                },
                {
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "text": "dac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                },
            ],
            [
                {"source": ["obj-1", 0], "destination": ["obj-2", 0]},
                {"source": ["obj-2", 0], "destination": ["obj-3", 0]},
            ],
        )
        results = review_patch(patch)
        m4l_results = [r for r in results if "m4l" in r.finding.lower() or "plugout~" in r.finding.lower() or "live.thisdevice" in r.finding.lower()]
        assert len(m4l_results) == 0, f"Non-M4L patch should not have M4L findings, got: {m4l_results}"


# ===========================================================================
# TestDeviceQuality -- D-04
# ===========================================================================

class TestDeviceQuality:
    def test_missing_openinpresentation_warning(self):
        """Missing openinpresentation=1 -> warning."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(
            ["plugin~", "plugout~", "live.thisdevice"],
            devicewidth=300.0,
            # No openinpresentation
        )
        results = review_m4l(patch, device_type="audio_effect")
        warnings = [r for r in results if r.severity == "warning" and "openinpresentation" in r.finding.lower()]
        assert len(warnings) >= 1

    def test_missing_devicewidth_warning(self):
        """Missing devicewidth -> warning."""
        from src.maxpat.critics.m4l_critic import review_m4l

        patch = _make_m4l_patch(
            ["plugin~", "plugout~", "live.thisdevice"],
            openinpresentation=1,
            # No devicewidth
        )
        results = review_m4l(patch, device_type="audio_effect")
        warnings = [r for r in results if r.severity == "warning" and "devicewidth" in r.finding.lower()]
        assert len(warnings) >= 1

    def test_live_control_missing_parameter_enable_warning(self):
        """live.* control without parameter_enable=1 -> warning."""
        from src.maxpat.critics.m4l_critic import review_m4l

        boxes = [
            {
                "id": "obj-1",
                "maxclass": "live.dial",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", "float"],
                # Missing parameter_enable
            },
            {
                "id": "obj-2",
                "maxclass": "live.thisdevice",
                "numinlets": 1,
                "numoutlets": 2,
                "outlettype": ["", ""],
            },
            {
                "id": "obj-3",
                "maxclass": "newobj",
                "text": "plugout~",
                "numinlets": 2,
                "numoutlets": 0,
                "outlettype": [],
            },
        ]
        patch = _make_patch(boxes, [], openinpresentation=1, devicewidth=300.0)
        results = review_m4l(patch, device_type="audio_effect")
        warnings = [r for r in results if r.severity == "warning" and "parameter_enable" in r.finding.lower()]
        assert len(warnings) >= 1
