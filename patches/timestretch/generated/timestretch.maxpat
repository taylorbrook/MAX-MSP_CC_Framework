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
            100.0,
            100.0,
            1542.0,
            783.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "presentation": 1,
                    "presentation_rect": [
                        0,
                        0,
                        660,
                        345
                    ],
                    "patching_rect": [
                        0,
                        0,
                        660,
                        345
                    ],
                    "numinlets": 1,
                    "numoutlets": 0,
                    "text": ""
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
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
                                        30.0,
                                        30.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "\n// === PARAMETERS ===\nParam stretch(1, min=1, max=16);\nParam grain_ms(40, min=5, max=200);\nParam pitch(0, min=-2400, max=2400);\nParam wsola_tol(128, min=0, max=256);\nParam jitter_amt(0.05, min=0, max=0.25);\nParam sensitivity(0.5, min=0, max=1);\nParam adapt(1, min=0, max=1);\nParam density(4, min=2, max=8);\nParam extreme(0, min=0, max=1);\nParam mode(0, min=0, max=1);\n\nBuffer source;\nData circ(131072);\nData gpos(8);\nData gphase(8);\nData gsize(8);\nData gactive(8);\n\nHistory wpos(0);\nHistory rpos(0);\nHistory hop_ctr(0);\nHistory next_g(0);\nHistory hp_z1(0);\nHistory env_f(0);\nHistory env_s(0);\n\n// === DSP ===\nsig = in1;\nsr = samplerate;\nbuf_len = 131072;\nmax_grains = 8;\n\nplayback_speed = pow(2, pitch / 1200);\nbase_size = grain_ms * sr / 1000;\nactive_grains = clamp(floor(density), 2, 8);\n\n// Write input to circular buffer (live mode)\nwp = wpos;\nif (mode < 0.5) {\n    poke(circ, sig, wp % buf_len);\n}\nwp = wp + 1;\nwpos = wp;\n\n// Source buffer length for file mode\nsrc_len = dim(source);\nuse_file = (mode > 0.5 && src_len > 0) ? 1 : 0;\n\n// --- Transient Detection ---\nhp_coeff = exp(-twopi * 2000 / sr);\nhp_prev = hp_z1;\nhp_out = sig - hp_prev * hp_coeff;\nhp_z1 = sig;\n\nabs_hp = abs(hp_out);\natk_c = exp(-1 / (0.001 * sr));\nrel_c = exp(-1 / (0.05 * sr));\n\nfast_e = env_f;\ncoeff_f = (abs_hp > fast_e) ? atk_c : rel_c;\nfast_e = abs_hp + coeff_f * (fast_e - abs_hp);\nenv_f = fast_e;\n\nslow_c = exp(-1 / (0.2 * sr));\nslow_e = env_s;\nslow_e = abs_hp + slow_c * (slow_e - abs_hp);\nenv_s = slow_e;\n\ntrans_ratio = (slow_e > 0.0001) ? fast_e / slow_e : 1;\nthresh = 1 + (1 - sensitivity) * 10;\nis_transient = (trans_ratio > thresh) ? 1 : 0;\n\n// Adaptive grain size\ngrain_size = base_size;\nif (adapt > 0.5 && is_transient > 0.5) {\n    grain_size = max(10 * sr / 1000, base_size * 0.25);\n}\n\n// --- Grain Scheduling ---\nhop = grain_size / active_grains;\nhc = hop_ctr;\nhc = hc - 1;\n\nif (hc <= 0) {\n    ng = next_g;\n    rp = rpos;\n\n    best_offset = 0;\n    best_corr = -1;\n    tol = floor(wsola_tol);\n\n    if (tol > 0) {\n        ref_start = (wp - grain_size) % buf_len;\n\n        for (k = -tol; k <= tol; k += 8) {\n            corr_sum = 0;\n            test_start = rp + k;\n\n            for (j = 0; j < 64; j += 1) {\n                ref_idx = (ref_start + j) % buf_len;\n                tst_idx = 0;\n                ref_s = 0;\n                tst_s = 0;\n\n                if (use_file > 0.5) {\n                    tst_idx = (test_start + j) % src_len;\n                    ref_s = peek(source, ref_idx % src_len, 0);\n                    tst_s = peek(source, tst_idx, 0);\n                } else {\n                    tst_idx = (test_start + j) % buf_len;\n                    ref_s = peek(circ, ref_idx, 0);\n                    tst_s = peek(circ, tst_idx, 0);\n                }\n\n                corr_sum = corr_sum + ref_s * tst_s;\n            }\n\n            norm_k = k / max(tol, 1);\n            bias_v = 1 - 0.25 * norm_k * norm_k;\n            corr_sum = corr_sum * bias_v;\n\n            if (corr_sum > best_corr) {\n                best_corr = corr_sum;\n                best_offset = k;\n            }\n        }\n    }\n\n    jit = noise() * jitter_amt * hop;\n    start_pos = rp + best_offset + jit;\n\n    if (extreme > 0.5) {\n        rand_pos = (noise() + 1) * 0.5;\n        if (use_file > 0.5) {\n            start_pos = rand_pos * src_len;\n        } else {\n            start_pos = rand_pos * buf_len;\n        }\n    }\n\n    poke(gpos, start_pos, ng);\n    poke(gphase, 0, ng);\n    poke(gsize, grain_size, ng);\n    poke(gactive, 1, ng);\n\n    ng = (ng + 1) % active_grains;\n    next_g = ng;\n    hc = hop;\n}\nhop_ctr = hc;\n\n// Advance read position\nrp_new = rpos;\nif (use_file > 0.5) {\n    rp_new = rp_new + 1 / max(stretch, 0.001);\n    if (rp_new >= src_len) {\n        rp_new = rp_new - src_len;\n    }\n} else {\n    rp_new = rp_new + 1 / max(stretch, 0.001);\n}\nrpos = rp_new;\n\n// --- Grain Synthesis ---\noutput = 0;\nfor (i = 0; i < 8; i += 1) {\n    act = peek(gactive, i, 0);\n    if (act > 0.5) {\n        pos_g = peek(gpos, i, 0);\n        phase_g = peek(gphase, i, 0);\n        gsize_i = peek(gsize, i, 0);\n\n        samp = 0;\n        if (use_file > 0.5) {\n            rd_idx = pos_g % src_len;\n            if (rd_idx < 0) { rd_idx = rd_idx + src_len; }\n            samp = peek(source, rd_idx, 0);\n        } else {\n            rd_idx = pos_g % buf_len;\n            if (rd_idx < 0) { rd_idx = rd_idx + buf_len; }\n            samp = peek(circ, rd_idx, 0);\n        }\n\n        env_g = 0.5 * (1 - cos(twopi * phase_g));\n        output = output + samp * env_g;\n\n        pos_g = pos_g + playback_speed;\n        phase_g = phase_g + 1 / gsize_i;\n\n        poke(gpos, pos_g, i);\n        poke(gphase, phase_g, i);\n\n        if (phase_g >= 1) {\n            poke(gactive, 0, i);\n        }\n    }\n}\n\noutput = output / max(active_grains * 0.5, 1);\n\nout1 = output;\nout2 = is_transient;\nout3 = rp_new / max((use_file > 0.5) ? src_len : buf_len, 1);\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
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
                                        30.0,
                                        285.0,
                                        30.0,
                                        35.0
                                    ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        285.0,
                                        30.0,
                                        35.0
                                    ],
                                    "text": "out 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        405.0,
                                        285.0,
                                        30.0,
                                        35.0
                                    ],
                                    "text": "out 3"
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
                                    "midpoints": [
                                        39.5,
                                        63.5,
                                        39.5,
                                        63.5
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
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-4",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-5",
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        2
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
                        250,
                        280,
                        189.0,
                        22.0
                    ],
                    "text": "gen~ @source timestretch-source"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20,
                        100,
                        64.0,
                        22.0
                    ],
                    "text": "adc~ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        1100,
                        160,
                        198.0,
                        22.0
                    ],
                    "text": "buffer~ timestretch-source"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        250,
                        170,
                        210.0,
                        22.0
                    ],
                    "text": "groove~ timestretch-source"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        500,
                        170,
                        160.0,
                        22.0
                    ],
                    "text": "selector~ 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        500,
                        325,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        700,
                        170,
                        51.0,
                        22.0
                    ],
                    "text": "line~"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        500,
                        370,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "markers": [
                        -60,
                        -48,
                        -36,
                        -24,
                        -12,
                        -6,
                        0,
                        6
                    ],
                    "markersused": 8,
                    "maxclass": "levelmeter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        580,
                        325,
                        64.0,
                        32.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        350.5,
                        274.75,
                        117.0,
                        58.5
                    ]
                }
            },
            {
                "box": {
                    "buffername": "timestretch-source",
                    "id": "obj-10",
                    "maxclass": "waveform~",
                    "numinlets": 5,
                    "numoutlets": 6,
                    "outlettype": [
                        "float",
                        "float",
                        "float",
                        "float",
                        "list",
                        ""
                    ],
                    "patching_rect": [
                        1300,
                        310,
                        79.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        30.0,
                        640.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        250,
                        325,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        250,
                        370,
                        24.0,
                        24.0
                    ],
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        370,
                        325,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        310,
                        100,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        800,
                        100,
                        107.0,
                        22.0
                    ],
                    "text": "trigger b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        850,
                        130,
                        40.0,
                        22.0
                    ],
                    "text": "0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-17",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        900,
                        130,
                        40.0,
                        22.0
                    ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        960,
                        130,
                        51.0,
                        22.0
                    ],
                    "text": "0.5 0"
                }
            },
            {
                "box": {
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
                        20,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Stretch [ts-1]",
                            "parameter_mmax": 16.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Stretch",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "live.dial"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-20",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        55,
                        86.0,
                        22.0
                    ],
                    "text": "stretch $1"
                }
            },
            {
                "box": {
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
                        230,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                40.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Grain [ts-2]",
                            "parameter_mmax": 200.0,
                            "parameter_mmin": 5.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Grain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "live.dial[1]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        230,
                        55,
                        93.0,
                        22.0
                    ],
                    "text": "grain_ms $1"
                }
            },
            {
                "box": {
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
                        300,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        180.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Pitch ct [ts-3]",
                            "parameter_mmax": 2400.0,
                            "parameter_mmin": -2400.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Pitch ct",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "live.dial[2]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300,
                        55,
                        72.0,
                        22.0
                    ],
                    "text": "pitch $1"
                }
            },
            {
                "box": {
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
                        160,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        225.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                128.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "WSOLA [ts-4]",
                            "parameter_mmax": 256.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "WSOLA",
                            "parameter_type": 0,
                            "parameter_unitstyle": 0
                        }
                    },
                    "varname": "live.dial[3]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        160,
                        55,
                        100.0,
                        22.0
                    ],
                    "text": "wsola_tol $1"
                }
            },
            {
                "box": {
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
                        90,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        225.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.05
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Jitter [ts-5]",
                            "parameter_mmax": 0.25,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Jitter",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "live.dial[4]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        90,
                        55,
                        107.0,
                        22.0
                    ],
                    "text": "jitter_amt $1"
                }
            },
            {
                "box": {
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
                        370,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        180.0,
                        225.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Sens [ts-6]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Sens",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "live.dial[5]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        370,
                        55,
                        114.0,
                        22.0
                    ],
                    "text": "sensitivity $1"
                }
            },
            {
                "box": {
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
                        440,
                        0,
                        44.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        145.0,
                        50.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Gain [ts-7]",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Gain",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "live.dial[6]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        440,
                        55,
                        51.0,
                        22.0
                    ],
                    "text": "$1 20"
                }
            },
            {
                "box": {
                    "id": "obj-33",
                    "items": [
                        "2 voices",
                        ",",
                        "4 voices",
                        ",",
                        "8 voices"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        20,
                        170,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        165.0,
                        90.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        20,
                        200,
                        100.0,
                        22.0
                    ],
                    "text": "select 0 1 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20,
                        235,
                        79.0,
                        22.0
                    ],
                    "text": "density 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        115,
                        235,
                        79.0,
                        22.0
                    ],
                    "text": "density 4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        210,
                        235,
                        79.0,
                        22.0
                    ],
                    "text": "density 8"
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        550,
                        10,
                        15.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                1
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Adaptive [ts-8]",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Adaptive",
                            "parameter_type": 2
                        }
                    },
                    "varname": "live.toggle"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        605,
                        55,
                        72.0,
                        22.0
                    ],
                    "text": "adapt $1"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        520,
                        10,
                        15.0,
                        15.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        240.0,
                        18.0,
                        18.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "Extreme [ts-9]",
                            "parameter_mmax": 1,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Extreme",
                            "parameter_type": 2
                        }
                    },
                    "varname": "live.toggle[1]"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        520,
                        55,
                        86.0,
                        22.0
                    ],
                    "text": "extreme $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        350,
                        130,
                        65.0,
                        22.0
                    ],
                    "text": "mode $1"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.35,
                        0.35,
                        0.35,
                        1.0
                    ],
                    "id": "obj-46",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1100,
                        100,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        310.0,
                        55.0,
                        25.0
                    ],
                    "rounded": 4.0,
                    "text": "LOAD",
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1100,
                        130,
                        44.0,
                        22.0
                    ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        215,
                        100,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        161.0,
                        310.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        250,
                        100,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        216.0,
                        310.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        250,
                        130,
                        65.0,
                        22.0
                    ],
                    "text": "loop $1"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "preset",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [
                        "preset",
                        "int",
                        "preset",
                        "int",
                        ""
                    ],
                    "patching_rect": [
                        1300,
                        340,
                        100.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        475.0,
                        157.0,
                        175.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        30,
                        212.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        6.0,
                        320.0,
                        22.0
                    ],
                    "text": "WSOLA Granular Time-Stretch"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        55,
                        100.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        132.0,
                        90.0,
                        18.0
                    ],
                    "text": "TIME / PITCH"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        80,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        212.0,
                        70.0,
                        18.0
                    ],
                    "text": "QUALITY"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        105,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        148.0,
                        55.0,
                        18.0
                    ],
                    "text": "Density"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        130,
                        72.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        225.0,
                        60.0,
                        18.0
                    ],
                    "text": "Adaptive"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-57",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        155,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        395.0,
                        225.0,
                        55.0,
                        18.0
                    ],
                    "text": "Extreme"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-58",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        180,
                        79.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        450.0,
                        225.0,
                        60.0,
                        18.0
                    ],
                    "text": "Transient"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-59",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        205,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        295.0,
                        65.0,
                        18.0
                    ],
                    "text": "SOURCE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-60",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        230,
                        44.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        157.0,
                        295.0,
                        30.0,
                        18.0
                    ],
                    "text": "Play"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-61",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        255,
                        44.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        212.0,
                        295.0,
                        31.0,
                        18.0
                    ],
                    "text": "Loop"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-62",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1300,
                        280,
                        65.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        475.0,
                        137.0,
                        65.0,
                        18.0
                    ],
                    "text": "PRESETS"
                }
            },
            {
                "box": {
                    "id": "obj-63",
                    "items": [
                        "none",
                        ",",
                        "live",
                        ",",
                        "buffer"
                    ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        100,
                        100,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        310.0,
                        70.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        100,
                        130,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-65",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        510,
                        0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.4"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        484.5,
                        309.0,
                        417.0,
                        309.0,
                        417.0,
                        327.0,
                        414.5,
                        327.0
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
                        "obj-13",
                        0
                    ],
                    "midpoints": [
                        569.5,
                        309.0,
                        537.0,
                        309.0,
                        537.0,
                        327.0,
                        534.5,
                        327.0
                    ],
                    "source": [
                        "obj-1",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        399.5,
                        309.0,
                        375.0,
                        309.0,
                        375.0,
                        270.0,
                        759.5,
                        270.0
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        414.5,
                        372.0,
                        459.5,
                        372.0
                    ],
                    "source": [
                        "obj-11",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        219.5,
                        60.0,
                        942.0,
                        60.0,
                        942.0,
                        30.0,
                        1149.5,
                        30.0
                    ],
                    "source": [
                        "obj-14",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        1237.5,
                        99.0,
                        1197.0,
                        99.0,
                        1197.0,
                        117.0,
                        1194.5,
                        117.0
                    ],
                    "source": [
                        "obj-15",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        1193.5,
                        99.0,
                        1257.0,
                        99.0,
                        1257.0,
                        117.0,
                        1254.5,
                        117.0
                    ],
                    "source": [
                        "obj-15",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        1149.5,
                        99.0,
                        1299.5,
                        99.0
                    ],
                    "source": [
                        "obj-15",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-63",
                        0
                    ],
                    "midpoints": [
                        1194.5,
                        198.0,
                        243.0,
                        198.0,
                        243.0,
                        54.0,
                        102.0,
                        54.0,
                        102.0,
                        27.0,
                        114.5,
                        27.0
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
                        "obj-33",
                        0
                    ],
                    "midpoints": [
                        1254.5,
                        198.0,
                        141.0,
                        198.0,
                        141.0,
                        150.0,
                        39.5,
                        150.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        1299.5,
                        162.0,
                        1104.5,
                        162.0
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
                    "midpoints": [
                        39.5,
                        51.0,
                        39.5,
                        51.0
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
                        "obj-5",
                        1
                    ],
                    "midpoints": [
                        39.5,
                        54.0,
                        15.0,
                        54.0,
                        15.0,
                        150.0,
                        465.0,
                        150.0,
                        465.0,
                        162.0,
                        725.0,
                        162.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        150.0,
                        399.5,
                        150.0
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
                    "midpoints": [
                        564.5,
                        51.0,
                        564.5,
                        51.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        564.5,
                        99.0,
                        465.0,
                        99.0,
                        465.0,
                        270.0,
                        399.5,
                        270.0
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
                    "midpoints": [
                        669.5,
                        51.0,
                        669.5,
                        51.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        669.5,
                        117.0,
                        690.0,
                        117.0,
                        690.0,
                        153.0,
                        399.5,
                        153.0
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
                    "midpoints": [
                        444.5,
                        51.0,
                        444.5,
                        51.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        444.5,
                        270.0,
                        399.5,
                        270.0
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
                    "midpoints": [
                        144.5,
                        51.0,
                        144.5,
                        51.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        144.5,
                        225.0,
                        399.5,
                        225.0
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
                    "midpoints": [
                        759.5,
                        51.0,
                        759.5,
                        51.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        759.5,
                        150.0,
                        630.0,
                        150.0,
                        630.0,
                        270.0,
                        399.5,
                        270.0
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
                    "midpoints": [
                        894.5,
                        51.0,
                        894.5,
                        51.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        894.5,
                        162.0,
                        1104.5,
                        162.0
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
                    "midpoints": [
                        39.5,
                        189.0,
                        39.5,
                        189.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        237.0,
                        54.5,
                        237.0
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
                    "midpoints": [
                        66.5,
                        219.0,
                        144.5,
                        219.0
                    ],
                    "source": [
                        "obj-34",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-37",
                        0
                    ],
                    "midpoints": [
                        93.5,
                        219.0,
                        234.5,
                        219.0
                    ],
                    "source": [
                        "obj-34",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        54.5,
                        282.0,
                        399.5,
                        282.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        144.5,
                        282.0,
                        399.5,
                        282.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        234.5,
                        282.0,
                        399.5,
                        282.0
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
                        "obj-39",
                        0
                    ],
                    "midpoints": [
                        369.0,
                        63.0,
                        369.5,
                        63.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        369.5,
                        270.0,
                        399.5,
                        270.0
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
                        "obj-5",
                        2
                    ],
                    "midpoints": [
                        489.5,
                        198.0,
                        816.0,
                        198.0,
                        816.0,
                        162.0,
                        795.5,
                        162.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        264.0,
                        63.0,
                        264.5,
                        63.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        264.5,
                        225.0,
                        399.5,
                        225.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        144.0,
                        816.0,
                        144.0,
                        816.0,
                        270.0,
                        399.5,
                        270.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        1389.5,
                        60.0,
                        1419.5,
                        60.0
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
                        "obj-3",
                        0
                    ],
                    "midpoints": [
                        1419.5,
                        99.0,
                        1389.5,
                        99.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        174.5,
                        57.0,
                        243.0,
                        57.0,
                        243.0,
                        117.0,
                        489.5,
                        117.0
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
                    "midpoints": [
                        954.5,
                        72.0,
                        954.5,
                        72.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        654.5,
                        270.0,
                        399.5,
                        270.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        954.5,
                        117.0,
                        489.5,
                        117.0
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
                        "obj-8",
                        1
                    ],
                    "midpoints": [
                        759.5,
                        372.0,
                        812.5,
                        372.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        759.5,
                        354.0,
                        759.5,
                        354.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        759.5,
                        354.0,
                        822.0,
                        354.0,
                        822.0,
                        327.0,
                        834.5,
                        327.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-6",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-64",
                        0
                    ],
                    "midpoints": [
                        114.5,
                        54.0,
                        114.5,
                        54.0
                    ],
                    "source": [
                        "obj-63",
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
                    "midpoints": [
                        114.5,
                        84.0,
                        117.0,
                        84.0,
                        117.0,
                        108.0,
                        432.0,
                        108.0,
                        432.0,
                        60.0,
                        882.0,
                        60.0,
                        882.0,
                        117.0,
                        1119.5,
                        117.0
                    ],
                    "source": [
                        "obj-64",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        0
                    ],
                    "midpoints": [
                        188.5,
                        162.0,
                        654.5,
                        162.0
                    ],
                    "source": [
                        "obj-64",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        1
                    ],
                    "midpoints": [
                        1104.5,
                        315.0,
                        798.5,
                        315.0
                    ],
                    "source": [
                        "obj-7",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-19": [
                "Stretch [ts-1]",
                "Stretch",
                0
            ],
            "obj-21": [
                "Grain [ts-2]",
                "Grain",
                0
            ],
            "obj-23": [
                "Pitch ct [ts-3]",
                "Pitch ct",
                0
            ],
            "obj-25": [
                "WSOLA [ts-4]",
                "WSOLA",
                0
            ],
            "obj-27": [
                "Jitter [ts-5]",
                "Jitter",
                0
            ],
            "obj-29": [
                "Sens [ts-6]",
                "Sens",
                0
            ],
            "obj-31": [
                "Gain [ts-7]",
                "Gain",
                0
            ],
            "obj-38": [
                "Adaptive [ts-8]",
                "Adaptive",
                0
            ],
            "obj-40": [
                "Extreme [ts-9]",
                "Extreme",
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
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}