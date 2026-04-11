// drift.js — continuous random parameter drift for gong-model
// Smooth brownian motion for all parameters except gain.
// Receives: bang (tick from metro), int (master on/off),
//   enables <list>, ranges <list>, rates <list> from multisliders
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

var N = params.length;
var _p = null; // patcher reference (lazy init)

// Per-parameter state
var enabled = [];
var range_amt = [];
var rate_amt = [];
var center = [];
var current = [];
var velocity = [];

for (var i = 0; i < N; i++) {
	enabled.push(1);
	range_amt.push(0.2);
	rate_amt.push(0.5);
	center.push(0);
	current.push(0);
	velocity.push(0);
}

var master = 0;

function loadbang() {
	_p = this.patcher;
}

function bang() {
	// Tick from metro — step all drifting parameters
	if (!master) return;
	if (!_p) _p = this.patcher;

	for (var i = 0; i < N; i++) {
		if (!enabled[i]) continue;

		var lo = params[i][1];
		var hi = params[i][2];
		var full_range = hi - lo;
		var drift_half = full_range * range_amt[i] * 0.5;

		// Brownian motion: random acceleration with damping
		velocity[i] += (Math.random() - 0.5) * rate_amt[i] * 0.15;
		velocity[i] *= 0.85;
		current[i] += velocity[i] * full_range * range_amt[i];

		// Clamp and bounce off drift boundaries
		var lo_bound = Math.max(lo, center[i] - drift_half);
		var hi_bound = Math.min(hi, center[i] + drift_half);

		if (current[i] < lo_bound) {
			current[i] = lo_bound;
			velocity[i] = Math.abs(velocity[i]) * 0.5;
		}
		if (current[i] > hi_bound) {
			current[i] = hi_bound;
			velocity[i] = -Math.abs(velocity[i]) * 0.5;
		}

		var val = current[i];
		if (params[i][3]) val = Math.round(val);

		var dial = _p.getnamed(params[i][0]);
		if (dial) {
			dial.message("set", val);
			dial.message("bang");
		}
	}
}

function msg_int(v) {
	// Master on/off from toggle
	master = v ? 1 : 0;
	if (!_p) _p = this.patcher;

	if (master) {
		// Capture current dial positions as drift centers
		for (var i = 0; i < N; i++) {
			_capture(i);
		}
	}
}

function _capture(idx) {
	var lo = params[idx][1];
	var hi = params[idx][2];
	var mid = (lo + hi) / 2;
	var dial = _p ? _p.getnamed(params[idx][0]) : null;

	if (dial) {
		try {
			var dist = dial.getattr("distance");
			if (typeof dist === "number" && !isNaN(dist)) {
				center[idx] = lo + dist * (hi - lo);
			} else {
				center[idx] = mid;
			}
		} catch(e) {
			center[idx] = mid;
		}
	} else {
		center[idx] = mid;
	}
	current[idx] = center[idx];
	velocity[idx] = 0;
}

function anything() {
	var msg = messagename;
	var args = arrayfromargs(arguments);

	if (msg === "enables") {
		for (var i = 0; i < args.length && i < N; i++) {
			var was = enabled[i];
			enabled[i] = args[i] > 0.5 ? 1 : 0;
			if (enabled[i] && !was && master) {
				_capture(i);
			}
		}
	} else if (msg === "ranges") {
		for (var i = 0; i < args.length && i < N; i++) {
			range_amt[i] = Math.max(0, Math.min(1, args[i]));
		}
	} else if (msg === "rates") {
		for (var i = 0; i < args.length && i < N; i++) {
			rate_amt[i] = Math.max(0, Math.min(1, args[i]));
		}
	}
}
