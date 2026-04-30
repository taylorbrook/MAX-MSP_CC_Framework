# Signal Role Review (Plan 30-03)

Curator: edit `curator_role` column for any row where you disagree with `suggested_role`, OR for low-confidence rows (suggested_role empty). Then run `python scripts/audit_signal_role.py apply` from the project root.

Confidence tiers (D-08):
- **high**: auto-applied. Override only if extraction was wrong.
- **medium**: auto-applied with `# verify` marker. Spot-check.
- **low**: NOT applied. Curator MUST fill `curator_role`.

| object | outlet_id | digest | suggested_role | confidence | curator_role |
|---|---|---|---|---|---|
| !-~ | 0 | (signal) Difference Out | audio | high |  |
| !/~ | 0 | (signal) Quotient Out | audio | high |  |
| !=~ | 0 | (signal) Comparison Result (1 or 0) | audio | high |  |
| %~ | 0 | (signal) Modulo Result | audio | high |  |
| *~ | 0 | (signal) Multiplication Result | audio | high |  |
| +=~ | 0 | (signal) Accumulator Output | audio | high |  |
| +~ | 0 | (signal) Addition Result | audio | high |  |
| -~ | 0 | (signal) Subtraction Result | audio | high |  |
| /~ | 0 | (signal) Division Result | audio | high |  |
| <=~ | 0 | (signal) Comparison Result (1 or 0) | audio | high |  |
| <~ | 0 | (signal) Comparison Result (1 or 0) | audio | high |  |
| ==~ | 0 | (signal) Comparison Result (1 or 0) | audio | high |  |
| >=~ | 0 | (signal) Comparison Result (1 or 0) | audio | high |  |
| >~ | 0 | (signal) Comparison Result (1 or 0) | audio | high |  |
| abs~ | 0 | (signal) Absolute Value of Input | audio | high |  |
| acosh~ | 0 | Acosh (x) Out | audio | high |  |
| acos~ | 0 | Acos (x) Out | audio | high |  |
| adoutput~ | 0 | (signal) Output of Audio Channel 1 | audio | high |  |
| adoutput~ | 1 | (signal) Output of Audio Channel 2 | audio | high |  |
| adsr~ | 0 | ADSR envelope | audio | high |  |
| adsr~ | 1 | new envelope trigger | audio | high |  |
| adsr~ | 2 | mute outlet | status | high |  |
| adsr~ | 3 | dump outlet |  | low | list |
| adstatus | 0 | Control output |  | low | status |
| adstatus | 1 | Control output |  | low | status |
| allpass~ | 0 | (signal) Filter Output | audio | high |  |
| asinh~ | 0 | Asinh (x) Out | audio | high |  |
| asin~ | 0 | Asin (x) Out | audio | high |  |
| atan2~ | 0 | atan2(y/x) | audio | high |  |
| atanh~ | 0 | Atanh (x) Out | audio | high |  |
| atan~ | 0 | Atan (x) Out | audio | high |  |
| atodb~ | 0 | (signal) Gain/Attenuation dB | audio | high |  |
| average~ | 0 | (signal) Running Mean Average Out | audio | high |  |
| avg~ | 0 | (float) Average Value of Input Signal | float # verify | medium |  |
| begin~ | 0 | (signal) Connect to Objects to Turn On and Off | audio | high |  |
| biquad~ | 0 | Output | audio | high |  |
| bitand~ | 0 | (signal) Output | audio | high |  |
| bitnot~ | 0 | (signal) Output | audio | high |  |
| bitor~ | 0 | (signal) Output | audio | high |  |
| bitsafe~ | 0 | (signal) Output | audio | high |  |
| bitshift~ | 0 | (signal) Output | audio | high |  |
| bitxor~ | 0 | (signal) Output | audio | high |  |
| buffer~ | 0 | Mouse position in editing window (ms) | float # verify | medium |  |
| buffer~ | 1 | bang when read/write operation completed | trigger | high |  |
| buffir~ | 0 | (signal) Output | audio | high |  |
| cartopol~ | 0 | (signal) amplitude/alpha output | audio | high |  |
| cartopol~ | 1 | (signal) phase/theta output | audio | high |  |
| cascade~ | 0 | (signal) filtered signal out | audio | high |  |
| change~ | 0 | (signal) 0. if Unchanged; -1. (decreasing) or 1. (increasing) if Changed. | audio | high |  |
| chucker~ | 0 |  | audio | high |  |
| chucker~ | 1 | Right Audio Output | audio | high |  |
| chucker~ | 2 | Current Step Number | audio | high |  |
| click~ | 0 | (signal) Impulse Signal Out | audio | high |  |
| clip~ | 0 | (signal) Clipped Output | audio | high |  |
| comb~ | 0 | (signal) Filter Output | audio | high |  |
| cosh~ | 0 | Cosh (x) Out | audio | high |  |
| cosx~ | 0 | Cos (x) Out | audio | high |  |
| cos~ | 0 | (signal) Cosine Output | audio | high |  |
| count~ | 0 | Count Output | audio | high |  |
| cross~ | 0 | (signal) Lowpass Filtered Output | audio | high |  |
| cross~ | 1 | (signal) Highpass Filtered Output | audio | high |  |
| cverb~ | 0 | (signal) Output | audio | high |  |
| dbtoa~ | 0 | (signal) Amplitude Scalar | audio | high |  |
| ddg.mono | 0 | MIDI Note out | float # verify | medium |  |
| ddg.mono | 1 | MIDI Velocity out |  | low | float |
| degrade~ | 0 | (signal) Output | audio | high |  |
| delay~ | 0 | Delayed Output | audio | high |  |
| deltaclip~ | 0 | (signal) Output | audio | high |  |
| delta~ | 0 | (signal) Differences Between Input Samples | audio | high |  |
| downsamp~ | 0 | (signal) Output | audio | high |  |
| dspstate~ | 0 | Control output |  | low | status |
| dspstate~ | 1 | Control output |  | low | status |
| dspstate~ | 2 | Control output |  | low | status |
| dspstate~ | 3 | Control output |  | low | status |
| dsptime~ | 0 | Control output |  | low | status |
| edge~ | 0 | (bang) Output on zero to non-zero transition | trigger | high |  |
| edge~ | 1 | (bang) Output on non-zero to zero transition | trigger | high |  |
| ezadc~ | 0 | Audio In ch 1 | audio | high |  |
| ezadc~ | 1 | Audio In ch 2 | audio | high |  |
| fbinshift~ | 0 | bin-shifted real/x output | audio | high |  |
| fbinshift~ | 1 | bin-shifted imaginary/y output | audio | high |  |
| fftinfo~ | 0 | (int) FFT Frame Size |  | low | float |
| fftinfo~ | 1 | (int) Spectral Frame Size |  | low | float |
| fftinfo~ | 2 | (int) FFT Hop Size |  | low | float |
| fftinfo~ | 3 | (int) Full Spectrum Flag (0/1) | status | high |  |
| fftin~ | 0 | Real Input 1 to Patcher | audio | high |  |
| fftin~ | 1 | Imaginary Input 1 to Patcher | audio | high |  |
| fftin~ | 2 | FFT Bin Index | audio | high |  |
| fft~ | 0 | (signal) Real Output | audio | high |  |
| fft~ | 1 | (signal) Imaginary Output | audio | high |  |
| fft~ | 2 | (signal) Ramp from 0 to Number of Points - 1 | audio | high |  |
| filtercoeff~ | 0 | (signal) Gain (FF Coefficient 0) | audio | high |  |
| filtercoeff~ | 1 | (signal) FF Coefficient 1 | audio | high |  |
| filtercoeff~ | 2 | (signal) FF Coefficient 2 | audio | high |  |
| filtercoeff~ | 3 | (signal) FB Coefficient 1 | audio | high |  |
| filtercoeff~ | 4 | (signal) FB Coefficient 2 | audio | high |  |
| filterdesign | 0 | filter coefficients |  | low | list |
| filterdetail | 0 | magnitude response |  | low | list |
| filterdetail | 1 | phase response |  | low | list |
| filterdetail | 2 | phase delay |  | low | list |
| filterdetail | 3 | group delay |  | low | list |
| filterdetail | 4 | impulse response |  | low | list |
| filterdetail | 5 | step response |  | low | list |
| filtergraph~ | 0 | List of Filter Coefficients | list # verify | medium |  |
| filtergraph~ | 1 | Frequency Out |  | low | float |
| filtergraph~ | 2 | Gain (Linear) Out |  | low | float |
| filtergraph~ | 3 | Q (Resonance) or S (Slope) Out |  | low | float |
| filtergraph~ | 4 | Bandwidth Out |  | low | float |
| filtergraph~ | 5 | Query Result (amp, phase) |  | low | list |
| filtergraph~ | 6 | Filter Index Out | data # verify | medium |  |
| frameaccum~ | 0 | (signal) FFT Running Phase Output | audio | high |  |
| frameaverage~ | 0 | FFT Running Phase Output | audio | high |  |
| framedelta~ | 0 | (signal) FFT Phase Deviation | audio | high |  |
| framesmooth~ | 0 | FFT Running Phase Output | audio | high |  |
| framesnap~ | 0 | Output Frame as a list | list # verify | medium |  |
| frame~ | 0 | output frame | audio | high |  |
| freqshift~ | 0 | (signal) Frequency-shifted Signal (Positive Sideband) | audio | high |  |
| freqshift~ | 1 | (signal) Frequency-shifted Signal (Negative Sideband) | audio | high |  |
| ftom~ | 0 | Floating-point MIDI Note Number | audio | high |  |
| fzero~ | 0 | Estimated fundamental pitch |  | low | float |
| fzero~ | 1 | Peak amplitude in analysis vector |  | low | float |
| fzero~ | 2 | onset detected |  | low | trigger |
| gate~ | 0 | (signal) Output | audio | high |  |
| gen | 0 | out 1 |  | low | audio |
| gen.codebox | 0 | out1 |  | low | audio |
| gen.codebox~ | 0 | out 1 | audio | high |  |
| gen~ | 0 | out 1 | audio | high |  |
| gizmo~ | 0 | (signal) Pitch-shifted Real Signal | audio | high |  |
| gizmo~ | 1 | (signal) Pitch-shifted Imaginary Signal | audio | high |  |
| groove~ | 0 | Channel 1 Output | audio | high |  |
| groove~ | 1 | Loop Sync Output | audio | high |  |
| hilbert~ | 0 | (signal) cosine/real output | audio | high |  |
| hilbert~ | 1 | (signal) sine/imag output | audio | high |  |
| ifft~ | 0 | (signal) Real Output | audio | high |  |
| ifft~ | 1 | (signal) Imaginary Output | audio | high |  |
| ifft~ | 2 | (signal) Ramp from 0 to Number of Points - 1 | audio | high |  |
| in | 0 | Control output |  | low | status |
| info~ | 0 | Sample rate (float) |  | low | float |
| info~ | 1 | Instrument info / MIDI pitch (list) | list # verify | medium |  |
| info~ | 2 | Sustain loop start in ms (float) | float # verify | medium |  |
| info~ | 3 | Sustain loop end in ms (float) | float # verify | medium |  |
| info~ | 4 | Release loop start in ms (float) | float # verify | medium |  |
| info~ | 5 | Release loop end in ms (float) | float # verify | medium |  |
| info~ | 6 | Total time of buffer in ms (float) | float # verify | medium |  |
| info~ | 7 | Filename of most recently read audio file (symbol) | list # verify | medium |  |
| info~ | 8 | Number of channels (int) |  | low | float |
| info~ | 9 | State / valid flag | status | high |  |
| in~ | 0 | Input 1 | audio | high |  |
| ioscbank~ | 0 | (signal) output | audio | high |  |
| kink~ | 0 | (signal) Disorted Phase Output | audio | high |  |
| levelmeter~ | 0 | RMS level in dB (float) | float # verify | medium |  |
| log~ | 0 | (signal) log of Input to Base | audio | high |  |
| lookup~ | 0 | Distorted Output | audio | high |  |
| lores~ | 0 | (signal) Output | audio | high |  |
| loudness~ | 0 | Momentary Loudness in LUFS |  | low | float |
| loudness~ | 1 | Short-Term Loudness in LUFS |  | low | float |
| loudness~ | 2 | Integrated Loudness in LUFS |  | low | float |
| loudness~ | 3 | Loudness Range |  | low | float |
| loudness~ | 4 | Peak Sample Value | float # verify | medium |  |
| loudness~ | 5 | True Peak Value | float # verify | medium |  |
| matrix~ | 0 | Output 0 | audio | high |  |
| matrix~ | 1 | Output 1 | audio | high |  |
| matrix~ | 2 | Inlets Outlets Gains |  | low | list |
| maximum~ | 0 | (signal) Maximum of Left and Right Signals | audio | high |  |
| mcs.2d.wave~ | 0 | (signal) Channel 1 Output | audio | high |  |
| mcs.amxd~ | 0 | Signal output | audio | high |  |
| mcs.amxd~ | 1 | Control output |  | low | status |
| mcs.amxd~ | 2 | Control output |  | low | status |
| mcs.fffb~ | 0 | signal output from filter 0 | audio | high |  |
| mcs.gate~ | 0 | (signal) Output | audio | high |  |
| mcs.gen~ | 0 | out 1 | audio | high |  |
| mcs.groove~ | 0 | Multichannel output | audio | high |  |
| mcs.groove~ | 1 | Loop Sync Output | audio | high |  |
| mcs.limi~ | 0 | Output | audio | high |  |
| mcs.matrix~ | 0 | Output | audio | high |  |
| mcs.matrix~ | 1 | inlets outlets gains |  | low | list |
| mcs.play~ | 0 | Signal output | audio | high |  |
| mcs.play~ | 1 | Control output |  | low | status |
| mcs.poly~ | 0 | Control output |  | low | status |
| mcs.selector~ | 0 | (signal) Output | audio | high |  |
| mcs.sig~ | 0 | Output | audio | high |  |
| mcs.tapout~ | 0 | Control output |  | low | status |
| mcs.vst~ | 0 | Signal output | audio | high |  |
| mcs.vst~ | 1 | Control output |  | low | status |
| mcs.vst~ | 2 | Control output |  | low | status |
| mcs.vst~ | 3 | Control output |  | low | status |
| mcs.vst~ | 4 | Control output |  | low | status |
| mcs.vst~ | 5 | Control output |  | low | status |
| mcs.vst~ | 6 | Control output |  | low | status |
| mcs.wave~ | 0 | (signal) Output | audio | high |  |
| meter~ | 0 | Peak value for each metering interval (float) | float # verify | medium |  |
| minimum~ | 0 | (signal) Minimum of Left and Right Signals | audio | high |  |
| minmax~ | 0 | (signal) Minimum | audio | high |  |
| minmax~ | 1 | (signal) Maximum | audio | high |  |
| minmax~ | 2 | (float) Minimum |  | low | float |
| minmax~ | 3 | (float) Maximum |  | low | float |
| mstosamps~ | 0 | (signal) Samples At Input signal or Current Sampling Rate | audio | high |  |
| mstosamps~ | 1 | (float) Samples At Input signal or Current Sampling Rate | float # verify | medium |  |
| mtof~ | 0 | Frequency in Hz | audio | high |  |
| multirange | 0 | Interpolated Y1, Y2, Phase for Input X |  | low | list |
| multirange | 1 | All Points in line Format |  | low | list |
| multirange | 2 | dump Message Output (list) | list # verify | medium |  |
| multirange | 3 | bang When Changed With Mouse | trigger | high |  |
| mute~ | 0 | Control output |  | low | status |
| noise~ | 0 | (signal) The Noise | audio | high |  |
| normalize~ | 0 | (signal) Normalized Output | audio | high |  |
| number~ | 0 | Number Value as a Signal | audio | high |  |
| number~ | 1 | Signal Value | float # verify | medium |  |
| omx.4band~ | 0 | (signal) Left Output Channel | audio | high |  |
| omx.4band~ | 1 | (signal) Right Output Channel | audio | high |  |
| omx.4band~ | 2 | (list) Parameter Output | list # verify | medium |  |
| omx.4band~ | 3 | (list) Meter Output | list # verify | medium |  |
| omx.5band~ | 0 | (signal) Left Output Channel | audio | high |  |
| omx.5band~ | 1 | (signal) Right Output Channel | audio | high |  |
| omx.5band~ | 2 | (list) Parameter Output | list # verify | medium |  |
| omx.5band~ | 3 | (list) Meter Output | list # verify | medium |  |
| omx.comp~ | 0 | (signal) Left Output Channel | audio | high |  |
| omx.comp~ | 1 | (signal) Right Output Channel | audio | high |  |
| omx.comp~ | 2 | (list) Parameter Output | list # verify | medium |  |
| omx.comp~ | 3 | (list) Meter Output | list # verify | medium |  |
| omx.peaklim~ | 0 | (signal) Left Output Channel | audio | high |  |
| omx.peaklim~ | 1 | (signal) Right Output Channel | audio | high |  |
| omx.peaklim~ | 2 | (list) Parameter Output | list # verify | medium |  |
| omx.peaklim~ | 3 | (list) Meter Output | list # verify | medium |  |
| onepole~ | 0 | (signal) filter output | audio | high |  |
| oscbank~ | 0 | (signal) output | audio | high |  |
| overdrive~ | 0 | Signal Output | audio | high |  |
| pass~ | 0 | (signal) Output | audio | high |  |
| peakamp~ | 0 | (float) peak amplitude of input |  | low | float |
| peek~ | 0 | buffer~ value at sample index (float) | float # verify | medium |  |
| pfft~ | 0 | Control output |  | low | status |
| phasegroove~ | 0 | Connect to groove~ | audio | high |  |
| phaseshift~ | 0 | (signal) Output | audio | high |  |
| phasewrap~ | 0 | Phase-Wrapped Signal Out | audio | high |  |
| phasor~ | 0 | Output (ramp cycle from 0 to 1) | audio | high |  |
| pink~ | 0 | (signal) The Noise | audio | high |  |
| pitchshift~ | 0 | Control output |  | low | status |
| pitchshift~ | 1 | Control output |  | low | status |
| pitchshift~ | 2 | Control output |  | low | status |
| plot~ | 0 | Mouse interaction data |  | low | list |
| plugin~ | 0 | (signal) Channel 1 audio input from the Live application. | audio | high |  |
| plugin~ | 1 | (signal) Channel 2 audio input from the Live application. | audio | high |  |
| plugout~ | 0 | (signal) Test output to pass thru for audio device channel 1. | audio | high |  |
| plugout~ | 1 | (signal) Test output to pass thru for audio device channel 2. | audio | high |  |
| plugphasor~ | 0 | Beat-Synchronized 0-1 Ramp | audio | high |  |
| plugphasor~ | 1 | Debug Output |  | low | status |
| plugreceive~ | 0 | Receive From plugsend~ | audio | high |  |
| plugsync~ | 0 | (int) Transport State (1 = Play, 0 = Off) | status | high |  |
| plugsync~ | 1 | (int) Current Bar Count | data # verify | medium |  |
| plugsync~ | 2 | (int) Current Beat Count | data # verify | medium |  |
| plugsync~ | 3 | (float) Current Ticks Within a Beat (1 PPQ) |  | low | float |
| plugsync~ | 4 | (list) Time Signature | list # verify | medium |  |
| plugsync~ | 5 | (float) Tempo |  | low | float |
| plugsync~ | 6 | (float) Ticks (1 PPQ) |  | low | float |
| plugsync~ | 7 | (int) Sample Count | data # verify | medium |  |
| plugsync~ | 8 | (long) Flags Indicating Which Data Are Valid |  | low | float |
| poltocar~ | 0 | real/x output | audio | high |  |
| poltocar~ | 1 | imaginary/y output | audio | high |  |
| polybuffer~ | 0 | Messages and buffer info |  | low | list |
| polybuffer~ | 1 | bang when file/folder read operation completed | trigger | high |  |
| poly~ | 0 | Control output |  | low | status |
| pong~ | 0 | (signal) Output | audio | high |  |
| pow~ | 0 | (signal) Base raised to Input | audio | high |  |
| rampsmooth~ | 0 | (signal) Smoothed result | audio | high |  |
| rand~ | 0 | (signal) The Noise Path | audio | high |  |
| rate~ | 0 | (signal) Time-Scaled Version of the Input | audio | high |  |
| receive~ | 0 | Output | audio | high |  |
| record~ | 0 | Sync Out | audio | high |  |
| rect~ | 0 | (signal) Output | audio | high |  |
| reson~ | 0 | (signal) Filtered Output | audio | high |  |
| round~ | 0 | Output | audio | high |  |
| sah~ | 0 | Output | audio | high |  |
| sampstoms~ | 0 | (signal) Milliseconds At Input signal or Current Sampling Rate | audio | high |  |
| sampstoms~ | 1 | (float) Milliseconds At Input signal or Current Sampling Rate |  | low | float |
| sash~ | 0 | Output | audio | high |  |
| saw~ | 0 | (signal) Input signal | audio | high |  |
| scale~ | 0 | (signal) scaled output value | audio | high |  |
| selector~ | 0 | (signal) Output | audio | high |  |
| seq~ | 0 | sequence output |  | low | list |
| seq~ | 1 | dump output |  | low | list |
| seq~ | 2 | id on read, (bang) when done reading | trigger | high |  |
| sfinfo~ | 0 | Control output |  | low | status |
| sfinfo~ | 1 | Control output |  | low | status |
| sfinfo~ | 2 | Control output |  | low | status |
| sfinfo~ | 3 | Control output |  | low | status |
| sfinfo~ | 4 | Control output |  | low | status |
| sfinfo~ | 5 | Control output |  | low | status |
| sflist~ | 0 | Control output |  | low | status |
| sfrecord~ | 0 | Control output |  | low | status |
| shape~ | 0 | Time-Scaled Function | audio | high |  |
| sig~ | 0 | (signal) Output | audio | high |  |
| sinh~ | 0 | Sinh (x) Out | audio | high |  |
| sinx~ | 0 | Sin (x) Out | audio | high |  |
| slide~ | 0 | (signal) Output | audio | high |  |
| snowfall~ | 0 | Particle Output | audio | high |  |
| spike~ | 0 | (float) Outputs interval on zero to non-zero transition |  | low | float |
| sqrt~ | 0 | (signal) Square Root | audio | high |  |
| stepcounter~ | 0 | Impulse When Current Step Count Reached | audio | high |  |
| stepcounter~ | 1 | Impulse When Sequence Resets | audio | high |  |
| stepcounter~ | 2 | Step Index (0-Relative) | audio | high |  |
| stepcounter~ | 3 | Counter Index (0-Relative) | audio | high |  |
| stepdiv~ | 0 | Output | audio | high |  |
| stepdiv~ | 1 | Step Number | audio | high |  |
| stepfun~ | 0 | Output | audio | high |  |
| stepfun~ | 1 | Step Number | audio | high |  |
| stutter~ | 0 | (signal) Playback Output 1 | audio | high |  |
| subdiv~ | 0 | Output | audio | high |  |
| subdiv~ | 1 | Step Number | audio | high |  |
| subdiv~ | 2 |  |  | low | status |
| svf~ | 0 | (signal) Low-pass Output | audio | high |  |
| svf~ | 1 | (signal) High-pass Output | audio | high |  |
| svf~ | 2 | (signal) Band-pass Output | audio | high |  |
| svf~ | 3 | (signal) Notch Output | audio | high |  |
| swing~ | 0 | Output | audio | high |  |
| swing~ | 1 | Step Number | audio | high |  |
| swing~ | 2 | Step Number |  | low | float |
| table~ | 0 | Output | audio | high |  |
| tanh~ | 0 | Tanh (x) Out | audio | high |  |
| tanx~ | 0 | Tan (x) Out | audio | high |  |
| tapin~ | 0 | Control output |  | low | status |
| tapout~ | 0 | (signal) Delayed Output | audio | high |  |
| techno~ | 0 | (signal) frequency | audio | high |  |
| techno~ | 1 | (signal) amplitude envelope | audio | high |  |
| techno~ | 2 | (signal) step position | audio | high |  |
| teeth~ | 0 | (signal) Filter Output | audio | high |  |
| thispoly~ | 0 | Instance index of patcher (int) | data # verify | medium |  |
| thispoly~ | 1 | Mute flag 0/1 for instance (int) | status | high |  |
| thresh~ | 0 | (signal) Output | audio | high |  |
| trapezoid~ | 0 | (signal) Output | audio | high |  |
| triangle~ | 0 | (signal) Output | audio | high |  |
| tri~ | 0 | (signal) Output | audio | high |  |
| trunc~ | 0 | (signal) Integer Part of Input | audio | high |  |
| twist~ | 0 | Curved Ramp Out | audio | high |  |
| typeroute~ | 0 | (signal) An audio signal, if the input type is an audio signal | audio | high |  |
| typeroute~ | 1 | (bang) A bang, if the input type is a bang | trigger | high |  |
| typeroute~ | 2 | (int) An int, if the input type is an int |  | low | float |
| typeroute~ | 3 | (float) A float, if the input type is a float |  | low | float |
| typeroute~ | 4 | (symbol) A symbol, if the input type is a symbol | list # verify | medium |  |
| typeroute~ | 5 | (list) A list, if the input type is a list | list # verify | medium |  |
| updown~ | 0 | Trapezoidal Output | audio | high |  |
| vectral~ | 0 | (signal) Output Value | audio | high |  |
| waveform~ | 0 | Display Start (ms) | float # verify | medium |  |
| waveform~ | 1 | Display Length (ms) | float # verify | medium |  |
| waveform~ | 2 | Selection Start (ms) | float # verify | medium |  |
| waveform~ | 3 | Selection End (ms) | float # verify | medium |  |
| waveform~ | 4 | Mouse output: x, y, state | status | high |  |
| waveform~ | 5 | Link Out (for multi-channel viewing) |  | low | status |
| wave~ | 0 | (signal) Output | audio | high |  |
| what~ | 0 | Impulse if Values Detect, 0 Otherwise | audio | high |  |
| what~ | 1 | Index of Matched Item | data # verify | medium |  |
| where~ | 0 | Elapsed Time | audio | high |  |
| where~ | 1 | Predicted Time Until Reset | audio | high |  |
| zerox~ | 0 | (signal) Number of Zero-Crossings per Signal Vector | audio | high |  |
| zerox~ | 1 | Clicks at Zero-Crossings | audio | high |  |
| zplane~ | 0 | List of 2nd Order Filter Coefficients | list # verify | medium |  |
| zplane~ | 1 | List of Zero Coordinate Pairs | list # verify | medium |  |
| zplane~ | 2 | List of Pole Coordinate Pairs | list # verify | medium |  |
| zplane~ | 3 | List of 2nd Order Filter Gains | list # verify | medium |  |
