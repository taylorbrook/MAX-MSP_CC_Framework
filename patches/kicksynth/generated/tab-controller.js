inlets = 1;
outlets = 1;

var groups = {
	0: ["d_pitch_start", "d_pitch_end", "d_pitch_decay", "d_pitch_curve", "d_amp_decay", "d_amp_curve", "d_body_level", "body_label"],
	1: ["d_sub_level", "d_sub_decay", "d_noise_level", "d_noise_decay", "d_noise_tone", "sub_label", "noise_label"],
	2: ["d_click_level", "d_click_decay", "d_click_tone", "click_label"],
	3: ["d_drive", "d_hp_freq", "d_eq_low_freq", "d_eq_low_gain", "d_eq_mid_freq", "d_eq_mid_gain", "d_lim_ceil", "d_lim_release", "master_label"],
	4: ["viz_scope", "viz_meter", "viz_label"]
};

function msg_int(tab) {
	for (var g = 0; g < 5; g++) {
		var names = groups[g];
		var cmd = (g === tab) ? "show" : "hide";
		for (var i = 0; i < names.length; i++) {
			outlet(0, "script", cmd, names[i]);
		}
	}
}
