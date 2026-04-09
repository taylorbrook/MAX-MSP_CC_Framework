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
            112.0,
            1052.0,
            756.0
        ],
        "boxes": [
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        20.0,
                        170.0,
                        24.0
                    ],
                    "text": "Gong Physical Model"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        45.0,
                        541.0,
                        20.0
                    ],
                    "text": "Modal synthesis with nonlinear coupling, bloom, and 5-point structure morph"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        20.0,
                        72.0,
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
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        110.0,
                        44.0,
                        22.0
                    ],
                    "text": "mtof"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        134.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend base_freq"
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
                        "float"
                    ],
                    "patching_rect": [
                        170.0,
                        110.0,
                        58.0,
                        22.0
                    ],
                    "text": "/ 127."
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
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        140.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend velocity"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        320.0,
                        80.0,
                        65.0,
                        22.0
                    ],
                    "text": "touchin"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        320.0,
                        110.0,
                        58.0,
                        22.0
                    ],
                    "text": "/ 127."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        320.0,
                        140.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend aftertouch"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-11",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        201.0,
                        149.0,
                        20.0
                    ],
                    "text": "Audio Exciter Input"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        225.0,
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
                    "id": "obj-13",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        250.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        58.5,
                        301.0,
                        93.0,
                        20.0
                    ],
                    "text": "gen~ Engine"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        322.0,
                        128.0,
                        22.0
                    ],
                    "text": "gen~ gong-engine",
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 0,
                            "revision": 0,
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
                                    "text": "in 1",
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
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-2",
                                    "code": "// Gong Physical Model Engine v0.6\n// Modal synthesis: 32 resonators, 5-point structure morph,\n// nonlinear coupling, bloom, amplitude-dependent pitch glide\n\n// =====================================================\n// DECLARATIONS (all must precede expressions)\n// =====================================================\n\nParam base_freq(110, min=20, max=2000);\nParam structure(0.5, min=0, max=1);\nParam brightness(0.5, min=0, max=1);\nParam decay_time(8, min=0.1, max=30);\nParam position(0.5, min=0, max=1);\nParam nonlinearity(0.1, min=0, max=1);\nParam num_modes(16, min=4, max=32);\nParam mallet_hardness(0.5, min=0, max=1);\nParam bloom_amount(0.1, min=0, max=1);\nParam bloom_speed(1, min=0.1, max=5);\nParam velocity(0, min=0, max=1);\nParam aftertouch(0, min=0, max=1);\nParam strike_count(0, min=0, max=10000);\nParam strike_force(0.8, min=0, max=1);\nParam output_gain(0.5, min=0, max=1);\n\nData mode_y1(32);\nData mode_y2(32);\nData mode_a1(32);\nData mode_a2(32);\nData mode_freq(32);\nData mode_output(32);\nData mode_env(32);\nData ratio_table(32, 5);\nData coupling_map(16, 4);\nData current_ratios(32);\nData pos_gain(32);\nData init_flag(1);\n\nHistory s_freq(110);\nHistory s_struct(0.5);\nHistory s_bright(0.5);\nHistory s_decay(4);\nHistory s_pos(0.5);\nHistory s_nonlin(0.1);\nHistory s_hard(0.5);\nHistory s_bloom(0.1);\nHistory s_bspd(1);\nHistory s_at(0);\nHistory s_gain(0.5);\nHistory prev_vel(0);\nHistory prev_sc(0);\nHistory burst_env(0);\nHistory burst_vel(0);\nHistory burst_lp(0);\nHistory low_rms(0);\nHistory bloom_env(0);\nHistory dcx0(0);\nHistory dcy0(0);\nHistory dcx1(0);\nHistory dcy1(0);\nHistory update_idx(0);\nHistory prev_struct(-1);\nHistory prev_pos(-1);\n\n\n// =====================================================\n// INITIALIZATION (runs once on first sample)\n// =====================================================\nif (peek(init_flag, 0, 0) < 0.5) {\n    for (i = 0; i < 32; i += 1) {\n        poke(mode_y1, 0, i, 0);\n        poke(mode_y2, 0, i, 0);\n        poke(mode_a1, 0, i, 0);\n        poke(mode_a2, 0, i, 0);\n        poke(mode_freq, 440, i, 0);\n        poke(mode_output, 0, i, 0);\n        poke(current_ratios, i + 1, i, 0);\n        poke(pos_gain, 0.5, i, 0);\n    }\n\n    // --- Ratio tables (5 structure types x 32 modes) ---\n\n    // Channel 0: Harmonic\n    poke(ratio_table, 1.000, 0, 0);\n    poke(ratio_table, 2.000, 1, 0);\n    poke(ratio_table, 3.000, 2, 0);\n    poke(ratio_table, 4.000, 3, 0);\n    poke(ratio_table, 5.000, 4, 0);\n    poke(ratio_table, 6.000, 5, 0);\n    poke(ratio_table, 7.000, 6, 0);\n    poke(ratio_table, 8.000, 7, 0);\n    poke(ratio_table, 9.000, 8, 0);\n    poke(ratio_table, 10.000, 9, 0);\n    poke(ratio_table, 11.000, 10, 0);\n    poke(ratio_table, 12.000, 11, 0);\n    poke(ratio_table, 13.000, 12, 0);\n    poke(ratio_table, 14.000, 13, 0);\n    poke(ratio_table, 15.000, 14, 0);\n    poke(ratio_table, 16.000, 15, 0);\n    poke(ratio_table, 17.000, 16, 0);\n    poke(ratio_table, 18.000, 17, 0);\n    poke(ratio_table, 19.000, 18, 0);\n    poke(ratio_table, 20.000, 19, 0);\n    poke(ratio_table, 21.000, 20, 0);\n    poke(ratio_table, 22.000, 21, 0);\n    poke(ratio_table, 23.000, 22, 0);\n    poke(ratio_table, 24.000, 23, 0);\n    poke(ratio_table, 25.000, 24, 0);\n    poke(ratio_table, 26.000, 25, 0);\n    poke(ratio_table, 27.000, 26, 0);\n    poke(ratio_table, 28.000, 27, 0);\n    poke(ratio_table, 29.000, 28, 0);\n    poke(ratio_table, 30.000, 29, 0);\n    poke(ratio_table, 31.000, 30, 0);\n    poke(ratio_table, 32.000, 31, 0);\n    // Channel 1: Gamelan (ombak beating)\n    poke(ratio_table, 1.000, 0, 1);\n    poke(ratio_table, 1.005, 1, 1);\n    poke(ratio_table, 2.010, 2, 1);\n    poke(ratio_table, 2.035, 3, 1);\n    poke(ratio_table, 3.050, 4, 1);\n    poke(ratio_table, 3.085, 5, 1);\n    poke(ratio_table, 4.120, 6, 1);\n    poke(ratio_table, 4.170, 7, 1);\n    poke(ratio_table, 5.220, 8, 1);\n    poke(ratio_table, 5.285, 9, 1);\n    poke(ratio_table, 6.360, 10, 1);\n    poke(ratio_table, 6.440, 11, 1);\n    poke(ratio_table, 7.530, 12, 1);\n    poke(ratio_table, 7.625, 13, 1);\n    poke(ratio_table, 8.730, 14, 1);\n    poke(ratio_table, 8.845, 15, 1);\n    poke(ratio_table, 9.960, 16, 1);\n    poke(ratio_table, 10.090, 17, 1);\n    poke(ratio_table, 11.220, 18, 1);\n    poke(ratio_table, 11.370, 19, 1);\n    poke(ratio_table, 12.510, 20, 1);\n    poke(ratio_table, 12.680, 21, 1);\n    poke(ratio_table, 13.830, 22, 1);\n    poke(ratio_table, 14.020, 23, 1);\n    poke(ratio_table, 15.180, 24, 1);\n    poke(ratio_table, 15.390, 25, 1);\n    poke(ratio_table, 16.560, 26, 1);\n    poke(ratio_table, 16.790, 27, 1);\n    poke(ratio_table, 17.970, 28, 1);\n    poke(ratio_table, 18.220, 29, 1);\n    poke(ratio_table, 19.410, 30, 1);\n    poke(ratio_table, 19.680, 31, 1);\n    // Channel 2: Nipple gong\n    poke(ratio_table, 1.000, 0, 2);\n    poke(ratio_table, 1.483, 1, 2);\n    poke(ratio_table, 1.986, 2, 2);\n    poke(ratio_table, 2.514, 3, 2);\n    poke(ratio_table, 2.998, 4, 2);\n    poke(ratio_table, 3.523, 5, 2);\n    poke(ratio_table, 4.011, 6, 2);\n    poke(ratio_table, 4.524, 7, 2);\n    poke(ratio_table, 5.033, 8, 2);\n    poke(ratio_table, 5.571, 9, 2);\n    poke(ratio_table, 6.092, 10, 2);\n    poke(ratio_table, 6.631, 11, 2);\n    poke(ratio_table, 7.098, 12, 2);\n    poke(ratio_table, 7.645, 13, 2);\n    poke(ratio_table, 8.153, 14, 2);\n    poke(ratio_table, 8.691, 15, 2);\n    poke(ratio_table, 9.210, 16, 2);\n    poke(ratio_table, 9.748, 17, 2);\n    poke(ratio_table, 10.267, 18, 2);\n    poke(ratio_table, 10.805, 19, 2);\n    poke(ratio_table, 11.324, 20, 2);\n    poke(ratio_table, 11.862, 21, 2);\n    poke(ratio_table, 12.381, 22, 2);\n    poke(ratio_table, 12.919, 23, 2);\n    poke(ratio_table, 13.438, 24, 2);\n    poke(ratio_table, 13.976, 25, 2);\n    poke(ratio_table, 14.495, 26, 2);\n    poke(ratio_table, 15.033, 27, 2);\n    poke(ratio_table, 15.552, 28, 2);\n    poke(ratio_table, 16.090, 29, 2);\n    poke(ratio_table, 16.609, 30, 2);\n    poke(ratio_table, 17.147, 31, 2);\n    // Channel 3: Church bell\n    poke(ratio_table, 0.500, 0, 3);\n    poke(ratio_table, 1.000, 1, 3);\n    poke(ratio_table, 1.183, 2, 3);\n    poke(ratio_table, 1.506, 3, 3);\n    poke(ratio_table, 2.000, 4, 3);\n    poke(ratio_table, 2.514, 5, 3);\n    poke(ratio_table, 2.662, 6, 3);\n    poke(ratio_table, 3.011, 7, 3);\n    poke(ratio_table, 3.520, 8, 3);\n    poke(ratio_table, 4.065, 9, 3);\n    poke(ratio_table, 4.190, 10, 3);\n    poke(ratio_table, 5.255, 11, 3);\n    poke(ratio_table, 5.398, 12, 3);\n    poke(ratio_table, 6.009, 13, 3);\n    poke(ratio_table, 6.584, 14, 3);\n    poke(ratio_table, 7.223, 15, 3);\n    poke(ratio_table, 7.890, 16, 3);\n    poke(ratio_table, 8.541, 17, 3);\n    poke(ratio_table, 9.245, 18, 3);\n    poke(ratio_table, 9.912, 19, 3);\n    poke(ratio_table, 10.628, 20, 3);\n    poke(ratio_table, 11.312, 21, 3);\n    poke(ratio_table, 12.043, 22, 3);\n    poke(ratio_table, 12.750, 23, 3);\n    poke(ratio_table, 13.489, 24, 3);\n    poke(ratio_table, 14.208, 25, 3);\n    poke(ratio_table, 14.960, 26, 3);\n    poke(ratio_table, 15.697, 27, 3);\n    poke(ratio_table, 16.462, 28, 3);\n    poke(ratio_table, 17.213, 29, 3);\n    poke(ratio_table, 17.989, 30, 3);\n    poke(ratio_table, 18.754, 31, 3);\n    // Channel 4: Tam-tam\n    poke(ratio_table, 1.000, 0, 4);\n    poke(ratio_table, 1.593, 1, 4);\n    poke(ratio_table, 2.136, 2, 4);\n    poke(ratio_table, 2.296, 3, 4);\n    poke(ratio_table, 2.653, 4, 4);\n    poke(ratio_table, 2.917, 5, 4);\n    poke(ratio_table, 3.156, 6, 4);\n    poke(ratio_table, 3.501, 7, 4);\n    poke(ratio_table, 3.600, 8, 4);\n    poke(ratio_table, 4.060, 9, 4);\n    poke(ratio_table, 4.154, 10, 4);\n    poke(ratio_table, 4.480, 11, 4);\n    poke(ratio_table, 4.715, 12, 4);\n    poke(ratio_table, 5.193, 13, 4);\n    poke(ratio_table, 5.500, 14, 4);\n    poke(ratio_table, 5.956, 15, 4);\n    poke(ratio_table, 6.350, 16, 4);\n    poke(ratio_table, 6.780, 17, 4);\n    poke(ratio_table, 7.150, 18, 4);\n    poke(ratio_table, 7.580, 19, 4);\n    poke(ratio_table, 7.960, 20, 4);\n    poke(ratio_table, 8.400, 21, 4);\n    poke(ratio_table, 8.810, 22, 4);\n    poke(ratio_table, 9.260, 23, 4);\n    poke(ratio_table, 9.680, 24, 4);\n    poke(ratio_table, 10.130, 25, 4);\n    poke(ratio_table, 10.570, 26, 4);\n    poke(ratio_table, 11.040, 27, 4);\n    poke(ratio_table, 11.490, 28, 4);\n    poke(ratio_table, 11.970, 29, 4);\n    poke(ratio_table, 12.430, 30, 4);\n    poke(ratio_table, 12.920, 31, 4);\n\n    // Coupling triplets [modeA, modeB, modeC, strength]\n    poke(coupling_map, 0, 0, 0); poke(coupling_map, 0, 0, 1); poke(coupling_map, 1, 0, 2); poke(coupling_map, 0, 0, 3);\n    poke(coupling_map, 0, 1, 0); poke(coupling_map, 1, 1, 1); poke(coupling_map, 2, 1, 2); poke(coupling_map, 0, 1, 3);\n    poke(coupling_map, 0, 2, 0); poke(coupling_map, 1, 2, 1); poke(coupling_map, 3, 2, 2); poke(coupling_map, 0, 2, 3);\n    poke(coupling_map, 0, 3, 0); poke(coupling_map, 2, 3, 1); poke(coupling_map, 4, 3, 2); poke(coupling_map, 0, 3, 3);\n    poke(coupling_map, 1, 4, 0); poke(coupling_map, 1, 4, 1); poke(coupling_map, 3, 4, 2); poke(coupling_map, 0, 4, 3);\n    poke(coupling_map, 0, 5, 0); poke(coupling_map, 3, 5, 1); poke(coupling_map, 5, 5, 2); poke(coupling_map, 0, 5, 3);\n    poke(coupling_map, 1, 6, 0); poke(coupling_map, 2, 6, 1); poke(coupling_map, 5, 6, 2); poke(coupling_map, 0, 6, 3);\n    poke(coupling_map, 1, 7, 0); poke(coupling_map, 3, 7, 1); poke(coupling_map, 6, 7, 2); poke(coupling_map, 0, 7, 3);\n    poke(coupling_map, 2, 8, 0); poke(coupling_map, 2, 8, 1); poke(coupling_map, 6, 8, 2); poke(coupling_map, 0, 8, 3);\n    poke(coupling_map, 0, 9, 0); poke(coupling_map, 4, 9, 1); poke(coupling_map, 7, 9, 2); poke(coupling_map, 0, 9, 3);\n    poke(coupling_map, 2, 10, 0); poke(coupling_map, 3, 10, 1); poke(coupling_map, 7, 10, 2); poke(coupling_map, 0, 10, 3);\n    poke(coupling_map, 1, 11, 0); poke(coupling_map, 4, 11, 1); poke(coupling_map, 8, 11, 2); poke(coupling_map, 0, 11, 3);\n    poke(coupling_map, 3, 12, 0); poke(coupling_map, 3, 12, 1); poke(coupling_map, 8, 12, 2); poke(coupling_map, 0, 12, 3);\n    poke(coupling_map, 2, 13, 0); poke(coupling_map, 4, 13, 1); poke(coupling_map, 9, 13, 2); poke(coupling_map, 0, 13, 3);\n    poke(coupling_map, 3, 14, 0); poke(coupling_map, 4, 14, 1); poke(coupling_map, 10, 14, 2); poke(coupling_map, 0, 14, 3);\n    poke(coupling_map, 0, 15, 0); poke(coupling_map, 5, 15, 1); poke(coupling_map, 9, 15, 2); poke(coupling_map, 0, 15, 3);\n\n    // Compute valid coefficients for all 32 modes immediately\n    // (don't rely on round-robin update which takes 32 samples)\n    init_struct = 0.5;\n    init_fidx = init_struct * 4.0;\n    init_rlo = floor(init_fidx);\n    init_rhi = min(init_rlo + 1, 4);\n    init_frac = init_fidx - init_rlo;\n    for (i = 0; i < 32; i += 1) {\n        rl = peek(ratio_table, i, init_rlo);\n        rh = peek(ratio_table, i, init_rhi);\n        init_ratio = rl + (rh - rl) * init_frac;\n        poke(current_ratios, init_ratio, i, 0);\n\n        init_f = 110 * init_ratio;\n        init_f = min(init_f, samplerate * 0.49);\n        poke(mode_freq, init_f, i, 0);\n\n        // Default brightness=0.5 -> damp_slope=0.5\n        init_t60 = 8.0 * pow(max(init_ratio, 0.1), -0.5);\n        init_t60 = max(init_t60, 0.01);\n        init_r = exp(-6.9078 / (init_t60 * samplerate));\n        init_theta = TWOPI * init_f / samplerate;\n        poke(mode_a1, 2.0 * init_r * cos(init_theta), i, 0);\n        poke(mode_a2, -(init_r * init_r), i, 0);\n\n        // Init position gains for pos=0.5\n        poke(pos_gain, sin(PI * 0.5 * (i + 1)), i, 0);\n    }\n\n    poke(init_flag, 1, 0, 0);\n}\n\n\n// =====================================================\n// 1. PARAMETER SMOOTHING (one-pole, ~1ms convergence)\n// =====================================================\nsm = 0.001;\ns_freq = s_freq + (base_freq - s_freq) * sm;\ns_struct = s_struct + (structure - s_struct) * sm;\ns_bright = s_bright + (brightness - s_bright) * sm;\ns_decay = s_decay + (decay_time - s_decay) * sm;\ns_pos = s_pos + (position - s_pos) * sm;\ns_nonlin = s_nonlin + (nonlinearity - s_nonlin) * sm;\ns_hard = s_hard + (mallet_hardness - s_hard) * sm;\ns_bloom = s_bloom + (bloom_amount - s_bloom) * sm;\ns_bspd = s_bspd + (bloom_speed - s_bspd) * sm;\ns_at = s_at + (aftertouch - s_at) * sm;\ns_gain = s_gain + (output_gain - s_gain) * sm;\n\n\n// =====================================================\n// 2. RATIO TABLE INTERPOLATION (when structure changes)\n// =====================================================\nif (abs(s_struct - prev_struct) > 0.0001) {\n    prev_struct = s_struct;\n\n    frac_idx = s_struct * 4.0;\n    row_lo = floor(frac_idx);\n    row_hi = min(row_lo + 1, 4);\n    frac = frac_idx - row_lo;\n\n    for (m = 0; m < 32; m += 1) {\n        r_lo = peek(ratio_table, m, row_lo);\n        r_hi = peek(ratio_table, m, row_hi);\n        poke(current_ratios, r_lo + (r_hi - r_lo) * frac, m, 0);\n    }\n\n    // Update coupling strengths from frequency proximity\n    for (t = 0; t < 16; t += 1) {\n        a_idx = peek(coupling_map, t, 0);\n        b_idx = peek(coupling_map, t, 1);\n        c_idx = peek(coupling_map, t, 2);\n        ra = peek(current_ratios, a_idx, 0);\n        rb = peek(current_ratios, b_idx, 0);\n        rc = peek(current_ratios, c_idx, 0);\n        sum_ab = ra + rb;\n        prox = abs(rc - sum_ab) / max(sum_ab, 0.001);\n        poke(coupling_map, max(1.0 - prox * 33.33, 0) * 0.00005, t, 3);\n    }\n}\n\n\n// =====================================================\n// 3. POSITION GAIN UPDATE (when position changes)\n// =====================================================\nif (abs(s_pos - prev_pos) > 0.0001) {\n    prev_pos = s_pos;\n    for (m = 0; m < 32; m += 1) {\n        poke(pos_gain, sin(PI * s_pos * (m + 1)), m, 0);\n    }\n}\n\n\n// =====================================================\n// 4. COEFFICIENT UPDATE (1 mode per sample, cycles continuously)\n// =====================================================\nm_upd = floor(update_idx);\nupdate_idx = update_idx + 1;\nif (update_idx >= 32) {\n    update_idx = 0;\n}\n\nratio = peek(current_ratios, m_upd, 0);\nfreq = s_freq * ratio;\nfreq = min(freq, samplerate * 0.49);\npoke(mode_freq, freq, m_upd, 0);\n\n// Frequency-dependent decay: higher modes decay faster\n// brightness=1 -> gentle slope (bright), brightness=0 -> steep slope (dark)\ndamp_slope = 0.7 - s_bright * 0.4;\nt60 = s_decay * pow(max(ratio, 0.1), -damp_slope);\nt60 = max(t60, 0.1);\n\nr = exp(-6.9078 / (t60 * samplerate));\ntheta = TWOPI * freq / samplerate;\n\n// Apply nonlinear pitch glide (amplitude-dependent frequency shift)\n// Use smoothed envelope, not raw sample (avoids FM artifacts at zero crossings)\nraw_amp = abs(peek(mode_y1, m_upd, 0));\nenv_prev = peek(mode_env, m_upd, 0);\nenv_coeff = 0.001;\nenv = env_prev + (raw_amp - env_prev) * env_coeff;\npoke(mode_env, env, m_upd, 0);\n// Real gong nonlinearity: omega_NL = omega_0 * sqrt(1 + beta * (A/h)^2)\n// Cap at 1.5x frequency shift (extreme hard strike at max nonlinearity)\nnl_mod = 1.0 + s_nonlin * clamp(env * env, 0, 1) * 0.5;\ntheta_nl = TWOPI * min(freq * nl_mod, samplerate * 0.49) / samplerate;\n\npoke(mode_a1, 2.0 * r * cos(theta_nl), m_upd, 0);\npoke(mode_a2, -(r * r), m_upd, 0);\n\n\n// =====================================================\n// 5. TRIGGER DETECTION + REARTICULATION\n// =====================================================\n// Two trigger paths:\n// (a) MIDI: velocity rises from 0 (note-off resets to 0)\n// (b) Test button: strike_count increments (always unique)\nvel = velocity;\nsc = strike_count;\nmidi_onset = (vel > 0.01 && prev_vel < 0.01) ? 1 : 0;\ncount_onset = (sc != prev_sc) ? 1 : 0;\nonset = (midi_onset > 0.5 || count_onset > 0.5) ? 1 : 0;\n// Use vel for force; if triggered by count, use stored strike_force\nif (count_onset > 0.5 && midi_onset < 0.5) {\n    vel = strike_force;\n}\nprev_vel = velocity;\nprev_sc = sc;\n\nif (onset > 0.5) {\n    // Rearticulation: damp existing resonance\n    // Soft mallet preserves more ringing, hard mallet kills more\n    reartic_damp = 0.05 + (1.0 - s_hard) * 0.75;\n\n    for (md = 0; md < 32; md += 1) {\n        y1_old = peek(mode_y1, md, 0);\n        y2_old = peek(mode_y2, md, 0);\n        poke(mode_y1, y1_old * reartic_damp, md, 0);\n        poke(mode_y2, y2_old * reartic_damp, md, 0);\n    }\n\n    burst_vel = vel;\n    burst_env = 1.0;\n}\n\n\n// =====================================================\n// 6. EXCITATION (filtered noise burst + audio input)\n// =====================================================\n// Burst duration: 1ms (hard) to 5ms (soft)\ndecay_samps = (1.0 + (1.0 - s_hard) * 4.0) * 0.001 * samplerate;\ndecay_coeff = exp(-1.0 / max(decay_samps, 1));\n\nraw_burst = noise() * burst_env * burst_vel;\n\n// Decay envelope AFTER use (not before)\nburst_env = burst_env * decay_coeff;\n\n// Velocity-dependent LPF: harder mallet = brighter (500-8000 Hz)\ncutoff = 500 + s_hard * 7500;\nlp_coeff = 1.0 - exp(-TWOPI * cutoff / samplerate);\nburst_lp = burst_lp + lp_coeff * (raw_burst - burst_lp);\n\naudio_in = in1;\nexcitation = burst_lp + audio_in;\n\n\n// =====================================================\n// 7. RESONATOR BANK (32 parallel 2nd-order resonators)\n// =====================================================\nsum_L = 0;\nsum_R = 0;\nnm = floor(num_modes);\n\n// Aftertouch damping coefficient (per-sample)\nat_damp = s_at > 0.005 ? (1.0 - s_at * 0.0003) : 1.0;\n\nfor (m = 0; m < 32; m += 1) {\n    a1 = peek(mode_a1, m, 0);\n    a2 = peek(mode_a2, m, 0);\n    y1 = peek(mode_y1, m, 0);\n    y2 = peek(mode_y2, m, 0);\n\n    // Excitation gain: position pattern * active flag\n    g = peek(pos_gain, m, 0) * (m < nm ? 1.0 : 0.0);\n\n    // 2nd-order resonator\n    y = a1 * y1 + a2 * y2 + excitation * g;\n\n    // Aftertouch hand-damping\n    y = y * at_damp;\n\n    poke(mode_y1, y, m, 0);\n    poke(mode_y2, y1, m, 0);\n    poke(mode_output, y, m, 0);\n\n    // Stereo: even modes left, odd modes right\n    is_even = 1.0 - (m % 2);\n    sum_L = sum_L + y * is_even;\n    sum_R = sum_R + y * (1.0 - is_even);\n}\n\n\n// =====================================================\n// 8. NONLINEAR COUPLING (sparse resonant triplets)\n// =====================================================\n// Read from mode_y1 (state) not mode_output (Q-amplified) to prevent\n// positive feedback explosion. Clamp coupling injection per sample.\nnl_scale = s_nonlin;\nfor (t = 0; t < 16; t += 1) {\n    a_idx = peek(coupling_map, t, 0);\n    b_idx = peek(coupling_map, t, 1);\n    c_idx = peek(coupling_map, t, 2);\n    strength = peek(coupling_map, t, 3) * nl_scale;\n\n    ya = peek(mode_y1, a_idx, 0);\n    yb = peek(mode_y1, b_idx, 0);\n\n    // Quadratic coupling with hard clamp to prevent runaway\n    coupling_term = clamp(ya * yb * strength, -0.001, 0.001);\n\n    // Add to target mode C\n    yc1 = peek(mode_y1, c_idx, 0);\n    poke(mode_y1, yc1 + coupling_term, c_idx, 0);\n    // Subtract from source modes (energy conservation)\n    ya1 = peek(mode_y1, a_idx, 0);\n    yb1 = peek(mode_y1, b_idx, 0);\n    poke(mode_y1, ya1 - coupling_term * 0.5, a_idx, 0);\n    poke(mode_y1, yb1 - coupling_term * 0.5, b_idx, 0);\n}\n\n\n// =====================================================\n// 9. BLOOM (phenomenological energy cascade)\n// =====================================================\n// Monitor RMS of low modes (0-7)\nlow_sum_sq = 0;\nfor (mb = 0; mb < 8; mb += 1) {\n    y_mb = peek(mode_output, mb, 0);\n    low_sum_sq = low_sum_sq + y_mb * y_mb;\n}\nrms_coeff = exp(-1.0 / (0.01 * samplerate));\nlow_rms = sqrt(low_rms * low_rms * rms_coeff + low_sum_sq / 8.0 * (1.0 - rms_coeff));\n\n// Bloom envelope: rises when low-mode energy exceeds threshold\nbloom_thresh = 0.005;\nbloom_target = (low_rms > bloom_thresh) ? 1.0 : 0.0;\nbloom_rate = 1.0 / (s_bspd * samplerate);\nif (bloom_target > bloom_env) {\n    bloom_env = min(bloom_env + bloom_rate, 1.0);\n} else {\n    bloom_env = max(bloom_env - bloom_rate * 2, 0);\n}\n\n// Inject bloom energy into high modes (16-31)\nbloom_gain_val = bloom_env * s_bloom * low_rms;\n// Only inject bloom energy when there is real resonator activity\nif (low_rms > 0.001) {\n    for (mh = 16; mh < 32; mh += 1) {\n        boost = bloom_gain_val * (mh - 15.0) / 16.0;\n        y1_mh = peek(mode_y1, mh, 0);\n        poke(mode_y1, y1_mh + boost * noise() * 0.1, mh, 0);\n    }\n}\n\n\n// =====================================================\n// 10. OUTPUT (scaling + DC blocker)\n// =====================================================\nscale = s_gain / max(sqrt(nm), 1.0);\nwet_L = sum_L * scale;\nwet_R = sum_R * scale;\n\n// DC blocker (same as FDN reverb pattern)\nw0 = wet_L - dcx0 + 0.995 * dcy0;\ndcx0 = wet_L;\ndcy0 = w0;\nw1 = wet_R - dcx1 + 0.995 * dcy1;\ndcx1 = wet_R;\ndcy1 = w1;\n\n// Soft limiter (tanh saturation)\nout1 = tanh(w0);\nout2 = tanh(w1);\n",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ],
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "text": "out 1",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        50.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "text": "out 2",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        130.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        362.0,
                        58.0,
                        20.0
                    ],
                    "text": "Output"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        20.0,
                        382.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        130.0,
                        382.0,
                        58.0,
                        22.0
                    ],
                    "text": "*~ 0.7"
                }
            },
            {
                "box": {
                    "id": "obj-60",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        61.5,
                        472.5,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-61",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        20.0,
                        417.0,
                        15.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-62",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        130.0,
                        417.0,
                        15.0,
                        100.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        220.0,
                        362.0,
                        107.0,
                        20.0
                    ],
                    "text": "Visualization"
                }
            },
            {
                "box": {
                    "id": "obj-64",
                    "maxclass": "spectroscope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        220.0,
                        382.0,
                        180.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "scope~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        220.0,
                        517.0,
                        180.0,
                        80.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-66",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        162.0,
                        110.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-67",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        170.0,
                        162.0,
                        110.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-68",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        320.0,
                        165.0,
                        110.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-79",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        168.5,
                        322.0,
                        131.0,
                        22.0
                    ],
                    "text": "receive gong-ctrl"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-90",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        530.0,
                        69.0,
                        20.0
                    ],
                    "text": "Test Strike"
                }
            },
            {
                "box": {
                    "id": "obj-91",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        20.0,
                        552.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        20.0,
                        582.0,
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
                    "id": "obj-93",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        20.0,
                        612.0,
                        44.0,
                        22.0
                    ],
                    "text": "f 60"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-94",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        636.0,
                        44.0,
                        22.0
                    ],
                    "text": "mtof"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-95",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        20.0,
                        660.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend base_freq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-96",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        20.0,
                        684.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-97",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        173.5,
                        612.0,
                        51.0,
                        22.0
                    ],
                    "text": "f 0.8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-98",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        173.5,
                        636.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend velocity"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-99",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        173.5,
                        660.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-100",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        173.5,
                        684.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_force"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-101",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        173.5,
                        708.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "int",
                        "",
                        "",
                        "int"
                    ],
                    "patching_rect": [
                        334.25,
                        612.0,
                        81.5,
                        22.0
                    ],
                    "text": "counter"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-103",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        334.25,
                        636.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_count"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        334.25,
                        660.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-105",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        170.0,
                        164.0,
                        44.0,
                        22.0
                    ],
                    "text": "> 0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        188.0,
                        72.0,
                        22.0
                    ],
                    "text": "select 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "int",
                        "",
                        "",
                        "int"
                    ],
                    "patching_rect": [
                        170.0,
                        212.0,
                        81.5,
                        22.0
                    ],
                    "text": "counter"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-108",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        236.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_count"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-109",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        170.0,
                        260.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-110",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        300.0,
                        164.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend strike_force"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-111",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        300.0,
                        188.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-176",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        107.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend structure"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-177",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        131.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-182",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        195.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend brightness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-183",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        219.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-188",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        283.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend decay_time"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-189",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        307.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-194",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        371.0,
                        128.0,
                        22.0
                    ],
                    "text": "prepend position"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-195",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        395.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-200",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        539.0,
                        459.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend nonlinearity"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-201",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        539.0,
                        483.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-206",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        107.0,
                        177.0,
                        22.0
                    ],
                    "text": "prepend mallet_hardness"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-207",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        131.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-212",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        195.0,
                        156.0,
                        22.0
                    ],
                    "text": "prepend bloom_amount"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-213",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        219.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-218",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        283.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend bloom_speed"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-219",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        307.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-224",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        371.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend num_modes"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-225",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        395.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-230",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        772.0,
                        459.0,
                        149.0,
                        22.0
                    ],
                    "text": "prepend output_gain"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-231",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        772.0,
                        483.0,
                        114.0,
                        22.0
                    ],
                    "text": "send gong-ctrl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-232",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        716.0,
                        566.0,
                        58.0,
                        20.0
                    ],
                    "text": "Preset"
                }
            },
            {
                "box": {
                    "id": "obj-233",
                    "items": [
                        "Tam-Tam",
                        ",",
                        "Opera Gong",
                        ",",
                        "Church Bell",
                        ",",
                        "Gamelan",
                        ",",
                        "Dark Crash",
                        ",",
                        "Singing Bowl"
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
                        769.0,
                        564.0,
                        140.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-234",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        723.0,
                        601.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-235",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        723.0,
                        623.0,
                        114.0,
                        22.0
                    ],
                    "text": "prepend recall"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-236",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        723.0,
                        645.0,
                        275.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "pattrstorage gong-presets @savemode 3",
                    "varname": "gong-presets"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-237",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        851.0,
                        645.0,
                        79.0,
                        22.0
                    ],
                    "restore": {
                        "d_structure": [
                            0.5039
                        ],
                        "d_brightness": [
                            0.5039
                        ],
                        "d_decay": [
                            3.9265
                        ],
                        "d_position": [
                            0.5039
                        ],
                        "d_nonlinearity": [
                            0.1024
                        ],
                        "d_hardness": [
                            0.5039
                        ],
                        "d_bloom": [
                            0.1024
                        ],
                        "d_bloom_speed": [
                            0.9859
                        ],
                        "d_modes": [
                            24.063
                        ],
                        "d_gain": [
                            0.5039
                        ]
                    },
                    "text": "autopattr",
                    "varname": "u063001597"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-238",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        851.0,
                        601.0,
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
                    "id": "obj-239",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        851.0,
                        623.0,
                        72.0,
                        22.0
                    ],
                    "text": "recall 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-240",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v1.0.0"
                }
            },
            {
                "box": {
                    "id": "obj-300",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        65.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Structure",
                            "parameter_shortname": "Struct",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ]
                        }
                    },
                    "varname": "d_structure"
                }
            },
            {
                "box": {
                    "id": "obj-301",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        153.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Brightness",
                            "parameter_shortname": "Bright",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ]
                        }
                    },
                    "varname": "d_brightness"
                }
            },
            {
                "box": {
                    "id": "obj-302",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        241.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Decay Time",
                            "parameter_shortname": "Decay",
                            "parameter_mmin": 0.1,
                            "parameter_mmax": 30.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                8.0
                            ]
                        }
                    },
                    "varname": "d_decay"
                }
            },
            {
                "box": {
                    "id": "obj-303",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        329.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Position",
                            "parameter_shortname": "Pos",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ]
                        }
                    },
                    "varname": "d_position"
                }
            },
            {
                "box": {
                    "id": "obj-304",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        484.0,
                        417.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Nonlinearity",
                            "parameter_shortname": "Nonlin",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.1
                            ]
                        }
                    },
                    "varname": "d_nonlinearity"
                }
            },
            {
                "box": {
                    "id": "obj-305",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        65.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Mallet Hardness",
                            "parameter_shortname": "Hard",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ]
                        }
                    },
                    "varname": "d_hardness"
                }
            },
            {
                "box": {
                    "id": "obj-306",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        153.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Bloom Amount",
                            "parameter_shortname": "Bloom",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.1
                            ]
                        }
                    },
                    "varname": "d_bloom"
                }
            },
            {
                "box": {
                    "id": "obj-307",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        241.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Bloom Speed",
                            "parameter_shortname": "BlmSpd",
                            "parameter_mmin": 0.1,
                            "parameter_mmax": 5.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                1.0
                            ]
                        }
                    },
                    "varname": "d_bloom_speed"
                }
            },
            {
                "box": {
                    "id": "obj-308",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        329.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Number of Modes",
                            "parameter_shortname": "Modes",
                            "parameter_mmin": 4.0,
                            "parameter_mmax": 32.0,
                            "parameter_type": 1,
                            "parameter_unitstyle": 0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                16.0
                            ]
                        }
                    },
                    "varname": "d_modes"
                }
            },
            {
                "box": {
                    "id": "obj-309",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        717.0,
                        417.0,
                        50.0,
                        68.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Output Gain",
                            "parameter_shortname": "Gain",
                            "parameter_mmin": 0.0,
                            "parameter_mmax": 1.0,
                            "parameter_type": 0,
                            "parameter_unitstyle": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0.5
                            ]
                        }
                    },
                    "varname": "d_gain"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-68",
                        0
                    ],
                    "midpoints": [
                        329.5,
                        165.0,
                        329.5,
                        165.0
                    ],
                    "source": [
                        "obj-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-101",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        708.0,
                        183.0,
                        708.0
                    ],
                    "source": [
                        "obj-100",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-103",
                        0
                    ],
                    "midpoints": [
                        343.75,
                        636.0,
                        343.75,
                        636.0
                    ],
                    "source": [
                        "obj-102",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-104",
                        0
                    ],
                    "midpoints": [
                        343.75,
                        660.0,
                        343.75,
                        660.0
                    ],
                    "source": [
                        "obj-103",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-106",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        189.0,
                        179.5,
                        189.0
                    ],
                    "source": [
                        "obj-105",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-107",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        213.0,
                        179.5,
                        213.0
                    ],
                    "source": [
                        "obj-106",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-108",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        237.0,
                        179.5,
                        237.0
                    ],
                    "source": [
                        "obj-107",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-109",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        261.0,
                        179.5,
                        261.0
                    ],
                    "source": [
                        "obj-108",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-111",
                        0
                    ],
                    "midpoints": [
                        309.5,
                        189.0,
                        309.5,
                        189.0
                    ],
                    "source": [
                        "obj-110",
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
                    "midpoints": [
                        29.5,
                        249.0,
                        29.5,
                        249.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        273.0,
                        29.5,
                        273.0
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
                        "obj-57",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        345.0,
                        6.0,
                        345.0,
                        6.0,
                        378.0,
                        29.5,
                        378.0
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
                        "obj-58",
                        0
                    ],
                    "midpoints": [
                        138.5,
                        345.0,
                        139.5,
                        345.0
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
                        "obj-177",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        132.0,
                        548.5,
                        132.0
                    ],
                    "source": [
                        "obj-176",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-183",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        219.0,
                        548.5,
                        219.0
                    ],
                    "source": [
                        "obj-182",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-189",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        306.0,
                        548.5,
                        306.0
                    ],
                    "source": [
                        "obj-188",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-195",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        396.0,
                        548.5,
                        396.0
                    ],
                    "source": [
                        "obj-194",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-201",
                        0
                    ],
                    "midpoints": [
                        548.5,
                        483.0,
                        548.5,
                        483.0
                    ],
                    "source": [
                        "obj-200",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-207",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        132.0,
                        781.5,
                        132.0
                    ],
                    "source": [
                        "obj-206",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-213",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        219.0,
                        781.5,
                        219.0
                    ],
                    "source": [
                        "obj-212",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-219",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        306.0,
                        781.5,
                        306.0
                    ],
                    "source": [
                        "obj-218",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-225",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        396.0,
                        781.5,
                        396.0
                    ],
                    "source": [
                        "obj-224",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-231",
                        0
                    ],
                    "midpoints": [
                        781.5,
                        483.0,
                        781.5,
                        483.0
                    ],
                    "source": [
                        "obj-230",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-234",
                        0
                    ],
                    "midpoints": [
                        778.5,
                        597.0,
                        732.5,
                        597.0
                    ],
                    "source": [
                        "obj-233",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-235",
                        0
                    ],
                    "midpoints": [
                        732.5,
                        624.0,
                        732.5,
                        624.0
                    ],
                    "source": [
                        "obj-234",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-236",
                        0
                    ],
                    "midpoints": [
                        732.5,
                        648.0,
                        732.5,
                        648.0
                    ],
                    "source": [
                        "obj-235",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-239",
                        0
                    ],
                    "midpoints": [
                        860.5,
                        624.0,
                        860.5,
                        624.0
                    ],
                    "source": [
                        "obj-238",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-236",
                        0
                    ],
                    "midpoints": [
                        860.5,
                        678.0,
                        720.0,
                        678.0,
                        720.0,
                        642.0,
                        732.5,
                        642.0
                    ],
                    "source": [
                        "obj-239",
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
                        29.5,
                        96.0,
                        29.5,
                        96.0
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
                    "midpoints": [
                        49.0,
                        96.0,
                        179.5,
                        96.0
                    ],
                    "source": [
                        "obj-3",
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
                    "midpoints": [
                        29.5,
                        135.0,
                        29.5,
                        135.0
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
                        "obj-66",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        159.0,
                        29.5,
                        159.0
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
                        "obj-60",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        414.0,
                        71.0,
                        414.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-61",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        405.0,
                        29.0,
                        405.0
                    ],
                    "order": 3,
                    "source": [
                        "obj-57",
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
                        29.5,
                        405.0,
                        117.0,
                        405.0,
                        117.0,
                        369.0,
                        207.0,
                        369.0,
                        207.0,
                        378.0,
                        229.5,
                        378.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-65",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        414.0,
                        207.0,
                        414.0,
                        207.0,
                        513.0,
                        229.5,
                        513.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-60",
                        1
                    ],
                    "midpoints": [
                        139.5,
                        405.0,
                        97.0,
                        405.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-58",
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
                    "midpoints": [
                        139.5,
                        405.0,
                        139.0,
                        405.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-58",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-105",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        135.0,
                        165.0,
                        135.0,
                        165.0,
                        159.0,
                        179.5,
                        159.0
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
                        "obj-110",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        135.0,
                        306.0,
                        135.0,
                        306.0,
                        159.0,
                        309.5,
                        159.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        135.0,
                        179.5,
                        135.0
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
                        "obj-67",
                        0
                    ],
                    "midpoints": [
                        179.5,
                        165.0,
                        179.5,
                        165.0
                    ],
                    "source": [
                        "obj-7",
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
                        178.0,
                        345.0,
                        162.0,
                        345.0,
                        162.0,
                        288.0,
                        29.5,
                        288.0
                    ],
                    "source": [
                        "obj-79",
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
                        329.5,
                        105.0,
                        329.5,
                        105.0
                    ],
                    "source": [
                        "obj-8",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        329.5,
                        135.0,
                        329.5,
                        135.0
                    ],
                    "source": [
                        "obj-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-92",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        579.0,
                        29.5,
                        579.0
                    ],
                    "source": [
                        "obj-91",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-102",
                        0
                    ],
                    "midpoints": [
                        117.5,
                        606.0,
                        159.0,
                        606.0,
                        159.0,
                        597.0,
                        234.0,
                        597.0,
                        234.0,
                        609.0,
                        343.75,
                        609.0
                    ],
                    "source": [
                        "obj-92",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-93",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        606.0,
                        29.5,
                        606.0
                    ],
                    "source": [
                        "obj-92",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-97",
                        0
                    ],
                    "midpoints": [
                        73.5,
                        615.0,
                        159.0,
                        615.0,
                        159.0,
                        609.0,
                        183.0,
                        609.0
                    ],
                    "source": [
                        "obj-92",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-94",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        636.0,
                        29.5,
                        636.0
                    ],
                    "source": [
                        "obj-93",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-95",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        660.0,
                        29.5,
                        660.0
                    ],
                    "source": [
                        "obj-94",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-96",
                        0
                    ],
                    "midpoints": [
                        29.5,
                        684.0,
                        29.5,
                        684.0
                    ],
                    "source": [
                        "obj-95",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-100",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        636.0,
                        168.0,
                        636.0,
                        168.0,
                        681.0,
                        183.0,
                        681.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-98",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        636.0,
                        183.0,
                        636.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-99",
                        0
                    ],
                    "midpoints": [
                        183.0,
                        660.0,
                        183.0,
                        660.0
                    ],
                    "source": [
                        "obj-98",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-300",
                        0
                    ],
                    "destination": [
                        "obj-176",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-301",
                        0
                    ],
                    "destination": [
                        "obj-182",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-302",
                        0
                    ],
                    "destination": [
                        "obj-188",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-303",
                        0
                    ],
                    "destination": [
                        "obj-194",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-304",
                        0
                    ],
                    "destination": [
                        "obj-200",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-305",
                        0
                    ],
                    "destination": [
                        "obj-206",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-306",
                        0
                    ],
                    "destination": [
                        "obj-212",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-307",
                        0
                    ],
                    "destination": [
                        "obj-218",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-308",
                        0
                    ],
                    "destination": [
                        "obj-224",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-309",
                        0
                    ],
                    "destination": [
                        "obj-230",
                        0
                    ]
                }
            }
        ],
        "parameters": {
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