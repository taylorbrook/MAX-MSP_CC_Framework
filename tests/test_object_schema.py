"""ODB-01: Validate every object has the required schema fields."""

import pytest


class TestObjectSchema:
    """Every object in the database must have the required fields."""

    def test_every_object_has_name(self, all_objects):
        """Every object must have a non-empty name string."""
        for obj in all_objects:
            assert isinstance(obj.get("name"), str), f"Missing name: {obj}"
            assert obj["name"].strip(), f"Empty name: {obj}"

    def test_every_object_has_maxclass(self, all_objects):
        """Every object must have a non-empty maxclass string."""
        for obj in all_objects:
            assert isinstance(obj.get("maxclass"), str), f"Missing maxclass: {obj.get('name', '?')}"
            assert obj["maxclass"].strip(), f"Empty maxclass: {obj.get('name', '?')}"

    def test_every_object_has_inlets_list(self, all_objects):
        """Every object must have an inlets field (list, may be empty for some objects)."""
        for obj in all_objects:
            assert isinstance(obj.get("inlets"), list), (
                f"Missing or non-list inlets: {obj.get('name', '?')}"
            )

    def test_every_object_has_outlets_list(self, all_objects):
        """Every object must have an outlets field (list, may be empty for some objects)."""
        for obj in all_objects:
            assert isinstance(obj.get("outlets"), list), (
                f"Missing or non-list outlets: {obj.get('name', '?')}"
            )

    def test_every_object_has_arguments_list(self, all_objects):
        """Every object must have an arguments field (list, may be empty)."""
        for obj in all_objects:
            assert isinstance(obj.get("arguments"), list), (
                f"Missing or non-list arguments: {obj.get('name', '?')}"
            )

    def test_every_object_has_messages_list(self, all_objects):
        """Every object must have a messages field (list, may be empty)."""
        for obj in all_objects:
            assert isinstance(obj.get("messages"), list), (
                f"Missing or non-list messages: {obj.get('name', '?')}"
            )

    def test_every_object_has_domain(self, all_objects):
        """Every object must have a non-empty domain string."""
        for obj in all_objects:
            assert isinstance(obj.get("domain"), str), (
                f"Missing domain: {obj.get('name', '?')}"
            )
            assert obj["domain"].strip(), f"Empty domain: {obj.get('name', '?')}"

    def test_every_object_has_verified_flag(self, all_objects):
        """Every object must have a verified boolean field."""
        for obj in all_objects:
            assert isinstance(obj.get("verified"), bool), (
                f"Missing or non-bool verified: {obj.get('name', '?')}"
            )


class TestSpotChecks:
    """Spot-check critical objects for correct schema values."""

    def test_cycle_tilde_has_2_inlets_1_outlet(self, object_by_name):
        """cycle~ must have 2 inlets and 1 outlet."""
        cycle = object_by_name("cycle~")
        assert cycle is not None, "cycle~ not found in database"
        assert len(cycle["inlets"]) == 2, f"cycle~ expected 2 inlets, got {len(cycle['inlets'])}"
        assert len(cycle["outlets"]) == 1, f"cycle~ expected 1 outlet, got {len(cycle['outlets'])}"

    def test_trigger_has_1_inlet_and_gte_2_outlets(self, object_by_name):
        """trigger must have 1 inlet and >= 2 outlets."""
        trigger = object_by_name("trigger")
        assert trigger is not None, "trigger not found in database"
        assert len(trigger["inlets"]) == 1, (
            f"trigger expected 1 inlet, got {len(trigger['inlets'])}"
        )
        assert len(trigger["outlets"]) >= 2, (
            f"trigger expected >= 2 outlets, got {len(trigger['outlets'])}"
        )

    def test_dac_tilde_has_signal_inlets(self, object_by_name):
        """dac~ must have signal inlets."""
        dac = object_by_name("dac~")
        assert dac is not None, "dac~ not found in database"
        assert len(dac["inlets"]) >= 1, "dac~ should have at least 1 inlet"
        # At least one inlet should be signal type
        signal_inlets = [i for i in dac["inlets"] if i.get("signal", False)]
        assert len(signal_inlets) >= 1, "dac~ should have at least one signal inlet"
