# Signal Role Review (Plan 30-03)

Curator: edit `curator_role` column for any row where you disagree with `suggested_role`, OR for low-confidence rows (suggested_role empty). Then run `python scripts/audit_signal_role.py apply` from the project root.

Confidence tiers (D-08):
- **high**: auto-applied. Override only if extraction was wrong.
- **medium**: auto-applied with `# verify` marker. Spot-check.
- **low**: NOT applied. Curator MUST fill `curator_role`.

| object | outlet_id | digest | suggested_role | confidence | curator_role |
|---|---|---|---|---|---|
| mc.!-~ | 0 | (signal) Difference Out | audio | inherited |  |
| mc.!/~ | 0 | (signal) Quotient Out | audio | inherited |  |
| mc.!=~ | 0 | (signal) Comparison Result (1 or 0) | audio | inherited |  |
| mc.%~ | 0 | (signal) Modulo Result | audio | inherited |  |
| mc.*~ | 0 | (signal) Multiplication Result | audio | inherited |  |
| mc.+=~ | 0 | (signal) Accumulator Output | audio | inherited |  |
| mc.+~ | 0 | (signal) Addition Result | audio | inherited |  |
| mc.-~ | 0 | (signal) Subtraction Result | audio | inherited |  |
| mc./~ | 0 | (signal) Division Result | audio | inherited |  |
| mc.2d.wave~ | 0 | (signal) Channel 1 Output | audio | high |  |
| mc.<=~ | 0 | (signal) Comparison Result (1 or 0) | audio | inherited |  |
| mc.<~ | 0 | (signal) Comparison Result (1 or 0) | audio | inherited |  |
| mc.==~ | 0 | (signal) Comparison Result (1 or 0) | audio | inherited |  |
| mc.>=~ | 0 | (signal) Comparison Result (1 or 0) | audio | inherited |  |
| mc.>~ | 0 | (signal) Comparison Result (1 or 0) | audio | inherited |  |
| mc.abs~ | 0 | (signal) Absolute Value of Input | audio | inherited |  |
| mc.acosh~ | 0 | Acosh (x) Out | audio | inherited |  |
| mc.acos~ | 0 | Acos (x) Out | audio | inherited |  |
| mc.adc~ | 0 | Audio Input (multichannel) | audio | high |  |
| mc.adsr~ | 0 | Control output |  | low | status |
| mc.adsr~ | 1 | Control output |  | low | status |
| mc.adsr~ | 2 | Control output |  | low | status |
| mc.adsr~ | 3 | Control output |  | low | status |
| mc.adsr~ | 4 | Control output |  | low | status |
| mc.allpass~ | 0 | (signal) Filter Output | audio | inherited |  |
| mc.amxd~ | 0 | Signal output | audio | high |  |
| mc.amxd~ | 1 | Signal output | audio | high |  |
| mc.amxd~ | 2 | Control output |  | low | status |
| mc.amxd~ | 3 | Control output |  | low | status |
| mc.amxd~ | 4 | Control output |  | low | status |
| mc.apply~ | 0 | Function Applied to Channels | audio | high |  |
| mc.asinh~ | 0 | Asinh (x) Out | audio | inherited |  |
| mc.asin~ | 0 | Asin (x) Out | audio | inherited |  |
| mc.assign | 0 | setvalue Message Output |  | low | list |
| mc.atan2~ | 0 | atan2(y/x) | audio | inherited |  |
| mc.atanh~ | 0 | Atanh (x) Out | audio | inherited |  |
| mc.atan~ | 0 | Atan (x) Out | audio | inherited |  |
| mc.atodb~ | 0 | (signal) Gain/Attenuation dB | audio | inherited |  |
| mc.average~ | 0 | (signal) Running Mean Average Out | audio | inherited |  |
| mc.avg~ | 0 | (float) Average Value of Input Signal | float | inherited |  |
| mc.bands~ | 0 | Signal output | audio | high |  |
| mc.bands~ | 1 | Control output |  | low | status |
| mc.bands~ | 2 | Control output |  | low | status |
| mc.biquad~ | 0 | Output | audio | inherited |  |
| mc.bitand~ | 0 | (signal) Output | audio | inherited |  |
| mc.bitnot~ | 0 | (signal) Output | audio | inherited |  |
| mc.bitor~ | 0 | (signal) Output | audio | inherited |  |
| mc.bitsafe~ | 0 | (signal) Output | audio | inherited |  |
| mc.bitshift~ | 0 | (signal) Output | audio | inherited |  |
| mc.bitxor~ | 0 | (signal) Output | audio | inherited |  |
| mc.buffir~ | 0 | (signal) Output | audio | inherited |  |
| mc.cartopol~ | 0 | (signal) amplitude/alpha output | audio | inherited |  |
| mc.cartopol~ | 1 | (signal) phase/theta output | audio | inherited |  |
| mc.cascade~ | 0 | (signal) filtered signal out | audio | inherited |  |
| mc.cell | 0 | setvalue Message Output |  | low | list |
| mc.change~ | 0 | (signal) 0. if Unchanged; -1. (decreasing) or 1. (increasing) if Changed. | audio | inherited |  |
| mc.channelcount~ | 0 | Channel Count of Input as int | data # verify | medium |  |
| mc.channelcount~ | 1 | Channel Count of Input as signal | audio | high |  |
| mc.chord~ | 0 | List Values | audio | high |  |
| mc.chord~ | 1 | 1 if On, 0 if Off | audio | high |  |
| mc.chord~ | 2 | Chord as a List | list # verify | medium |  |
| mc.chord~ | 3 | Last Index Recalled | data # verify | medium |  |
| mc.click~ | 0 | (signal) Impulse Signal Out | audio | inherited |  |
| mc.clip~ | 0 | (signal) Clipped Output | audio | inherited |  |
| mc.combine~ | 0 | Output | audio | high |  |
| mc.comb~ | 0 | (signal) Filter Output | audio | inherited |  |
| mc.cosh~ | 0 | Cosh (x) Out | audio | inherited |  |
| mc.cosx~ | 0 | Cos (x) Out | audio | inherited |  |
| mc.cos~ | 0 | (signal) Cosine Output | audio | inherited |  |
| mc.count~ | 0 | Count Output | audio | inherited |  |
| mc.cross~ | 0 | (signal) Lowpass Filtered Output | audio | inherited |  |
| mc.cross~ | 1 | (signal) Highpass Filtered Output | audio | inherited |  |
| mc.curve~ | 0 | Output Ramp | audio | inherited |  |
| mc.curve~ | 1 | bang When Curve Reaches Destination | trigger | inherited |  |
| mc.cycle~ | 0 | Output | audio | inherited |  |
| mc.dbtoa~ | 0 | (signal) Amplitude Scalar | audio | inherited |  |
| mc.degrade~ | 0 | (signal) Output | audio | inherited |  |
| mc.deinterleave~ | 0 | Deinterleaved Output | audio | high |  |
| mc.deinterleave~ | 1 | Deinterleaved Output | audio | high |  |
| mc.delay~ | 0 | Delayed Output | audio | inherited |  |
| mc.deltaclip~ | 0 | (signal) Output | audio | inherited |  |
| mc.delta~ | 0 | (signal) Differences Between Input Samples | audio | inherited |  |
| mc.downsamp~ | 0 | (signal) Output | audio | inherited |  |
| mc.dup~ | 0 | input duplicated | audio | high |  |
| mc.edge~ | 0 | Control output |  | low | status |
| mc.edge~ | 1 | Control output |  | low | status |
| mc.edge~ | 2 | Control output |  | low | status |
| mc.evolve~ | 0 | Output | audio | high |  |
| mc.evolve~ | 1 | Query value for an output channel | float # verify | medium |  |
| mc.evolve~ | 2 | Query value of the output range | float # verify | medium |  |
| mc.ezadc~ | 0 | Output from Audio Device Input | audio | high |  |
| mc.fffb~ | 0 | Signal output | audio | inherited |  |
| mc.fffb~ | 1 | Signal output | audio | inherited |  |
| mc.fffb~ | 2 | Signal output | audio | inherited |  |
| mc.fffb~ | 3 | Signal output | audio | inherited |  |
| mc.fffb~ | 4 | Signal output | audio | inherited |  |
| mc.fffb~ | 5 | Signal output | audio | inherited |  |
| mc.fffb~ | 6 | Signal output | audio | inherited |  |
| mc.fffb~ | 7 | Signal output | audio | inherited |  |
| mc.fft~ | 0 | (signal) Real Output | audio | inherited |  |
| mc.fft~ | 1 | (signal) Imaginary Output | audio | inherited |  |
| mc.fft~ | 2 | (signal) Ramp from 0 to Number of Points - 1 | audio | inherited |  |
| mc.filtercoeff~ | 0 | (signal) Gain (FF Coefficient 0) | audio | inherited |  |
| mc.filtercoeff~ | 1 | (signal) FF Coefficient 1 | audio | inherited |  |
| mc.filtercoeff~ | 2 | (signal) FF Coefficient 2 | audio | inherited |  |
| mc.filtercoeff~ | 3 | (signal) FB Coefficient 1 | audio | inherited |  |
| mc.filtercoeff~ | 4 | (signal) FB Coefficient 2 | audio | inherited |  |
| mc.frameaccum~ | 0 | (signal) FFT Running Phase Output | audio | inherited |  |
| mc.frameaverage~ | 0 | FFT Running Phase Output | audio | inherited |  |
| mc.framedelta~ | 0 | (signal) FFT Phase Deviation | audio | inherited |  |
| mc.framesmooth~ | 0 | FFT Running Phase Output | audio | inherited |  |
| mc.freqshift~ | 0 | (signal) Frequency-shifted Signal (Positive Sideband) | audio | inherited |  |
| mc.freqshift~ | 1 | (signal) Frequency-shifted Signal (Negative Sideband) | audio | inherited |  |
| mc.ftom~ | 0 | Floating-point MIDI Note Number | audio | inherited |  |
| mc.function | 0 | Interpolated Y (float) for Input X |  | low | float |
| mc.function | 1 | All Points in line Format |  | low | list |
| mc.function | 2 | dump Message Output (list) | list # verify | medium |  |
| mc.function | 3 | bang When Changed With Mouse | trigger | high |  |
| mc.function | 4 | Output Channel |  | low | data |
| mc.fzero~ | 0 | Estimated fundamental pitch | float | inherited |  |
| mc.fzero~ | 1 | Peak amplitude in analysis vector | float | inherited |  |
| mc.fzero~ | 2 | onset detected | trigger | inherited |  |
| mc.gain~ | 0 | Scaled Output | audio | inherited |  |
| mc.gain~ | 1 | Slider Value | float | inherited |  |
| mc.gate~ | 0 | (signal) Output | audio | inherited |  |
| mc.gen | 0 | Control output |  | low | status |
| mc.gen | 1 | Control output |  | low | status |
| mc.generate~ | 0 | Output | audio | high |  |
| mc.gen~ | 0 | out 1 | audio | inherited |  |
| mc.getattr | 0 | Attribute Value | float # verify | medium |  |
| mc.getattr | 1 | Connect to An Object |  | low | list |
| mc.getattr | 2 | dumpout |  | low | list |
| mc.gradient~ | 0 | Output | audio | high |  |
| mc.gradient~ | 1 | Channel value in response to chanval message | float # verify | medium |  |
| mc.gradient~ | 2 | Output function values for input |  | low | list |
| mc.groove~ | 0 | Signal output | audio | high |  |
| mc.groove~ | 1 | Signal output | audio | high |  |
| mc.groove~ | 2 | Signal output | audio | high |  |
| mc.hilbert~ | 0 | (signal) cosine/real output | audio | inherited |  |
| mc.hilbert~ | 1 | (signal) sine/imag output | audio | inherited |  |
| mc.ifft~ | 0 | (signal) Real Output | audio | inherited |  |
| mc.ifft~ | 1 | (signal) Imaginary Output | audio | inherited |  |
| mc.ifft~ | 2 | (signal) Ramp from 0 to Number of Points - 1 | audio | inherited |  |
| mc.index~ | 0 | Sample Value at Index | audio | high |  |
| mc.index~ | 1 | Audio Channel In buffer~ | audio | high |  |
| mc.interleave~ | 0 | Interleaved Output | audio | high |  |
| mc.in~ | 0 | Inputs | audio | inherited |  |
| mc.jit.peek~ | 0 | value | audio | high |  |
| mc.jit.peek~ | 1 | dumpout | audio | high |  |
| mc.kink~ | 0 | (signal) Disorted Phase Output | audio | inherited |  |
| mc.limi~ | 0 | Output | audio | high |  |
| mc.line | 0 | Ramp Output |  | low | audio |
| mc.line | 1 | Signals End of Ramp |  | low | trigger |
| mc.line~ | 0 | Signal output | audio | high |  |
| mc.line~ | 1 | Control output |  | low | status |
| mc.line~ | 2 | Control output |  | low | status |
| mc.list~ | 0 | Output | audio | high |  |
| mc.live.gain~ | 0 | Scaled Signal (ch 1) | audio | high |  |
| mc.live.gain~ | 1 | Scaled Signal (ch 2) |  | low | audio |
| mc.live.gain~ | 2 | Parameter Value (-70.00-6.00) | float # verify | medium |  |
| mc.live.gain~ | 3 | Parameter Raw Value (0.-1.) | float # verify | medium |  |
| mc.log~ | 0 | (signal) log of Input to Base | audio | inherited |  |
| mc.lookup~ | 0 | Distorted Output | audio | inherited |  |
| mc.lores~ | 0 | (signal) Output | audio | inherited |  |
| mc.loudness~ | 0 | Momentary Loudness in LUFS | float | inherited |  |
| mc.loudness~ | 1 | Short-Term Loudness in LUFS | float | inherited |  |
| mc.loudness~ | 2 | Integrated Loudness in LUFS | float | inherited |  |
| mc.loudness~ | 3 | Loudness Range | float | inherited |  |
| mc.loudness~ | 4 | Peak Sample Value | float | inherited |  |
| mc.loudness~ | 5 | True Peak Value | float | inherited |  |
| mc.makelist | 0 | List Output | list # verify | medium |  |
| mc.matrix~ | 0 | Output 0 | audio | inherited |  |
| mc.matrix~ | 1 | Output 1 | audio | inherited |  |
| mc.matrix~ | 2 | Inlets Outlets Gains | list | inherited |  |
| mc.maximum~ | 0 | (signal) Maximum of Left and Right Signals | audio | inherited |  |
| mc.midiplayer~ | 0 | MIDI Events for vst~ | audio | high |  |
| mc.midiplayer~ | 1 | MIDI Event Output Not for vst~ |  | low | list |
| mc.miditarget | 0 | setvalue Index Followed by midievent Message | data # verify | medium |  |
| mc.minimum~ | 0 | (signal) Minimum of Left and Right Signals | audio | inherited |  |
| mc.minmax~ | 0 | (signal) Minimum | audio | inherited |  |
| mc.minmax~ | 1 | (signal) Maximum | audio | inherited |  |
| mc.minmax~ | 2 | (float) Minimum | float | inherited |  |
| mc.minmax~ | 3 | (float) Maximum | float | inherited |  |
| mc.mixdown~ | 0 | Output | audio | high |  |
| mc.mstosamps~ | 0 | (signal) Samples At Input signal or Current Sampling Rate | audio | inherited |  |
| mc.mstosamps~ | 1 | (float) Samples At Input signal or Current Sampling Rate | float | inherited |  |
| mc.mtof~ | 0 | Frequency in Hz | audio | inherited |  |
| mc.noise~ | 0 | (signal) The Noise | audio | inherited |  |
| mc.normalize~ | 0 | (signal) Normalized Output | audio | inherited |  |
| mc.noteallocator~ | 0 | Control output |  | low | status |
| mc.noteallocator~ | 1 | Control output |  | low | status |
| mc.noteallocator~ | 2 | Control output |  | low | status |
| mc.noteallocator~ | 3 | Control output |  | low | status |
| mc.noteallocator~ | 4 | Control output |  | low | status |
| mc.noteallocator~ | 5 | Control output |  | low | status |
| mc.number~ | 0 | Entered or received float values as a multichannel signal | audio | high |  |
| mc.number~ | 1 | Sampled values from incoming signal |  | low | float |
| mc.number~ | 2 | Output Channel for Signal Value | float # verify | medium |  |
| mc.omx.4band~ | 0 | (signal) Left Output Channel | audio | inherited |  |
| mc.omx.4band~ | 1 | (signal) Right Output Channel | audio | inherited |  |
| mc.omx.4band~ | 2 | (list) Parameter Output | list | inherited |  |
| mc.omx.4band~ | 3 | (list) Meter Output | list | inherited |  |
| mc.omx.5band~ | 0 | (signal) Left Output Channel | audio | inherited |  |
| mc.omx.5band~ | 1 | (signal) Right Output Channel | audio | inherited |  |
| mc.omx.5band~ | 2 | (list) Parameter Output | list | inherited |  |
| mc.omx.5band~ | 3 | (list) Meter Output | list | inherited |  |
| mc.omx.comp~ | 0 | (signal) Left Output Channel | audio | inherited |  |
| mc.omx.comp~ | 1 | (signal) Right Output Channel | audio | inherited |  |
| mc.omx.comp~ | 2 | (list) Parameter Output | list | inherited |  |
| mc.omx.comp~ | 3 | (list) Meter Output | list | inherited |  |
| mc.omx.peaklim~ | 0 | (signal) Left Output Channel | audio | inherited |  |
| mc.omx.peaklim~ | 1 | (signal) Right Output Channel | audio | inherited |  |
| mc.omx.peaklim~ | 2 | (list) Parameter Output | list | inherited |  |
| mc.omx.peaklim~ | 3 | (list) Meter Output | list | inherited |  |
| mc.onepole~ | 0 | (signal) filter output | audio | inherited |  |
| mc.op~ | 0 | Computed Output | audio | high |  |
| mc.overdrive~ | 0 | Signal Output | audio | inherited |  |
| mc.pack~ | 0 | Output | audio | high |  |
| mc.pattern~ | 0 | Pattern(s) | audio | high |  |
| mc.pattern~ | 1 | Pattern Data in Response to getcontent Message | audio | high |  |
| mc.pattern~ | 2 | Pattern Data in Response to getcontent Message |  | low | list |
| mc.peakamp~ | 0 | Control output |  | low | status |
| mc.peakamp~ | 1 | Control output |  | low | status |
| mc.peek~ | 0 | buffer~ Value at Sample Index | float | inherited |  |
| mc.phasegroove~ | 0 | Connect to groove~ | audio | inherited |  |
| mc.phaseshift~ | 0 | (signal) Output | audio | inherited |  |
| mc.phasewrap~ | 0 | Phase-Wrapped Signal Out | audio | inherited |  |
| mc.phasor~ | 0 | Output (ramp cycle from 0 to 1) | audio | inherited |  |
| mc.pink~ | 0 | (signal) The Noise | audio | inherited |  |
| mc.pitchshift~ | 0 | pitchshifted signal, channel: 1 | audio | high |  |
| mc.pitchshift~ | 1 | Current latency, reported in samples | audio | high |  |
| mc.playlist~ | 0 | Output | audio | high |  |
| mc.playlist~ | 1 | Sync Output | audio | high |  |
| mc.playlist~ | 2 | Playback Notifications | audio | high |  |
| mc.playlist~ | 3 | Current content |  | low | list |
| mc.play~ | 0 | Signal output | audio | high |  |
| mc.play~ | 1 | Control output |  | low | status |
| mc.play~ | 2 | Control output |  | low | status |
| mc.poltocar~ | 0 | real/x output | audio | inherited |  |
| mc.poltocar~ | 1 | imaginary/y output | audio | inherited |  |
| mc.poly~ | 0 | Signal output | status | inherited |  |
| mc.pong~ | 0 | (signal) Output | audio | inherited |  |
| mc.pow~ | 0 | (signal) Base raised to Input | audio | inherited |  |
| mc.rampsmooth~ | 0 | (signal) Smoothed result | audio | inherited |  |
| mc.ramp~ | 0 | Ramp Output | audio | inherited |  |
| mc.ramp~ | 1 | bang When Ramp Completes | trigger | inherited |  |
| mc.rand~ | 0 | (signal) The Noise Path | audio | inherited |  |
| mc.range~ | 0 | Range | audio | high |  |
| mc.range~ | 1 | Range |  | low | float |
| mc.range~ | 2 | Range |  | low | float |
| mc.rate~ | 0 | (signal) Time-Scaled Version of the Input | audio | inherited |  |
| mc.receive~ | 0 | Signal output | audio | inherited |  |
| mc.record~ | 0 | Sync Out | audio | inherited |  |
| mc.rect~ | 0 | (signal) Output | audio | inherited |  |
| mc.resize~ | 0 | Output | audio | high |  |
| mc.reson~ | 0 | (signal) Filtered Output | audio | inherited |  |
| mc.retune~ | 0 | retuned signal | audio | high |  |
| mc.retune~ | 1 | detected frequency | audio | high |  |
| mc.retune~ | 2 | closest note | audio | high |  |
| mc.retune~ | 3 | deviation in cents | audio | high |  |
| mc.retune~ | 4 | closest note and deviation in cents | float # verify | medium |  |
| mc.round~ | 0 | Output | audio | inherited |  |
| mc.route | 0 | Per-Voice Output |  | low | audio |
| mc.route | 1 | Output for Voice 2 |  | low | audio |
| mc.r~ | 0 | Output | audio | inherited |  |
| mc.sah~ | 0 | Output | audio | inherited |  |
| mc.sampstoms~ | 0 | (signal) Milliseconds At Input signal or Current Sampling Rate | audio | inherited |  |
| mc.sampstoms~ | 1 | (float) Milliseconds At Input signal or Current Sampling Rate | float | inherited |  |
| mc.sash~ | 0 | Output | audio | inherited |  |
| mc.saw~ | 0 | (signal) Input signal | audio | inherited |  |
| mc.scale~ | 0 | (signal) scaled output value | audio | inherited |  |
| mc.selector~ | 0 | Control output |  | low | status |
| mc.separate~ | 0 | Separated Output | audio | high |  |
| mc.separate~ | 1 | Separated Output 2 (1 Channels) | audio | high |  |
| mc.seq~ | 0 | sequence output | list | inherited |  |
| mc.seq~ | 1 | dump output | list | inherited |  |
| mc.seq~ | 2 | id on read, (bang) when done reading | trigger | inherited |  |
| mc.sfizz~ | 0 | Audio Output 1 | audio | high |  |
| mc.sfizz~ | 1 | Audio Output 2 | audio | high |  |
| mc.sfplay~ | 0 | Signal output | audio | inherited |  |
| mc.sfplay~ | 1 | Control output | trigger | inherited |  |
| mc.sfrecord~ | 0 | (signal) elapsed time (ms) | audio | high |  |
| mc.shape~ | 0 | Time-Scaled Function | audio | inherited |  |
| mc.sig~ | 0 | (signal) Output | audio | inherited |  |
| mc.sinh~ | 0 | Sinh (x) Out | audio | inherited |  |
| mc.sinx~ | 0 | Sin (x) Out | audio | inherited |  |
| mc.slide~ | 0 | (signal) Output | audio | inherited |  |
| mc.snapshot~ | 0 | Control output |  | low | status |
| mc.snapshot~ | 1 | Control output |  | low | status |
| mc.snowfall~ | 0 | Particle Output | audio | inherited |  |
| mc.snowphasor~ | 0 | Phasors | audio | high |  |
| mc.spike~ | 0 | Control output |  | low | status |
| mc.spike~ | 1 | Control output |  | low | status |
| mc.sqrt~ | 0 | (signal) Square Root | audio | inherited |  |
| mc.stash~ | 0 | Output | audio | inherited |  |
| mc.stash~ | 1 | Index | data | inherited |  |
| mc.stepdiv~ | 0 | Output | audio | inherited |  |
| mc.stepdiv~ | 1 | Step Number | audio | inherited |  |
| mc.stepfun~ | 0 | Output | audio | inherited |  |
| mc.stepfun~ | 1 | Step Number | audio | inherited |  |
| mc.stereo~ | 0 | Output (2 Channels) | audio | high |  |
| mc.stutter~ | 0 | (signal) Playback Output 1 | audio | inherited |  |
| mc.subdiv~ | 0 | Output | audio | inherited |  |
| mc.subdiv~ | 1 | Step Number | audio | inherited |  |
| mc.subdiv~ | 2 |  | status | inherited |  |
| mc.sum~ | 0 | Signal output | audio | high |  |
| mc.svf~ | 0 | (signal) Low-pass Output | audio | inherited |  |
| mc.svf~ | 1 | (signal) High-pass Output | audio | inherited |  |
| mc.svf~ | 2 | (signal) Band-pass Output | audio | inherited |  |
| mc.svf~ | 3 | (signal) Notch Output | audio | inherited |  |
| mc.swing~ | 0 | Output | audio | inherited |  |
| mc.swing~ | 1 | Step Number | audio | inherited |  |
| mc.swing~ | 2 | Step Number | float | inherited |  |
| mc.sync~ | 0 | synchronized ramp (0-1) | audio | inherited |  |
| mc.sync~ | 1 | BPM and beat detect information | status | inherited |  |
| mc.sync~ | 2 | MIDI beat clock | status | inherited |  |
| mc.table~ | 0 | Output | audio | inherited |  |
| mc.tanh~ | 0 | Tanh (x) Out | audio | inherited |  |
| mc.tanx~ | 0 | Tan (x) Out | audio | inherited |  |
| mc.tapin~ | 0 | Control output | status | inherited |  |
| mc.tapout~ | 0 | Signal output | audio | high |  |
| mc.tapout~ | 1 | Signal output | audio | high |  |
| mc.tapout~ | 2 | Signal output | audio | high |  |
| mc.target | 0 |  |  | low | status |
| mc.target | 1 | Voice Index | data # verify | medium |  |
| mc.targetlist | 0 | Control output |  | low | status |
| mc.targetlist | 1 | Control output |  | low | status |
| mc.teeth~ | 0 | (signal) Filter Output | audio | inherited |  |
| mc.thresh~ | 0 | (signal) Output | audio | inherited |  |
| mc.train~ | 0 | Signal output | audio | high |  |
| mc.train~ | 1 | Control output |  | low | status |
| mc.train~ | 2 | Control output |  | low | status |
| mc.transpose~ | 0 | Transposed Output | audio | high |  |
| mc.transpose~ | 1 | Transposed Output 2 | audio | high |  |
| mc.trapezoid~ | 0 | (signal) Output | audio | inherited |  |
| mc.triangle~ | 0 | (signal) Output | audio | inherited |  |
| mc.tri~ | 0 | (signal) Output | audio | inherited |  |
| mc.trunc~ | 0 | (signal) Integer Part of Input | audio | inherited |  |
| mc.twist~ | 0 | Curved Ramp Out | audio | inherited |  |
| mc.unpack~ | 0 | Output 1 | audio | high |  |
| mc.unpack~ | 1 | Output 2 | audio | high |  |
| mc.updown~ | 0 | Trapezoidal Output | audio | inherited |  |
| mc.vectral~ | 0 | (signal) Output Value | audio | inherited |  |
| mc.voiceallocator~ | 0 | Control output |  | low | status |
| mc.voiceallocator~ | 1 | Control output |  | low | status |
| mc.vst~ | 0 | Signal output | audio | high |  |
| mc.vst~ | 1 | Signal output | audio | high |  |
| mc.vst~ | 2 | Control output |  | low | status |
| mc.vst~ | 3 | Control output |  | low | status |
| mc.vst~ | 4 | Control output |  | low | status |
| mc.vst~ | 5 | Control output |  | low | status |
| mc.vst~ | 6 | Control output |  | low | status |
| mc.vst~ | 7 | Control output |  | low | status |
| mc.vst~ | 8 | Control output |  | low | status |
| mc.wave~ | 0 | (signal) Output | audio | inherited |  |
| mc.what~ | 0 | Impulse if Values Detect, 0 Otherwise | audio | inherited |  |
| mc.what~ | 1 | Index of Matched Item | data | inherited |  |
| mc.where~ | 0 | Elapsed Time | audio | inherited |  |
| mc.where~ | 1 | Predicted Time Until Reset | audio | inherited |  |
| mc.zerox~ | 0 | (signal) Number of Zero-Crossings per Signal Vector | audio | inherited |  |
| mc.zerox~ | 1 | Clicks at Zero-Crossings | audio | inherited |  |
| mc.zigzag~ | 0 | (signal) Output Ramp | audio | inherited |  |
| mc.zigzag~ | 1 | (signal) Current Index | audio | inherited |  |
| mc.zigzag~ | 2 | Contents of Current List | list | inherited |  |
| mc.zigzag~ | 3 | bang When Line Reaches Destination | trigger | inherited |  |
| mcp.record~ | 0 | Signal output | audio | high |  |
| mcs.loudness~ | 0 | Control output | float | inherited |  |
| mcs.loudness~ | 1 | Control output | float | inherited |  |
| mcs.loudness~ | 2 | Control output | float | inherited |  |
| mcs.loudness~ | 3 | Control output | float | inherited |  |
| mcs.loudness~ | 4 | Control output | float | inherited |  |
| mcs.loudness~ | 5 | Control output | float | inherited |  |
| mcs.sfizz~ | 0 | Signal output | audio | high |  |
