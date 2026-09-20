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
            127.0,
            1500.0,
            900.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-185",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
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
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-131",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "multichannelsignal"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
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
                                    "id": "obj-132",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "multichannelsignal"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        140.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "mc.rampsmooth~ 1024 1024"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-183",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-184",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        222.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-132",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        124.0,
                                        59.5,
                                        124.0
                                    ],
                                    "source": [
                                        "obj-131",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-184",
                                        0
                                    ],
                                    "source": [
                                        "obj-132",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-131",
                                        0
                                    ],
                                    "source": [
                                        "obj-183",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        1162.0,
                        698.0,
                        62.0,
                        22.0
                    ],
                    "text": "p mcramp"
                }
            },
            {
                "box": {
                    "id": "obj-182",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
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
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-81",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "dbtoa"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-82",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        130.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "$1 20"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-83",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "signal",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        160.0,
                                        51.0,
                                        22.0
                                    ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-180",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-181",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        242.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-81",
                                        0
                                    ],
                                    "source": [
                                        "obj-180",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-82",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        123.0,
                                        59.5,
                                        123.0
                                    ],
                                    "source": [
                                        "obj-81",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-83",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        153.0,
                                        59.5,
                                        153.0
                                    ],
                                    "source": [
                                        "obj-82",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-181",
                                        0
                                    ],
                                    "source": [
                                        "obj-83",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        900.0,
                        776.0,
                        71.0,
                        22.0
                    ],
                    "text": "p gaininterp"
                }
            },
            {
                "box": {
                    "id": "obj-164",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
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
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-70",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [
                                        "",
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
                                        100.0,
                                        22.0
                                    ],
                                    "restore": [
                                        0
                                    ],
                                    "saved_object_attributes": {
                                        "parameter_enable": 0,
                                        "parameter_mappable": 0
                                    },
                                    "text": "pattr srcpos",
                                    "varname": "srcpos"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-71",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        130.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "prepend srcxy"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-162",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-163",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        212.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-70",
                                        0
                                    ],
                                    "source": [
                                        "obj-162",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-71",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        124.0,
                                        59.5,
                                        124.0
                                    ],
                                    "source": [
                                        "obj-70",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-163",
                                        0
                                    ],
                                    "source": [
                                        "obj-71",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        983.5,
                        570.0,
                        43.0,
                        22.0
                    ],
                    "text": "p pattr",
                    "varname": "patcher"
                }
            },
            {
                "box": {
                    "id": "obj-161",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
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
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-73",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "multichannelsignal"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
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
                                    "id": "obj-74",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "multichannelsignal"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        148.0,
                                        184.0,
                                        22.0
                                    ],
                                    "text": "mc.rampsmooth~ 1024 1024"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-159",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-160",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        242.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-73",
                                        0
                                    ],
                                    "source": [
                                        "obj-159",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-74",
                                        0
                                    ],
                                    "midpoints": [
                                        59.5,
                                        180.0,
                                        59.5,
                                        180.0
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
                                        "obj-160",
                                        0
                                    ],
                                    "source": [
                                        "obj-74",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        701.0,
                        552.0,
                        35.0,
                        22.0
                    ],
                    "text": "p mc"
                }
            },
            {
                "box": {
                    "id": "obj-158",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
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
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-60",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
                                        93.0,
                                        22.0
                                    ],
                                    "text": "speedlim 15"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-61",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        130.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "prepend mouse"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-156",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "list"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-157",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        212.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-60",
                                        0
                                    ],
                                    "source": [
                                        "obj-156",
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
                                        59.5,
                                        124.0,
                                        59.5,
                                        124.0
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
                                        "obj-157",
                                        0
                                    ],
                                    "source": [
                                        "obj-61",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        700.0,
                        443.0,
                        67.0,
                        22.0
                    ],
                    "text": "p speedlim"
                }
            },
            {
                "box": {
                    "id": "obj-155",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
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
                            0.0,
                            0.0,
                            1000.0,
                            780.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-99",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        100.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "pack store 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-100",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        100.0,
                                        107.0,
                                        22.0
                                    ],
                                    "text": "pack recall 1"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-150",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-151",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        138.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-152",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        180.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-153",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "int"
                                    ],
                                    "patching_rect": [
                                        261.0,
                                        40.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-154",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        109.0,
                                        182.0,
                                        30.0,
                                        30.0
                                    ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-154",
                                        0
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
                                        "obj-100",
                                        0
                                    ],
                                    "source": [
                                        "obj-150",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-100",
                                        1
                                    ],
                                    "source": [
                                        "obj-151",
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
                                    "source": [
                                        "obj-152",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-99",
                                        1
                                    ],
                                    "source": [
                                        "obj-153",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-154",
                                        0
                                    ],
                                    "source": [
                                        "obj-99",
                                        0
                                    ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [
                        1524.0,
                        182.0,
                        82.0,
                        22.0
                    ],
                    "text": "p scenespack"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "format": 6,
                    "id": "obj-67",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        980.0,
                        620.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        198.0,
                        344.0,
                        52.0,
                        22.0
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
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "format": 6,
                    "id": "obj-66",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        920.0,
                        620.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        120.0,
                        344.0,
                        48.0,
                        22.0
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
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "format": 6,
                    "id": "obj-65",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        860.0,
                        620.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        42.0,
                        344.0,
                        48.0,
                        22.0
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
                    "bordercolor": [
                        0.62,
                        0.62,
                        0.68,
                        1.0
                    ],
                    "id": "obj-24",
                    "maxclass": "dropfile",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        430.0,
                        100.0,
                        100.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        382.0,
                        94.0,
                        150.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-91",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        741.0,
                        192.25,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        61.0,
                        128.25,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-90",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        741.0,
                        284.5,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        61.0,
                        220.5,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-89",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        781.5,
                        337.0,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        101.5,
                        273.0,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-88",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        880.5,
                        337.0,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        200.5,
                        273.0,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-87",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        921.0,
                        284.5,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        241.0,
                        220.5,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-86",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        921.0,
                        192.25,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        241.0,
                        128.25,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-85",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        921.0,
                        112.0,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        241.0,
                        48.0,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "id": "obj-84",
                    "ignoreclick": 1,
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        741.0,
                        112.0,
                        12.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        61.0,
                        48.0,
                        12.0,
                        58.0
                    ]
                }
            },
            {
                "box": {
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "id": "obj-6",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1226.0,
                        236.0,
                        288.0,
                        190.0
                    ],
                    "rounded": 6
                }
            },
            {
                "box": {
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "id": "obj-5",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1226.0,
                        56.0,
                        288.0,
                        190.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        280.0,
                        348.0,
                        360.0,
                        148.0
                    ],
                    "rounded": 6
                }
            },
            {
                "box": {
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "id": "obj-4",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        686.0,
                        56.0,
                        538.0,
                        592.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        280.0,
                        170.0,
                        360.0,
                        170.0
                    ],
                    "rounded": 6
                }
            },
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
                        16.0,
                        56.0,
                        658.0,
                        470.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        280.0,
                        36.0,
                        360.0,
                        124.0
                    ],
                    "rounded": 6
                }
            },
            {
                "box": {
                    "background": 1,
                    "bgcolor": [
                        0.19,
                        0.19,
                        0.22,
                        1.0
                    ],
                    "id": "obj-2",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        686.0,
                        652.0,
                        600.0,
                        306.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        376.0,
                        240.0,
                        120.0
                    ],
                    "rounded": 6
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        15.0,
                        64.08,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        8.0,
                        300.0,
                        22.0
                    ],
                    "text": "#1",
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "title"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        70.0,
                        60.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        42.0,
                        66.0,
                        20.0
                    ],
                    "text": "SOURCE",
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
                    "comment": "audio in L from host (selector: Inlet)",
                    "id": "obj-8",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        630.0,
                        100.0,
                        30.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.27,
                        0.27,
                        0.31,
                        1.0
                    ],
                    "bgfillcolor_color": [
                        0.27,
                        0.27,
                        0.31,
                        1.0
                    ],
                    "bgfillcolor_type": "color",
                    "id": "obj-9",
                    "items": [
                        "File",
                        ",",
                        "Live",
                        ",",
                        "Inlet"
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
                        80.0,
                        100.0,
                        100.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        64.0,
                        76.0,
                        22.0
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
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        80.0,
                        165.0,
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
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        80.0,
                        260.0,
                        200.0,
                        22.0
                    ],
                    "text": "selector~ 3"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        200.0,
                        100.0,
                        44.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        372.0,
                        64.0,
                        44.0,
                        22.0
                    ],
                    "text": "open"
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        260.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        422.0,
                        64.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        288.0,
                        102.0,
                        44.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        444.0,
                        66.0,
                        32.0,
                        19.0
                    ],
                    "text": "play",
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
                    "id": "obj-15",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        340.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        480.0,
                        64.0,
                        20.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        368.0,
                        102.0,
                        44.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        502.0,
                        66.0,
                        32.0,
                        19.0
                    ],
                    "text": "loop",
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
                    "id": "obj-17",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        340.0,
                        140.0,
                        65.0,
                        22.0
                    ],
                    "text": "loop $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        200.0,
                        210.0,
                        172.0,
                        22.0
                    ],
                    "text": "sfplay~ 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-19",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        550.0,
                        80.0,
                        58.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        96.0,
                        42.0,
                        19.0
                    ],
                    "text": "adc ch",
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
                    "id": "obj-20",
                    "maxclass": "number",
                    "maximum": 64,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        550.0,
                        100.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        334.0,
                        94.0,
                        40.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        550.0,
                        140.0,
                        72.0,
                        22.0
                    ],
                    "text": "set 1 $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        550.0,
                        180.0,
                        72.0,
                        22.0
                    ],
                    "text": "adc~ 1 2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        430.0,
                        145.0,
                        121.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        384.0,
                        96.0,
                        146.0,
                        19.0
                    ],
                    "text": "drop audio file",
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
                    "id": "obj-25",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        430.0,
                        170.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend open"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        80.0,
                        300.0,
                        22.0,
                        140.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        556.0,
                        56.0,
                        22.0,
                        96.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        107.0,
                        300.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        582.0,
                        56.0,
                        12.0,
                        96.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-28",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        130.0,
                        300.0,
                        44.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        598.0,
                        58.0,
                        36.0,
                        19.0
                    ],
                    "text": "trim",
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
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        700.0,
                        70.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        176.0,
                        84.0,
                        20.0
                    ],
                    "text": "POSITION",
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
                    "id": "obj-30",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        970.0,
                        170.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        192.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                4.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "rolloff",
                            "parameter_mmax": 12.0,
                            "parameter_mmin": 3.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "rolloff",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "rolloff"
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
                        1110.0,
                        170.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        360.0,
                        192.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                0.03
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "blur",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "blur",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "blur"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-32",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        970.0,
                        80.0,
                        79.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430.0,
                        196.0,
                        62.0,
                        19.0
                    ],
                    "text": "src Z (m)",
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
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "fontsize": 14.0,
                    "format": 6,
                    "id": "obj-33",
                    "maxclass": "flonum",
                    "maximum": 15.0,
                    "minimum": -3.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        970.0,
                        100.0,
                        50.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        430.0,
                        216.0,
                        62.0,
                        24.0
                    ],
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "srcz"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        970.0,
                        250.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend rolloff"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1110.0,
                        250.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend blur"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        970.0,
                        130.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend srcz"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1240.0,
                        70.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        352.0,
                        75.0,
                        20.0
                    ],
                    "text": "WEIGHTS",
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
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "contdata": 1,
                    "id": "obj-38",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1240.0,
                        100.0,
                        240.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        370.0,
                        340.0,
                        42.0
                    ],
                    "setminmax": [
                        0.0,
                        1.0
                    ],
                    "setstyle": 1,
                    "size": 8,
                    "slidercolor": [
                        0.35,
                        0.78,
                        1.0,
                        1.0
                    ],
                    "varname": "weights"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-39",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1250.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        305.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "1",
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
                    "fontsize": 9.0,
                    "id": "obj-40",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1280.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        347.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "2",
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
                    "fontsize": 9.0,
                    "id": "obj-41",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1310.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "3",
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
                    "fontsize": 9.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1340.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        433.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "4",
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
                    "fontsize": 9.0,
                    "id": "obj-43",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1370.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        475.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "5",
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
                    "fontsize": 9.0,
                    "id": "obj-44",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1400.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        517.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "6",
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
                    "fontsize": 9.0,
                    "id": "obj-45",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1430.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        560.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "7",
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
                    "fontsize": 9.0,
                    "id": "obj-46",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1460.0,
                        184.0,
                        40.0,
                        17.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        603.25,
                        413.0,
                        16.0,
                        17.0
                    ],
                    "text": "8",
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
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1240.0,
                        210.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend weights"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1240.0,
                        250.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        429.0,
                        93.0,
                        20.0
                    ],
                    "text": "TRIMS  dB",
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
                    "bgcolor": [
                        0.1,
                        0.1,
                        0.12,
                        1.0
                    ],
                    "contdata": 1,
                    "id": "obj-49",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1240.0,
                        280.0,
                        240.0,
                        80.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        448.0,
                        340.0,
                        42.0
                    ],
                    "setminmax": [
                        -24.0,
                        12.0
                    ],
                    "setstyle": 1,
                    "signed": 1,
                    "size": 8,
                    "slidercolor": [
                        0.35,
                        0.78,
                        1.0,
                        1.0
                    ],
                    "varname": "trims"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "id": "obj-50",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1250.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "1",
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
                    "fontsize": 9.0,
                    "id": "obj-51",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1280.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "2",
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
                    "fontsize": 9.0,
                    "id": "obj-52",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1310.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "3",
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
                    "fontsize": 9.0,
                    "id": "obj-53",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1340.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "4",
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
                    "fontsize": 9.0,
                    "id": "obj-54",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1370.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "5",
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
                    "fontsize": 9.0,
                    "id": "obj-55",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1400.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "6",
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
                    "fontsize": 9.0,
                    "id": "obj-56",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1430.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "7",
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
                    "fontsize": 9.0,
                    "id": "obj-57",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1460.0,
                        364.0,
                        40.0,
                        17.0
                    ],
                    "text": "8",
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
                    "id": "obj-58",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1240.0,
                        390.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend trims"
                }
            },
            {
                "box": {
                    "border": 0,
                    "id": "obj-59",
                    "local": 0,
                    "maxclass": "lcd",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [
                        "list",
                        "list",
                        "int",
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        100.0,
                        240.0,
                        300.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        36.0,
                        240.0,
                        300.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-62",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        860.0,
                        600.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        20.0,
                        346.0,
                        26.0,
                        19.0
                    ],
                    "text": "x m",
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
                    "fontsize": 11.0,
                    "id": "obj-63",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        920.0,
                        600.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        98.0,
                        346.0,
                        26.0,
                        19.0
                    ],
                    "text": "y m",
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
                    "fontsize": 11.0,
                    "id": "obj-64",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        980.0,
                        600.0,
                        40.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        176.0,
                        346.0,
                        20.0,
                        19.0
                    ],
                    "text": "z",
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
                    "id": "obj-68",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        860.0,
                        540.0,
                        107.0,
                        22.0
                    ],
                    "text": "route pos nxy"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-69",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "float",
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        860.0,
                        570.0,
                        116.0,
                        22.0
                    ],
                    "text": "unpack f f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-72",
                    "maxclass": "newobj",
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
                        700.0,
                        500.0,
                        135.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "dbap.js",
                        "parameter_enable": 0
                    },
                    "text": "js dbap.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-75",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        700.0,
                        597.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-76",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        700.5,
                        698.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-77",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        900.0,
                        855.0,
                        210.0,
                        22.0
                    ],
                    "text": "mc.unpack~ 8"
                }
            },
            {
                "box": {
                    "comment": "8-channel mc signal (speakers 1-8) -> host mc.dac~",
                    "id": "obj-78",
                    "index": 0,
                    "maxclass": "outlet",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        700.0,
                        920.0,
                        30.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-79",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        900.0,
                        660.0,
                        59.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        382.0,
                        66.0,
                        20.0
                    ],
                    "text": "MASTER",
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
                    "id": "obj-80",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        900.0,
                        680.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        30.0,
                        402.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "master",
                            "parameter_mmax": 0.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "master",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "master"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1524.0,
                        70.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        382.0,
                        66.0,
                        20.0
                    ],
                    "text": "SCENES",
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
                    "id": "obj-93",
                    "maxclass": "number",
                    "maximum": 64,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1524.0,
                        100.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        404.0,
                        44.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-94",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        1524.0,
                        140.0,
                        51.0,
                        22.0
                    ],
                    "text": "t i i"
                }
            },
            {
                "box": {
                    "id": "obj-95",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1674.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        160.0,
                        404.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-96",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1700.0,
                        102.0,
                        51.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        186.0,
                        406.0,
                        44.0,
                        19.0
                    ],
                    "text": "store",
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
                    "id": "obj-97",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        1584.0,
                        100.0,
                        22.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        160.0,
                        434.0,
                        22.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-98",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1610.0,
                        102.0,
                        58.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        186.0,
                        436.0,
                        50.0,
                        19.0
                    ],
                    "text": "recall",
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
                    "id": "obj-101",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1764.0,
                        100.0,
                        44.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        434.0,
                        44.0,
                        22.0
                    ],
                    "text": "read"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1816.0,
                        100.0,
                        51.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        110.0,
                        462.0,
                        44.0,
                        22.0
                    ],
                    "text": "write"
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
                        1524.0,
                        230.0,
                        205.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "pattrstorage #1 @savemode 0",
                    "varname": "#1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
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
                        1744.0,
                        230.0,
                        79.0,
                        22.0
                    ],
                    "restore": {
                        "air": [
                            0.35
                        ],
                        "blur": [
                            0.03
                        ],
                        "decorr": [
                            0.0
                        ],
                        "hull": [
                            1.0
                        ],
                        "master": [
                            0.0
                        ],
                        "rolloff": [
                            4.0
                        ],
                        "srcz": [
                            0.0
                        ],
                        "trims": [
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0,
                            0.0
                        ],
                        "weights": [
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0,
                            1.0
                        ],
                        "width": [
                            0.0
                        ]
                    },
                    "text": "autopattr",
                    "varname": "u138001749"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-105",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        1900.0,
                        100.0,
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
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 13,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        1900.0,
                        140.0,
                        205.0,
                        22.0
                    ],
                    "text": "t b b b b b b b b b b b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1900.0,
                        180.0,
                        58.0,
                        22.0
                    ],
                    "text": "set #1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-108",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1970.0,
                        180.0,
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
                    "id": "obj-109",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2022.0,
                        180.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-110",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2074.0,
                        180.0,
                        44.0,
                        22.0
                    ],
                    "text": "0.03"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-111",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2130.0,
                        180.0,
                        40.0,
                        22.0
                    ],
                    "text": "4."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-112",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2182.0,
                        180.0,
                        40.0,
                        22.0
                    ],
                    "text": "127"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-113",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2234.0,
                        180.0,
                        121.0,
                        22.0
                    ],
                    "text": "0 0 0 0 0 0 0 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-114",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2367.0,
                        180.0,
                        177.0,
                        22.0
                    ],
                    "text": "1. 1. 1. 1. 1. 1. 1. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-115",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1900.0,
                        70.0,
                        226.0,
                        20.0
                    ],
                    "text": "INIT (loadbang, right to left)",
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
                    "comment": "audio in R from host (selector: Inlet; used when chans = stereo)",
                    "id": "obj-116",
                    "index": 0,
                    "maxclass": "inlet",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        663.0,
                        130.0,
                        30.0,
                        30.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-117",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        80.0,
                        132.0,
                        51.0,
                        22.0
                    ],
                    "text": "t i i"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-118",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        420.0,
                        215.0,
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
                    "id": "obj-119",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        420.0,
                        260.0,
                        80.0,
                        22.0
                    ],
                    "text": "selector~ 3"
                }
            },
            {
                "box": {
                    "id": "obj-120",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        140.0,
                        300.0,
                        22.0,
                        140.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-121",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        170.0,
                        330.0,
                        289.0,
                        20.0
                    ],
                    "text": "R trim slaved to L (gain~ right outlet)",
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
                    "id": "obj-122",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        600.0,
                        220.0,
                        93.0,
                        22.0
                    ],
                    "text": "loadmess #2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-123",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        600.0,
                        250.0,
                        37.0,
                        22.0
                    ],
                    "text": "- 1"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.27,
                        0.27,
                        0.31,
                        1.0
                    ],
                    "bgfillcolor_color": [
                        0.27,
                        0.27,
                        0.31,
                        1.0
                    ],
                    "bgfillcolor_type": "color",
                    "id": "obj-124",
                    "items": [
                        "mono",
                        ",",
                        "stereo"
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
                        600.0,
                        280.0,
                        80.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        124.0,
                        76.0,
                        22.0
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
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-125",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        685.0,
                        282.0,
                        51.0,
                        19.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        372.0,
                        126.0,
                        44.0,
                        19.0
                    ],
                    "text": "chans",
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
                    "id": "obj-126",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        690.0,
                        222.0,
                        345.0,
                        20.0
                    ],
                    "text": "bpatcher arg 2 seeds the menu: 1 mono, 2 stereo",
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
                    "id": "obj-127",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        600.0,
                        310.0,
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
                    "id": "obj-128",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        200.0,
                        460.0,
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
                    "id": "obj-129",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 5,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "dsp.gen",
                        "rect": [
                            100.0,
                            100.0,
                            680.0,
                            862.0
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
                                        50.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        130.0,
                                        20.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2"
                                }
                            },
                            {
                                "box": {
                                    "code": "// barnett-dbap v0.4 air filter + decorrelator -- ports of O-Octagon GainStage step 6 (D19)\n// and Decorrelator.h (D18)\n// in1 = L feed, in2 = R feed; out1 / out2 = the two feeds at 0.5 (GainStage level convention).\n// Four Schroeder all-pass sections per feed, g = 0.7, bases in samples at 48 kHz scaled by\n// samplerate: L {113, 199, 317, 449}, R {139, 233, 359, 521}. depth (0..1, from js =\n// decorr * min(wEff / 2 m, 1)) scales the DELAY LENGTHS (integer reads, floor >= 1), so at\n// depth 0 both chains collapse to the same one-sample filter and the pair stays correlated.\n// A 5 ms linear slew on depth and a 5 ms 0/1 crossfade (the plugin's decorrMix gate) mean the\n// chains are bypassed bit-exactly once depth is 0. `one` is a never-written History so no\n// Param-only expression is hoisted (CLAUDE.md hoisting rule).\nParam depth(0, min=0, max=1);\nParam fcl(0, min=0, max=20000);\nParam fcr(0, min=0, max=20000);\nDelay dl1(4096);\nDelay dl2(4096);\nDelay dl3(4096);\nDelay dl4(4096);\nDelay dr1(4096);\nDelay dr2(4096);\nDelay dr3(4096);\nDelay dr4(4096);\nHistory one(1);\nHistory dprev(0);\nHistory mprev(0);\nHistory lpl(0);\nHistory lpr(0);\nHistory fclprev(0);\nHistory fcrprev(0);\nHistory alprev(0);\nHistory arprev(0);\n\n// ---- per-sample setup (hoist guard) ----\nsrs = samplerate * one;\nk_depth = depth * one;\nk_fcl = fcl * one;\nk_fcr = fcr * one;\nstep = 1 / (0.005 * srs);\nscale = srs / 48000;\ng = 0.7;\n\n// ---- 5 ms slews: depth, and the 0/1 engage crossfade ----\nddelta = clamp(k_depth - dprev, 0 - step, step);\ndep = dprev + ddelta;\ndprev = dep;\nwanted = 0;\nif (k_depth > 0) {\n    wanted = 1;\n}\nmdelta = clamp(wanted - mprev, 0 - step, step);\nmix = mprev + mdelta;\nmprev = mix;\n\n// ---- integer delay lengths, floor 1 sample, rail 4095 ----\nn1 = clamp(floor(113 * scale * dep + 0.5), 1, 4095);\nn2 = clamp(floor(199 * scale * dep + 0.5), 1, 4095);\nn3 = clamp(floor(317 * scale * dep + 0.5), 1, 4095);\nn4 = clamp(floor(449 * scale * dep + 0.5), 1, 4095);\nm1 = clamp(floor(139 * scale * dep + 0.5), 1, 4095);\nm2 = clamp(floor(233 * scale * dep + 0.5), 1, 4095);\nm3 = clamp(floor(359 * scale * dep + 0.5), 1, 4095);\nm4 = clamp(floor(521 * scale * dep + 0.5), 1, 4095);\n\nxl = in1;\nxr = in2;\n\n// ---- v0.4 air filter: one-pole TPT lowpass per feed, BEFORE the decorrelator (GainStage step 6) ----\n// fcl / fcr in Hz from js; 0 = skip (air 0 or inside the near field) -> the feed passes bit-exact.\n// The engage edge seeds the state with x, so v = G*(x - s) = 0 and y = x on the edge sample.\n// The cutoff is slewed (one-pole, 10 ms) because js updates arrive at mouse rate rather than on\n// the plugin's 64-sample grid; it snaps on the engage edge. Ceiling min(20 kHz, 0.45 fs).\n// Branch-free filter math; the ifs only select (codebox safe-construct rules).\nfceil = min(20000, 0.45 * srs);\nfcoef = 1 - exp(-1 / (0.010 * srs));\nactl = 0;\nif (k_fcl > 0) {\n    actl = 1;\n}\nactr = 0;\nif (k_fcr > 0) {\n    actr = 1;\n}\nfcls = fclprev + (k_fcl - fclprev) * fcoef;\nlpls = lpl;\nif (actl > 0.5 && alprev < 0.5) {\n    fcls = k_fcl;\n    lpls = xl;\n}\ntanl = tan(pi * clamp(fcls, 20, fceil) / srs);\nbigl = tanl / (1 + tanl);\nvl = bigl * (xl - lpls);\nlowl = vl + lpls;\nlpl = fixnan(lowl + vl);\nfclprev = fcls;\nalprev = actl;\nairl = xl;\nif (actl > 0.5) {\n    airl = lowl;\n}\nfcrs = fcrprev + (k_fcr - fcrprev) * fcoef;\nlprs = lpr;\nif (actr > 0.5 && arprev < 0.5) {\n    fcrs = k_fcr;\n    lprs = xr;\n}\ntanr = tan(pi * clamp(fcrs, 20, fceil) / srs);\nbigr = tanr / (1 + tanr);\nvr = bigr * (xr - lprs);\nlowr = vr + lprs;\nlpr = fixnan(lowr + vr);\nfcrprev = fcrs;\narprev = actr;\nairr = xr;\nif (actr > 0.5) {\n    airr = lowr;\n}\n\n// ---- left chain: read before write; w = x + g*delayed; y = delayed - g*w ----\nt1 = dl1.read(n1);\nw1 = airl + g * t1;\ndl1.write(w1);\ny1 = t1 - g * w1;\nt2 = dl2.read(n2);\nw2 = y1 + g * t2;\ndl2.write(w2);\ny2 = t2 - g * w2;\nt3 = dl3.read(n3);\nw3 = y2 + g * t3;\ndl3.write(w3);\ny3 = t3 - g * w3;\nt4 = dl4.read(n4);\nw4 = y3 + g * t4;\ndl4.write(w4);\nyl = t4 - g * w4;\n\n// ---- right chain ----\nu1 = dr1.read(m1);\nv1 = airr + g * u1;\ndr1.write(v1);\nz1 = u1 - g * v1;\nu2 = dr2.read(m2);\nv2 = z1 + g * u2;\ndr2.write(v2);\nz2 = u2 - g * v2;\nu3 = dr3.read(m3);\nv3 = z2 + g * u3;\ndr3.write(v3);\nz3 = u3 - g * v3;\nu4 = dr4.read(m4);\nv4 = z3 + g * u4;\ndr4.write(v4);\nyr = u4 - g * v4;\n\n// ---- lerp crossfade (bit-exact dry at mix 0), feeds at 0.5 ----\nout1 = 0.5 * (airl + mix * (yl - airl));\nout2 = 0.5 * (airr + mix * (yr - airr));\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "codebox",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        581.0,
                                        414.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        50.0,
                                        545.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        130.0,
                                        545.0,
                                        35.0,
                                        22.0
                                    ],
                                    "text": "out 2"
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
                                    "midpoints": [
                                        59.5,
                                        45.0,
                                        59.5,
                                        45.0
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
                                        1
                                    ],
                                    "midpoints": [
                                        139.5,
                                        66.0,
                                        621.5,
                                        66.0
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
                                    "midpoints": [
                                        59.5,
                                        489.0,
                                        59.5,
                                        489.0
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
                                        "obj-5",
                                        0
                                    ],
                                    "midpoints": [
                                        621.5,
                                        531.0,
                                        139.5,
                                        531.0
                                    ],
                                    "source": [
                                        "obj-3",
                                        1
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
                        80.0,
                        490.0,
                        120.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-130",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        210.0,
                        492.0,
                        499.0,
                        33.0
                    ],
                    "text": "air filter (TPT one-pole per feed, fcl / fcr Hz from js, 0 = skip) -> decorrelator: 4 Schroeder all-passes per feed, feeds out at 0.5 (D18, D19)",
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
                    "id": "obj-133",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        1130.0,
                        740.0,
                        51.0,
                        22.0
                    ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-134",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "multichannelsignal"
                    ],
                    "patching_rect": [
                        700.5,
                        638.0,
                        66.0,
                        22.0
                    ],
                    "text": "mc.+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-135",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        1130.0,
                        640.0,
                        226.0,
                        20.0
                    ],
                    "text": "R sub-point lane (js outlet 3)",
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
                    "id": "obj-136",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        970.0,
                        300.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        500.0,
                        192.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "width",
                            "parameter_mmax": 12.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "width",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "width"
                }
            },
            {
                "box": {
                    "id": "obj-137",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        1110.0,
                        300.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        565.0,
                        192.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                0.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "decorr",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "decorr",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "decorr"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-138",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        970.0,
                        380.0,
                        107.0,
                        22.0
                    ],
                    "text": "prepend width"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-139",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1110.0,
                        380.0,
                        114.0,
                        22.0
                    ],
                    "text": "prepend decorr"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-140",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        970.0,
                        280.0,
                        415.0,
                        20.0
                    ],
                    "text": "width m (0..12)  /  decorr (0..1)  -> js -> depth to gen~",
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
                    "id": "obj-141",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2560.0,
                        180.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-142",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2612.0,
                        180.0,
                        40.0,
                        22.0
                    ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "id": "obj-143",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        970.0,
                        430.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        290.0,
                        266.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                0.35
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "air",
                            "parameter_mmax": 1.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "air",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "air"
                }
            },
            {
                "box": {
                    "id": "obj-144",
                    "maxclass": "live.dial",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "float"
                    ],
                    "parameter_enable": 1,
                    "patching_rect": [
                        1110.0,
                        430.0,
                        60.0,
                        48.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        360.0,
                        266.0,
                        60.0,
                        48.0
                    ],
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [
                                1.0
                            ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "hull",
                            "parameter_mmax": 3.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "hull",
                            "parameter_type": 0,
                            "parameter_unitstyle": 1
                        }
                    },
                    "textcolor": [
                        0.8,
                        0.8,
                        0.82,
                        1.0
                    ],
                    "varname": "hull"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-145",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        970.0,
                        510.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend air"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-146",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        1110.0,
                        510.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend hull"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-147",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        970.0,
                        410.0,
                        527.0,
                        20.0
                    ],
                    "text": "air (0..1, 0 = filter skipped)  /  hull trim dB per m (0..3)  -> js (D19)",
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
                    "id": "obj-148",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2664.0,
                        180.0,
                        44.0,
                        22.0
                    ],
                    "text": "0.35"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-149",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        2720.0,
                        180.0,
                        40.0,
                        22.0
                    ],
                    "text": "1."
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-186",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        800.0,
                        62.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "motion dx dy dz + trace from a dbap-motion module (optional)",
                    "index": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-187",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        836.0,
                        40.0,
                        478.0,
                        20.0
                    ],
                    "text": "motion in (dbap-motion): offset in metres added to the anchor, D21",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                    "id": "obj-188",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        790.0,
                        443.0,
                        142.0,
                        22.0
                    ],
                    "text": "receive dbap-venue",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-189",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        1524.0,
                        206.0,
                        51.0,
                        22.0
                    ],
                    "text": "t l l",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-190",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        780.0,
                        920.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "store N / recall N -> dbap-motion inlet (one recall restores position AND motion)",
                    "index": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-191",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        816.0,
                        926.0,
                        219.0,
                        20.0
                    ],
                    "text": "scene cord out -> dbap-motion",
                    "fontname": "Arial",
                    "fontsize": 11.0,
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
                        "obj-11",
                        0
                    ],
                    "midpoints": [
                        89.5,
                        189.0,
                        89.5,
                        189.0
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
                        "obj-103",
                        0
                    ],
                    "midpoints": [
                        1773.5,
                        216.0,
                        1533.5,
                        216.0
                    ],
                    "source": [
                        "obj-101",
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
                        1825.5,
                        216.0,
                        1533.5,
                        216.0
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
                        "obj-106",
                        0
                    ],
                    "midpoints": [
                        1909.5,
                        123.0,
                        1909.5,
                        123.0
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
                        1925.0,
                        165.0,
                        1911.0,
                        165.0,
                        1911.0,
                        177.0,
                        1909.5,
                        177.0
                    ],
                    "source": [
                        "obj-106",
                        1
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
                        1940.5,
                        177.0,
                        1979.5,
                        177.0
                    ],
                    "source": [
                        "obj-106",
                        2
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
                        1956.0,
                        177.0,
                        2031.5,
                        177.0
                    ],
                    "source": [
                        "obj-106",
                        3
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
                        1971.5,
                        177.0,
                        2083.5,
                        177.0
                    ],
                    "source": [
                        "obj-106",
                        4
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
                        1987.0,
                        165.0,
                        2139.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-112",
                        0
                    ],
                    "midpoints": [
                        2002.5,
                        165.0,
                        2191.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-113",
                        0
                    ],
                    "midpoints": [
                        2018.0,
                        165.0,
                        2243.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-114",
                        0
                    ],
                    "midpoints": [
                        2033.5,
                        165.0,
                        2376.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-141",
                        0
                    ],
                    "midpoints": [
                        2049.0,
                        165.0,
                        2569.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-142",
                        0
                    ],
                    "midpoints": [
                        2064.5,
                        165.0,
                        2621.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-148",
                        0
                    ],
                    "midpoints": [
                        2080.0,
                        165.0,
                        2673.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-149",
                        0
                    ],
                    "midpoints": [
                        2095.5,
                        165.0,
                        2729.5,
                        165.0
                    ],
                    "source": [
                        "obj-106",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        1909.5,
                        165.0,
                        1833.0,
                        165.0,
                        1833.0,
                        495.0,
                        709.5,
                        495.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        1909.5,
                        204.0,
                        1878.0,
                        204.0,
                        1878.0,
                        0.0,
                        39.5,
                        0.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        1979.5,
                        213.0,
                        1878.0,
                        213.0,
                        1878.0,
                        42.0,
                        105.0,
                        42.0,
                        105.0,
                        87.0,
                        90.0,
                        87.0,
                        90.0,
                        96.0,
                        89.5,
                        96.0
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
                        "obj-80",
                        0
                    ],
                    "midpoints": [
                        2031.5,
                        441.0,
                        909.5,
                        441.0
                    ],
                    "source": [
                        "obj-109",
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
                        89.5,
                        285.0,
                        89.5,
                        285.0
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
                        "obj-31",
                        0
                    ],
                    "midpoints": [
                        2083.5,
                        213.0,
                        1878.0,
                        213.0,
                        1878.0,
                        42.0,
                        1119.5,
                        42.0
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
                        "obj-30",
                        0
                    ],
                    "midpoints": [
                        2139.5,
                        213.0,
                        1878.0,
                        213.0,
                        1878.0,
                        42.0,
                        1080.0,
                        42.0,
                        1080.0,
                        165.0,
                        979.5,
                        165.0
                    ],
                    "source": [
                        "obj-111",
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
                        2191.5,
                        213.0,
                        1878.0,
                        213.0,
                        1878.0,
                        42.0,
                        180.0,
                        42.0,
                        180.0,
                        246.0,
                        66.0,
                        246.0,
                        66.0,
                        297.0,
                        89.5,
                        297.0
                    ],
                    "source": [
                        "obj-112",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-49",
                        0
                    ],
                    "midpoints": [
                        2243.5,
                        267.0,
                        1320.0,
                        267.0,
                        1320.0,
                        273.0,
                        1249.5,
                        273.0
                    ],
                    "source": [
                        "obj-113",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-38",
                        0
                    ],
                    "midpoints": [
                        2376.5,
                        216.0,
                        1500.0,
                        216.0,
                        1500.0,
                        87.0,
                        1305.0,
                        87.0,
                        1305.0,
                        96.0,
                        1249.5,
                        96.0
                    ],
                    "source": [
                        "obj-114",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-119",
                        3
                    ],
                    "midpoints": [
                        672.5,
                        207.0,
                        585.0,
                        207.0,
                        585.0,
                        246.0,
                        490.5,
                        246.0
                    ],
                    "source": [
                        "obj-116",
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
                        89.5,
                        156.0,
                        89.5,
                        156.0
                    ],
                    "source": [
                        "obj-117",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-118",
                        0
                    ],
                    "midpoints": [
                        121.5,
                        165.0,
                        327.0,
                        165.0,
                        327.0,
                        195.0,
                        417.0,
                        195.0,
                        417.0,
                        207.0,
                        429.5,
                        207.0
                    ],
                    "source": [
                        "obj-117",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-119",
                        0
                    ],
                    "midpoints": [
                        429.5,
                        240.0,
                        429.5,
                        240.0
                    ],
                    "source": [
                        "obj-118",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-120",
                        0
                    ],
                    "midpoints": [
                        429.5,
                        297.0,
                        149.5,
                        297.0
                    ],
                    "source": [
                        "obj-119",
                        0
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
                        209.5,
                        123.0,
                        209.5,
                        123.0
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
                        "obj-128",
                        2
                    ],
                    "midpoints": [
                        149.5,
                        441.0,
                        350.5,
                        441.0
                    ],
                    "source": [
                        "obj-120",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-123",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        243.0,
                        609.5,
                        243.0
                    ],
                    "source": [
                        "obj-122",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-124",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        273.0,
                        609.5,
                        273.0
                    ],
                    "source": [
                        "obj-123",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-127",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        303.0,
                        609.5,
                        303.0
                    ],
                    "source": [
                        "obj-124",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-128",
                        0
                    ],
                    "midpoints": [
                        609.5,
                        447.0,
                        209.5,
                        447.0
                    ],
                    "source": [
                        "obj-127",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-129",
                        1
                    ],
                    "midpoints": [
                        209.5,
                        483.0,
                        190.5,
                        483.0
                    ],
                    "source": [
                        "obj-128",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-133",
                        0
                    ],
                    "midpoints": [
                        190.5,
                        738.0,
                        1125.0,
                        738.0,
                        1125.0,
                        735.0,
                        1139.5,
                        735.0
                    ],
                    "source": [
                        "obj-129",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-75",
                        0
                    ],
                    "midpoints": [
                        89.5,
                        594.0,
                        709.5,
                        594.0
                    ],
                    "source": [
                        "obj-129",
                        0
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
                        269.5,
                        195.0,
                        209.5,
                        195.0
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
                        "obj-134",
                        1
                    ],
                    "midpoints": [
                        1139.5,
                        765.0,
                        963.0,
                        765.0,
                        963.0,
                        738.0,
                        762.0,
                        738.0,
                        762.0,
                        672.0,
                        757.0,
                        672.0
                    ],
                    "source": [
                        "obj-133",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-76",
                        0
                    ],
                    "midpoints": [
                        710.0,
                        663.0,
                        710.0,
                        663.0
                    ],
                    "source": [
                        "obj-134",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-138",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        351.0,
                        979.5,
                        351.0
                    ],
                    "source": [
                        "obj-136",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-139",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        351.0,
                        1119.5,
                        351.0
                    ],
                    "source": [
                        "obj-137",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        405.0,
                        951.0,
                        405.0,
                        951.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
                    ],
                    "source": [
                        "obj-138",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        405.0,
                        1089.0,
                        405.0,
                        1089.0,
                        366.0,
                        951.0,
                        366.0,
                        951.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
                    ],
                    "source": [
                        "obj-139",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-136",
                        0
                    ],
                    "midpoints": [
                        2569.5,
                        251.0,
                        979.5,
                        251.0
                    ],
                    "source": [
                        "obj-141",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-137",
                        0
                    ],
                    "midpoints": [
                        2621.5,
                        251.0,
                        1119.5,
                        251.0
                    ],
                    "source": [
                        "obj-142",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-145",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        480.0,
                        979.5,
                        480.0
                    ],
                    "source": [
                        "obj-143",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-146",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        480.0,
                        1119.5,
                        480.0
                    ],
                    "source": [
                        "obj-144",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        534.0,
                        957.0,
                        534.0,
                        957.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
                    ],
                    "source": [
                        "obj-145",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        534.0,
                        1077.0,
                        534.0,
                        1077.0,
                        495.0,
                        709.5,
                        495.0
                    ],
                    "source": [
                        "obj-146",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-143",
                        0
                    ],
                    "midpoints": [
                        2673.5,
                        489.0,
                        957.0,
                        489.0,
                        957.0,
                        426.0,
                        979.5,
                        426.0
                    ],
                    "source": [
                        "obj-148",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-144",
                        0
                    ],
                    "midpoints": [
                        2729.5,
                        316.0,
                        1119.5,
                        316.0
                    ],
                    "source": [
                        "obj-149",
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
                        349.5,
                        123.0,
                        349.5,
                        123.0
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
                        "obj-72",
                        0
                    ],
                    "source": [
                        "obj-158",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-75",
                        1
                    ],
                    "midpoints": [
                        710.5,
                        594.0,
                        741.5,
                        594.0
                    ],
                    "source": [
                        "obj-161",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        993.0,
                        594.0,
                        978.0,
                        594.0,
                        978.0,
                        534.0,
                        957.0,
                        534.0,
                        957.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
                    ],
                    "source": [
                        "obj-164",
                        0
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
                        349.5,
                        195.0,
                        209.5,
                        195.0
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
                        "obj-11",
                        1
                    ],
                    "midpoints": [
                        209.5,
                        246.0,
                        149.83333333333334,
                        246.0
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
                        "obj-76",
                        1
                    ],
                    "midpoints": [
                        909.5,
                        801.0,
                        762.0,
                        801.0,
                        762.0,
                        693.0,
                        742.0,
                        693.0
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
                        "obj-133",
                        1
                    ],
                    "source": [
                        "obj-185",
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
                        559.5,
                        123.0,
                        559.5,
                        123.0
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
                        559.5,
                        165.0,
                        559.5,
                        165.0
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
                        "obj-11",
                        2
                    ],
                    "midpoints": [
                        559.5,
                        246.0,
                        210.16666666666669,
                        246.0
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
                        "obj-119",
                        2
                    ],
                    "midpoints": [
                        612.5,
                        204.0,
                        585.0,
                        204.0,
                        585.0,
                        246.0,
                        470.1666666666667,
                        246.0
                    ],
                    "source": [
                        "obj-22",
                        1
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
                        439.5,
                        141.0,
                        426.0,
                        141.0,
                        426.0,
                        165.0,
                        439.5,
                        165.0
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
                        "obj-18",
                        0
                    ],
                    "midpoints": [
                        439.5,
                        195.0,
                        209.5,
                        195.0
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
                        "obj-120",
                        0
                    ],
                    "midpoints": [
                        93.0,
                        441.0,
                        126.0,
                        441.0,
                        126.0,
                        297.0,
                        149.5,
                        297.0
                    ],
                    "source": [
                        "obj-26",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-128",
                        1
                    ],
                    "midpoints": [
                        89.5,
                        456.0,
                        280.0,
                        456.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-129",
                        0
                    ],
                    "midpoints": [
                        89.5,
                        441.0,
                        89.5,
                        441.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-26",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-27",
                        0
                    ],
                    "midpoints": [
                        89.5,
                        441.0,
                        66.0,
                        441.0,
                        66.0,
                        297.0,
                        116.0,
                        297.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-26",
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
                        979.5,
                        219.0,
                        1035.0,
                        219.0,
                        1035.0,
                        246.0,
                        979.5,
                        246.0
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
                        "obj-35",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        219.0,
                        1119.5,
                        219.0
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
                        "obj-36",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        126.0,
                        979.5,
                        126.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        273.0,
                        951.0,
                        273.0,
                        951.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        1119.5,
                        273.0,
                        951.0,
                        273.0,
                        951.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        979.5,
                        165.0,
                        1047.0,
                        165.0,
                        1047.0,
                        246.0,
                        957.0,
                        246.0,
                        957.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
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
                        "obj-47",
                        0
                    ],
                    "midpoints": [
                        1249.5,
                        183.0,
                        1245.0,
                        183.0,
                        1245.0,
                        207.0,
                        1249.5,
                        207.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        1249.5,
                        234.0,
                        1236.0,
                        234.0,
                        1236.0,
                        231.0,
                        1047.0,
                        231.0,
                        1047.0,
                        246.0,
                        957.0,
                        246.0,
                        957.0,
                        486.0,
                        711.0,
                        486.0,
                        711.0,
                        495.0,
                        709.5,
                        495.0
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
                        "obj-58",
                        0
                    ],
                    "midpoints": [
                        1249.5,
                        363.0,
                        1245.0,
                        363.0,
                        1245.0,
                        387.0,
                        1249.5,
                        387.0
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
                        "obj-72",
                        0
                    ],
                    "midpoints": [
                        1249.5,
                        495.0,
                        709.5,
                        495.0
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
                        "obj-158",
                        0
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
                        "obj-164",
                        0
                    ],
                    "midpoints": [
                        913.5,
                        564.0,
                        993.0,
                        564.0
                    ],
                    "source": [
                        "obj-68",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-69",
                        0
                    ],
                    "midpoints": [
                        869.5,
                        564.0,
                        869.5,
                        564.0
                    ],
                    "source": [
                        "obj-68",
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
                        869.5,
                        594.0,
                        855.0,
                        594.0,
                        855.0,
                        615.0,
                        869.5,
                        615.0
                    ],
                    "source": [
                        "obj-69",
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
                        918.0,
                        597.0,
                        915.0,
                        597.0,
                        915.0,
                        615.0,
                        929.5,
                        615.0
                    ],
                    "source": [
                        "obj-69",
                        1
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
                        966.5,
                        615.0,
                        989.5,
                        615.0
                    ],
                    "source": [
                        "obj-69",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-129",
                        0
                    ],
                    "midpoints": [
                        825.5,
                        537.0,
                        66.0,
                        537.0,
                        66.0,
                        486.0,
                        89.5,
                        486.0
                    ],
                    "source": [
                        "obj-72",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-161",
                        0
                    ],
                    "source": [
                        "obj-72",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-185",
                        0
                    ],
                    "midpoints": [
                        796.5,
                        657.0,
                        1116.0,
                        657.0,
                        1116.0,
                        684.0,
                        1171.5,
                        684.0
                    ],
                    "source": [
                        "obj-72",
                        3
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
                        738.5,
                        534.0,
                        846.0,
                        534.0,
                        846.0,
                        411.0,
                        957.0,
                        411.0,
                        957.0,
                        243.0,
                        1047.0,
                        243.0,
                        1047.0,
                        162.0,
                        951.0,
                        162.0,
                        951.0,
                        87.0,
                        774.0,
                        87.0,
                        774.0,
                        93.0,
                        709.5,
                        93.0
                    ],
                    "source": [
                        "obj-72",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-68",
                        0
                    ],
                    "midpoints": [
                        767.5,
                        537.0,
                        869.5,
                        537.0
                    ],
                    "source": [
                        "obj-72",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-134",
                        0
                    ],
                    "midpoints": [
                        709.5,
                        621.0,
                        710.0,
                        621.0
                    ],
                    "source": [
                        "obj-75",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-77",
                        0
                    ],
                    "midpoints": [
                        710.0,
                        849.01171875,
                        909.5,
                        849.01171875
                    ],
                    "order": 0,
                    "source": [
                        "obj-76",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-78",
                        0
                    ],
                    "midpoints": [
                        710.0,
                        723.0,
                        709.5,
                        723.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-76",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-84",
                        0
                    ],
                    "midpoints": [
                        909.5,
                        903.0,
                        885.0,
                        903.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        261.0,
                        957.0,
                        261.0,
                        957.0,
                        243.0,
                        1047.0,
                        243.0,
                        1047.0,
                        162.0,
                        945.0,
                        162.0,
                        945.0,
                        99.0,
                        783.0,
                        99.0,
                        783.0,
                        108.0,
                        747.0,
                        108.0
                    ],
                    "source": [
                        "obj-77",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-85",
                        0
                    ],
                    "midpoints": [
                        936.7857142857143,
                        912.0,
                        885.0,
                        912.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        261.0,
                        957.0,
                        261.0,
                        957.0,
                        243.0,
                        1047.0,
                        243.0,
                        1047.0,
                        162.0,
                        945.0,
                        162.0,
                        945.0,
                        108.0,
                        927.0,
                        108.0
                    ],
                    "source": [
                        "obj-77",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-86",
                        0
                    ],
                    "midpoints": [
                        964.0714285714286,
                        912.0,
                        885.0,
                        912.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        261.0,
                        957.0,
                        261.0,
                        957.0,
                        243.0,
                        1035.0,
                        243.0,
                        1035.0,
                        219.0,
                        957.0,
                        219.0,
                        957.0,
                        189.0,
                        927.0,
                        189.0
                    ],
                    "source": [
                        "obj-77",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-87",
                        0
                    ],
                    "midpoints": [
                        991.3571428571429,
                        912.0,
                        885.0,
                        912.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        279.0,
                        927.0,
                        279.0
                    ],
                    "source": [
                        "obj-77",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-88",
                        0
                    ],
                    "midpoints": [
                        1018.6428571428571,
                        912.0,
                        885.0,
                        912.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        333.0,
                        886.5,
                        333.0
                    ],
                    "source": [
                        "obj-77",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-89",
                        0
                    ],
                    "midpoints": [
                        1045.9285714285713,
                        912.0,
                        885.0,
                        912.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        333.0,
                        787.5,
                        333.0
                    ],
                    "source": [
                        "obj-77",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-90",
                        0
                    ],
                    "midpoints": [
                        1073.2142857142858,
                        912.0,
                        885.0,
                        912.0,
                        885.0,
                        654.0,
                        846.0,
                        654.0,
                        846.0,
                        279.0,
                        747.0,
                        279.0
                    ],
                    "source": [
                        "obj-77",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        0
                    ],
                    "midpoints": [
                        1100.5,
                        903.0,
                        1110.0,
                        903.0,
                        1110.0,
                        633.0,
                        1041.0,
                        633.0,
                        1041.0,
                        543.0,
                        969.0,
                        543.0,
                        969.0,
                        534.0,
                        957.0,
                        534.0,
                        957.0,
                        243.0,
                        1035.0,
                        243.0,
                        1035.0,
                        219.0,
                        957.0,
                        219.0,
                        957.0,
                        189.0,
                        747.0,
                        189.0
                    ],
                    "source": [
                        "obj-77",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-11",
                        3
                    ],
                    "midpoints": [
                        639.5,
                        207.0,
                        585.0,
                        207.0,
                        585.0,
                        246.0,
                        270.5,
                        246.0
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
                        "obj-182",
                        0
                    ],
                    "source": [
                        "obj-80",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-117",
                        0
                    ],
                    "midpoints": [
                        89.5,
                        123.0,
                        89.5,
                        123.0
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
                        "obj-94",
                        0
                    ],
                    "midpoints": [
                        1533.5,
                        123.0,
                        1533.5,
                        123.0
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
                        "obj-155",
                        3
                    ],
                    "midpoints": [
                        1565.5,
                        165.0,
                        1596.5,
                        165.0
                    ],
                    "source": [
                        "obj-94",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-155",
                        1
                    ],
                    "midpoints": [
                        1533.5,
                        177.0,
                        1554.5,
                        177.0
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
                        "obj-155",
                        2
                    ],
                    "midpoints": [
                        1683.5,
                        168.0,
                        1575.5,
                        168.0
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
                        "obj-155",
                        0
                    ],
                    "midpoints": [
                        1593.5,
                        168.0,
                        1533.5,
                        168.0
                    ],
                    "source": [
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-186",
                        0
                    ],
                    "destination": [
                        "obj-72",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-188",
                        0
                    ],
                    "destination": [
                        "obj-72",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-155",
                        0
                    ],
                    "destination": [
                        "obj-189",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-189",
                        1
                    ],
                    "destination": [
                        "obj-103",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-189",
                        0
                    ],
                    "destination": [
                        "obj-190",
                        0
                    ]
                }
            }
        ],
        "parameters": {
            "obj-136": [
                "width",
                "width",
                0
            ],
            "obj-137": [
                "decorr",
                "decorr",
                0
            ],
            "obj-143": [
                "air",
                "air",
                0
            ],
            "obj-144": [
                "hull",
                "hull",
                0
            ],
            "obj-30": [
                "rolloff",
                "rolloff",
                0
            ],
            "obj-31": [
                "blur",
                "blur",
                0
            ],
            "obj-80": [
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