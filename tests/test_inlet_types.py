"""ODB-06: Validate inlet/outlet type normalization and signal classification."""

import pytest


# These are the normalized types the extraction should produce
NORMALIZED_TYPES = {
    "signal", "signal/float", "signal/int", "signal/message", "signal/list",
    "signal/mc", "mc_signal", "mc_signal/float", "mc_signal/message",
    "matrix", "texture/matrix",
    "control", "int", "float", "bang", "list", "symbol", "anything",
    "message", "number", "int/list", "bang/int", "bang/anything",
    "dict", "midievent", "inactive",
}

# Types that should NOT appear in normalized output
RAW_XML_TYPES = {"INLET_TYPE", "OUTLET_TYPE", "Signal", "Signal/Float", "List"}

SIGNAL_TYPES = {
    "signal", "signal/float", "signal/int", "signal/message",
    "signal/list", "signal/mc", "mc_signal", "mc_signal/float",
    "mc_signal/message",
}


class TestInletTypeNormalization:
    """Inlet and outlet types must be normalized, not raw XML values."""

    def test_inlets_have_type_field(self, all_objects):
        """Every inlet must have a type field with a normalized value."""
        for obj in all_objects:
            for inlet in obj.get("inlets", []):
                assert "type" in inlet, (
                    f"Object '{obj['name']}' inlet {inlet.get('id', '?')} missing type field"
                )

    def test_no_raw_xml_inlet_types(self, all_objects):
        """No raw XML type variants should appear in normalized output."""
        for obj in all_objects:
            for inlet in obj.get("inlets", []):
                assert inlet.get("type") not in RAW_XML_TYPES, (
                    f"Object '{obj['name']}' inlet {inlet.get('id', '?')} has raw XML type "
                    f"'{inlet['type']}' -- should be normalized"
                )

    def test_no_raw_xml_outlet_types(self, all_objects):
        """No raw XML type variants should appear in normalized outlet output."""
        for obj in all_objects:
            for outlet in obj.get("outlets", []):
                assert outlet.get("type") not in RAW_XML_TYPES, (
                    f"Object '{obj['name']}' outlet {outlet.get('id', '?')} has raw XML type "
                    f"'{outlet['type']}' -- should be normalized"
                )


class TestSignalBoolean:
    """Every inlet/outlet must have a signal boolean field."""

    def test_inlets_have_signal_field(self, all_objects):
        """Every inlet must have a signal boolean."""
        for obj in all_objects:
            for inlet in obj.get("inlets", []):
                assert isinstance(inlet.get("signal"), bool), (
                    f"Object '{obj['name']}' inlet {inlet.get('id', '?')} missing signal bool"
                )

    def test_outlets_have_signal_field(self, all_objects):
        """Every outlet must have a signal boolean."""
        for obj in all_objects:
            for outlet in obj.get("outlets", []):
                assert isinstance(outlet.get("signal"), bool), (
                    f"Object '{obj['name']}' outlet {outlet.get('id', '?')} missing signal bool"
                )

    def test_signal_types_have_signal_true(self, all_objects):
        """Inlets with signal types must have signal=true."""
        for obj in all_objects:
            for inlet in obj.get("inlets", []):
                if inlet.get("type") in SIGNAL_TYPES:
                    assert inlet.get("signal") is True, (
                        f"Object '{obj['name']}' inlet {inlet.get('id', '?')} has signal type "
                        f"'{inlet['type']}' but signal={inlet.get('signal')}"
                    )


class TestHotColdInlets:
    """Every inlet must have a hot boolean field."""

    def test_inlets_have_hot_field(self, all_objects):
        """Every inlet must have a hot boolean."""
        for obj in all_objects:
            for inlet in obj.get("inlets", []):
                assert isinstance(inlet.get("hot"), bool), (
                    f"Object '{obj['name']}' inlet {inlet.get('id', '?')} missing hot bool"
                )


class TestMSPSignalInlets:
    """MSP objects with ~ suffix should have at least one signal inlet or outlet."""

    # Some ~ objects are UI/control objects that don't actually carry signal
    # (e.g., filtergraph~ is a graphical filter editor with float inlets)
    TILDE_UI_EXCEPTIONS = {
        "filtergraph~", "spectroscope~", "number~", "meter~",
        "levelmeter~", "live.gain~", "live.meter~", "live.scope~",
        "waveform~", "zplane~",
    }

    def test_tilde_objects_have_signal_io(self, all_objects):
        """Objects with ~ in name should have at least one signal inlet or outlet.

        Exceptions: UI objects (filtergraph~, spectroscope~, etc.) are control-only
        despite the ~ suffix -- they have explicitly typed float/list/int inlets in XML.
        """
        failures = []
        for obj in all_objects:
            name = obj.get("name", "")
            if "~" in name and obj.get("domain") in ("MSP", "MC"):
                if name in self.TILDE_UI_EXCEPTIONS:
                    continue
                signal_inlets = [i for i in obj["inlets"] if i.get("signal")]
                signal_outlets = [o for o in obj["outlets"] if o.get("signal")]
                has_signal = len(signal_inlets) > 0 or len(signal_outlets) > 0
                if (obj["inlets"] or obj["outlets"]) and not has_signal:
                    failures.append(name)
        assert not failures, (
            f"MSP/MC objects with ~ but no signal I/O (not in exceptions): {failures}"
        )


class TestSpotCheckInlets:
    """Spot-check specific objects for correct inlet types."""

    def test_cycle_tilde_inlet_0_is_signal(self, object_by_name):
        """cycle~ inlet 0 must have signal: true."""
        cycle = object_by_name("cycle~")
        assert cycle is not None, "cycle~ not found"
        assert len(cycle["inlets"]) >= 1, "cycle~ has no inlets"
        assert cycle["inlets"][0].get("signal") is True, (
            f"cycle~ inlet 0 should have signal=true, got {cycle['inlets'][0].get('signal')}"
        )
