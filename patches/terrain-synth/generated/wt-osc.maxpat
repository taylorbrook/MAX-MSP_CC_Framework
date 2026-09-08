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
            1875.0,
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
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        615.0,
                        30.0,
                        685.0,
                        24.0
                    ],
                    "text": "wt-osc  --  mipmapped wavetable oscillator (reads buffer~ terrainbank)",
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
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        615.0,
                        90.0,
                        1220.0,
                        20.0
                    ],
                    "text": "in1 Hz | in2 position 0-1 | in3 bank index -> umenu -> replace. Buffer layout: mip*524288 + frame*2048 + sample (11 mips, 256 frames). Banks baked by tools/bake_geometry.py",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                    "maxclass": "inlet",
                    "id": "obj-3",
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
                    "parameter_enable": 0,
                    "comment": "Frequency Hz (signal or float)"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        75.0,
                        30.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Frame position 0-1 (signal or float)"
                }
            },
            {
                "box": {
                    "maxclass": "inlet",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        195.0,
                        30.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Bank index (int) -> umenu"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
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
                                    "maxclass": "newobj",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        75.0,
                                        30.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 2",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "codebox",
                                    "id": "obj-3",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "History phb(0.);\nBuffer wt(\"terrainbank\");\n\n// mipmapped wavetable oscillator -- lifted from the ji-harmonizer mc.gen~ base group\n// (single osc, no spacing/inversion groups). Buffer layout written by tools/bake_geometry.py:\n//   idx = mip * 524288 + frame * 2048 + sample   (11 mips, 256 frames of 2048)\n// in1 = frequency in Hz (signal or float), in2 = frame position 0..1 (signal or float)\nf = max(in1, 0.);\npos = clamp(in2, 0., 1.);\n\n// phase accumulator\nph = wrap(phb + f / samplerate, 0., 1.);\nphb = ph;\n\n// mip level: base freqs 20 * 2^k, level 10 is silence above ~20 kHz fundamentals\nlev = clamp(floor(log2(max(f, 1.) / 20.)), 0., 10.);\nmb = lev * 524288.;\n\n// sample index + linear interpolation within the frame\nsp = ph * 2048.;\ns0 = floor(sp);\nsf = sp - s0;\ns1 = wrap(s0 + 1., 0., 2048.);\n\n// frame index + bilinear morph between adjacent frames\nfp = pos * 255.;\nf0 = floor(fp);\nf1 = min(f0 + 1., 255.);\nff = fp - f0;\n\na00 = peek(wt, mb + f0 * 2048. + s0, 0);\na01 = peek(wt, mb + f0 * 2048. + s1, 0);\na10 = peek(wt, mb + f1 * 2048. + s0, 0);\na11 = peek(wt, mb + f1 * 2048. + s1, 0);\nl0 = a00 + sf * (a01 - a00);\nl1 = a10 + sf * (a11 - a10);\nout1 = l0 + ff * (l1 - l0);\n",
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
                                        210.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
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
                                        "obj-3",
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
                                        1
                                    ],
                                    "midpoints": [
                                        90.0,
                                        63.5,
                                        423.0,
                                        63.5
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
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        90.0,
                        120.0,
                        30.0,
                        30.0
                    ],
                    "parameter_enable": 0,
                    "comment": "Oscillator signal"
                }
            },
            {
                "box": {
                    "maxclass": "umenu",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        140.0,
                        180.0,
                        22.0
                    ],
                    "parameter_enable": 0,
                    "items": [
                        "bank00-torus-sdf.wav"
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        360.0,
                        75.0,
                        121.0,
                        22.0
                    ],
                    "text": "prepend replace",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        120.0,
                        296.0,
                        22.0
                    ],
                    "text": "buffer~ terrainbank bank00-torus-sdf.wav",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        615.0,
                        135.0,
                        723.0,
                        20.0
                    ],
                    "text": "bank select: umenu symbol -> replace <file> -> buffer~ (one shared buffer~ terrainbank per bank name)",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                        "obj-4",
                        0
                    ],
                    "destination": [
                        "obj-6",
                        1
                    ],
                    "midpoints": [
                        90.0,
                        67.5,
                        144.0,
                        67.5
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
                        "obj-7",
                        0
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
                        "obj-8",
                        0
                    ],
                    "midpoints": [
                        210.0,
                        52.5,
                        450.0,
                        52.5
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-8",
                        1
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        450.0,
                        71.0,
                        420.5,
                        71.0
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
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
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
        ],
        "locked_bgcolor": [
            0.333,
            0.333,
            0.333,
            1.0
        ]
    }
}