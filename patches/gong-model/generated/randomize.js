// randomize.js — randomize all gong-model parameters except gain
// Sets live.dial values directly so dials move visually,
// and their outlets trigger the existing prepend→send gong-ctrl chain.
inlets = 1;
outlets = 0;

// [dial_varname, min, max, is_int]
var params = [
	["d_structure", 0, 1, false],
	["d_brightness", 0, 1, false],
	["d_decay", 0.1, 30, false],
	["d_nonlinearity", 0, 1, false],
	["d_hardness", 0, 1, false],
	["d_bloom", 0, 1, false],
	["d_bloom_speed", 0.1, 5, false],
	["d_bloom_persist", 0, 1, false],
	["d_noise_level", 0, 1, false],
	["d_material", 0, 1, false],
	["d_stereo_width", 0, 1, false],
	["d_vel_curve", 0.3, 3, false],
	["d_detune", 0, 1, false],
	["d_modes", 4, 32, true]
];

function bang() {
	for (var i = 0; i < params.length; i++) {
		var varname = params[i][0];
		var lo = params[i][1];
		var hi = params[i][2];
		var is_int = params[i][3];
		var val = lo + Math.random() * (hi - lo);
		if (is_int) val = Math.round(val);
		var dial = this.patcher.getnamed(varname);
		if (dial) {
			dial.message("set", val);
			dial.message("bang");
		}
	}
}
