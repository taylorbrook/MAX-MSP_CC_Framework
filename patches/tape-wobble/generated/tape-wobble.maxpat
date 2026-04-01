{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 0,
            "revision": 0,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            85.0,
            104.0,
            1060.0,
            680.0
        ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 12.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridonopen": 1,
        "gridsize": [
            15.0,
            15.0
        ],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 200,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": 0.0,
        "description": "",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        10,
                        124.5,
                        24.0
                    ],
                    "text": "TAPE WOBBLE",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.25,
                        0.42,
                        1.0
                    ],
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        985,
                        12,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        200,
                        225,
                        121.0,
                        22.0
                    ],
                    "text": "gen~",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 0,
                            "revision": 0,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [
                            100.0,
                            100.0,
                            620.0,
                            520.0
                        ],
                        "bglocked": 0,
                        "openinpresentation": 0,
                        "default_fontsize": 12.0,
                        "default_fontface": 0,
                        "default_fontname": "Arial",
                        "gridonopen": 1,
                        "gridsize": [
                            15.0,
                            15.0
                        ],
                        "gridsnaponopen": 1,
                        "objectsnaponopen": 1,
                        "statusbarvisible": 2,
                        "toolbarvisible": 1,
                        "lefttoolbarpinned": 0,
                        "toptoolbarpinned": 0,
                        "righttoolbarpinned": 0,
                        "bottomtoolbarpinned": 0,
                        "toolbars_unpinned_last_save": 0,
                        "tallnewobj": 0,
                        "boxanimatetime": 200,
                        "enablehscroll": 1,
                        "enablevscroll": 1,
                        "devicewidth": 0.0,
                        "description": "",
                        "digest": "",
                        "tags": "",
                        "style": "",
                        "subpatcher_template": "",
                        "assistshowspatchername": 0,
                        "boxes": [
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-1",
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
                                    "text": "in 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        500.0,
                                        320.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "\n// ============================================================\n// TAPE WOBBLE — Analog Tape Transport Emulation\n// Three-layer modulation: drift + wow + flutter\n// Based on ChowTapeModel / DAFx 2019 research\n// ============================================================\n\n// === PARAMETERS ===\nParam wow_rate(2, min=0.1, max=6);\nParam wow_depth(0.3, min=0, max=1);\nParam flutter_rate(8, min=3, max=30);\nParam flutter_depth(0.2, min=0, max=1);\nParam drift(0.3, min=0, max=1);\nParam saturation(0.3, min=0, max=1);\nParam hf_cutoff(9000, min=4000, max=15000);\nParam bump_gain(3, min=0, max=6);\nParam bump_freq(100, min=60, max=200);\nParam stereo_spread(0.15, min=0, max=1);\nParam drywet(0.7, min=0, max=1);\n\n// === STATE ===\nHistory ou_L(0);\nHistory ou_R(0.1);\nHistory ou_smooth_L(0);\nHistory ou_smooth_R(0);\nHistory wow_phase(0);\nHistory f_phase1(0);\nHistory f_phase2(0);\nHistory f_phase3(0);\nHistory hbx1L(0); History hbx2L(0); History hby1L(0); History hby2L(0);\nHistory hbx1R(0); History hbx2R(0); History hby1R(0); History hby2R(0);\nHistory lpx1L(0); History lpx2L(0); History lpy1L(0); History lpy2L(0);\nHistory lpx1R(0); History lpx2R(0); History lpy1R(0); History lpy2R(0);\nHistory dcx1L(0); History dcy1L(0);\nHistory dcx1R(0); History dcy1R(0);\n\n// === DELAY LINES ===\nDelay del_L(4096);\nDelay del_R(4096);\n\n// === CONSTANTS ===\npi = 3.14159265358979;\ntwopi = 2.0 * pi;\nsr = samplerate;\n\n// === ORNSTEIN-UHLENBECK DRIFT (independent L/R) ===\ndt = 1.0 / sr;\nsqrt_dt = sqrt(dt);\nou_damping = 20.0;\n\nn_L = noise();\nou_next_L = ou_L + sqrt_dt * n_L * drift * 0.5;\nou_next_L = ou_next_L + ou_damping * (0.0 - ou_next_L) * dt;\nou_L = ou_next_L;\n\nou_coeff = exp(-twopi * 10.0 / sr);\nou_smooth_L = ou_next_L + ou_coeff * (ou_smooth_L - ou_next_L);\n\nn_R = noise();\nou_next_R = ou_R + sqrt_dt * n_R * drift * 0.5;\nou_next_R = ou_next_R + ou_damping * (0.0 - ou_next_R) * dt;\nou_R = ou_next_R;\nou_smooth_R = ou_next_R + ou_coeff * (ou_smooth_R - ou_next_R);\n\ndrift_mod_L = ou_smooth_L * 15.0;\ndrift_mod_R = ou_smooth_R * 15.0;\n\n// === WOW LFO ===\nwow_freq = wow_rate * (1.0 + ou_smooth_L * 0.3 * drift);\nwow_inc = twopi * wow_freq / sr;\nwow_phase = wrap(wow_phase + wow_inc, 0, twopi);\n\nwow_mod_L = cos(wow_phase) * wow_depth * 20.0;\nwow_mod_R = cos(wow_phase + 0.1 * stereo_spread) * wow_depth * 20.0;\n\n// === FLUTTER LFO (3-harmonic, ChowTape ratios 230:80:99) ===\nf1_inc = twopi * flutter_rate / sr;\nf2_inc = 2.0 * f1_inc;\nf3_inc = 3.0 * f1_inc;\n\nf_phase1 = wrap(f_phase1 + f1_inc, 0, twopi);\nf_phase2 = wrap(f_phase2 + f2_inc, 0, twopi);\nf_phase3 = wrap(f_phase3 + f3_inc, 0, twopi);\n\nflutter_mod_L = flutter_depth * 6.0 * (\n    cos(f_phase1) +\n    0.35 * cos(f_phase2 + 10.2102) +\n    0.43 * cos(f_phase3 - 0.31416)\n);\n\nflutter_mod_R = flutter_depth * 6.0 * (\n    cos(f_phase1 + 0.05 * stereo_spread) +\n    0.35 * cos(f_phase2 + 10.2102 + 0.08 * stereo_spread) +\n    0.43 * cos(f_phase3 - 0.31416 + 0.03 * stereo_spread)\n);\n\n// === COMBINED MODULATION ===\nbase_delay = 50.0;\nmod_L = base_delay + wow_mod_L + flutter_mod_L + drift_mod_L;\nmod_R = base_delay + wow_mod_R + flutter_mod_R + drift_mod_R;\nmod_L = clamp(mod_L, 1, 4000);\nmod_R = clamp(mod_R, 1, 4000);\n\n// === SATURATION (Pade tanh, pre-wobble) ===\ndrive = 1.0 + saturation * 10.0;\n\nsat_in_L = in1 * drive;\nsat_L = sat_in_L * (27.0 + sat_in_L * sat_in_L) / (27.0 + 9.0 * sat_in_L * sat_in_L);\nsat_L = sat_L / drive;\n\nsat_in_R = in2 * drive;\nsat_R = sat_in_R * (27.0 + sat_in_R * sat_in_R) / (27.0 + 9.0 * sat_in_R * sat_in_R);\nsat_R = sat_R / drive;\n\n// === MODULATED DELAY ===\ndel_L.write(sat_L);\ndel_R.write(sat_R);\n\nwet_L = del_L.read(mod_L);\nwet_R = del_R.read(mod_R);\n\n// === HEAD BUMP EQ (peaking biquad) ===\nw0_bump = twopi * bump_freq / sr;\nA_bump = pow(10.0, bump_gain / 40.0);\nalpha_bump = sin(w0_bump) / 2.0;\n\nhb_b0 = (1.0 + alpha_bump * A_bump) / (1.0 + alpha_bump / A_bump);\nhb_b1 = (-2.0 * cos(w0_bump)) / (1.0 + alpha_bump / A_bump);\nhb_b2 = (1.0 - alpha_bump * A_bump) / (1.0 + alpha_bump / A_bump);\nhb_a1 = (-2.0 * cos(w0_bump)) / (1.0 + alpha_bump / A_bump);\nhb_a2 = (1.0 - alpha_bump / A_bump) / (1.0 + alpha_bump / A_bump);\n\nhb_outL = hb_b0 * wet_L + hb_b1 * hbx1L + hb_b2 * hbx2L - hb_a1 * hby1L - hb_a2 * hby2L;\nhbx2L = hbx1L; hbx1L = wet_L;\nhby2L = hby1L; hby1L = hb_outL;\n\nhb_outR = hb_b0 * wet_R + hb_b1 * hbx1R + hb_b2 * hbx2R - hb_a1 * hby1R - hb_a2 * hby2R;\nhbx2R = hbx1R; hbx1R = wet_R;\nhby2R = hby1R; hby1R = hb_outR;\n\n// === HF ROLLOFF (Butterworth LPF) ===\nw0_lp = twopi * hf_cutoff / sr;\ncos_w0_lp = cos(w0_lp);\nsin_w0_lp = sin(w0_lp);\nalpha_lp = sin_w0_lp / (2.0 * 0.707);\n\nlp_norm = 1.0 + alpha_lp;\nlp_b0 = ((1.0 - cos_w0_lp) / 2.0) / lp_norm;\nlp_b1 = (1.0 - cos_w0_lp) / lp_norm;\nlp_b2 = ((1.0 - cos_w0_lp) / 2.0) / lp_norm;\nlp_a1 = (-2.0 * cos_w0_lp) / lp_norm;\nlp_a2 = (1.0 - alpha_lp) / lp_norm;\n\nlp_outL = lp_b0 * hb_outL + lp_b1 * lpx1L + lp_b2 * lpx2L - lp_a1 * lpy1L - lp_a2 * lpy2L;\nlpx2L = lpx1L; lpx1L = hb_outL;\nlpy2L = lpy1L; lpy1L = lp_outL;\n\nlp_outR = lp_b0 * hb_outR + lp_b1 * lpx1R + lp_b2 * lpx2R - lp_a1 * lpy1R - lp_a2 * lpy2R;\nlpx2R = lpx1R; lpx1R = hb_outR;\nlpy2R = lpy1R; lpy1R = lp_outR;\n\n// === DC BLOCKER ===\ndc_outL = lp_outL - dcx1L + 0.999 * dcy1L;\ndcx1L = lp_outL; dcy1L = dc_outL;\n\ndc_outR = lp_outR - dcx1R + 0.999 * dcy1R;\ndcx1R = lp_outR; dcy1R = dc_outR;\n\n// === DRY/WET MIX ===\nout1 = in1 * (1.0 - drywet) + dc_outL * drywet;\nout2 = in2 * (1.0 - drywet) + dc_outR * drywet;\n\n// === MOD SIGNAL (for visualization) ===\nout3 = clamp((mod_L - base_delay) / 30.0, -1.0, 1.0);\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        50.0,
                                        440.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "out 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        130.0,
                                        440.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "out 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        440.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "out 3",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-1",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-3",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        0
                                    ],
                                    "destination": [
                                        "obj-4",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        1
                                    ],
                                    "destination": [
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        2
                                    ],
                                    "destination": [
                                        "obj-6",
                                        0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0,
                        "bgcolor": [
                            0.9,
                            0.9,
                            0.9,
                            1.0
                        ]
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        30,
                        205,
                        64.0,
                        22.0
                    ],
                    "text": "adc~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-5",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        200,
                        275,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        350,
                        205,
                        135.0,
                        22.0
                    ],
                    "text": "receive tape-ctrl",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 11,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        500,
                        145,
                        121.0,
                        22.0
                    ],
                    "text": "p param-routing",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 0,
                            "revision": 0,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [
                            100.0,
                            100.0,
                            1000.0,
                            420.0
                        ],
                        "bglocked": 0,
                        "openinpresentation": 0,
                        "default_fontsize": 12.0,
                        "default_fontface": 0,
                        "default_fontname": "Arial",
                        "gridonopen": 1,
                        "gridsize": [
                            15.0,
                            15.0
                        ],
                        "gridsnaponopen": 1,
                        "objectsnaponopen": 1,
                        "statusbarvisible": 2,
                        "toolbarvisible": 1,
                        "lefttoolbarpinned": 0,
                        "toptoolbarpinned": 0,
                        "righttoolbarpinned": 0,
                        "bottomtoolbarpinned": 0,
                        "toolbars_unpinned_last_save": 0,
                        "tallnewobj": 0,
                        "boxanimatetime": 200,
                        "enablehscroll": 1,
                        "enablevscroll": 1,
                        "devicewidth": 0.0,
                        "description": "",
                        "digest": "",
                        "tags": "",
                        "style": "",
                        "subpatcher_template": "",
                        "assistshowspatchername": 0,
                        "boxes": [
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Rate"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Depth"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Rate"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        290.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Depth"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Drift"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-6",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        450.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Drive"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-7",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        530.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "HF Cut"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-8",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        610.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Gain"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-9",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        690.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Freq"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-10",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        770.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Spread"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-11",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        850.0,
                                        30.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Mix"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        200,
                                        350,
                                        114.0,
                                        22.0
                                    ],
                                    "text": "send tape-ctrl",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-13",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        180,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0.1 6.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-14",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        240,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "wow_rate $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-15",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        115,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-16",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        115,
                                        240,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "wow_depth $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-17",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200,
                                        180,
                                        142.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 3. 30.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-18",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        200,
                                        240,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "flutter_rate $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-19",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        285,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-20",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        285,
                                        240,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "flutter_depth $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-21",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-22",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370,
                                        240,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "drift $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-23",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        455,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-24",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        455,
                                        240,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "saturation $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-25",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540,
                                        180,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 4000. 15000.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-26",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        540,
                                        240,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "hf_cutoff $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-27",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        625,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 6.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-28",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        625,
                                        240,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "bump_gain $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-29",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        710,
                                        180,
                                        156.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 60. 200.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-30",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        710,
                                        240,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "bump_freq $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-31",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        795,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-32",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        795,
                                        240,
                                        128.0,
                                        22.0
                                    ],
                                    "text": "stereo_spread $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-33",
                                    "numinlets": 6,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        880,
                                        180,
                                        135.0,
                                        22.0
                                    ],
                                    "text": "scale 0 127 0. 1.",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-34",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        880,
                                        240,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "drywet $1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-35",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        290,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "loadbang",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-36",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        90,
                                        290,
                                        1192.0,
                                        22.0
                                    ],
                                    "text": "wow_rate 2., wow_depth 0.3, flutter_rate 8., flutter_depth 0.2, drift 0.3, saturation 0.3, hf_cutoff 9000., bump_gain 3., bump_freq 100., stereo_spread 0.15, drywet 0.7",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [
                                        "obj-1",
                                        0
                                    ],
                                    "destination": [
                                        "obj-13",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-13",
                                        0
                                    ],
                                    "destination": [
                                        "obj-14",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-14",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-2",
                                        0
                                    ],
                                    "destination": [
                                        "obj-15",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-15",
                                        0
                                    ],
                                    "destination": [
                                        "obj-16",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-16",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        0
                                    ],
                                    "destination": [
                                        "obj-17",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-17",
                                        0
                                    ],
                                    "destination": [
                                        "obj-18",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-18",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-4",
                                        0
                                    ],
                                    "destination": [
                                        "obj-19",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-19",
                                        0
                                    ],
                                    "destination": [
                                        "obj-20",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-20",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-5",
                                        0
                                    ],
                                    "destination": [
                                        "obj-21",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-21",
                                        0
                                    ],
                                    "destination": [
                                        "obj-22",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-22",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-6",
                                        0
                                    ],
                                    "destination": [
                                        "obj-23",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-23",
                                        0
                                    ],
                                    "destination": [
                                        "obj-24",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-24",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
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
                                        "obj-25",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-25",
                                        0
                                    ],
                                    "destination": [
                                        "obj-26",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-26",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-8",
                                        0
                                    ],
                                    "destination": [
                                        "obj-27",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-27",
                                        0
                                    ],
                                    "destination": [
                                        "obj-28",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-28",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-9",
                                        0
                                    ],
                                    "destination": [
                                        "obj-29",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-29",
                                        0
                                    ],
                                    "destination": [
                                        "obj-30",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-30",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-10",
                                        0
                                    ],
                                    "destination": [
                                        "obj-31",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-31",
                                        0
                                    ],
                                    "destination": [
                                        "obj-32",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-32",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-11",
                                        0
                                    ],
                                    "destination": [
                                        "obj-33",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-33",
                                        0
                                    ],
                                    "destination": [
                                        "obj-34",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-34",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-35",
                                        0
                                    ],
                                    "destination": [
                                        "obj-36",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-36",
                                        0
                                    ],
                                    "destination": [
                                        "obj-12",
                                        0
                                    ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        37,
                        40.0,
                        20.0
                    ],
                    "text": "WOW",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        32,
                        54,
                        44.0,
                        20.0
                    ],
                    "text": "Rate",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        87,
                        54,
                        51.0,
                        20.0
                    ],
                    "text": "Depth",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        85.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        155,
                        37,
                        65.0,
                        20.0
                    ],
                    "text": "FLUTTER",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        157,
                        54,
                        44.0,
                        20.0
                    ],
                    "text": "Rate",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        155.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        212,
                        54,
                        51.0,
                        20.0
                    ],
                    "text": "Depth",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-18",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        285,
                        37,
                        44.0,
                        20.0
                    ],
                    "text": "TAPE",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        287,
                        54,
                        51.0,
                        20.0
                    ],
                    "text": "Drift",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        285.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        342,
                        54,
                        51.0,
                        20.0
                    ],
                    "text": "Drive",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        340.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        420,
                        37,
                        40.0,
                        20.0
                    ],
                    "text": "EQ",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        422,
                        54,
                        58.0,
                        20.0
                    ],
                    "text": "HF Cut",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        477,
                        54,
                        44.0,
                        20.0
                    ],
                    "text": "Gain",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        475.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        532,
                        54,
                        44.0,
                        20.0
                    ],
                    "text": "Freq",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        530.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        610,
                        37,
                        58.0,
                        20.0
                    ],
                    "text": "OUTPUT",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        612,
                        54,
                        58.0,
                        20.0
                    ],
                    "text": "Spread",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        610.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        667,
                        54,
                        40.0,
                        20.0
                    ],
                    "text": "Mix",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "dial",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        665.0,
                        68.0,
                        40.0,
                        40.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        315,
                        143.5,
                        24.0
                    ],
                    "text": "VISUALIZATION",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.25,
                        0.42,
                        1.0
                    ],
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        338,
                        79.0,
                        20.0
                    ],
                    "text": "DRY INPUT",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "live.scope~",
                    "id": "obj-37",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        355.0,
                        290.0,
                        130.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        350,
                        338,
                        86.0,
                        20.0
                    ],
                    "text": "WET OUTPUT",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "live.scope~",
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        350.0,
                        355.0,
                        290.0,
                        130.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        670,
                        338,
                        86.0,
                        20.0
                    ],
                    "text": "MOD SIGNAL",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "live.scope~",
                    "id": "obj-41",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        670.0,
                        355.0,
                        290.0,
                        130.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30,
                        188,
                        51.0,
                        20.0
                    ],
                    "text": "AUDIO",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "fontface": 1,
                    "textcolor": [
                        0.3,
                        0.3,
                        0.35,
                        1.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        226.0,
                        207.0,
                        226.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        1
                    ],
                    "destination": [
                        "obj-3",
                        1
                    ],
                    "midpoints": [
                        62.0,
                        226.0,
                        314.0,
                        226.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        1
                    ],
                    "destination": [
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        260.5,
                        261.0,
                        238.0,
                        261.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-6",
                        0
                    ],
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        417.5,
                        226.0,
                        207.0,
                        226.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-10",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        50.0,
                        126.5,
                        507.0,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        1
                    ],
                    "midpoints": [
                        105.0,
                        126.5,
                        517.7,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        2
                    ],
                    "midpoints": [
                        175.0,
                        126.5,
                        528.4,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-17",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        3
                    ],
                    "midpoints": [
                        230.0,
                        126.5,
                        539.1,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-20",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        4
                    ],
                    "midpoints": [
                        305.0,
                        126.5,
                        549.8,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-22",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        5
                    ],
                    "midpoints": [
                        360.0,
                        126.5,
                        560.5,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-25",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        6
                    ],
                    "midpoints": [
                        440.0,
                        126.5,
                        571.2,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-27",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        7
                    ],
                    "midpoints": [
                        495.0,
                        126.5,
                        581.9,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-29",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        8
                    ],
                    "midpoints": [
                        550.0,
                        126.5,
                        592.6,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-32",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        9
                    ],
                    "midpoints": [
                        630.0,
                        126.5,
                        603.3,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        0
                    ],
                    "destination": [
                        "obj-7",
                        10
                    ],
                    "midpoints": [
                        685.0,
                        126.5,
                        614.0,
                        126.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        207.0,
                        301.0,
                        357.0,
                        301.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        2
                    ],
                    "destination": [
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        314.0,
                        301.0,
                        677.0,
                        301.0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
        "locked_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}