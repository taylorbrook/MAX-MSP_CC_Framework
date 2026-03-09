"""ODB-07: Validate RNBO compatibility flags on all objects."""

import pytest


# Domains to check for RNBO flags (RNBO domain itself is the reference, not checked)
CORE_DOMAINS = ["max", "msp", "jitter", "mc", "gen", "m4l", "packages"]


class TestRnboFlag:
    """Every core-domain object must have an rnbo_compatible boolean flag."""

    def test_every_object_has_rnbo_flag(self, all_objects):
        """Every object in core domains must have rnbo_compatible field (boolean)."""
        # Filter out RNBO-domain objects (they are the reference set)
        core_objects = [o for o in all_objects if o.get("domain") != "RNBO"]
        for obj in core_objects:
            assert "rnbo_compatible" in obj, (
                f"Missing rnbo_compatible flag: {obj.get('name', '?')} "
                f"(domain={obj.get('domain', '?')})"
            )
            assert isinstance(obj["rnbo_compatible"], bool), (
                f"rnbo_compatible not bool for {obj.get('name', '?')}: "
                f"{type(obj['rnbo_compatible'])}"
            )

    def test_cycle_tilde_is_rnbo_compatible(self, object_by_name):
        """cycle~ must be marked as RNBO-compatible."""
        cycle = object_by_name("cycle~")
        assert cycle is not None, "cycle~ not found"
        assert cycle.get("rnbo_compatible") is True, (
            f"cycle~ should be rnbo_compatible=True, got {cycle.get('rnbo_compatible')}"
        )

    def test_at_least_150_rnbo_compatible(self, all_objects):
        """At least 150 core-domain objects should be RNBO-compatible."""
        core_objects = [o for o in all_objects if o.get("domain") != "RNBO"]
        rnbo_true = [o for o in core_objects if o.get("rnbo_compatible") is True]
        assert len(rnbo_true) >= 150, (
            f"Expected >= 150 RNBO-compatible objects, found {len(rnbo_true)}"
        )

    def test_dac_tilde_not_rnbo_compatible(self, object_by_name):
        """dac~ should NOT be RNBO-compatible (RNBO uses rnbo~ not dac~)."""
        dac = object_by_name("dac~")
        assert dac is not None, "dac~ not found"
        assert dac.get("rnbo_compatible") is False, (
            f"dac~ should be rnbo_compatible=False, got {dac.get('rnbo_compatible')}"
        )

    def test_jitter_objects_not_rnbo(self, objects_by_domain):
        """Jitter objects should not be RNBO-compatible (RNBO has no video)."""
        jitter = objects_by_domain.get("jitter", {})
        for name, obj in jitter.items():
            assert obj.get("rnbo_compatible") is False, (
                f"Jitter object {name} should not be RNBO-compatible"
            )
