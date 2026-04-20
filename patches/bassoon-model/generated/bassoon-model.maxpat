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
            120.0,
            120.0,
            892.0,
            572.0
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
                    "maxclass": "flonum",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        0.0,
                        50.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        40.0,
                        80.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        30.0,
                        44.0,
                        22.0
                    ],
                    "text": "mtof",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        345.0,
                        120.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~ bassoon",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.slider",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        0.0,
                        39.0,
                        87.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        75.0,
                        80.0,
                        140.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        570.0,
                        30.0,
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
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        540.0,
                        150.0,
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
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        570.0,
                        315.0,
                        51.0,
                        22.0
                    ],
                    "text": "limi~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.gain~",
                    "id": "obj-9",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "signal",
                        "signal",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        540.0,
                        345.0,
                        48.0,
                        136.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        230.0,
                        80.0,
                        140.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        525.0,
                        510.0,
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
                    "maxclass": "live.scope~",
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        390.0,
                        150.0,
                        131.0,
                        131.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        40.0,
                        440.0,
                        200.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "spectroscope~",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        465.0,
                        120.0,
                        300.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        265.0,
                        440.0,
                        200.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        390.0,
                        50.0,
                        50.0
                    ],
                    "_parameter_range": [
                        0.0,
                        1.0
                    ],
                    "_parameter_initial": [
                        0.5
                    ],
                    "_parameter_initial_enable": 1,
                    "_parameter_shortname": "reed_stiff",
                    "_parameter_longname": "reed_stiff"
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
                        195.0,
                        30.0,
                        107.0,
                        22.0
                    ],
                    "text": "reed_stiff $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        150.0,
                        390.0,
                        50.0,
                        50.0
                    ],
                    "_parameter_range": [
                        -1.0,
                        1.0
                    ],
                    "_parameter_initial": [
                        0.0
                    ],
                    "_parameter_initial_enable": 1,
                    "_parameter_shortname": "reed_aper",
                    "_parameter_longname": "reed_aper"
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
                        630.0,
                        30.0,
                        100.0,
                        22.0
                    ],
                    "text": "reed_aper $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-17",
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
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        260.0,
                        390.0,
                        50.0,
                        50.0
                    ],
                    "_parameter_range": [
                        0.0,
                        1.0
                    ],
                    "_parameter_initial": [
                        0.5
                    ],
                    "_parameter_initial_enable": 1,
                    "_parameter_shortname": "bell_bright",
                    "_parameter_longname": "bell_bright"
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
                        435.0,
                        30.0,
                        114.0,
                        22.0
                    ],
                    "text": "bell_bright $1",
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
                        90.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        470.0,
                        50.0,
                        50.0
                    ],
                    "_parameter_range": [
                        0.1,
                        12.0
                    ],
                    "_parameter_initial": [
                        5.0
                    ],
                    "_parameter_initial_enable": 1,
                    "_parameter_shortname": "vib_rate",
                    "_parameter_longname": "vib_rate"
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
                        90.0,
                        30.0,
                        93.0,
                        22.0
                    ],
                    "text": "vib_rate $1",
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
                        315.0,
                        0.0,
                        44.0,
                        66.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        150.0,
                        470.0,
                        50.0,
                        50.0
                    ],
                    "_parameter_range": [
                        0.0,
                        50.0
                    ],
                    "_parameter_initial": [
                        0.0
                    ],
                    "_parameter_initial_enable": 1,
                    "_parameter_shortname": "vib_depth",
                    "_parameter_longname": "vib_depth"
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
                        315.0,
                        30.0,
                        100.0,
                        22.0
                    ],
                    "text": "vib_depth $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
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
                        90.0,
                        0.0,
                        177.0,
                        20.0
                    ],
                    "text": "freq (MIDI, fractional)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        40.0,
                        160.0,
                        20.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-24",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        615.0,
                        0.0,
                        58.0,
                        20.0
                    ],
                    "text": "breath",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        75.0,
                        80.0,
                        20.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        540.0,
                        150.0,
                        107.0,
                        20.0
                    ],
                    "text": "bore waveform",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        245.0,
                        120.0,
                        18.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        780.0,
                        120.0,
                        72.0,
                        20.0
                    ],
                    "text": "spectrum",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        400.0,
                        470.0,
                        120.0,
                        18.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        600.0,
                        345.0,
                        58.0,
                        20.0
                    ],
                    "text": "master",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        230.0,
                        80.0,
                        20.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        255.0,
                        0.0,
                        86.0,
                        20.0
                    ],
                    "text": "reed_stiff",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        92.0,
                        406.0,
                        60.0,
                        18.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        690.0,
                        0.0,
                        79.0,
                        20.0
                    ],
                    "text": "reed_aper",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        202.0,
                        406.0,
                        60.0,
                        18.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-30",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        495.0,
                        0.0,
                        93.0,
                        20.0
                    ],
                    "text": "bell_bright",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        312.0,
                        406.0,
                        60.0,
                        18.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        150.0,
                        0.0,
                        72.0,
                        20.0
                    ],
                    "text": "vib_rate",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        92.0,
                        486.0,
                        60.0,
                        18.0
                    ],
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
                    "maxclass": "comment",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        375.0,
                        0.0,
                        79.0,
                        20.0
                    ],
                    "text": "vib_depth",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        202.0,
                        486.0,
                        60.0,
                        18.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ]
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
                        "obj-3",
                        0
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        52.0,
                        108.5,
                        352.0,
                        108.5
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
                        "obj-4",
                        1
                    ],
                    "midpoints": [
                        577.0,
                        -8.0,
                        562.0,
                        -8.0,
                        562.0,
                        95.0,
                        562.0,
                        -8.0,
                        487.0,
                        -8.0,
                        487.0,
                        74.0,
                        487.0,
                        22.0,
                        557.0,
                        22.0,
                        557.0,
                        60.0,
                        557.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        228.0,
                        459.0,
                        228.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        248.5,
                        -8.0,
                        247.0,
                        -8.0,
                        247.0,
                        74.0,
                        247.0,
                        -8.0,
                        307.0,
                        -8.0,
                        307.0,
                        74.0,
                        307.0,
                        22.0,
                        307.0,
                        22.0,
                        307.0,
                        60.0,
                        352.0,
                        60.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        680.0,
                        -8.0,
                        562.0,
                        -8.0,
                        562.0,
                        95.0,
                        562.0,
                        -8.0,
                        622.0,
                        -8.0,
                        622.0,
                        74.0,
                        622.0,
                        -8.0,
                        487.0,
                        -8.0,
                        487.0,
                        74.0,
                        487.0,
                        -8.0,
                        367.0,
                        -8.0,
                        367.0,
                        74.0,
                        367.0,
                        22.0,
                        562.0,
                        22.0,
                        562.0,
                        60.0,
                        562.0,
                        22.0,
                        557.0,
                        22.0,
                        557.0,
                        60.0,
                        557.0,
                        22.0,
                        423.0,
                        22.0,
                        423.0,
                        60.0,
                        423.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        228.0,
                        352.0,
                        228.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        492.0,
                        -8.0,
                        427.0,
                        -8.0,
                        427.0,
                        74.0,
                        427.0,
                        -8.0,
                        367.0,
                        -8.0,
                        367.0,
                        74.0,
                        367.0,
                        22.0,
                        423.0,
                        22.0,
                        423.0,
                        60.0,
                        423.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        228.0,
                        352.0,
                        228.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        136.5,
                        -8.0,
                        247.0,
                        -8.0,
                        247.0,
                        74.0,
                        247.0,
                        -8.0,
                        142.0,
                        -8.0,
                        142.0,
                        74.0,
                        142.0,
                        -8.0,
                        307.0,
                        -8.0,
                        307.0,
                        74.0,
                        307.0,
                        22.0,
                        187.0,
                        22.0,
                        187.0,
                        60.0,
                        187.0,
                        22.0,
                        307.0,
                        22.0,
                        307.0,
                        60.0,
                        352.0,
                        60.0
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
                        "obj-4",
                        0
                    ],
                    "midpoints": [
                        365.0,
                        -8.0,
                        367.0,
                        -8.0,
                        367.0,
                        74.0,
                        352.0,
                        74.0
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
                        "obj-11",
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
                        "obj-12",
                        0
                    ],
                    "midpoints": [
                        405.5,
                        131.0,
                        472.0,
                        131.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        405.5,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        228.0,
                        457.0,
                        142.0,
                        529.0,
                        142.0,
                        529.0,
                        289.0,
                        529.0,
                        142.0,
                        532.0,
                        142.0,
                        532.0,
                        178.0,
                        547.0,
                        178.0
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
                        569.0,
                        112.0,
                        457.0,
                        112.0,
                        457.0,
                        228.0,
                        457.0,
                        142.0,
                        532.0,
                        142.0,
                        532.0,
                        178.0,
                        577.0,
                        178.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        577.0,
                        341.0,
                        547.0,
                        341.0
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
                        "obj-9",
                        1
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
                        "obj-10",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-9",
                        1
                    ],
                    "destination": [
                        "obj-10",
                        1
                    ],
                    "midpoints": [
                        555.5,
                        495.5,
                        590.0,
                        495.5
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