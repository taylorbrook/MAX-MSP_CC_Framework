# Manual Test Protocol

How `/max:test` generates checklists and how results are recorded.

## Checklist Generation

The `generate_test_checklist()` function scans a patch dictionary for object types and builds relevant manual test steps.

```python
from src.maxpat.testing import generate_test_checklist

checklist = generate_test_checklist(
    patch_dict=patch,
    patch_name="my-synth",
    patch_path="patches/my-synth/generated/my-synth.maxpat"
)
```

### Object Detection

The function detects object types in the patch and generates appropriate test steps:
- **Audio objects** (dac~, adc~, cycle~, etc.) -- audio output/input tests
- **MIDI objects** (notein, noteout, ctlin, etc.) -- MIDI I/O tests
- **UI objects** (dial, slider, toggle, etc.) -- control interaction tests
- **Gen~ objects** -- DSP processing tests
- **Subpatchers** -- navigation and encapsulation tests

### Checklist Format

```markdown
# Manual Test: my-synth.maxpat

## Setup
1. Open `patches/my-synth/generated/my-synth.maxpat` in MAX 9
2. Ensure audio is ON (Options > Audio Status > Audio On)

## Tests

### Test 1: Audio Output
- **Action:** Click the toggle connected to dac~
- **Expected:** You should hear audio from your speakers/headphones
- **Result:** [ ] Pass  [ ] Fail

### Test 2: MIDI Input
- **Action:** Play a note on your MIDI controller
- **Expected:** Pitch changes, note displays in number box
- **Result:** [ ] Pass  [ ] Fail
```

Each step has:
1. A numbered test name
2. A specific action to take in MAX
3. An expected result to observe
4. Pass/Fail checkboxes

## Result Recording

After the user completes testing:

```python
from src.maxpat.testing import save_test_results

save_test_results(
    project_dir=Path("patches/my-synth"),
    test_name="my-synth",
    results_md="[completed checklist markdown with Pass/Fail marked]"
)
```

Results are saved to `test-results/test-NNN.md` with incrementing numbers.

## Integration

The lifecycle agent:
1. Gets the active project from `get_active_project()`
2. Reads generated patches from `generated/` directory
3. Calls `generate_test_checklist()` for each patch
4. Presents the combined checklist to the user
5. After user reports results, calls `save_test_results()`
6. Updates project status to reflect test outcomes
