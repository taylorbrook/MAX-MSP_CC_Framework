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
            249.0,
            105.0,
            1400.0,
            827.0
        ],
        "boxes": [
            {
                "box": {
                    "bgcolor": [
                        0.88,
                        0.9,
                        0.95,
                        1.0
                    ],
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        10.0,
                        153.0,
                        24.0
                    ],
                    "text": "Mixer Controls",
                    "textcolor": [
                        0.2,
                        0.25,
                        0.42,
                        1.0
                    ]
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
                        10.0,
                        38.0,
                        58.0,
                        20.0
                    ],
                    "text": "Tracks"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        73.0,
                        38.0,
                        58.0,
                        20.0
                    ],
                    "text": "Busses"
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "number",
                    "maximum": 32,
                    "minimum": 1,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        10.0,
                        55.0,
                        50.0,
                        22.0
                    ],
                    "varname": "ntracks"
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "number",
                    "maximum": 8,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        73.0,
                        55.0,
                        50.0,
                        22.0
                    ],
                    "varname": "nbusses"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        85.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend tracks"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        115.0,
                        85.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend busses"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-41",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        115.0,
                        135.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "mixer-manager.js",
                        "parameter_enable": 0
                    },
                    "text": "js mixer-manager.js"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-42",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        145.0,
                        69.0,
                        22.0
                    ],
                    "save": [
                        "#N",
                        "thispatcher",
                        ";",
                        "#Q",
                        "end",
                        ";"
                    ],
                    "text": "thispatcher"
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
                    "id": "obj-50",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        266.0,
                        11.0,
                        62.0,
                        22.0
                    ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "bang",
                        "bang",
                        "bang"
                    ],
                    "patching_rect": [
                        266.0,
                        39.0,
                        46.0,
                        22.0
                    ],
                    "text": "t b b b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-52",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        266.0,
                        66.0,
                        56.0,
                        22.0
                    ],
                    "text": "load"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-53",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        326.0,
                        66.0,
                        80,
                        22.0
                    ],
                    "text": "name mixer"
                }
            },
            {
                "box": {
                    "fontface": 2,
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-15",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        170.0,
                        356.0,
                        18.0
                    ],
                    "text": "Strips and busses created dynamically by mixer-manager.js",
                    "textcolor": [
                        0.55,
                        0.55,
                        0.6,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-10",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-master.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "patching_rect": [
                        602.0,
                        190.0,
                        110,
                        430
                    ],
                    "varname": "master",
                    "viewvisibility": 1,
                    "outlettype": []
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "mixer-in-1-L",
                        "mixer-in-1-R"
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
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        10.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-1",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "mixer-in-2-L",
                        "mixer-in-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-9",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        102.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-2",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        3,
                        "mixer-in-3-L",
                        "mixer-in-3-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-12",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        194.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-3",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        4,
                        "mixer-in-4-L",
                        "mixer-in-4-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-14",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        286.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-4",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "bus-1-L",
                        "bus-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-17",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        394.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-1",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "bus-2-L",
                        "bus-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-19",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        486.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-2",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-55",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 0,
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
                            120.0,
                            120.0,
                            750.0,
                            469.0
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
                                        700.0,
                                        26.0
                                    ],
                                    "text": "MIXER -- stereo mixing console with channel strips, busses and master"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-2",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        58.0,
                                        700.0,
                                        23.0
                                    ],
                                    "text": "USING IT"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        83.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Tracks (1-32) / Busses (0-8) set the strip counts. All settings save to mixer-state.json on close or via \"save\"."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        105.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Changing a count only adds or removes strips at the end -- existing strips keep their cords and settings."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        127.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Each channel strip: Gain (input trim), fader with meters, Pan, M (mute) and S (solo-in-place; busses stay audible)."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        149.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Ins switches the strip to its insert return inlets instead of its own input."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        171.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Sends 1-8: level dial + tap menu (Pre = pre-fader, Post = post-fader, Pan = post-pan) into bus N."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        193.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Bus strips: fader, Pan and M for each bus return."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        215.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Master: fader, M (mute), L/R meters, speaker = audio on. Its outlets and send~ <name>-out-L/R carry the mix."
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-10",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        247.0,
                                        700.0,
                                        23.0
                                    ],
                                    "text": "INPUTS & OUTPUTS"
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
                                        272.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Strip inlets 1-2: audio in L/R, or send~ <name>-in-N-L/R (\"name mixer\" sets <name>). Inlets 3-4: insert return L/R."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-12",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        294.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Strip outlets 1-2: post-fader L/R. Outlets 3-4: insert send (after Gain, before the fader)."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        316.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Every strip and bus is also summed into the master automatically."
                                }
                            },
                            {
                                "box": {
                                    "fontface": 1,
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-14",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        348.0,
                                        700.0,
                                        23.0
                                    ],
                                    "text": "HOW IT WORKS"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        373.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "mixer-manager.js creates mixer-strip and mixer-bus bpatchers via thispatcher scripting."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        395.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Internal send~/receive~ names get a fresh per-instance ID at load, so several mixers can run side by side."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "comment",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        20.0,
                                        417.0,
                                        700.0,
                                        22.0
                                    ],
                                    "text": "Strips and busses feed send~ master-L/R, which the mixer-master section receives."
                                }
                            }
                        ],
                        "lines": [],
                        "bgcolor": [
                            0.333,
                            0.333,
                            0.333,
                            1.0
                        ],
                        "editing_bgcolor": [
                            0.333,
                            0.333,
                            0.333,
                            1.0
                        ]
                    },
                    "patching_rect": [
                        358.0,
                        10.0,
                        86.0,
                        22.0
                    ],
                    "saved_object_attributes": {
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
                    },
                    "text": "p about"
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "mixer-in-1-L",
                        "mixer-in-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-8",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        10.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-1[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "mixer-in-2-L",
                        "mixer-in-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-13",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        102.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-2[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        3,
                        "mixer-in-3-L",
                        "mixer-in-3-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-18",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        194.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-3[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        4,
                        "mixer-in-4-L",
                        "mixer-in-4-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-21",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        286.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-4[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "bus-1-L",
                        "bus-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-23",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        394.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-1[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "bus-2-L",
                        "bus-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-25",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        486.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-2[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "mixer-in-1-L",
                        "mixer-in-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-11",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        10.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-1[2]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "mixer-in-2-L",
                        "mixer-in-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-20",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        102.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-2[2]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        3,
                        "mixer-in-3-L",
                        "mixer-in-3-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-24",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        194.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-3[2]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        4,
                        "mixer-in-4-L",
                        "mixer-in-4-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-27",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        286.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-4[2]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "bus-1-L",
                        "bus-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-29",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        394.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-1[2]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "bus-2-L",
                        "bus-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-31",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        486.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-2[2]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "mixer-in-1-L",
                        "mixer-in-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-33",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        10.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-1[3]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "mixer-in-2-L",
                        "mixer-in-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-35",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        102.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-2[3]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        3,
                        "mixer-in-3-L",
                        "mixer-in-3-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-37",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        194.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-3[3]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        4,
                        "mixer-in-4-L",
                        "mixer-in-4-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-39",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        286.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-4[3]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        5,
                        "mixer-in-5-L",
                        "mixer-in-5-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-45",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        378.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-5",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "bus-1-L",
                        "bus-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-47",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        486.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-1[3]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "bus-2-L",
                        "bus-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-49",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        578.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-2[3]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "bus-1-L",
                        "bus-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-57",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        486.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-1[4]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "bus-2-L",
                        "bus-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-59",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        578.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-2[4]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        3,
                        "bus-3-L",
                        "bus-3-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-61",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        670.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-3",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-62",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        160.0,
                        145.0,
                        352.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "pattrstorage mixstate @autorestore 0 @savemode 0",
                    "varname": "mixstate"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        460.0,
                        11.0,
                        79.0,
                        22.0
                    ],
                    "text": "closebang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        460.0,
                        66.0,
                        44.0,
                        22.0
                    ],
                    "text": "save"
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "mixer-in-1-L",
                        "mixer-in-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-16",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        10.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-1[4]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "mixer-in-2-L",
                        "mixer-in-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-26",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        102.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-2[4]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        3,
                        "mixer-in-3-L",
                        "mixer-in-3-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-30",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        194.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-3[4]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        4,
                        "mixer-in-4-L",
                        "mixer-in-4-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-34",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-strip.maxpat",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        286.0,
                        190.0,
                        80,
                        694
                    ],
                    "varname": "strip-4[4]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        1,
                        "bus-1-L",
                        "bus-1-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-38",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        394.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-1[5]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [
                        2,
                        "bus-2-L",
                        "bus-2-R"
                    ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-46",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "mixer-bus.maxpat",
                    "numinlets": 0,
                    "numoutlets": 2,
                    "offset": [
                        0.0,
                        0.0
                    ],
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        486.0,
                        190.0,
                        80,
                        420
                    ],
                    "varname": "bus-2[5]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-65",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        160,
                        85,
                        142.0,
                        22.0
                    ],
                    "text": "receive mixer-solo",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "varname": "solorecv"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-66",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        290,
                        92,
                        247.0,
                        20.0
                    ],
                    "text": "<- port name prefix: edit + click",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-43",
                        0
                    ],
                    "midpoints": [
                        19.5,
                        78.0,
                        19.5,
                        78.0
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
                        "obj-42",
                        0
                    ],
                    "midpoints": [
                        19.5,
                        138.0,
                        19.5,
                        138.0
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
                        "obj-41",
                        0
                    ],
                    "midpoints": [
                        19.5,
                        108.0,
                        19.5,
                        108.0
                    ],
                    "source": [
                        "obj-43",
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
                        124.5,
                        108.0,
                        19.5,
                        108.0
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
                        "obj-51",
                        0
                    ],
                    "midpoints": [
                        275.5,
                        34.0,
                        275.5,
                        34.0
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
                        "obj-52",
                        0
                    ],
                    "midpoints": [
                        275.5,
                        64.0,
                        275.5,
                        64.0
                    ],
                    "source": [
                        "obj-51",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-53",
                        0
                    ],
                    "midpoints": [
                        289.0,
                        61.0,
                        335.5,
                        61.0
                    ],
                    "source": [
                        "obj-51",
                        1
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
                        275.5,
                        111.0,
                        19.5,
                        111.0
                    ],
                    "source": [
                        "obj-52",
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
                        82.5,
                        78.0,
                        124.5,
                        78.0
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
                        "obj-64",
                        0
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
                        "obj-41",
                        0
                    ],
                    "source": [
                        "obj-64",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-65",
                        0
                    ],
                    "destination": [
                        "obj-41",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-53",
                        0
                    ],
                    "destination": [
                        "obj-41",
                        0
                    ]
                }
            }
        ],
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