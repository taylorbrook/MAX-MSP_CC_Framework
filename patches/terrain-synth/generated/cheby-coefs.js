// cheby-coefs.js -- coefficient + display bridge for the Chebyshev terrain core (terrain-synth)
// js cheby-coefs.js <offset>   offset = first frame of this slot in buffer~ chebcoef (A = 0, B = 64)
// terrain(x, y) = sum c[m][n] * T_m(x) * T_n(y), m = x order, n = y order, stored at offset + m * 8 + n
// in: preset <i> | bright <0-1> | mode <0/1>
// out 0: exprfill 0 <same polynomial>, bang  -> source-1 store of this slot (only while mode = 1)
// out 1: bang when mode goes 1 -> 0 (re-select the terrain source so the picture comes back)

inlets = 1;
outlets = 2;

var N = 8;
var buf_name = "chebcoef";
var off = (jsarguments.length > 1) ? jsarguments[1] : 0;

// [m, n, amplitude]; keep in sync with tools/cheby_preflight.py
var PRESETS = [
	[[1, 0, 1.0], [2, 0, 0.5], [3, 0, 0.3333], [4, 0, 0.25], [5, 0, 0.2], [6, 0, 0.1667], [7, 0, 0.1429]], // saw
	[[1, 0, 1.0], [3, 0, 0.3333], [5, 0, 0.2], [7, 0, 0.1429]], // square
	[[1, 0, 1.0], [0, 3, 0.5], [5, 0, 0.33], [0, 7, 0.25], [2, 1, 0.3]], // hollow xy
	[[1, 1, 1.0], [2, 1, 0.6], [1, 3, 0.5], [3, 2, 0.4], [2, 5, 0.3], [4, 3, 0.25]], // cross
	[[1, 0, 1.0], [2, 2, 0.5], [3, 3, 0.4], [5, 5, 0.3], [7, 7, 0.25]], // glass
	[[1, 0, 0.6], [3, 4, 1.0], [4, 3, 0.8], [7, 2, 0.5], [6, 7, 0.4], [7, 7, 0.3]] // bell
];

var preset_i = 0;
var bright_v = 1.0;
var mode_v = 0;
var fill_task = new Task(fill, this);

// effective terms: brightness b^(degree - lowest degree), normalised so sum |c| = 1
// (|T| <= 1 on the terrain square, so the core can never exceed +/-1)
function terms() {
	var src = PRESETS[preset_i];
	var dmin = 99;
	var i;
	for (i = 0; i < src.length; i++) {
		dmin = Math.min(dmin, src[i][0] + src[i][1]);
	}
	var out = [];
	var sum = 0;
	for (i = 0; i < src.length; i++) {
		var c = src[i][2] * Math.pow(bright_v, src[i][0] + src[i][1] - dmin);
		out.push([src[i][0], src[i][1], c]);
		sum += Math.abs(c);
	}
	for (i = 0; i < out.length; i++) {
		out[i][2] = out[i][2] / Math.max(sum, 0.000001);
	}
	return out;
}

function write_buffer() {
	var buf = new Buffer(buf_name);
	var t = terms();
	var i;
	for (i = 0; i < N * N; i++) {
		buf.poke(1, off + i, 0.0);
	}
	for (i = 0; i < t.length; i++) {
		buf.poke(1, off + t[i][0] * N + t[i][1], t[i][2]);
	}
}

function num(v) {
	var s = v.toFixed(5);
	return (v < 0) ? "(" + s + ")" : s;
}

// integer polynomial coefficient as a float literal ("-8." not "-8")
function inum(v) {
	return (v < 0) ? "(" + v + ".)" : v + ".";
}

// T_k(v) as a Horner string in v * v, from the recurrence T_k = 2 v T_(k-1) - T_(k-2)
function cheb(k, v) {
	if (k == 1) {
		return v;
	}
	var a = [1];
	var b = [0, 1];
	var i, j;
	for (i = 2; i <= k; i++) {
		var c = [0];
		for (j = 0; j < b.length; j++) {
			c.push(2 * b[j]);
		}
		for (j = 0; j < a.length; j++) {
			c[j] -= a[j];
		}
		a = b;
		b = c;
	}
	var s = inum(b[k]);
	for (j = k - 2; j >= 0; j -= 2) {
		s = inum(b[j]) + "+" + v + "*" + v + "*(" + s + ")";
	}
	return (k % 2 == 1) ? v + "*(" + s + ")" : "(" + s + ")";
}

function fill() {
	if (!mode_v) {
		return;
	}
	var t = terms();
	var parts = [];
	for (var i = 0; i < t.length; i++) {
		var p = num(t[i][2]);
		if (t[i][0] > 0) {
			p += "*" + cheb(t[i][0], "snorm[0]");
		}
		if (t[i][1] > 0) {
			p += "*" + cheb(t[i][1], "snorm[1]");
		}
		parts.push(p);
	}
	outlet(0, "exprfill", 0, parts.join("+"));
	outlet(0, "bang");
}

function update() {
	write_buffer();
	if (mode_v) {
		// a dial drag sends many values: redraw the picture once it settles
		fill_task.cancel();
		fill_task.schedule(60);
	}
}

function preset(i) {
	preset_i = Math.min(Math.max(Math.floor(i), 0), PRESETS.length - 1);
	update();
}

function bright(v) {
	bright_v = Math.min(Math.max(v, 0.0), 1.0);
	update();
}

function mode(v) {
	mode_v = (v > 0) ? 1 : 0;
	if (mode_v) {
		fill();
	} else {
		fill_task.cancel();
		outlet(1, "bang");
	}
}
