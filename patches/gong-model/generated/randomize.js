// randomize.js — randomize all gong-model parameters except gain
inlets = 1;
outlets = 1;

// [param_name, min, max, is_int]
var params = [
	["structure", 0, 1, false],
	["brightness", 0, 1, false],
	["decay_time", 0.1, 30, false],
	["nonlinearity", 0, 1, false],
	["mallet_hardness", 0, 1, false],
	["bloom_amount", 0, 1, false],
	["bloom_speed", 0.1, 5, false],
	["bloom_persist", 0, 1, false],
	["noise_level", 0, 1, false],
	["material", 0, 1, false],
	["stereo_width", 0, 1, false],
	["vel_curve", 0.3, 3, false],
	["detune", 0, 1, false],
	["num_modes", 4, 32, true]
];

function bang() {
	for (var i = 0; i < params.length; i++) {
		var name = params[i][0];
		var lo = params[i][1];
		var hi = params[i][2];
		var is_int = params[i][3];
		var val = lo + Math.random() * (hi - lo);
		if (is_int) val = Math.round(val);
		outlet(0, name, val);
	}
}
