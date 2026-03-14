// presets.js -- Kick drum preset recall
// Receives preset index (int) from umenu.
// Outlet 0 -> kick engine gen~ (param messages)
// Outlet 1 -> master chain gen~ (param messages)

inlets = 1;
outlets = 2;

var presets = [
    { // 0: Default
        kick: {
            pitch_start: 300, pitch_end: 50, pitch_decay: 30, amp_decay: 200,
            pitch_curve: 0.3, amp_curve: 0.15, body_level: 1,
            click_level: 0.5, click_decay: 2, click_tone: 3000,
            sub_level: 0.5, sub_decay: 300,
            noise_level: 0.3, noise_decay: 5, noise_tone: 4000
        },
        master: {
            drive: 1, hp_freq: 30, eq_low_freq: 80, eq_low_gain: 0,
            eq_mid_freq: 300, eq_mid_gain: 0, lim_ceil: 0, lim_release: 10
        }
    },
    { // 1: 808
        kick: {
            pitch_start: 130, pitch_end: 49, pitch_decay: 80, amp_decay: 600,
            pitch_curve: 0.2, amp_curve: 0.1, body_level: 1,
            click_level: 0, click_decay: 2, click_tone: 3000,
            sub_level: 0.3, sub_decay: 500,
            noise_level: 0, noise_decay: 5, noise_tone: 4000
        },
        master: {
            drive: 1.5, hp_freq: 25, eq_low_freq: 60, eq_low_gain: 3,
            eq_mid_freq: 300, eq_mid_gain: -2, lim_ceil: -1, lim_release: 15
        }
    },
    { // 2: 909
        kick: {
            pitch_start: 250, pitch_end: 55, pitch_decay: 12, amp_decay: 200,
            pitch_curve: 0.4, amp_curve: 0.2, body_level: 1,
            click_level: 0.8, click_decay: 3, click_tone: 4000,
            sub_level: 0.3, sub_decay: 150,
            noise_level: 0.4, noise_decay: 4, noise_tone: 5000
        },
        master: {
            drive: 3, hp_freq: 35, eq_low_freq: 80, eq_low_gain: 2,
            eq_mid_freq: 350, eq_mid_gain: -4, lim_ceil: -2, lim_release: 8
        }
    },
    { // 3: Techno
        kick: {
            pitch_start: 300, pitch_end: 45, pitch_decay: 20, amp_decay: 150,
            pitch_curve: 0.35, amp_curve: 0.25, body_level: 1,
            click_level: 0.5, click_decay: 1.5, click_tone: 3500,
            sub_level: 0.4, sub_decay: 120,
            noise_level: 0.2, noise_decay: 3, noise_tone: 4500
        },
        master: {
            drive: 4, hp_freq: 40, eq_low_freq: 70, eq_low_gain: 4,
            eq_mid_freq: 250, eq_mid_gain: -6, lim_ceil: -3, lim_release: 5
        }
    },
    { // 4: Trap
        kick: {
            pitch_start: 180, pitch_end: 38, pitch_decay: 50, amp_decay: 450,
            pitch_curve: 0.15, amp_curve: 0.08, body_level: 1,
            click_level: 0.2, click_decay: 2, click_tone: 2500,
            sub_level: 0.7, sub_decay: 400,
            noise_level: 0.1, noise_decay: 5, noise_tone: 3000
        },
        master: {
            drive: 1.2, hp_freq: 22, eq_low_freq: 55, eq_low_gain: 6,
            eq_mid_freq: 200, eq_mid_gain: -3, lim_ceil: -1, lim_release: 20
        }
    }
];

function msg_int(idx) {
    if (idx < 0 || idx >= presets.length) return;
    var p = presets[idx];

    for (var key in p.kick) {
        outlet(0, key, p.kick[key]);
    }
    for (var key in p.master) {
        outlet(1, key, p.master[key]);
    }
}
