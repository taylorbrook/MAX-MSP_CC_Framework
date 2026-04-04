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
        "rect": [ 100.0, 100.0, 1542.0, 783.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "signal", "signal", "signal" ],
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
                        "rect": [ 100.0, 100.0, 600.0, 450.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 30.0, 30.0, 22.0 ],
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
                                    "outlettype": [ "", "", "" ],
                                    "patching_rect": [ 30.0, 75.0, 400.0, 200.0 ]
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
                                    "patching_rect": [ 30.0, 285.0, 30.0, 35.0 ],
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
                                    "patching_rect": [ 210.0, 285.0, 30.0, 35.0 ],
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
                                    "patching_rect": [ 405.0, 285.0, 30.0, 35.0 ],
                                    "text": "out 3"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "midpoints": [ 39.5, 63.5, 39.5, 63.5 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-2", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-2", 2 ]
                                }
                            }
                        ],
                        "bgcolor": [ 0.9, 0.9, 0.9, 1.0 ]
                    },
                    "patching_rect": [ 250.0, 280.0, 189.0, 22.0 ],
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 20.0, 100.0, 64.0, 22.0 ],
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
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 1100.0, 160.0, 198.0, 22.0 ],
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
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 250.0, 170.0, 210.0, 22.0 ],
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 170.0, 160.0, 22.0 ],
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 500.0, 325.0, 58.0, 22.0 ],
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
                    "outlettype": [ "signal", "bang" ],
                    "patching_rect": [ 700.0, 170.0, 51.0, 22.0 ],
                    "text": "line~"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.92, 0.85, 0.85, 1.0 ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 500.0, 370.0, 72.0, 22.0 ],
                    "text": "dac~ 1 2"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "markers": [ -60, -48, -36, -24, -12, -6, 0, 6 ],
                    "markersused": 8,
                    "maxclass": "levelmeter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 580.0, 325.0, 64.0, 32.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 350.5, 274.75, 117.0, 58.5 ]
                }
            },
            {
                "box": {
                    "buffername": "timestretch-source",
                    "id": "obj-10",
                    "maxclass": "waveform~",
                    "numinlets": 5,
                    "numoutlets": 6,
                    "outlettype": [ "float", "float", "float", "float", "list", "" ],
                    "patching_rect": [ 1300.0, 310.0, 79.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 30.0, 640.0, 100.0 ]
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
                    "outlettype": [ "float" ],
                    "patching_rect": [ 250.0, 325.0, 100.0, 22.0 ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 250.0, 370.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 460.0, 240.0, 18.0, 18.0 ]
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
                    "outlettype": [ "float" ],
                    "patching_rect": [ 370.0, 325.0, 100.0, 22.0 ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.85, 0.92, 0.85, 1.0 ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 310.0, 100.0, 72.0, 22.0 ],
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
                    "outlettype": [ "bang", "bang", "bang" ],
                    "patching_rect": [ 800.0, 100.0, 107.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 850.0, 130.0, 40.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 900.0, 130.0, 40.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 960.0, 130.0, 51.0, 22.0 ],
                    "text": "0.5 0"
                }
            },
            {
                "box": {
                    "id": "obj-19",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 20.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 145.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 1.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 55.0, 105.0, 22.0 ],
                    "text": "stretch $1"
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 399.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 100.0, 145.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 40.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 399.0, 55.0, 113.0, 22.0 ],
                    "text": "grain_ms $1"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 520.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 180.0, 145.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 520.0, 55.0, 89.0, 22.0 ],
                    "text": "pitch $1"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 270.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 225.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 128.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 270.0, 55.0, 121.0, 22.0 ],
                    "text": "wsola_tol $1"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 133.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 100.0, 225.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.05 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 133.0, 55.0, 129.0, 22.0 ],
                    "text": "jitter_amt $1"
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 617.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 180.0, 225.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 617.0, 55.0, 137.0, 22.0 ],
                    "text": "sensitivity $1"
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 762.0, 0.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 260.0, 145.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 762.0, 55.0, 65.0, 22.0 ],
                    "text": "$1 20"
                }
            },
            {
                "box": {
                    "id": "obj-33",
                    "items": [ "2 voices", ",", "4 voices", ",", "8 voices" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 20.0, 170.0, 100.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 350.0, 165.0, 90.0, 22.0 ]
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
                    "outlettype": [ "bang", "bang", "bang", "" ],
                    "patching_rect": [ 20.0, 200.0, 100.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 20.0, 235.0, 79.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 235.0, 79.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 210.0, 235.0, 79.0, 22.0 ],
                    "text": "density 8"
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 948.0, 10.0, 15.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 350.0, 240.0, 18.0, 18.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "off", "on" ],
                            "parameter_initial": [ 1 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 948.0, 55.0, 89.0, 22.0 ],
                    "text": "adapt $1"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 835.0, 10.0, 15.0, 15.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 400.0, 240.0, 18.0, 18.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "off", "on" ],
                            "parameter_initial": [ 0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 835.0, 55.0, 105.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 350.0, 130.0, 65.0, 22.0 ],
                    "text": "mode $1"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.35, 0.35, 0.35, 1.0 ],
                    "id": "obj-46",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1100.0, 100.0, 100.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 95.0, 310.0, 55.0, 25.0 ],
                    "rounded": 4.0,
                    "text": "LOAD",
                    "textcolor": [ 1.0, 1.0, 1.0, 1.0 ]
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 1100.0, 130.0, 44.0, 22.0 ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 215.0, 100.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 161.0, 310.0, 22.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-49",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 250.0, 100.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 216.0, 310.0, 22.0, 22.0 ]
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 250.0, 130.0, 65.0, 22.0 ],
                    "text": "loop $1"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "preset",
                    "numinlets": 1,
                    "numoutlets": 5,
                    "outlettype": [ "preset", "int", "preset", "int", "" ],
                    "patching_rect": [ 1300.0, 340.0, 100.0, 40.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 475.0, 157.0, 175.0, 30.0 ]
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
                    "patching_rect": [ 1300.0, 30.0, 212.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 6.0, 320.0, 22.0 ],
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
                    "patching_rect": [ 1300.0, 55.0, 100.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 132.0, 90.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 80.0, 65.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 212.0, 70.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 105.0, 65.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 350.0, 148.0, 55.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 130.0, 72.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 350.0, 225.0, 60.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 155.0, 65.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 395.0, 225.0, 55.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 180.0, 79.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 450.0, 225.0, 60.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 205.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 295.0, 65.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 230.0, 44.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 157.0, 295.0, 30.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 255.0, 44.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 212.0, 295.0, 31.0, 18.0 ],
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
                    "patching_rect": [ 1300.0, 280.0, 65.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 475.0, 137.0, 65.0, 18.0 ],
                    "text": "PRESETS"
                }
            },
            {
                "box": {
                    "id": "obj-63",
                    "items": [ "none", ",", "live", ",", "buffer" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 100.0, 100.0, 100.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 310.0, 70.0, 22.0 ]
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
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 100.0, 130.0, 93.0, 22.0 ],
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
                    "patching_rect": [ 1052.0, 56.0, 58.0, 20.0 ],
                    "text": "v0.1.7"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "midpoints": [ 344.5, 312.0, 259.5, 312.0 ],
                    "source": [ "obj-1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "midpoints": [ 429.5, 312.0, 379.5, 312.0 ],
                    "source": [ "obj-1", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "midpoints": [ 259.5, 312.0, 509.5, 312.0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-12", 0 ],
                    "midpoints": [ 259.5, 348.0, 259.5, 348.0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "midpoints": [ 319.5, 123.0, 393.0, 123.0, 393.0, 96.0, 809.5, 96.0 ],
                    "source": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "midpoints": [ 897.5, 123.0, 859.5, 123.0 ],
                    "source": [ "obj-15", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-17", 0 ],
                    "midpoints": [ 853.5, 123.0, 909.5, 123.0 ],
                    "source": [ "obj-15", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 0 ],
                    "midpoints": [ 809.5, 162.0, 957.0, 162.0, 957.0, 126.0, 969.5, 126.0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-63", 0 ],
                    "midpoints": [ 859.5, 153.0, 426.0, 153.0, 426.0, 87.0, 109.5, 87.0 ],
                    "source": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-33", 0 ],
                    "midpoints": [ 909.5, 204.0, 132.0, 204.0, 132.0, 156.0, 29.5, 156.0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "midpoints": [ 969.5, 162.0, 762.0, 162.0, 762.0, 156.0, 709.5, 156.0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-20", 0 ],
                    "midpoints": [ 29.5, 51.0, 29.5, 51.0 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 1 ],
                    "midpoints": [ 29.5, 123.0, 6.0, 123.0, 6.0, 87.0, 580.0, 87.0 ],
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 29.5, 87.0, 6.0, 87.0, 6.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 0 ],
                    "midpoints": [ 408.5, 51.0, 408.5, 51.0 ],
                    "source": [ "obj-21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 408.5, 87.0, 207.0, 87.0, 207.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-24", 0 ],
                    "midpoints": [ 529.5, 51.0, 529.5, 51.0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 529.5, 87.0, 207.0, 87.0, 207.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "midpoints": [ 279.5, 51.0, 279.5, 51.0 ],
                    "source": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 279.5, 87.0, 207.0, 87.0, 207.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "midpoints": [ 142.5, 51.0, 142.5, 51.0 ],
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 142.5, 87.0, 207.0, 87.0, 207.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "midpoints": [ 626.5, 51.0, 626.5, 51.0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 626.5, 87.0, 471.0, 87.0, 471.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-30", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 0 ],
                    "midpoints": [ 771.5, 51.0, 771.5, 51.0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "midpoints": [ 771.5, 156.0, 709.5, 156.0 ],
                    "source": [ "obj-32", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "midpoints": [ 29.5, 195.0, 29.5, 195.0 ],
                    "source": [ "obj-33", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "midpoints": [ 29.5, 225.0, 29.5, 225.0 ],
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-36", 0 ],
                    "midpoints": [ 56.5, 231.0, 124.5, 231.0 ],
                    "source": [ "obj-34", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "midpoints": [ 83.5, 231.0, 219.5, 231.0 ],
                    "source": [ "obj-34", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 29.5, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 124.5, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-36", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 219.5, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-39", 0 ],
                    "midpoints": [ 957.0, 42.0, 957.5, 42.0 ],
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 957.5, 156.0, 471.0, 156.0, 471.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-39", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 2 ],
                    "midpoints": [ 259.5, 204.0, 486.0, 204.0, 486.0, 156.0, 650.5, 156.0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 844.0, 27.0, 844.5, 27.0 ],
                    "source": [ "obj-40", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 844.5, 156.0, 471.0, 156.0, 471.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-41", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 359.5, 153.0, 237.0, 153.0, 237.0, 222.0, 300.0, 222.0, 300.0, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-44", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-47", 0 ],
                    "midpoints": [ 1109.5, 123.0, 1109.5, 123.0 ],
                    "source": [ "obj-46", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 1109.5, 153.0, 1109.5, 153.0 ],
                    "source": [ "obj-47", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 224.5, 165.0, 259.5, 165.0 ],
                    "source": [ "obj-48", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-50", 0 ],
                    "midpoints": [ 259.5, 126.0, 259.5, 126.0 ],
                    "source": [ "obj-49", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "midpoints": [ 509.5, 267.0, 259.5, 267.0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 259.5, 153.0, 259.5, 153.0 ],
                    "source": [ "obj-50", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 1 ],
                    "midpoints": [ 509.5, 357.0, 562.5, 357.0 ],
                    "order": 1,
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "midpoints": [ 509.5, 348.0, 509.5, 348.0 ],
                    "order": 2,
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "midpoints": [ 509.5, 357.0, 576.0, 357.0, 576.0, 321.0, 589.5, 321.0 ],
                    "order": 0,
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-64", 0 ],
                    "midpoints": [ 109.5, 123.0, 109.5, 123.0 ],
                    "source": [ "obj-63", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "midpoints": [ 109.5, 153.0, 336.0, 153.0, 336.0, 126.0, 359.5, 126.0 ],
                    "source": [ "obj-64", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "midpoints": [ 183.5, 204.0, 486.0, 204.0, 486.0, 165.0, 509.5, 165.0 ],
                    "source": [ "obj-64", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 1 ],
                    "midpoints": [ 709.5, 312.0, 548.5, 312.0 ],
                    "source": [ "obj-7", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-19": [ "Stretch [ts-1]", "Stretch", 0 ],
            "obj-21": [ "Grain [ts-2]", "Grain", 0 ],
            "obj-23": [ "Pitch ct [ts-3]", "Pitch ct", 0 ],
            "obj-25": [ "WSOLA [ts-4]", "WSOLA", 0 ],
            "obj-27": [ "Jitter [ts-5]", "Jitter", 0 ],
            "obj-29": [ "Sens [ts-6]", "Sens", 0 ],
            "obj-31": [ "Gain [ts-7]", "Gain", 0 ],
            "obj-38": [ "Adaptive [ts-8]", "Adaptive", 0 ],
            "obj-40": [ "Extreme [ts-9]", "Extreme", 0 ],
            "inherited_shortname": 1
        },
        "autosave": 0,
        "editing_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ]
    }
}