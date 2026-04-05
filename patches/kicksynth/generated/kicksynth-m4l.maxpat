{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            85.0,
            104.0,
            640.0,
            480.0
        ],
        "openinpresentation": 1,
        "devicewidth": 614.0,
        "boxes": [
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        50.0,
                        50.0,
                        58.0,
                        22.0
                    ],
                    "text": "notein"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        50.0,
                        80.0,
                        79.0,
                        22.0
                    ],
                    "text": "stripnote"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        50.0,
                        110.0,
                        80.5,
                        22.0
                    ],
                    "text": "trigger b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        50.0,
                        140.0,
                        58.0,
                        22.0
                    ],
                    "text": "click~"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        50.0,
                        170.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        30.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [
                            100.0,
                            100.0,
                            600.0,
                            450.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param pitch_start(300, min=50, max=1000);\nParam pitch_end(50, min=20, max=200);\nParam pitch_decay(30, min=1, max=500);\nParam amp_decay(200, min=10, max=2000);\nParam pitch_curve(0.3, min=0.01, max=1);\nParam amp_curve(0.15, min=0.01, max=1);\nParam body_level(1, min=0, max=1);\nParam click_level(0.5, min=0, max=1);\nParam click_decay(2, min=0.1, max=20);\nParam click_tone(3000, min=200, max=12000);\nParam sub_level(0.5, min=0, max=1);\nParam sub_decay(300, min=10, max=2000);\nParam noise_level(0.3, min=0, max=1);\nParam noise_decay(5, min=0.5, max=100);\nParam noise_tone(4000, min=200, max=12000);\n\nHistory phase(0);\nHistory pitch_env(0);\nHistory amp_env(0);\nHistory prev_trig(0);\nHistory click_env(0);\nHistory click_lp(0);\nHistory sub_phase(0);\nHistory sub_env(0);\nHistory noise_env(0);\nHistory noise_lp(0);\n\ntrig = in1;\ntrig_on = (trig > 0) && (prev_trig <= 0);\nprev_trig = trig;\n\nif (trig_on) {\n    pitch_env = 1.0;\n    amp_env = 1.0;\n    click_env = 1.0;\n    sub_env = 1.0;\n    noise_env = 1.0;\n    phase = 0;\n    sub_phase = 0;\n}\n\npitch_samples = max(pitch_decay * 0.001 * samplerate, 1);\npitch_coeff = exp(-1.0 / (pitch_samples * pitch_curve));\npitch_env *= pitch_coeff;\namp_samples = max(amp_decay * 0.001 * samplerate, 1);\namp_coeff = exp(-1.0 / (amp_samples * amp_curve));\namp_env *= amp_coeff;\nfreq = pitch_end + (pitch_start - pitch_end) * pitch_env;\nphase += freq / samplerate;\nphase -= floor(phase);\nbody = sin(phase * TWOPI) * amp_env * body_level;\n\nclick_samples = max(click_decay * 0.001 * samplerate, 1);\nclick_coeff = exp(-1.0 / click_samples);\nclick_env *= click_coeff;\nclick_alpha = min(TWOPI * click_tone / samplerate, 1);\nclick_noise = noise();\nclick_lp = click_lp + click_alpha * (click_noise - click_lp);\nclick_out = (trig_on + click_lp * click_env) * click_level;\n\nsub_samples = max(sub_decay * 0.001 * samplerate, 1);\nsub_coeff = exp(-1.0 / sub_samples);\nsub_env *= sub_coeff;\nsub_phase += pitch_end / samplerate;\nsub_phase -= floor(sub_phase);\nsub = sin(sub_phase * TWOPI) * sub_env * sub_level;\n\nnoise_samples = max(noise_decay * 0.001 * samplerate, 1);\nnoise_coeff = exp(-1.0 / noise_samples);\nnoise_env *= noise_coeff;\nnoise_alpha = min(TWOPI * noise_tone / samplerate, 1);\nnoise_raw = noise();\nnoise_lp = noise_lp + noise_alpha * (noise_raw - noise_lp);\nnoise_out = noise_lp * noise_env * noise_level;\n\nout1 = body + click_out + sub + noise_out;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-2",
                                        0
                                    ],
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-3",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        0
                                    ]
                                }
                            }
                        ],
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    },
                    "patching_rect": [
                        50.0,
                        220.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [
                            100.0,
                            100.0,
                            600.0,
                            450.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param drive(1, min=1, max=20);\nParam hp_freq(30, min=20, max=200);\nParam eq_low_freq(80, min=40, max=200);\nParam eq_low_gain(0, min=-12, max=12);\nParam eq_mid_freq(300, min=100, max=800);\nParam eq_mid_gain(0, min=-12, max=12);\nParam lim_ceil(0, min=-20, max=0);\nParam lim_release(10, min=1, max=100);\n\nHistory hp_s1(0);\nHistory hp_s2(0);\nHistory ls_s1(0);\nHistory ls_s2(0);\nHistory pk_s1(0);\nHistory pk_s2(0);\nHistory peak_env(0);\n\nsig = in1;\n\ntanh_drive = tanh(drive);\nsig = tanh(drive * sig) / max(tanh_drive, 0.001);\n\nw0_hp = TWOPI * hp_freq / samplerate;\nsin_hp = sin(w0_hp);\ncos_hp = cos(w0_hp);\nalpha_hp = sin_hp / 1.4142;\nhp_b0 = (1 + cos_hp) * 0.5 / (1 + alpha_hp);\nhp_b1 = -(1 + cos_hp) / (1 + alpha_hp);\nhp_b2 = (1 + cos_hp) * 0.5 / (1 + alpha_hp);\nhp_a1 = -2 * cos_hp / (1 + alpha_hp);\nhp_a2 = (1 - alpha_hp) / (1 + alpha_hp);\nhp_y = hp_b0 * sig + hp_s1;\nhp_s1 = hp_b1 * sig - hp_a1 * hp_y + hp_s2;\nhp_s2 = hp_b2 * sig - hp_a2 * hp_y;\nsig = hp_y;\n\nls_A = pow(10, eq_low_gain / 40);\nw0_ls = TWOPI * eq_low_freq / samplerate;\nsin_ls = sin(w0_ls);\ncos_ls = cos(w0_ls);\nsqrt_ls = sqrt(max(ls_A, 0.001));\nalpha_ls = sin_ls / 1.4142;\nls_a0 = (ls_A+1) + (ls_A-1)*cos_ls + 2*sqrt_ls*alpha_ls;\nls_b0 = ls_A * ((ls_A+1) - (ls_A-1)*cos_ls + 2*sqrt_ls*alpha_ls) / ls_a0;\nls_b1 = 2*ls_A * ((ls_A-1) - (ls_A+1)*cos_ls) / ls_a0;\nls_b2 = ls_A * ((ls_A+1) - (ls_A-1)*cos_ls - 2*sqrt_ls*alpha_ls) / ls_a0;\nls_a1 = -2 * ((ls_A-1) + (ls_A+1)*cos_ls) / ls_a0;\nls_a2 = ((ls_A+1) + (ls_A-1)*cos_ls - 2*sqrt_ls*alpha_ls) / ls_a0;\nls_y = ls_b0 * sig + ls_s1;\nls_s1 = ls_b1 * sig - ls_a1 * ls_y + ls_s2;\nls_s2 = ls_b2 * sig - ls_a2 * ls_y;\nsig = ls_y;\n\npk_A = pow(10, eq_mid_gain / 40);\nw0_pk = TWOPI * eq_mid_freq / samplerate;\nsin_pk = sin(w0_pk);\ncos_pk = cos(w0_pk);\nalpha_pk = sin_pk * 0.5;\npk_a0 = 1 + alpha_pk / max(pk_A, 0.001);\npk_b0 = (1 + alpha_pk * pk_A) / pk_a0;\npk_b1 = (-2 * cos_pk) / pk_a0;\npk_b2 = (1 - alpha_pk * pk_A) / pk_a0;\npk_a1 = (-2 * cos_pk) / pk_a0;\npk_a2 = (1 - alpha_pk / max(pk_A, 0.001)) / pk_a0;\npk_y = pk_b0 * sig + pk_s1;\npk_s1 = pk_b1 * sig - pk_a1 * pk_y + pk_s2;\npk_s2 = pk_b2 * sig - pk_a2 * pk_y;\nsig = pk_y;\n\nlim_thresh = pow(10, lim_ceil / 20);\nrel_coeff = exp(-1.0 / max(lim_release * 0.001 * samplerate, 1));\nabs_sig = abs(sig);\nif (abs_sig > peak_env) {\n    peak_env = abs_sig;\n} else {\n    peak_env = abs_sig + rel_coeff * (peak_env - abs_sig);\n}\nlim_gain = (peak_env > lim_thresh) ? lim_thresh / peak_env : 1;\nout1 = sig * lim_gain;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-2",
                                        0
                                    ],
                                    "source": [
                                        "obj-1",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-3",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        0
                                    ]
                                }
                            }
                        ],
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    },
                    "patching_rect": [
                        50.0,
                        260.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        50.0,
                        530.0,
                        90.0,
                        22.0
                    ],
                    "text": "plugout~"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-10",
                    "maxclass": "live.scope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        300.0,
                        320.0,
                        100.0,
                        50.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        30.0,
                        400.0,
                        130.0
                    ],
                    "varname": "viz_scope"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-11",
                    "maxclass": "live.meter~",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "int"
                    ],
                    "patching_rect": [
                        420.0,
                        320.0,
                        30.0,
                        50.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        460.0,
                        30.0,
                        140.0,
                        130.0
                    ],
                    "slidercolor": [
                        0.079348079365577,
                        0.07934804057877,
                        0.079348050547289,
                        1.0
                    ],
                    "varname": "viz_meter"
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "live.tab",
                    "num_lines_patching": 1,
                    "num_lines_presentation": 1,
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        200.0,
                        30.0,
                        200.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        614.0,
                        20.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "Body",
                                "Sub+Noise",
                                "Click",
                                "Master",
                                "Visualize"
                            ],
                            "parameter_initial": [
                                0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Tab",
                            "parameter_mmax": 4,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Tab",
                            "parameter_type": 2,
                            "parameter_unitstyle": 9
                        }
                    },
                    "varname": "live.tab"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        60.0,
                        156.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "tab-controller.js",
                        "parameter_enable": 0
                    },
                    "text": "js tab-controller.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        90.0,
                        93.0,
                        22.0
                    ],
                    "save": [
                        "#N",
                        "thispatcher",
                        ";",
                        "#Q",
                        "end",
                        ";"
                    ],
                    "text": "thispatcher"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        -1.0,
                        87.5,
                        22.0
                    ],
                    "text": "loadmess 0"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-17",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        300.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                300.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Pitch Start",
                            "parameter_mmax": 1000.0,
                            "parameter_mmin": 50.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "P.Start",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_pitch_start"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        455.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend pitch_start"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-19",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        380.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        128.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                50.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Pitch End",
                            "parameter_mmax": 200.0,
                            "parameter_mmin": 20.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "P.End",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_pitch_end"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        455.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend pitch_end"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-21",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        460.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        206.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                30.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Pitch Decay",
                            "parameter_mmax": 500.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "P.Decay",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "d_pitch_decay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        460.0,
                        455.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend pitch_decay"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-23",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        540.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        284.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.3
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Pitch Curve",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": 0.01,
                            "parameter_modmode": 0,
                            "parameter_shortname": "P.Curve",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_pitch_curve"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        455.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend pitch_curve"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-25",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        620.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        362.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                200.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Amp Decay",
                            "parameter_mmax": 2000.0,
                            "parameter_mmin": 10.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "A.Decay",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "d_amp_decay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        620.0,
                        455.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend amp_decay"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-27",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        700.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        440.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.15
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Amp Curve",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": 0.01,
                            "parameter_modmode": 0,
                            "parameter_shortname": "A.Curve",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_amp_curve"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        455.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend amp_curve"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-29",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        780.0,
                        400.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        518.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Body Level",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Body",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_body_level"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        780.0,
                        455.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend body_level"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-31",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        300.0,
                        530.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Sub Level",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Sub",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_sub_level"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        585.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend sub_level"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-33",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        380.0,
                        530.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        160.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                300.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Sub Decay",
                            "parameter_mmax": 2000.0,
                            "parameter_mmin": 10.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "S.Decay",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "d_sub_decay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        585.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend sub_decay"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-35",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        460.0,
                        530.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        270.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.3
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Noise Level",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Noise",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_noise_level"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        460.0,
                        585.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend noise_level"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-37",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        540.0,
                        530.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        380.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                5.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Noise Decay",
                            "parameter_mmax": 100.0,
                            "parameter_mmin": 0.5,
                            "parameter_modmode": 0,
                            "parameter_shortname": "N.Decay",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "d_noise_decay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        585.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend noise_decay"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-39",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        620.0,
                        530.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        490.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                4000.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Noise Tone",
                            "parameter_mmax": 12000.0,
                            "parameter_mmin": 200.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "N.Tone",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_noise_tone"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-40",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        620.0,
                        585.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend noise_tone"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-41",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        300.0,
                        660.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Click Level",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Click",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_click_level"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        715.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend click_level"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-43",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        380.0,
                        660.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                2.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Click Decay",
                            "parameter_mmax": 20.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "C.Decay",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "d_click_decay"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        715.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend click_decay"
                }
            },
            {
                "box": {
                    "hidden": 1,
                    "id": "obj-45",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        460.0,
                        660.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        410.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                3000.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Click Tone",
                            "parameter_mmax": 12000.0,
                            "parameter_mmin": 200.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "C.Tone",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_click_tone"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-46",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        460.0,
                        715.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend click_tone"
                }
            },
            {
                "box": {
                    "id": "obj-47",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        300.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Drive",
                            "parameter_mmax": 20.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Drive",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "d_drive"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        845.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend drive"
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        380.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        118.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                30.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "HP Frequency",
                            "parameter_mmax": 200.0,
                            "parameter_mmin": 20.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "HP Freq",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_hp_freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        380.0,
                        845.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend hp_freq"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        460.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        186.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                80.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "EQ Low Freq",
                            "parameter_mmax": 200.0,
                            "parameter_mmin": 40.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Lo Freq",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_eq_low_freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-52",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        460.0,
                        845.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend eq_low_freq"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        540.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        254.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "EQ Low Gain",
                            "parameter_mmax": 12.0,
                            "parameter_mmin": -12.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Lo Gain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "d_eq_low_gain"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-54",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        845.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend eq_low_gain"
                }
            },
            {
                "box": {
                    "id": "obj-55",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        620.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        322.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                300.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "EQ Mid Freq",
                            "parameter_mmax": 800.0,
                            "parameter_mmin": 100.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Mid Freq",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "d_eq_mid_freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        620.0,
                        845.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend eq_mid_freq"
                }
            },
            {
                "box": {
                    "id": "obj-57",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        700.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "EQ Mid Gain",
                            "parameter_mmax": 12.0,
                            "parameter_mmin": -12.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Mid Gain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "d_eq_mid_gain"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        845.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend eq_mid_gain"
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        780.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        458.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Limiter Ceiling",
                            "parameter_mmax": 0.0,
                            "parameter_mmin": -20.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Lim Ceil",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "varname": "d_lim_ceil"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-60",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        780.0,
                        845.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend lim_ceil"
                }
            },
            {
                "box": {
                    "id": "obj-61",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        860.0,
                        790.0,
                        50.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        526.0,
                        30.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                10.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Limiter Release",
                            "parameter_mmax": 100.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Lim Rel",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "d_lim_release"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-62",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        860.0,
                        845.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend lim_release"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "hidden": 1,
                    "id": "obj-63",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        700.0,
                        44.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        85.0,
                        42.0,
                        19.0
                    ],
                    "text": "BODY",
                    "varname": "body_label"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "hidden": 1,
                    "id": "obj-64",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        700.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        85.0,
                        34.0,
                        19.0
                    ],
                    "text": "SUB",
                    "varname": "sub_label"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "hidden": 1,
                    "id": "obj-65",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        700.0,
                        51.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        85.0,
                        50.0,
                        19.0
                    ],
                    "text": "NOISE",
                    "varname": "noise_label"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "hidden": 1,
                    "id": "obj-66",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        700.0,
                        51.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        85.0,
                        50.0,
                        19.0
                    ],
                    "text": "CLICK",
                    "varname": "click_label"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-67",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        700.0,
                        58.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        85.0,
                        58.0,
                        19.0
                    ],
                    "text": "MASTER",
                    "varname": "master_label"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "hidden": 1,
                    "id": "obj-68",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        500.0,
                        700.0,
                        58.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        50.0,
                        85.0,
                        58.0,
                        19.0
                    ],
                    "text": "OUTPUT",
                    "varname": "viz_label"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-69",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.0"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        1
                    ],
                    "source": [
                        "obj-1",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        0
                    ],
                    "source": [
                        "obj-1",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "source": [
                        "obj-12",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-14",
                        0
                    ],
                    "source": [
                        "obj-13",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-12",
                        0
                    ],
                    "source": [
                        "obj-16",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "source": [
                        "obj-17",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-18",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-20",
                        0
                    ],
                    "source": [
                        "obj-19",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "source": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-20",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-22",
                        0
                    ],
                    "source": [
                        "obj-21",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-22",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-24",
                        0
                    ],
                    "source": [
                        "obj-23",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-24",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-26",
                        0
                    ],
                    "source": [
                        "obj-25",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-28",
                        0
                    ],
                    "source": [
                        "obj-27",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-28",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-30",
                        0
                    ],
                    "source": [
                        "obj-29",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "source": [
                        "obj-3",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-30",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-32",
                        0
                    ],
                    "source": [
                        "obj-31",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-32",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "source": [
                        "obj-33",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-34",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "source": [
                        "obj-35",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-36",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "source": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-38",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-40",
                        0
                    ],
                    "source": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-40",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-42",
                        0
                    ],
                    "source": [
                        "obj-41",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-42",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-44",
                        0
                    ],
                    "source": [
                        "obj-43",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "source": [
                        "obj-45",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "source": [
                        "obj-46",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-48",
                        0
                    ],
                    "source": [
                        "obj-47",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "source": [
                        "obj-49",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "source": [
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-50",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "source": [
                        "obj-51",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-52",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "source": [
                        "obj-53",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-54",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "source": [
                        "obj-55",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-56",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-58",
                        0
                    ],
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-58",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-60",
                        0
                    ],
                    "source": [
                        "obj-59",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-60",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-62",
                        0
                    ],
                    "source": [
                        "obj-61",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "source": [
                        "obj-62",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        0
                    ],
                    "destination": [
                        "obj-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-7",
                        0
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-12": [
                "Tab",
                "Tab",
                0
            ],
            "obj-17": [
                "Pitch Start",
                "P.Start",
                0
            ],
            "obj-19": [
                "Pitch End",
                "P.End",
                0
            ],
            "obj-21": [
                "Pitch Decay",
                "P.Decay",
                0
            ],
            "obj-23": [
                "Pitch Curve",
                "P.Curve",
                0
            ],
            "obj-25": [
                "Amp Decay",
                "A.Decay",
                0
            ],
            "obj-27": [
                "Amp Curve",
                "A.Curve",
                0
            ],
            "obj-29": [
                "Body Level",
                "Body",
                0
            ],
            "obj-31": [
                "Sub Level",
                "Sub",
                0
            ],
            "obj-33": [
                "Sub Decay",
                "S.Decay",
                0
            ],
            "obj-35": [
                "Noise Level",
                "Noise",
                0
            ],
            "obj-37": [
                "Noise Decay",
                "N.Decay",
                0
            ],
            "obj-39": [
                "Noise Tone",
                "N.Tone",
                0
            ],
            "obj-41": [
                "Click Level",
                "Click",
                0
            ],
            "obj-43": [
                "Click Decay",
                "C.Decay",
                0
            ],
            "obj-45": [
                "Click Tone",
                "C.Tone",
                0
            ],
            "obj-47": [
                "Drive",
                "Drive",
                0
            ],
            "obj-49": [
                "HP Frequency",
                "HP Freq",
                0
            ],
            "obj-51": [
                "EQ Low Freq",
                "Lo Freq",
                0
            ],
            "obj-53": [
                "EQ Low Gain",
                "Lo Gain",
                0
            ],
            "obj-55": [
                "EQ Mid Freq",
                "Mid Freq",
                0
            ],
            "obj-57": [
                "EQ Mid Gain",
                "Mid Gain",
                0
            ],
            "obj-59": [
                "Limiter Ceiling",
                "Lim Ceil",
                0
            ],
            "obj-61": [
                "Limiter Release",
                "Lim Rel",
                0
            ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ],
                    "buttons": [
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-",
                        "-"
                    ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0
    }
}