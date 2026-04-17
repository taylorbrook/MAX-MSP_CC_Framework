---
phase: quick
plan: 260416-vji
type: execute
wave: 1
depends_on: []
autonomous: false
---

<objective>
Audit the community-package portion of `.claude/max-objects/` against the user's installed Max packages (15 community packages copied to `.claude/max-objects/_pkg-source/`), find missing objects and incomplete entries, and update the DB.
</objective>

<scope>
Installed packages only: abclib, ABL Effect Modules, bach, catart-mubu, CNMAT Externals, cv.jit, dada, ears, ease, FlowSwing, FluidCorpusManipulation, grainflow, ml.star, nn_tilde, RNBO. Skip RNBO (overlaps with bundled `rnbo/objects.json`). Skip 5 uninstalled packages (Cage, Odot, IRCAM Spat, Rhythmic Time Toolkit, RNBO Guitar) — keep their existing curated stubs.

Source-of-truth: `.maxref.xml` refpages (XML pipeline) where available; `.maxpat` abstractions or `.maxhelp` newobj instances for packages without refpages.
</scope>

<tasks>
1. Patch `.claude/scripts/extract_objects.py` to discover community-layout `.maxref.xml` refpages and to add new packages to `package_info.json`.
2. Run extraction across the 11 XML-based packages; sanity-fix `maxclass == name` bug across all 17 package directories.
3. For 3 abstraction-only packages (ABL Effect Modules, catart-mubu, cv.jit), build entries from `.maxpat` inlet/outlet boxes or `.maxhelp` newobj instances.
4. Reconcile `package_info.json`: sync counts to disk totals, add `installed` flag, fix stale `extracted: false`, sort.
5. Write SUMMARY.md and update STATE.md "Quick Tasks Completed".
</tasks>

See SUMMARY.md for execution details.
