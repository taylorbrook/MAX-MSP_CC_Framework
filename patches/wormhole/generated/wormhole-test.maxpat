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
            1050.0,
            580.0
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
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        15.0,
                        163.0,
                        20.0
                    ],
                    "text": "Wormhole Test Patcher",
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "fontface": 1,
                    "textcolor": [
                        0.2,
                        0.25,
                        0.42,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        10.0,
                        220.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        55.0,
                        24.0,
                        24.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        40.0,
                        24.0,
                        24.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        35.0,
                        51.0,
                        20.0
                    ],
                    "text": "Audio",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        68.0,
                        40.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-4",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        55.0,
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
                    "maxclass": "comment",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        80.0,
                        35.0,
                        51.0,
                        20.0
                    ],
                    "text": "Input",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        60.0,
                        68.0,
                        40.0,
                        18.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        80.0,
                        50.0,
                        100.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        60.0,
                        42.0,
                        100.0,
                        22.0
                    ],
                    "items": [
                        "none",
                        ",",
                        "mic",
                        ",",
                        "soundfile"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        80.0,
                        15.0,
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
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        80.0,
                        35.0,
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
                    "maxclass": "ezadc~",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        200.0,
                        100.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        400.0,
                        70.0,
                        79.0,
                        22.0
                    ],
                    "text": "playlist~",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        170.0,
                        35.0,
                        200.0,
                        55.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        200.0,
                        180.0,
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
                    "id": "obj-12",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        350.0,
                        180.0,
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
                    "maxclass": "bpatcher",
                    "id": "obj-13",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        100.0,
                        240.0,
                        950.0,
                        130.0
                    ],
                    "args": [],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 1,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "viewvisibility": 1,
                    "name": "wormhole.maxpat",
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        100.0,
                        950.0,
                        130.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "live.gain~",
                    "id": "obj-14",
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
                        500.0,
                        400.0,
                        48.0,
                        136.0
                    ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [
                        975.0,
                        100.0,
                        48.0,
                        130.0
                    ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Output Gain",
                            "parameter_shortname": "Gain",
                            "parameter_type": 0,
                            "parameter_mmin": -70.0,
                            "parameter_mmax": 6.0,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                -6.0
                            ],
                            "parameter_unitstyle": 4
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        400.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        1030.0,
                        100.0,
                        10.0,
                        130.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        720.0,
                        400.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        1042.0,
                        100.0,
                        10.0,
                        130.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "ezdac~",
                    "id": "obj-17",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        500.0,
                        500.0,
                        45.0,
                        45.0
                    ],
                    "parameter_enable": 0,
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        15.0,
                        240.0,
                        45.0,
                        45.0
                    ]
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
                        900.0,
                        15.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.0",
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "presentation": 1,
                    "presentation_rect": [
                        970.0,
                        10.0,
                        80.0,
                        18.0
                    ]
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
                        "obj-4",
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
                        "obj-8",
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
                        "obj-11",
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
                        "obj-11",
                        1
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
                        "obj-12",
                        1
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
                        2
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
                        "obj-12",
                        2
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
                        "obj-13",
                        0
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
                        "obj-13",
                        1
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
                        "obj-13",
                        1
                    ],
                    "destination": [
                        "obj-14",
                        1
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
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-14",
                        1
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
                        "obj-2",
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
                        "obj-14",
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
                        "obj-14",
                        1
                    ],
                    "destination": [
                        "obj-17",
                        1
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
        ]
    }
}