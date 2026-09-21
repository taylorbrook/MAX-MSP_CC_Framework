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
            120.0,
            120.0,
            1171.0,
            770.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "format": 6,
                    "id": "obj-1",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        40.0,
                        86.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        62.0,
                        80.0,
                        22.0
                    ]
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
                        "signal"
                    ],
                    "patching_rect": [
                        40.0,
                        121.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        40.0,
                        295.0,
                        332.0,
                        22.0
                    ],
                    "text": "gen~ bassoon",
                    "varname": "gen~_AA"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "live.slider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        360.0,
                        56.0,
                        39.0,
                        87.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        110.0,
                        80.0,
                        110.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "amp",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Breath",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "amp"
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
                    "patching_rect": [
                        360.0,
                        155.0,
                        51.0,
                        22.0
                    ],
                    "text": "sig~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        40.0,
                        335.0,
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
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        40.0,
                        370.0,
                        51.0,
                        22.0
                    ],
                    "text": "limi~"
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "lastchannelcount": 0,
                    "maxclass": "live.gain~",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        "float",
                        "list"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        40.0,
                        405.0,
                        48.0,
                        136.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        122.0,
                        110.0,
                        80.0,
                        110.0
                    ],
                    "varname": "live.gain~"
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
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        40.0,
                        560.0,
                        72.0,
                        22.0
                    ],
                    "text": "dac~ 1 2"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "live.scope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        170.0,
                        365.0,
                        131.0,
                        131.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        645.0,
                        58.0,
                        440.0,
                        180.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "spectroscope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        538.0,
                        300.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        645.0,
                        278.0,
                        440.0,
                        220.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::reed_stiff",
                    "parameter_enable": 1,
                    "patching_rect": [
                        480.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_stiff",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Stiffness",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "reed_stiff"
                }
            },
            {
                "box": {
                    "id": "obj-15",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::reed_aper",
                    "parameter_enable": 1,
                    "patching_rect": [
                        544.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        122.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_aper",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": -1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Aperture",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "reed_aper"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::bell_bright",
                    "parameter_enable": 1,
                    "patching_rect": [
                        816.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        450.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "bell_bright",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Bell",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "bell_bright"
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
                    "param_connect": "gen~_AA::vib_rate",
                    "parameter_enable": 1,
                    "patching_rect": [
                        480.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                5.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_rate",
                            "parameter_mmax": 12.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Vib Rate",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "vib_rate"
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
                    "param_connect": "gen~_AA::vib_depth",
                    "parameter_enable": 1,
                    "patching_rect": [
                        544.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        122.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_depth",
                            "parameter_mmax": 50.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Vib Depth",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "vib_depth"
                }
            },
            {
                "box": {
                    "id": "obj-42",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::bore_damp",
                    "parameter_enable": 1,
                    "patching_rect": [
                        752.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        368.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.3
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "bore_damp",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Bore Damp",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "bore_damp"
                }
            },
            {
                "box": {
                    "id": "obj-44",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::reed_res_freq",
                    "parameter_enable": 1,
                    "patching_rect": [
                        608.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        204.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                1500.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_res_freq",
                            "parameter_mmax": 2500.0,
                            "parameter_mmin": 500.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Reed Freq",
                            "parameter_type": 0,
                            "parameter_unitstyle": 3
                        }
                    },
                    "varname": "reed_res_freq"
                }
            },
            {
                "box": {
                    "id": "obj-46",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::reed_res_q",
                    "parameter_enable": 1,
                    "patching_rect": [
                        672.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        286.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                2.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_res_q",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Reed Q",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "reed_res_q"
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::noise_amt",
                    "parameter_enable": 1,
                    "patching_rect": [
                        752.0,
                        266.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        450.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.075
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "noise_amt",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Noise",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "noise_amt"
                }
            },
            {
                "box": {
                    "id": "obj-50",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::vib_amp",
                    "parameter_enable": 1,
                    "patching_rect": [
                        608.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        204.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.08
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_amp",
                            "parameter_mmax": 0.3,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Tremolo",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "vib_amp"
                }
            },
            {
                "box": {
                    "id": "obj-52",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::chiff_amt",
                    "parameter_enable": 1,
                    "patching_rect": [
                        816.0,
                        266.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        122.0,
                        450.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.3
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "chiff_amt",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Chiff",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "chiff_amt"
                }
            },
            {
                "box": {
                    "id": "obj-54",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::register",
                    "parameter_enable": 1,
                    "patching_rect": [
                        880.0,
                        86.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        532.0,
                        274.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "register",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Register",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "register"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        95.0,
                        87.0,
                        70.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        124.0,
                        63.0,
                        70.0,
                        20.0
                    ],
                    "text": "freq (Hz)",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        404.0,
                        56.0,
                        58.0,
                        20.0
                    ],
                    "text": "breath",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        95.0,
                        405.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        122.0,
                        87.0,
                        80.0,
                        20.0
                    ],
                    "text": "master",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1080.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.19.1",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
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
                        480.0,
                        470.0,
                        79.0,
                        22.0
                    ],
                    "restore": {
                        "amp": [
                            0.05
                        ],
                        "attack_time": [
                            1.0
                        ],
                        "bell_bright": [
                            0.5
                        ],
                        "bore_damp": [
                            0.3
                        ],
                        "chiff_amt": [
                            0.3
                        ],
                        "drift_on": [
                            1.0
                        ],
                        "live.gain~": [
                            0.0
                        ],
                        "noise_amt": [
                            0.075
                        ],
                        "reed_aper": [
                            0.0
                        ],
                        "reed_res_freq": [
                            1500.0
                        ],
                        "reed_res_q": [
                            2.5
                        ],
                        "reed_stiff": [
                            0.5
                        ],
                        "register": [
                            0.0
                        ],
                        "release_time": [
                            224.8818897637796
                        ],
                        "staccato_btn": [
                            0.0
                        ],
                        "tongue_btn": [
                            0.0
                        ],
                        "vib_amp": [
                            0.08
                        ],
                        "vib_amp_lag": [
                            0.5
                        ],
                        "vib_depth": [
                            0.0
                        ],
                        "vib_onset_time": [
                            0.15
                        ],
                        "vib_ramp_time": [
                            0.3
                        ],
                        "vib_rate": [
                            5.0
                        ],
                        "vib_rate_jit": [
                            0.12
                        ]
                    },
                    "text": "autopattr",
                    "varname": "u358010894"
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
                        480.0,
                        440.0,
                        401.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "client_rect": [
                            4,
                            45,
                            358,
                            173
                        ],
                        "parameter_enable": 0,
                        "parameter_mappable": 0,
                        "storage_rect": [
                            200,
                            100,
                            800,
                            400
                        ]
                    },
                    "text": "pattrstorage bassoon_presets @savemode 3 @autorestore 1",
                    "varname": "bassoon_presets"
                }
            },
            {
                "box": {
                    "id": "obj-57",
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
                        480.0,
                        362.0,
                        126.0,
                        56.0
                    ],
                    "pattrstorage": "bassoon_presets",
                    "presentation": 1,
                    "presentation_rect": [
                        222.0,
                        62.0,
                        390.0,
                        56.0
                    ],
                    "stored1": [
                        1.0,
                        0.0,
                        0.0,
                        1.0
                    ]
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
                        "bang"
                    ],
                    "patching_rect": [
                        740.0,
                        362.0,
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
                    "id": "obj-59",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        740.0,
                        392.0,
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
                    "id": "obj-60",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        620.0,
                        384.0,
                        86.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        222.0,
                        126.0,
                        70.0,
                        22.0
                    ],
                    "text": "writeagain"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        620.0,
                        362.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        336.0,
                        127.0,
                        90.0,
                        20.0
                    ],
                    "text": "Save Presets",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-63",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::vib_onset_time",
                    "parameter_enable": 1,
                    "patching_rect": [
                        736.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        368.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.15
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_onset_time",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Vib Onset",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "vib_onset_time"
                }
            },
            {
                "box": {
                    "id": "obj-64",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::vib_ramp_time",
                    "parameter_enable": 1,
                    "patching_rect": [
                        800.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        450.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.3
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_ramp_time",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": 0.05,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Vib Ramp",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "vib_ramp_time"
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::vib_rate_jit",
                    "parameter_enable": 1,
                    "patching_rect": [
                        864.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        532.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.12
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_rate_jit",
                            "parameter_mmax": 0.3,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Rate Jitter",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "vib_rate_jit"
                }
            },
            {
                "box": {
                    "id": "obj-66",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::vib_amp_lag",
                    "parameter_enable": 1,
                    "patching_rect": [
                        672.0,
                        176.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        286.0,
                        362.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                0.5
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_amp_lag",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Trem Lag",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "varname": "vib_amp_lag"
                }
            },
            {
                "box": {
                    "id": "obj-67",
                    "maxclass": "live.toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "param_connect": "gen~_AA::drift_on",
                    "parameter_enable": 1,
                    "patching_rect": [
                        626.0,
                        272.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        190.0,
                        24.0,
                        24.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [
                                "off",
                                "on"
                            ],
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "drift_on",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "Drift",
                            "parameter_type": 2
                        }
                    },
                    "varname": "drift_on"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-68",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        654.0,
                        275.0,
                        50.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        428.0,
                        193.0,
                        40.0,
                        18.0
                    ],
                    "text": "drift",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-69",
                    "maxclass": "live.button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        255.0,
                        86.0,
                        20.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        188.0,
                        20.0,
                        20.0
                    ],
                    "varname": "staccato_btn"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-70",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        280.0,
                        87.0,
                        60.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        504.0,
                        189.0,
                        60.0,
                        18.0
                    ],
                    "text": "staccato",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-73",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        360.0,
                        215.0,
                        35.0,
                        22.0
                    ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "id": "obj-74",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::attack_time",
                    "parameter_enable": 1,
                    "patching_rect": [
                        480.0,
                        266.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        222.0,
                        186.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                15.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "attack_time",
                            "parameter_mmax": 200.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Attack",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "attack_time"
                }
            },
            {
                "box": {
                    "id": "obj-75",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "param_connect": "gen~_AA::release_time",
                    "parameter_enable": 1,
                    "patching_rect": [
                        544.0,
                        266.0,
                        58.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        304.0,
                        186.0,
                        80.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [
                                30.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "release_time",
                            "parameter_mmax": 500.0,
                            "parameter_mmin": 5.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "Release",
                            "parameter_type": 0,
                            "parameter_unitstyle": 2
                        }
                    },
                    "varname": "release_time"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-79",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        195.0,
                        87.0,
                        58.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        504.0,
                        213.0,
                        50.0,
                        18.0
                    ],
                    "text": "tongue",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-84",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        40.0,
                        56.0,
                        107.0,
                        22.0
                    ],
                    "text": "loadmess 110.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-85",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        170,
                        155,
                        114.0,
                        22.0
                    ],
                    "text": "p articulation",
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
                            400.0,
                            300.0
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
                                        30.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Tongue (bang): 20 ms tongue_trig pulse"
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
                                        480.0,
                                        20.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Staccato (bang): 155 ms breath envelope"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        30.0,
                                        200.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "gen~ messages (tongue_trig 1/0)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-4",
                                    "numinlets": 2,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        480.0,
                                        200.0,
                                        30.0,
                                        30.0
                                    ],
                                    "parameter_enable": 0,
                                    "comment": "Breath envelope (signal, sums with breath)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        60,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "t b b",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-6",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30,
                                        150,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "tongue_trig 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        175,
                                        105,
                                        83.0,
                                        22.0
                                    ],
                                    "text": "pipe 20",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-8",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        175,
                                        150,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "tongue_trig 0",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
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
                                        90,
                                        61,
                                        359.0,
                                        20.0
                                    ],
                                    "text": "right outlet first: arm 20 ms release, then raise",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-10",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        480,
                                        105,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "0. 0 0.9 15 0.9 60 0. 80",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-11",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        ""
                                    ],
                                    "patching_rect": [
                                        480,
                                        150,
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
                                    "maxclass": "comment",
                                    "id": "obj-12",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        480,
                                        61,
                                        534.0,
                                        20.0
                                    ],
                                    "text": "one list (line~ drops comma segments): 0 -> 0.9 in 15 ms, hold 60, fall 80",
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
                                        "obj-5",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-5",
                                        1
                                    ],
                                    "destination": [
                                        "obj-7",
                                        0
                                    ],
                                    "midpoints": [
                                        74.0,
                                        53.0,
                                        82.0,
                                        53.0,
                                        82.0,
                                        89.0,
                                        182.0,
                                        89.0
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
                                        "obj-8",
                                        0
                                    ],
                                    "midpoints": [
                                        216.5,
                                        138.5,
                                        182.0,
                                        138.5
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
                                        "obj-6",
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
                                        "obj-3",
                                        0
                                    ],
                                    "midpoints": [
                                        83.5,
                                        186.0,
                                        37.0,
                                        186.0
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
                                        "obj-3",
                                        0
                                    ],
                                    "midpoints": [
                                        228.5,
                                        142.0,
                                        145.0,
                                        142.0,
                                        145.0,
                                        180.0,
                                        37.0,
                                        180.0
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
                                        "obj-10",
                                        0
                                    ],
                                    "midpoints": [
                                        495.0,
                                        53.0,
                                        472.0,
                                        53.0,
                                        472.0,
                                        89.0,
                                        487.0,
                                        89.0
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
                                        "obj-11",
                                        0
                                    ],
                                    "midpoints": [
                                        572.0,
                                        138.5,
                                        487.0,
                                        138.5
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
                                        "obj-4",
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
                    "maxclass": "live.button",
                    "id": "obj-86",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        170.0,
                        86.0,
                        20.0,
                        20.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        212.0,
                        20.0,
                        20.0
                    ],
                    "varname": "tongue_btn"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-87",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        40,
                        20,
                        124.5,
                        24.0
                    ],
                    "text": "PERFORMANCE",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        30.0,
                        162.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-88",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        480,
                        330,
                        86.5,
                        24.0
                    ],
                    "text": "PRESETS",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        222.0,
                        30.0,
                        390.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-89",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        480,
                        236,
                        134.0,
                        24.0
                    ],
                    "text": "ARTICULATION",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        222.0,
                        158.0,
                        390.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-90",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        480,
                        56,
                        58.0,
                        24.0
                    ],
                    "text": "REED",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        246.0,
                        326.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-91",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        752,
                        56,
                        124.5,
                        24.0
                    ],
                    "text": "BORE / BELL",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        368.0,
                        246.0,
                        244.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-92",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        480,
                        146,
                        86.5,
                        24.0
                    ],
                    "text": "VIBRATO",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        334.0,
                        572.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-93",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        752,
                        236,
                        48.5,
                        24.0
                    ],
                    "text": "AIR",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        422.0,
                        162.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-94",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        170,
                        335,
                        143.5,
                        24.0
                    ],
                    "text": "BORE WAVEFORM",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        645.0,
                        30.0,
                        440.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-95",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        170,
                        508,
                        96.0,
                        24.0
                    ],
                    "text": "SPECTRUM",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "presentation": 1,
                    "presentation_rect": [
                        645.0,
                        250.0,
                        440.0,
                        24.0
                    ],
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
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
                    "id": "obj-96",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        40,
                        255,
                        77.0,
                        24.0
                    ],
                    "text": "OUTPUT",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.2,
                        0.25,
                        1.0
                    ],
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-3",
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        62.0,
                        247.0,
                        32.0,
                        247.0,
                        32.0,
                        287.0,
                        47.0,
                        287.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        206.0,
                        327.0,
                        162.0,
                        327.0,
                        162.0,
                        367.0,
                        177.0,
                        367.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-4",
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
                        206.0,
                        327.0,
                        162.0,
                        327.0,
                        162.0,
                        367.0,
                        162.0,
                        357.0,
                        162.0,
                        357.0,
                        162.0,
                        504.0,
                        162.0,
                        500.0,
                        162.0,
                        500.0,
                        162.0,
                        540.0,
                        177.0,
                        540.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-4",
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
                        206.0,
                        327.0,
                        162.0,
                        327.0,
                        162.0,
                        367.0,
                        47.0,
                        367.0
                    ],
                    "order": 1,
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
                        "obj-5",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-59",
                        0
                    ],
                    "midpoints": [
                        776.0,
                        388.0,
                        747.0,
                        388.0
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
                        "obj-56",
                        0
                    ],
                    "midpoints": [
                        776.0,
                        427.0,
                        680.5,
                        427.0
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
                        "obj-73",
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
                        "obj-56",
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
                        "obj-8",
                        0
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
                        "obj-4",
                        1
                    ],
                    "source": [
                        "obj-73",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-9",
                        1
                    ],
                    "order": 0,
                    "source": [
                        "obj-8",
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
                    "order": 1,
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
                        1
                    ],
                    "midpoints": [
                        55.5,
                        550.5,
                        105.0,
                        550.5
                    ],
                    "source": [
                        "obj-9",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-10",
                        0
                    ],
                    "source": [
                        "obj-9",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-84",
                        0
                    ],
                    "destination": [
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        93.5,
                        79.0,
                        87.0,
                        79.0,
                        87.0,
                        115.0,
                        65.0,
                        115.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-86",
                        0
                    ],
                    "destination": [
                        "obj-85",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-69",
                        0
                    ],
                    "destination": [
                        "obj-85",
                        1
                    ],
                    "midpoints": [
                        265.0,
                        79.0,
                        272.0,
                        79.0,
                        272.0,
                        113.0,
                        277.0,
                        113.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-85",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        177.0,
                        247.0,
                        125.0,
                        247.0,
                        125.0,
                        287.0,
                        47.0,
                        287.0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-85",
                        1
                    ],
                    "destination": [
                        "obj-73",
                        1
                    ],
                    "midpoints": [
                        277.0,
                        147.0,
                        352.0,
                        147.0,
                        352.0,
                        185.0,
                        388.0,
                        185.0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-13": [
                "reed_stiff",
                "Stiffness",
                0
            ],
            "obj-15": [
                "reed_aper",
                "Aperture",
                0
            ],
            "obj-17": [
                "bell_bright",
                "Bell",
                0
            ],
            "obj-19": [
                "vib_rate",
                "Vib Rate",
                0
            ],
            "obj-21": [
                "vib_depth",
                "Vib Depth",
                0
            ],
            "obj-42": [
                "bore_damp",
                "Bore Damp",
                0
            ],
            "obj-44": [
                "reed_res_freq",
                "Reed Freq",
                0
            ],
            "obj-46": [
                "reed_res_q",
                "Reed Q",
                0
            ],
            "obj-48": [
                "noise_amt",
                "Noise",
                0
            ],
            "obj-5": [
                "amp",
                "Breath",
                0
            ],
            "obj-50": [
                "vib_amp",
                "Tremolo",
                0
            ],
            "obj-52": [
                "chiff_amt",
                "Chiff",
                0
            ],
            "obj-54": [
                "register",
                "Register",
                0
            ],
            "obj-63": [
                "vib_onset_time",
                "Vib Onset",
                0
            ],
            "obj-64": [
                "vib_ramp_time",
                "Vib Ramp",
                0
            ],
            "obj-65": [
                "vib_rate_jit",
                "Rate Jitter",
                0
            ],
            "obj-66": [
                "vib_amp_lag",
                "Trem Lag",
                0
            ],
            "obj-67": [
                "drift_on",
                "Drift",
                0
            ],
            "obj-74": [
                "attack_time",
                "Attack",
                0
            ],
            "obj-75": [
                "release_time",
                "Release",
                0
            ],
            "inherited_shortname": 1
        },
        "autosave": 0,
        "editing_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ],
        "bgcolor": [
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