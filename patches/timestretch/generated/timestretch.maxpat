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
            100.0,
            100.0,
            800.0,
            470.0
        ],
        "bglocked": 0,
        "openinpresentation": 1,
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
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        390.0,
                        285.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~ @source timestretch-source",
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
                            600.0,
                            450.0
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
                                        30.0,
                                        30.0,
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
                                    "maxclass": "codebox",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "\n// === PARAMETERS ===\nParam stretch(1, min=0.25, max=8);\nParam grain_ms(40, min=5, max=200);\nParam pitch(0, min=-2400, max=2400);\nParam wsola_tol(128, min=0, max=256);\nParam jitter_amt(0.05, min=0, max=0.25);\nParam sensitivity(0.5, min=0, max=1);\nParam adapt(1, min=0, max=1);\nParam density(4, min=2, max=8);\nParam extreme(0, min=0, max=1);\nParam mode(0, min=0, max=1);\n\nBuffer source;\nData circ(131072);\nData gpos(8);\nData gphase(8);\nData gsize(8);\nData gactive(8);\n\nHistory wpos(0);\nHistory rpos(0);\nHistory hop_ctr(0);\nHistory next_g(0);\nHistory hp_z1(0);\nHistory env_f(0);\nHistory env_s(0);\n\n// === DSP ===\nsig = in1;\nsr = samplerate;\nbuf_len = 131072;\nmax_grains = 8;\n\nplayback_speed = pow(2, pitch / 1200);\nbase_size = grain_ms * sr / 1000;\nactive_grains = clamp(floor(density), 2, 8);\n\n// Write input to circular buffer (live mode)\nwp = wpos;\nif (mode < 0.5) {\n    poke(circ, sig, wp % buf_len);\n}\nwp = wp + 1;\nwpos = wp;\n\n// Source buffer length for file mode\nsrc_len = dim(source);\nuse_file = (mode > 0.5 && src_len > 0) ? 1 : 0;\n\n// --- Transient Detection ---\nhp_coeff = exp(-twopi * 2000 / sr);\nhp_prev = hp_z1;\nhp_out = sig - hp_prev * hp_coeff;\nhp_z1 = sig;\n\nabs_hp = abs(hp_out);\natk_c = exp(-1 / (0.001 * sr));\nrel_c = exp(-1 / (0.05 * sr));\n\nfast_e = env_f;\ncoeff_f = (abs_hp > fast_e) ? atk_c : rel_c;\nfast_e = abs_hp + coeff_f * (fast_e - abs_hp);\nenv_f = fast_e;\n\nslow_c = exp(-1 / (0.2 * sr));\nslow_e = env_s;\nslow_e = abs_hp + slow_c * (slow_e - abs_hp);\nenv_s = slow_e;\n\ntrans_ratio = (slow_e > 0.0001) ? fast_e / slow_e : 1;\nthresh = 1 + (1 - sensitivity) * 10;\nis_transient = (trans_ratio > thresh) ? 1 : 0;\n\n// Adaptive grain size\ngrain_size = base_size;\nif (adapt > 0.5 && is_transient > 0.5) {\n    grain_size = max(10 * sr / 1000, base_size * 0.25);\n}\n\n// --- Grain Scheduling ---\nhop = grain_size / active_grains;\nhc = hop_ctr;\nhc = hc - 1;\n\nif (hc <= 0) {\n    ng = next_g;\n    rp = rpos;\n\n    best_offset = 0;\n    best_corr = -1;\n    tol = floor(wsola_tol);\n\n    if (tol > 0) {\n        ref_start = (wp - grain_size) % buf_len;\n\n        for (k = -tol; k <= tol; k += 8) {\n            corr_sum = 0;\n            test_start = rp + k;\n\n            for (j = 0; j < 64; j += 1) {\n                ref_idx = (ref_start + j) % buf_len;\n                tst_idx = 0;\n                ref_s = 0;\n                tst_s = 0;\n\n                if (use_file > 0.5) {\n                    tst_idx = (test_start + j) % src_len;\n                    ref_s = peek(source, ref_idx % src_len, 0);\n                    tst_s = peek(source, tst_idx, 0);\n                } else {\n                    tst_idx = (test_start + j) % buf_len;\n                    ref_s = peek(circ, ref_idx, 0);\n                    tst_s = peek(circ, tst_idx, 0);\n                }\n\n                corr_sum = corr_sum + ref_s * tst_s;\n            }\n\n            norm_k = k / max(tol, 1);\n            bias_v = 1 - 0.25 * norm_k * norm_k;\n            corr_sum = corr_sum * bias_v;\n\n            if (corr_sum > best_corr) {\n                best_corr = corr_sum;\n                best_offset = k;\n            }\n        }\n    }\n\n    jit = noise() * jitter_amt * hop;\n    start_pos = rp + best_offset + jit;\n\n    if (extreme > 0.5) {\n        rand_pos = (noise() + 1) * 0.5;\n        if (use_file > 0.5) {\n            start_pos = rand_pos * src_len;\n        } else {\n            start_pos = rand_pos * buf_len;\n        }\n    }\n\n    poke(gpos, start_pos, ng);\n    poke(gphase, 0, ng);\n    poke(gsize, grain_size, ng);\n    poke(gactive, 1, ng);\n\n    ng = (ng + 1) % active_grains;\n    next_g = ng;\n    hc = hop;\n}\nhop_ctr = hc;\n\n// Advance read position\nrp_new = rpos;\nif (use_file > 0.5) {\n    rp_new = rp_new + 1 / max(stretch, 0.001);\n    if (rp_new >= src_len) {\n        rp_new = rp_new - src_len;\n    }\n} else {\n    rp_new = rp_new + 1 / max(stretch, 0.001);\n}\nrpos = rp_new;\n\n// --- Grain Synthesis ---\noutput = 0;\nfor (i = 0; i < 8; i += 1) {\n    act = peek(gactive, i, 0);\n    if (act > 0.5) {\n        pos_g = peek(gpos, i, 0);\n        phase_g = peek(gphase, i, 0);\n        gsize_i = peek(gsize, i, 0);\n\n        samp = 0;\n        if (use_file > 0.5) {\n            rd_idx = pos_g % src_len;\n            if (rd_idx < 0) { rd_idx = rd_idx + src_len; }\n            samp = peek(source, rd_idx, 0);\n        } else {\n            rd_idx = pos_g % buf_len;\n            if (rd_idx < 0) { rd_idx = rd_idx + buf_len; }\n            samp = peek(circ, rd_idx, 0);\n        }\n\n        env_g = 0.5 * (1 - cos(twopi * phase_g));\n        output = output + samp * env_g;\n\n        pos_g = pos_g + playback_speed;\n        phase_g = phase_g + 1 / gsize_i;\n\n        poke(gpos, pos_g, i);\n        poke(gphase, phase_g, i);\n\n        if (phase_g >= 1) {\n            poke(gactive, 0, i);\n        }\n    }\n}\n\noutput = output / max(active_grains * 0.5, 1);\n\nout1 = output;\nout2 = is_transient;\nout3 = rp_new / max((use_file > 0.5) ? src_len : buf_len, 1);\n",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        30.0,
                                        285.0,
                                        30.0,
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
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        210.0,
                                        285.0,
                                        30.0,
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
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        405.0,
                                        285.0,
                                        30.0,
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
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        45.0,
                                        63.5,
                                        230.0,
                                        63.5
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
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-2",
                                        1
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
                                        "obj-2",
                                        2
                                    ],
                                    "destination": [
                                        "obj-5",
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
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        64.0,
                        22.0
                    ],
                    "text": "adc~ 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1380.0,
                        105.0,
                        198.0,
                        22.0
                    ],
                    "text": "buffer~ timestretch-source",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        480.0,
                        120.0,
                        210.0,
                        22.0
                    ],
                    "text": "groove~ timestretch-source",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        645.0,
                        165.0,
                        160.0,
                        22.0
                    ],
                    "text": "selector~ 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        750.0,
                        330.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.5",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        1095.0,
                        165.0,
                        51.0,
                        22.0
                    ],
                    "text": "line~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        750.0,
                        375.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "levelmeter~",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        825.0,
                        330.0,
                        24.0,
                        128.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        660.0,
                        30.0,
                        25.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "waveform~",
                    "id": "obj-10",
                    "numinlets": 5,
                    "numoutlets": 6,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1620.0,
                        30.0,
                        79.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        30.0,
                        640.0,
                        100.0
                    ],
                    "buffername": "timestretch-source"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        405.0,
                        330.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-12",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        375.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        460.0,
                        240.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        525.0,
                        330.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210.0,
                        30.0,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1140.0,
                        75.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger b b b",
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
                        1185.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-17",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1245.0,
                        120.0,
                        40.0,
                        22.0
                    ],
                    "text": "1",
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
                        1290.0,
                        120.0,
                        51.0,
                        22.0
                    ],
                    "text": "0.5 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        145,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Stretch [ts-1]",
                            "parameter_shortname": "Stretch",
                            "parameter_type": 0,
                            "parameter_mmin": 0.25,
                            "parameter_mmax": 8.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        30.0,
                        75.0,
                        86.0,
                        22.0
                    ],
                    "text": "stretch $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-21",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        555.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        100,
                        145,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Grain [ts-2]",
                            "parameter_shortname": "Grain",
                            "parameter_type": 0,
                            "parameter_mmin": 5.0,
                            "parameter_mmax": 200.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                40.0
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        555.0,
                        75.0,
                        93.0,
                        22.0
                    ],
                    "text": "grain_ms $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        660.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        180,
                        145,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Pitch ct [ts-3]",
                            "parameter_shortname": "Pitch ct",
                            "parameter_type": 0,
                            "parameter_mmin": -2400.0,
                            "parameter_mmax": 2400.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        660.0,
                        75.0,
                        72.0,
                        22.0
                    ],
                    "text": "pitch $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        435.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        20,
                        225,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "WSOLA [ts-4]",
                            "parameter_shortname": "WSOLA",
                            "parameter_type": 0,
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 256.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                128.0
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        435.0,
                        75.0,
                        100.0,
                        22.0
                    ],
                    "text": "wsola_tol $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        100,
                        225,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Jitter [ts-5]",
                            "parameter_shortname": "Jitter",
                            "parameter_type": 0,
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 0.25,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.05
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        135.0,
                        75.0,
                        107.0,
                        22.0
                    ],
                    "text": "jitter_amt $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        750.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        180,
                        225,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Sens [ts-6]",
                            "parameter_shortname": "Sens",
                            "parameter_type": 0,
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        750.0,
                        75.0,
                        114.0,
                        22.0
                    ],
                    "text": "sensitivity $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        885.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        145.0,
                        50.0,
                        60.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Gain [ts-7]",
                            "parameter_shortname": "Gain",
                            "parameter_type": 0,
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_unitstyle": 0
                        }
                    }
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
                        885.0,
                        75.0,
                        51.0,
                        22.0
                    ],
                    "text": "$1 20",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        165.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        165.0,
                        90.0,
                        22.0
                    ],
                    "items": [
                        "2 voices",
                        ",",
                        "4 voices",
                        ",",
                        "8 voices"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        195.0,
                        100.0,
                        22.0
                    ],
                    "text": "select 0 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-35",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        45.0,
                        240.0,
                        79.0,
                        22.0
                    ],
                    "text": "density 2",
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
                        135.0,
                        240.0,
                        79.0,
                        22.0
                    ],
                    "text": "density 4",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-37",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        225.0,
                        240.0,
                        79.0,
                        22.0
                    ],
                    "text": "density 8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.toggle",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        45.0,
                        15.0,
                        15.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Adaptive [ts-8]",
                            "parameter_shortname": "Adaptive",
                            "parameter_type": 2,
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                1
                            ]
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-39",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        75.0,
                        72.0,
                        22.0
                    ],
                    "text": "adapt $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.toggle",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        45.0,
                        15.0,
                        15.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Extreme [ts-9]",
                            "parameter_shortname": "Extreme",
                            "parameter_type": 2,
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0
                            ]
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-41",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        255.0,
                        75.0,
                        86.0,
                        22.0
                    ],
                    "text": "extreme $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-44",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1110.0,
                        120.0,
                        65.0,
                        22.0
                    ],
                    "text": "mode $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "textbutton",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1380.0,
                        30.0,
                        100.0,
                        20.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        310.0,
                        55.0,
                        25.0
                    ],
                    "text": "LOAD",
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "bgcolor": [
                        0.35,
                        0.35,
                        0.35,
                        1.0
                    ],
                    "rounded": 4.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-47",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1410.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        165.0,
                        30.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        165.0,
                        314.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        945.0,
                        45.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        314.0,
                        18.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-50",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        945.0,
                        75.0,
                        65.0,
                        22.0
                    ],
                    "text": "loop $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "preset",
                    "id": "obj-51",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1620.0,
                        75.0,
                        100.0,
                        40.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        310.0,
                        300.0,
                        30.0
                    ],
                    "preset_data": []
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-52",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        150.0,
                        205.0,
                        20.0
                    ],
                    "text": "WSOLA Granular Time-Stretch",
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        6.0,
                        320.0,
                        20.0
                    ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-53",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        195.0,
                        100.0,
                        20.0
                    ],
                    "text": "TIME / PITCH",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        132.0,
                        90,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-54",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        255.0,
                        65.0,
                        20.0
                    ],
                    "text": "QUALITY",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        212.0,
                        70,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-55",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        300.0,
                        65.0,
                        20.0
                    ],
                    "text": "Density",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        148.0,
                        55,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-56",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        345.0,
                        72.0,
                        20.0
                    ],
                    "text": "Adaptive",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        225.0,
                        60,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-57",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1620.0,
                        405.0,
                        65.0,
                        20.0
                    ],
                    "text": "Extreme",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        395.0,
                        225.0,
                        55,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-58",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1845.0,
                        30.0,
                        79.0,
                        20.0
                    ],
                    "text": "Transient",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        450.0,
                        225.0,
                        60,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-59",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1845.0,
                        75.0,
                        58.0,
                        20.0
                    ],
                    "text": "SOURCE",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        295.0,
                        65,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-60",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1845.0,
                        135.0,
                        44.0,
                        20.0
                    ],
                    "text": "Play",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        162.0,
                        300.0,
                        30,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-61",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1845.0,
                        180.0,
                        44.0,
                        20.0
                    ],
                    "text": "Loop",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        217.0,
                        300.0,
                        30,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-62",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        1845.0,
                        225.0,
                        65.0,
                        20.0
                    ],
                    "text": "PRESETS",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        295.0,
                        65,
                        16.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-63",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        30.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        310.0,
                        70.0,
                        22.0
                    ],
                    "items": [
                        "none",
                        ",",
                        "live",
                        ",",
                        "buffer"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-64",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        105.0,
                        60.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-65",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "obj-2",
                        0
                    ],
                    "destination": [
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        37.0,
                        108.5,
                        725.0,
                        108.5
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
                        "obj-5",
                        2
                    ],
                    "midpoints": [
                        487.0,
                        153.5,
                        798.0,
                        153.5
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        725.0,
                        236.0,
                        450.5,
                        236.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        0
                    ],
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        397.0,
                        318.5,
                        757.0,
                        318.5
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
                        "obj-6",
                        1
                    ],
                    "midpoints": [
                        1102.0,
                        258.5,
                        801.0,
                        258.5
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        779.0,
                        363.5,
                        757.0,
                        363.5
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
                        "obj-8",
                        1
                    ],
                    "midpoints": [
                        779.0,
                        363.5,
                        815.0,
                        363.5
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        856.0,
                        357.0,
                        856.0,
                        322.0,
                        837.0,
                        322.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        1
                    ],
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        450.5,
                        318.5,
                        412.0,
                        318.5
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
                        "obj-12",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        2
                    ],
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        504.0,
                        318.5,
                        532.0,
                        318.5
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        246.0,
                        63.5,
                        1193.5,
                        63.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        2
                    ],
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        1240.0,
                        108.5,
                        1192.0,
                        108.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-15",
                        1
                    ],
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        1193.5,
                        108.5,
                        1252.0,
                        108.5
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        1147.0,
                        108.5,
                        1297.0,
                        108.5
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        1315.5,
                        153.5,
                        1102.0,
                        153.5
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        73.0,
                        191.0,
                        450.5,
                        191.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        601.5,
                        191.0,
                        450.5,
                        191.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        696.0,
                        191.0,
                        450.5,
                        191.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        485.0,
                        191.0,
                        450.5,
                        191.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        188.5,
                        191.0,
                        450.5,
                        191.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        807.0,
                        191.0,
                        450.5,
                        191.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        910.5,
                        131.0,
                        1102.0,
                        131.0
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
                    ],
                    "midpoints": [
                        37.0,
                        191.0,
                        80.0,
                        191.0
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
                        "obj-35",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        1
                    ],
                    "destination": [
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        65.66666666666667,
                        228.5,
                        142.0,
                        228.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-34",
                        2
                    ],
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        94.33333333333334,
                        228.5,
                        232.0,
                        228.5
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        84.5,
                        273.5,
                        450.5,
                        273.5
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        174.5,
                        273.5,
                        450.5,
                        273.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-37",
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        264.5,
                        273.5,
                        450.5,
                        273.5
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        1265.0,
                        153.5,
                        80.0,
                        153.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-38",
                        0
                    ],
                    "destination": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-39",
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        396.0,
                        191.0,
                        450.5,
                        191.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-40",
                        0
                    ],
                    "destination": [
                        "obj-41",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-41",
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        298.0,
                        191.0,
                        450.5,
                        191.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-44",
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        1142.5,
                        213.5,
                        450.5,
                        213.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-46",
                        0
                    ],
                    "destination": [
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        1387.0,
                        62.5,
                        1417.0,
                        62.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-47",
                        0
                    ],
                    "destination": [
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        1432.0,
                        101.0,
                        1479.0,
                        101.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-48",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        177.0,
                        87.0,
                        487.0,
                        87.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-49",
                        0
                    ],
                    "destination": [
                        "obj-50",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-50",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        977.5,
                        108.5,
                        487.0,
                        108.5
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
                        "obj-63",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-63",
                        0
                    ],
                    "destination": [
                        "obj-64",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-64",
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
                        "obj-64",
                        0
                    ],
                    "destination": [
                        "obj-44",
                        0
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
