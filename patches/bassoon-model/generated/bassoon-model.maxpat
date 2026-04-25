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
        "rect": [ 120.0, 120.0, 1171.0, 770.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "format": 6,
                    "id": "obj-1",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 38.0, 186.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 40.0, 40.0, 80.0, 22.0 ]
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 38.0, 221.0, 44.0, 22.0 ],
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 311.0, 344.0, 121.0, 22.0 ],
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
                    "outlettype": [ "", "float" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 443.0, 76.5, 39.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 40.0, 75.0, 80.0, 140.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "amp",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "amp",
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 443.0, 176.0, 51.0, 22.0 ],
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 465.0, 416.0, 58.0, 22.0 ],
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 563.0, 461.0, 51.0, 22.0 ],
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
                    "outlettype": [ "signal", "signal", "", "float", "list" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 548.0, 491.0, 48.0, 136.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 40.0, 230.0, 80.0, 140.0 ],
                    "varname": "live.gain~"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.92, 0.85, 0.85, 1.0 ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 518.0, 656.0, 72.0, 22.0 ],
                    "text": "dac~ 1 2"
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "live.scope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 294.0, 451.0, 131.0, 131.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 645.0, 40.0, 440.0, 200.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "spectroscope~",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 663.0, 296.0, 300.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 645.0, 265.0, 440.0, 200.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::reed_stiff",
                    "parameter_enable": 1,
                    "patching_rect": [ 192.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 40.0, 390.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_stiff",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "reed_stiff",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::reed_aper",
                    "parameter_enable": 1,
                    "patching_rect": [ 144.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 390.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_aper",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": -1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "reed_aper",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::bell_bright",
                    "parameter_enable": 1,
                    "patching_rect": [ 623.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 260.0, 390.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "bell_bright",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "bell_bright",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_rate",
                    "parameter_enable": 1,
                    "patching_rect": [ 98.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 40.0, 470.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 5.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_rate",
                            "parameter_mmax": 12.0,
                            "parameter_mmin": 0.1,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_rate",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_depth",
                    "parameter_enable": 1,
                    "patching_rect": [ 503.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 470.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_depth",
                            "parameter_mmax": 50.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_depth",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::bore_damp",
                    "parameter_enable": 1,
                    "patching_rect": [ 242.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 260.0, 470.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.3 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "bore_damp",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "bore_damp",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::reed_res_freq",
                    "parameter_enable": 1,
                    "patching_rect": [ 733.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 370.0, 390.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 1500.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_res_freq",
                            "parameter_mmax": 2500.0,
                            "parameter_mmin": 500.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "reed_res_freq",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::reed_res_q",
                    "parameter_enable": 1,
                    "patching_rect": [ 843.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 480.0, 390.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 2.5 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "reed_res_q",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "reed_res_q",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::noise_amt",
                    "parameter_enable": 1,
                    "patching_rect": [ 953.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 366.0, 470.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.075 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "noise_amt",
                            "parameter_mmax": 0.5,
                            "parameter_modmode": 3,
                            "parameter_shortname": "noise_amt",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_amp",
                    "parameter_enable": 1,
                    "patching_rect": [ 1063.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 480.0, 470.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.08 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_amp",
                            "parameter_mmax": 0.3,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_amp",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::chiff_amt",
                    "parameter_enable": 1,
                    "patching_rect": [ 1173.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 590.0, 470.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.3 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "chiff_amt",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "chiff_amt",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::register",
                    "parameter_enable": 1,
                    "patching_rect": [ 1283.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 590.0, 390.0, 50.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "register",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "register",
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
                    "patching_rect": [ 90.0, 187.0, 44.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 125.0, 40.0, 160.0, 20.0 ],
                    "text": "freq ",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
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
                    "patching_rect": [ 488.0, 110.0, 58.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 125.0, 75.0, 80.0, 20.0 ],
                    "text": "breath",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 533.0, 296.0, 107.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 645.0, 242.0, 120.0, 20.0 ],
                    "text": "bore waveform",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 773.0, 266.0, 72.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 645.0, 470.0, 120.0, 20.0 ],
                    "text": "spectrum",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
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
                    "patching_rect": [ 593.0, 491.0, 58.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 125.0, 230.0, 80.0, 20.0 ],
                    "text": "master",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
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
                    "patching_rect": [ 550.0, 10.0, 58.0, 20.0 ],
                    "text": "v0.16.0"
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
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 45.0, 720.0, 79.0, 22.0 ],
                    "restore": {
                        "amp": [ 0.0 ],
                        "bell_bright": [ 0.5 ],
                        "bore_damp": [ 0.3 ],
                        "chiff_amt": [ 0.3 ],
                        "drift_on": [ 1.0 ],
                        "live.gain~": [ 0.0 ],
                        "noise_amt": [ 0.075 ],
                        "reed_aper": [ 0.0 ],
                        "reed_res_freq": [ 1500.0 ],
                        "reed_res_q": [ 2.5 ],
                        "reed_stiff": [ 0.5 ],
                        "register": [ 0.0 ],
                        "staccato_btn": [ 0.0 ],
                        "vib_amp": [ 0.08 ],
                        "vib_amp_lag": [ 0.7834645669291336 ],
                        "vib_depth": [ 0.0 ],
                        "vib_onset_time": [ 0.724409448818898 ],
                        "vib_ramp_time": [ 0.6185039370078735 ],
                        "vib_rate": [ 5.0 ],
                        "vib_rate_jit": [ 0.3 ]
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 210.0, 720.0, 401.0, 22.0 ],
                    "saved_object_attributes": {
                        "client_rect": [ 4, 45, 358, 173 ],
                        "parameter_enable": 0,
                        "parameter_mappable": 0,
                        "storage_rect": [ 200, 100, 800, 400 ]
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
                    "outlettype": [ "preset", "int", "preset", "int", "" ],
                    "patching_rect": [ 135.0, 260.0, 126.0, 56.0 ],
                    "pattrstorage": "bassoon_presets",
                    "presentation": 1,
                    "presentation_rect": [ 135.0, 260.0, 360.0, 60.0 ],
                    "stored1": [ 1.0, 0.0, 0.0, 1.0 ]
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
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 45.0, 765.0, 72.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 50.0, 800.0, 72.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 470.0, 275.0, 86.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 500.0, 275.0, 70.0, 22.0 ],
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
                    "patching_rect": [ 263.0, 260.0, 100.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 500.0, 255.0, 80.0, 20.0 ],
                    "text": "Save Presets",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-62",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 240.0, 65.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 135.0, 240.0, 80.0, 20.0 ],
                    "text": "Presets",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-63",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_onset_time",
                    "parameter_enable": 1,
                    "patching_rect": [ 1393.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 43.0, 582.0, 92.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.15 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_onset_time",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_onset_time",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_ramp_time",
                    "parameter_enable": 1,
                    "patching_rect": [ 1503.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 153.0, 582.0, 92.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.3 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_ramp_time",
                            "parameter_mmax": 1.0,
                            "parameter_mmin": 0.05,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_ramp_time",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_rate_jit",
                    "parameter_enable": 1,
                    "patching_rect": [ 1613.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 263.0, 582.0, 92.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.12 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_rate_jit",
                            "parameter_mmax": 0.3,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_rate_jit",
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
                    "outlettype": [ "", "float" ],
                    "param_connect": "gen~_AA::vib_amp_lag",
                    "parameter_enable": 1,
                    "patching_rect": [ 1723.0, 110.0, 44.0, 48.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 373.0, 582.0, 92.0, 48.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_initial": [ 0.5 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "vib_amp_lag",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "vib_amp_lag",
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
                    "outlettype": [ "" ],
                    "param_connect": "gen~_AA::drift_on",
                    "parameter_enable": 1,
                    "patching_rect": [ 1833.0, 110.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 483.0, 582.0, 24.0, 24.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_enum": [ "off", "on" ],
                            "parameter_initial": [ 1.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "drift_on",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 0,
                            "parameter_shortname": "drift_on",
                            "parameter_type": 0
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
                    "patching_rect": [ 1828.0, 140.0, 50.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 478.0, 612.0, 50.0, 18.0 ],
                    "text": "drift",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-69",
                    "maxclass": "live.button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 503.0, 176.0, 20.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 120.0, 195.0, 20.0, 20.0 ],
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
                    "patching_rect": [ 528.0, 178.0, 60.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 145.0, 197.0, 60.0, 18.0 ],
                    "text": "staccato"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-71",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 600.0, 176.0, 205.0, 22.0 ],
                    "text": "set 0., 0.9 15 0.9 60 0. 80"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-72",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "bang" ],
                    "patching_rect": [ 600.0, 210.0, 44.0, 22.0 ],
                    "text": "line~"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 443.0, 230.0, 35.0, 22.0 ],
                    "text": "+~"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 47.5, 210.0, 47.5, 210.0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 47.5, 255.0, 120.0, 255.0, 120.0, 225.0, 320.5, 225.0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "midpoints": [ 320.5, 438.0, 303.5, 438.0 ],
                    "order": 2,
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-12", 0 ],
                    "midpoints": [ 320.5, 246.0, 438.0, 246.0, 438.0, 255.0, 462.0, 255.0, 462.0, 261.0, 672.5, 261.0 ],
                    "order": 0,
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "midpoints": [ 320.5, 402.0, 474.5, 402.0 ],
                    "order": 1,
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "midpoints": [ 452.5, 165.0, 452.5, 165.0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-59", 0 ],
                    "midpoints": [ 54.5, 795.0, 59.5, 795.0 ],
                    "source": [ "obj-58", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-56", 0 ],
                    "midpoints": [ 59.5, 834.0, 195.0, 834.0, 195.0, 717.0, 219.5, 717.0 ],
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-73", 0 ],
                    "midpoints": [ 452.5, 201.0, 452.5, 201.0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-56", 0 ],
                    "midpoints": [ 479.5, 402.0, 219.5, 402.0 ],
                    "source": [ "obj-60", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-71", 0 ],
                    "midpoints": [ 512.5, 207.0, 597.0, 207.0, 597.0, 171.0, 609.5, 171.0 ],
                    "source": [ "obj-69", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "midpoints": [ 474.5, 456.0, 572.5, 456.0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 0 ],
                    "midpoints": [ 609.5, 201.0, 609.5, 201.0 ],
                    "source": [ "obj-71", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-73", 1 ],
                    "midpoints": [ 609.5, 234.0, 489.0, 234.0, 489.0, 225.0, 468.5, 225.0 ],
                    "source": [ "obj-72", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 1 ],
                    "midpoints": [ 452.5, 255.0, 422.5, 255.0 ],
                    "source": [ "obj-73", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 1 ],
                    "midpoints": [ 572.5, 486.0, 586.5, 486.0 ],
                    "order": 0,
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "midpoints": [ 572.5, 486.0, 557.5, 486.0 ],
                    "order": 1,
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-10", 1 ],
                    "midpoints": [ 564.75, 642.0, 580.5, 642.0 ],
                    "source": [ "obj-9", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-10", 0 ],
                    "midpoints": [ 557.5, 642.0, 527.5, 642.0 ],
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-13": [ "reed_stiff", "reed_stiff", 0 ],
            "obj-15": [ "reed_aper", "reed_aper", 0 ],
            "obj-17": [ "bell_bright", "bell_bright", 0 ],
            "obj-19": [ "vib_rate", "vib_rate", 0 ],
            "obj-21": [ "vib_depth", "vib_depth", 0 ],
            "obj-42": [ "bore_damp", "bore_damp", 0 ],
            "obj-44": [ "reed_res_freq", "reed_res_freq", 0 ],
            "obj-46": [ "reed_res_q", "reed_res_q", 0 ],
            "obj-48": [ "noise_amt", "noise_amt", 0 ],
            "obj-5": [ "amp", "amp", 0 ],
            "obj-50": [ "vib_amp", "vib_amp", 0 ],
            "obj-52": [ "chiff_amt", "chiff_amt", 0 ],
            "obj-54": [ "register", "register", 0 ],
            "obj-63": [ "vib_onset_time", "vib_onset_time", 0 ],
            "obj-64": [ "vib_ramp_time", "vib_ramp_time", 0 ],
            "obj-65": [ "vib_rate_jit", "vib_rate_jit", 0 ],
            "obj-66": [ "vib_amp_lag", "vib_amp_lag", 0 ],
            "obj-67": [ "drift_on", "drift_on", 0 ],
            "inherited_shortname": 1
        },
        "autosave": 0,
        "editing_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ]
    }
}