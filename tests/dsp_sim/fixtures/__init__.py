"""Phase 32 regression mirror fixtures (D-06, D-11).

Hand-coded numpy mirrors that reproduce the bassoon v0.4.0 (group-delay
compensation -> phase_drift) and v0.4.1 (high-Q in-loop biquad ->
mode_competition) regressions. Per D-11 these are NOT auto-extracted from
the .gendsp; they target the failure mechanism only.
"""
