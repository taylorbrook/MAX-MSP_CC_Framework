{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 5,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            134.0,
            95.0,
            1279.0,
            752.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "id": "obj-3",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1406.0,
                        56.0,
                        420.0,
                        400.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        556.0,
                        1340.0,
                        64.0
                    ],
                    "rounded": 6
                }
            },
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
                        30.0,
                        15.0,
                        493.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        10.0,
                        493.0,
                        24.0
                    ],
                    "text": "BARNETT DBAP  v0.4   two sources -> 8 ch   (A mono, B stereo)",
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
                    "fontsize": 10.0,
                    "id": "obj-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        470.0,
                        20.0,
                        331.0,
                        18.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        515.0,
                        16.0,
                        320.0,
                        18.0
                    ],
                    "text": "Roy Barnett Recital Hall  (OQ4 traced layout)",
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
                    "data": {
                        "name": "Roy Barnett Recital Hall (O-Octagon OQ4 traced layout, not measured)",
                        "units": "metres",
                        "speakers": {
                            "s1": {
                                "x": 0.5,
                                "y": 4.5,
                                "z": 4.5
                            },
                            "s2": {
                                "x": 12.5,
                                "y": 4.5,
                                "z": 4.5
                            },
                            "s3": {
                                "x": 12.5,
                                "y": 9.85,
                                "z": 4.7
                            },
                            "s4": {
                                "x": 12.5,
                                "y": 16.0,
                                "z": 5.1
                            },
                            "s5": {
                                "x": 9.8,
                                "y": 19.5,
                                "z": 5.4
                            },
                            "s6": {
                                "x": 3.2,
                                "y": 19.5,
                                "z": 5.4
                            },
                            "s7": {
                                "x": 0.5,
                                "y": 16.0,
                                "z": 5.1
                            },
                            "s8": {
                                "x": 0.5,
                                "y": 9.85,
                                "z": 4.7
                            }
                        },
                        "rake": {
                            "front": 1.1,
                            "rear": 3.2
                        }
                    },
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [
                        "dictionary",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        70.0,
                        149.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "embed": 1,
                        "legacy": 1,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "dict venue @embed 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        190.0,
                        72.0,
                        415.0,
                        19.0
                    ],
                    "text": "shared venue: read by every instance's dbap.js (Dict API)",
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
                    "args": [
                        "A",
                        1
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-6",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "dbap-source.maxpat",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        30.0,
                        120.0,
                        660.0,
                        500.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        40.0,
                        660.0,
                        500.0
                    ],
                    "varname": "dbap-source[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        "B",
                        2
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-7",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "dbap-source.maxpat",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        720.0,
                        120.0,
                        660.0,
                        500.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        700.0,
                        40.0,
                        660.0,
                        500.0
                    ],
                    "varname": "dbap-source",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        650.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        562.0,
                        66.0,
                        20.0
                    ],
                    "text": "OUTPUT",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "checkedcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ],
                    "id": "obj-9",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        680.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        100.0,
                        570.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        60.0,
                        683.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        136.0,
                        576.0,
                        40.0,
                        19.0
                    ],
                    "text": "DSP",
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
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        720.0,
                        177.0,
                        22.0
                    ],
                    "text": "mc.dac~ 1 2 3 4 5 6 7 8"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1420.0,
                        70.0,
                        93.84,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        562.0,
                        111.0,
                        20.0
                    ],
                    "text": "VERIFY PING",
                    "textcolor": [
                        1.0,
                        0.73,
                        0.24,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "number",
                    "maximum": 8,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1520.0,
                        100.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        584.0,
                        44.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1420.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        272.0,
                        584.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1450.0,
                        102.0,
                        219.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        300.0,
                        586.0,
                        200.0,
                        19.0
                    ],
                    "text": "noise burst to speaker N only",
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
                    "id": "obj-16",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        1420.0,
                        140.0,
                        65.0,
                        22.0
                    ],
                    "text": "t b b b"
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
                        1660.0,
                        190.0,
                        205.0,
                        22.0
                    ],
                    "text": "applyvalues 0 0 0 0 0 0 0 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1520.0,
                        190.0,
                        135.0,
                        22.0
                    ],
                    "text": "pack setvalue 1 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-19",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1520.0,
                        230.0,
                        128.0,
                        22.0
                    ],
                    "text": "mc.sig~ @chans 8"
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
                        1420.0,
                        190.0,
                        72.0,
                        22.0
                    ],
                    "text": "1 0 0 80"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        1420.0,
                        230.0,
                        51.0,
                        22.0
                    ],
                    "text": "line~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        270.0,
                        58.0,
                        22.0
                    ],
                    "text": "noise~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        310.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        1420.0,
                        350.0,
                        65.0,
                        22.0
                    ],
                    "text": "*~ 0.25"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1420.0,
                        400.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        220.0,
                        722.0,
                        303.0,
                        19.0
                    ],
                    "text": "instances + ping sum at the mc.dac~ inlet",
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
                        30.0,
                        98.0,
                        639.0,
                        20.0
                    ],
                    "text": "bpatcher args: <name> <chans>   chans 1 = mono, 2 = stereo (JSON ints, #2 seeds the menu)",
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
                    "destination": [
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        1529.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        94.0,
                        1442.0,
                        94.0,
                        1442.0,
                        129.0,
                        1587.5,
                        129.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        94.0,
                        1442.0,
                        94.0,
                        1442.0,
                        129.0,
                        1429.5,
                        129.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        1475.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        182.0,
                        1512.0,
                        182.0,
                        1512.0,
                        220.0,
                        1512.0,
                        182.0,
                        1500.0,
                        182.0,
                        1500.0,
                        220.0,
                        1669.5,
                        220.0
                    ],
                    "source": [
                        "obj-16",
                        2
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
                        1452.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        182.0,
                        1500.0,
                        182.0,
                        1500.0,
                        220.0,
                        1529.5,
                        220.0
                    ],
                    "source": [
                        "obj-16",
                        1
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
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        1669.5,
                        48.0,
                        1834.0,
                        48.0,
                        1834.0,
                        464.0,
                        1834.0,
                        182.0,
                        1663.0,
                        182.0,
                        1663.0,
                        220.0,
                        1529.5,
                        220.0
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
                        "obj-19",
                        0
                    ],
                    "midpoints": [
                        1529.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1529.5,
                        464.0
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
                        "obj-25",
                        1
                    ],
                    "midpoints": [
                        1529.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        222.0,
                        1479.0,
                        222.0,
                        1479.0,
                        260.0,
                        1479.0,
                        262.0,
                        1486.0,
                        262.0,
                        1486.0,
                        300.0,
                        1486.0,
                        302.0,
                        1470.0,
                        302.0,
                        1470.0,
                        340.0,
                        1470.0,
                        342.0,
                        1493.0,
                        342.0,
                        1493.0,
                        380.0,
                        1461.5,
                        380.0
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
                        "obj-21",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-23",
                        1
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        262.0,
                        1412.0,
                        262.0,
                        1412.0,
                        300.0,
                        1452.5,
                        300.0
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
                        "obj-23",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-25",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1429.5,
                        464.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        1429.5,
                        48.0,
                        1398.0,
                        48.0,
                        1398.0,
                        464.0,
                        1398.0,
                        112.0,
                        698.0,
                        112.0,
                        698.0,
                        628.0,
                        698.0,
                        112.0,
                        712.0,
                        112.0,
                        712.0,
                        628.0,
                        712.0,
                        714.0,
                        531.0,
                        714.0,
                        531.0,
                        749.0,
                        39.5,
                        749.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        714.0,
                        212.0,
                        714.0,
                        212.0,
                        749.0,
                        39.5,
                        749.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        729.5,
                        112.0,
                        698.0,
                        112.0,
                        698.0,
                        628.0,
                        698.0,
                        714.0,
                        531.0,
                        714.0,
                        531.0,
                        749.0,
                        39.5,
                        749.0
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        675.0,
                        108.0,
                        675.0,
                        108.0,
                        710.0,
                        39.5,
                        710.0
                    ],
                    "source": [
                        "obj-9",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-6::obj-136": [
                "width[1]",
                "width",
                0
            ],
            "obj-6::obj-137": [
                "decorr[1]",
                "decorr",
                0
            ],
            "obj-6::obj-30": [
                "rolloff[1]",
                "rolloff",
                0
            ],
            "obj-6::obj-31": [
                "blur[1]",
                "blur",
                0
            ],
            "obj-6::obj-80": [
                "master[1]",
                "master",
                0
            ],
            "obj-7::obj-136": [
                "width",
                "width",
                0
            ],
            "obj-7::obj-137": [
                "decorr",
                "decorr",
                0
            ],
            "obj-7::obj-30": [
                "rolloff",
                "rolloff",
                0
            ],
            "obj-7::obj-31": [
                "blur",
                "blur",
                0
            ],
            "obj-7::obj-80": [
                "master",
                "master",
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
            "parameter_overrides": {
                "obj-6::obj-136": {
                    "parameter_longname": "width[1]"
                },
                "obj-6::obj-137": {
                    "parameter_longname": "decorr[1]"
                },
                "obj-6::obj-30": {
                    "parameter_longname": "rolloff[1]"
                },
                "obj-6::obj-31": {
                    "parameter_longname": "blur[1]"
                },
                "obj-6::obj-80": {
                    "parameter_longname": "master[1]"
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ],
        "editing_bgcolor": [
            0.13,
            0.13,
            0.15,
            1.0
        ]
    }
}