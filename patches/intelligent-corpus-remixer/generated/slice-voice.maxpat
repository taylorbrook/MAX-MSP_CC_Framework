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
            822.0,
            355.0
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
                        30.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        101.0,
                        22.0
                    ],
                    "text": "route note",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        120.0,
                        121.0,
                        22.0
                    ],
                    "text": "unpack 0. 0. 0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        645.0,
                        210.0,
                        137.0,
                        22.0
                    ],
                    "text": "thispoly~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        165.0,
                        81.5,
                        22.0
                    ],
                    "text": "counter",
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
                        30.0,
                        165.0,
                        135.0,
                        22.0
                    ],
                    "text": "message offset $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        165.0,
                        149.0,
                        22.0
                    ],
                    "text": "message duration $1",
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
                        345.0,
                        165.0,
                        149.0,
                        22.0
                    ],
                    "text": "message loopmode $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        510.0,
                        210.0,
                        121.0,
                        22.0
                    ],
                    "text": "message trig $1",
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
                        600.0,
                        165.0,
                        79.0,
                        22.0
                    ],
                    "text": "message 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        270.0,
                        255.0,
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
                                    "numoutlets": 2,
                                    "outlettype": [
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
                                    "code": "\nBuffer source;\nParam offset(0);\nParam duration(1);\nParam loopmode(0);\nParam trig(0);\nHistory phase(0);\nHistory running(0);\nHistory voiceage(0);\nHistory trig_prev(0);\n\ntrig_edge = trig - trig_prev;\ntrig_fire = trig_edge > 0.5;\nnew_phase_init = trig_fire ? 0 : phase;\nnew_voiceage_init = trig_fire ? 0 : voiceage;\nnew_running_init = trig_fire ? 1 : running;\nnext_phase = new_phase_init + 1;\nend_reached = next_phase >= duration;\nlooping = loopmode > 0.5;\nwrap_phase = end_reached ? (looping ? 0 : duration) : next_phase;\nnext_running = (end_reached && (looping == 0)) ? 0 : new_running_init;\nread_pos = offset + wrap_phase;\nsampleL = peek(source, read_pos, 0);\nsampleR = peek(source, read_pos, 1);\nfade_samples = 0.005 * samplerate;\nfade_in_val = min(1, new_voiceage_init / fade_samples);\nremaining = duration - wrap_phase;\nfade_out_val = looping ? 1 : min(1, remaining / fade_samples);\nenv = new_running_init * fade_in_val * fade_out_val;\nphase = wrap_phase;\nrunning = next_running;\nvoiceage = new_voiceage_init + new_running_init;\ntrig_prev = trig;\nout1 = sampleL * env;\nout2 = sampleR * env;\n",
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
                                        300.0,
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
                                        405.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 2",
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
                    "maxclass": "outlet",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        270.0,
                        285.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        375.0,
                        285.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0
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
                        67.5,
                        80.5,
                        67.5
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
                    ],
                    "midpoints": [
                        37.0,
                        108.5,
                        90.5,
                        108.5
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
                        "obj-6",
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        90.5,
                        157.0,
                        173.0,
                        157.0,
                        173.0,
                        195.0,
                        187.0,
                        195.0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        144.0,
                        157.0,
                        173.0,
                        157.0,
                        173.0,
                        195.0,
                        173.0,
                        157.0,
                        172.0,
                        157.0,
                        172.0,
                        195.0,
                        352.0,
                        195.0
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
                    ],
                    "midpoints": [
                        37.0,
                        157.0,
                        173.0,
                        157.0,
                        173.0,
                        195.0,
                        173.0,
                        157.0,
                        337.0,
                        157.0,
                        337.0,
                        195.0,
                        337.0,
                        157.0,
                        337.0,
                        157.0,
                        337.0,
                        195.0,
                        517.0,
                        195.0
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
                        "obj-9",
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        37.0,
                        157.0,
                        502.0,
                        157.0,
                        502.0,
                        195.0,
                        502.0,
                        157.0,
                        173.0,
                        157.0,
                        173.0,
                        195.0,
                        173.0,
                        157.0,
                        337.0,
                        157.0,
                        337.0,
                        195.0,
                        337.0,
                        157.0,
                        337.0,
                        157.0,
                        337.0,
                        195.0,
                        607.0,
                        195.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        639.5,
                        202.0,
                        639.0,
                        202.0,
                        639.0,
                        240.0,
                        713.5,
                        240.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        97.5,
                        157.0,
                        172.0,
                        157.0,
                        172.0,
                        195.0,
                        330.5,
                        195.0
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
                    ],
                    "midpoints": [
                        254.5,
                        221.0,
                        330.5,
                        221.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        419.5,
                        157.0,
                        337.0,
                        157.0,
                        337.0,
                        195.0,
                        330.5,
                        195.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        570.5,
                        243.5,
                        330.5,
                        243.5
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
                        "obj-11",
                        1
                    ],
                    "destination": [
                        "obj-13",
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