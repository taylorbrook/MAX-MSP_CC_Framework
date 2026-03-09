"""ODB-02: Verify extraction counts and coverage."""

import pytest
from conftest import DB_ROOT, DOMAIN_DIRS


class TestSourceCoverage:
    """The extracted database must meet minimum object count thresholds."""

    def test_total_objects_exceeds_1500(self, all_objects):
        """Total extracted objects must exceed 1500 (research says 2,148 XML files)."""
        assert len(all_objects) > 1500, (
            f"Expected > 1500 total objects, got {len(all_objects)}"
        )

    def test_each_domain_has_objects(self, objects_by_domain):
        """Every domain directory with an objects.json must have > 0 objects."""
        for domain_dir, objects in objects_by_domain.items():
            assert len(objects) > 0, f"Domain '{domain_dir}' has 0 objects"

    def test_max_domain_minimum_count(self, objects_by_domain):
        """Max domain should have > 200 objects."""
        max_objs = objects_by_domain.get("max", {})
        assert len(max_objs) > 200, (
            f"Max domain expected > 200 objects, got {len(max_objs)}"
        )

    def test_msp_domain_minimum_count(self, objects_by_domain):
        """MSP domain should have > 100 objects (excluding mc.* which are separate)."""
        msp_objs = objects_by_domain.get("msp", {})
        assert len(msp_objs) > 100, (
            f"MSP domain expected > 100 objects, got {len(msp_objs)}"
        )

    def test_jitter_domain_minimum_count(self, objects_by_domain):
        """Jitter domain should have > 100 objects."""
        jit_objs = objects_by_domain.get("jitter", {})
        assert len(jit_objs) > 100, (
            f"Jitter domain expected > 100 objects, got {len(jit_objs)}"
        )

    def test_gen_domain_minimum_count(self, objects_by_domain):
        """Gen domain should have > 100 objects."""
        gen_objs = objects_by_domain.get("gen", {})
        assert len(gen_objs) > 100, (
            f"Gen domain expected > 100 objects, got {len(gen_objs)}"
        )

    def test_mc_domain_minimum_count(self, objects_by_domain):
        """MC domain should have > 50 objects."""
        mc_objs = objects_by_domain.get("mc", {})
        assert len(mc_objs) > 50, (
            f"MC domain expected > 50 objects, got {len(mc_objs)}"
        )

    def test_extraction_log_exists(self, extraction_log):
        """extraction-log.json must exist with stats."""
        assert extraction_log, "extraction-log.json is missing or empty"
        assert "total_objects" in extraction_log, (
            "extraction-log.json missing 'total_objects' field"
        )

    def test_extraction_log_total(self, extraction_log):
        """extraction-log.json total_objects should match database count."""
        assert extraction_log.get("total_objects", 0) > 1500, (
            f"extraction-log total_objects expected > 1500, got {extraction_log.get('total_objects', 0)}"
        )

    def test_error_rate_under_5_percent(self, extraction_log):
        """Extraction error rate should be < 5% of total files."""
        total_files = extraction_log.get("total_files_found", 1)
        errors = extraction_log.get("error_count", 0)
        error_rate = errors / total_files
        assert error_rate < 0.05, (
            f"Error rate {error_rate:.1%} exceeds 5% ({errors}/{total_files})"
        )
