"""ODB-05: Verify domain classification for every object."""

import pytest

VALID_DOMAINS = {"Max", "MSP", "Jitter", "MC", "Gen", "M4L", "Packages", "RNBO"}


class TestDomainClassification:
    """Every object must have a valid domain and normalized module."""

    def test_every_object_has_valid_domain(self, all_objects):
        """domain field must be one of the allowed values."""
        for obj in all_objects:
            assert obj.get("domain") in VALID_DOMAINS, (
                f"Object '{obj.get('name', '?')}' has invalid domain: '{obj.get('domain')}'. "
                f"Must be one of {VALID_DOMAINS}"
            )

    def test_every_object_has_module(self, all_objects):
        """module field must be a normalized lowercase string."""
        for obj in all_objects:
            module = obj.get("module", "")
            assert isinstance(module, str), (
                f"Object '{obj.get('name', '?')}' module is not a string"
            )
            assert module == module.lower() or module == "", (
                f"Object '{obj.get('name', '?')}' module '{module}' is not normalized lowercase"
            )


class TestDomainSpotChecks:
    """Key objects must be in the correct domain."""

    def test_cycle_tilde_is_msp(self, object_by_name):
        """cycle~ should be in MSP domain."""
        cycle = object_by_name("cycle~")
        assert cycle is not None, "cycle~ not found"
        assert cycle["domain"] == "MSP", f"cycle~ domain should be MSP, got {cycle['domain']}"

    def test_trigger_is_max(self, object_by_name):
        """trigger should be in Max domain."""
        trigger = object_by_name("trigger")
        assert trigger is not None, "trigger not found"
        assert trigger["domain"] == "Max", (
            f"trigger domain should be Max, got {trigger['domain']}"
        )

    def test_jit_matrix_is_jitter(self, object_by_name):
        """jit.matrix should be in Jitter domain."""
        jm = object_by_name("jit.matrix")
        assert jm is not None, "jit.matrix not found"
        assert jm["domain"] == "Jitter", (
            f"jit.matrix domain should be Jitter, got {jm['domain']}"
        )

    def test_mc_cycle_tilde_is_mc(self, object_by_name):
        """mc.cycle~ should be in MC domain."""
        mc_cycle = object_by_name("mc.cycle~")
        assert mc_cycle is not None, "mc.cycle~ not found"
        assert mc_cycle["domain"] == "MC", (
            f"mc.cycle~ domain should be MC, got {mc_cycle['domain']}"
        )
