"""Plan 30-01: audit_signal_role_coverage() unit tests.

Covers the new audit function shape (msp/mc per-domain bucketing),
gap_count derivation, by_role enum tally, edge cases (mixed audited
outlets, empty I/O excluded, non-MSP/MC excluded), and sort stability.

Pure shape tests -- no data migration verification (Plans 30-02/03/04
add migration-specific coverage)."""

from __future__ import annotations

import json
from pathlib import Path

import pytest

from src.maxpat.db_lookup import (
    ObjectDatabase,
    _SIGNAL_ROLE_ENUM,
)


# RED-anchor: minimal probe that the method exists and returns the locked
# top-level shape. Task 1 GREEN will satisfy this; Task 2 expands the suite
# below into full coverage of D-13 + D-15.


class TestAuditSignalRoleCoverageRedAnchor:
    """Plan 30-01 Task 1 RED anchor — the function exists and returns
    a {msp, mc} dict against the production DB."""

    def test_method_exists_and_returns_dict_with_msp_and_mc(self):
        db = ObjectDatabase()
        result = db.audit_signal_role_coverage()
        assert set(result) == {"msp", "mc"}
