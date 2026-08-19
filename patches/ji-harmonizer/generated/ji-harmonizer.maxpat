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
        "rect": [ 80.0, 100.0, 1422.0, 905.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "int", "int" ],
                    "patching_rect": [ 30.0, 30.0, 58.0, 22.0 ],
                    "text": "notein"
                }
            },
            {
                "box": {
                    "id": "obj-2",
                    "maxclass": "kslider",
                    "mode": 2,
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 135.0, 79.0, 336.0, 53.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 400.0, 644.0, 95.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 135.0, 150.0, 88.0, 22.0 ],
                    "text": "pack 0 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 7,
                    "outlettype": [ "", "", "", "", "", "", "" ],
                    "patching_rect": [ 120.0, 240.0, 135.0, 22.0 ],
                    "saved_object_attributes": {
                        "filename": "ji-engine.js",
                        "parameter_enable": 0
                    },
                    "text": "js ji-engine.js"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "number",
                    "maximum": 12,
                    "minimum": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 530.0, 420.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 64.0, 48.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 920.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 42.0, 48.0, 18.0 ],
                    "text": "voices",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-7",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 592.0, 420.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 290.0, 64.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-8",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 965.0, 86.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 290.0, 42.0, 70.0, 18.0 ],
                    "text": "complexity",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-9",
                    "maxclass": "number",
                    "maximum": 11,
                    "minimum": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 654.0, 420.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 366.0, 64.0, 48.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 1025.0, 51.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 366.0, 42.0, 40.0, 18.0 ],
                    "text": "tonic",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-11",
                    "maxclass": "flonum",
                    "maximum": 480.0,
                    "minimum": 400.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 716.0, 420.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 426.0, 64.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 1070.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 426.0, 42.0, 40.0, 18.0 ],
                    "text": "A4",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-13",
                    "items": [ "Free", ",", "Close", ",", "Open", ",", "Drop-2", ",", "Thirds", ",", "Quartal", ",", "Quintal" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 778.0, 420.0, 100.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 502.0, 64.0, 96.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-14",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 1115.0, 65.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 502.0, 42.0, 60.0, 18.0 ],
                    "text": "voicing",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-15",
                    "maxclass": "newobj",
                    "numinlets": 8,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
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
                        "rect": [ 100.0, 100.0, 400.0, 300.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "voice count (2-12)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "complexity (0-1)",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 75.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "tonic (0-11)",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "master tune A4 (Hz)",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 165.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "voicing mode (0-6)",
                                    "id": "obj-5",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 210.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "tagged param messages to ji-engine",
                                    "id": "obj-6",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 405.0, 120.0, 30.0, 30.0 ]
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 75.0, 142.0, 22.0 ],
                                    "text": "prepend voicecount"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 345.0, 75.0, 142.0, 22.0 ],
                                    "text": "prepend complexity"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 660.0, 75.0, 107.0, 22.0 ],
                                    "text": "prepend tonic"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 180.0, 75.0, 142.0, 22.0 ],
                                    "text": "prepend mastertune"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 495.0, 75.0, 149.0, 22.0 ],
                                    "text": "prepend voicingmode"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data to prepend stereospread",
                                    "id": "obj-12",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 255.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 810.0, 75.0, 156.0, 22.0 ],
                                    "text": "prepend stereospread"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data to prepend detunerandom",
                                    "id": "obj-14",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 300.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 960.0, 120.0, 156.0, 22.0 ],
                                    "text": "prepend detunerandom"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data to prepend timingrandom",
                                    "id": "obj-16",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 345.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1110.0, 75.0, 156.0, 22.0 ],
                                    "text": "prepend timingrandom"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "midpoints": [ 39.5, 22.0, 67.0, 22.0, 67.0, 68.0, 39.5, 68.0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 189.5, 67.0, 337.0, 67.0, 337.0, 105.0, 414.5, 105.0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 504.5, 67.0, 495.0, 67.0, 495.0, 105.0, 414.5, 105.0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 264.5, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 652.0, 67.0, 652.0, 105.0, 652.0, 67.0, 330.0, 67.0, 330.0, 105.0, 330.0, 67.0, 652.0, 67.0, 652.0, 105.0, 819.5, 105.0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 819.5, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 652.0, 67.0, 652.0, 105.0, 652.0, 67.0, 652.0, 67.0, 652.0, 105.0, 414.5, 105.0 ],
                                    "source": [ "obj-13", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "midpoints": [ 309.5, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 652.0, 67.0, 652.0, 105.0, 652.0, 67.0, 330.0, 67.0, 330.0, 105.0, 330.0, 67.0, 652.0, 67.0, 652.0, 105.0, 652.0, 67.0, 802.0, 67.0, 802.0, 105.0, 802.0, 112.0, 443.0, 112.0, 443.0, 158.0, 969.5, 158.0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 969.5, 131.0, 414.5, 131.0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "midpoints": [ 354.5, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 775.0, 67.0, 775.0, 105.0, 775.0, 67.0, 652.0, 67.0, 652.0, 105.0, 652.0, 67.0, 802.0, 67.0, 802.0, 105.0, 1119.5, 105.0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 1119.5, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 775.0, 67.0, 775.0, 105.0, 775.0, 67.0, 652.0, 67.0, 652.0, 105.0, 652.0, 67.0, 802.0, 67.0, 802.0, 105.0, 802.0, 112.0, 952.0, 112.0, 952.0, 150.0, 414.5, 150.0 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "midpoints": [ 84.5, 22.0, 158.0, 22.0, 158.0, 68.0, 158.0, 22.0, 203.0, 22.0, 203.0, 68.0, 203.0, 22.0, 248.0, 22.0, 248.0, 68.0, 248.0, 22.0, 247.0, 22.0, 247.0, 68.0, 247.0, 22.0, 292.0, 22.0, 292.0, 68.0, 292.0, 22.0, 337.0, 22.0, 337.0, 68.0, 337.0, 67.0, 180.0, 67.0, 180.0, 105.0, 180.0, 67.0, 330.0, 67.0, 330.0, 105.0, 354.5, 105.0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "midpoints": [ 129.5, 22.0, 203.0, 22.0, 203.0, 68.0, 203.0, 22.0, 248.0, 22.0, 248.0, 68.0, 248.0, 22.0, 293.0, 22.0, 293.0, 68.0, 293.0, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 67.0, 180.0, 67.0, 180.0, 105.0, 180.0, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 330.0, 67.0, 330.0, 105.0, 330.0, 67.0, 487.0, 67.0, 487.0, 105.0, 669.5, 105.0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "midpoints": [ 174.5, 22.0, 202.0, 22.0, 202.0, 68.0, 202.0, 22.0, 247.0, 22.0, 247.0, 68.0, 247.0, 67.0, 180.0, 67.0, 180.0, 105.0, 189.5, 105.0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-11", 0 ],
                                    "midpoints": [ 219.5, 22.0, 293.0, 22.0, 293.0, 68.0, 293.0, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 67.0, 337.0, 67.0, 337.0, 105.0, 337.0, 67.0, 330.0, 67.0, 330.0, 105.0, 504.5, 105.0 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 39.5, 67.0, 337.0, 67.0, 337.0, 105.0, 337.0, 67.0, 330.0, 67.0, 330.0, 105.0, 414.5, 105.0 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 669.5, 67.0, 495.0, 67.0, 495.0, 105.0, 495.0, 67.0, 487.0, 67.0, 487.0, 105.0, 414.5, 105.0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 650.0, 465.0, 86.0, 22.0 ],
                    "text": "p params"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-16",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 1175.0, 51.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 42.0, 60.0, 18.0 ],
                    "text": "ratio",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-17",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 1220.0, 51.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 42.0, 60.0, 18.0 ],
                    "text": "cents",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
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
                        "rect": [ 100.0, 100.0, 935.0, 337.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "degree 0 ratio text",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 1 ratio text",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 75.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 2 ratio text",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 3 ratio text",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 165.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 4 ratio text",
                                    "id": "obj-5",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 5 ratio text",
                                    "id": "obj-6",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 255.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 6 ratio text",
                                    "id": "obj-7",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 300.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 7 ratio text",
                                    "id": "obj-8",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 345.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 8 ratio text",
                                    "id": "obj-9",
                                    "index": 9,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 390.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 9 ratio text",
                                    "id": "obj-10",
                                    "index": 10,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 435.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 10 ratio text",
                                    "id": "obj-11",
                                    "index": 11,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 480.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 11 ratio text",
                                    "id": "obj-12",
                                    "index": 12,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 525.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "ratio <deg> <n/d> messages to ji-engine",
                                    "id": "obj-13",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 840.0, 120.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 990.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1545.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 165.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 3"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1125.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 4"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1410.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 300.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 6"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 585.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 7"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1275.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 8"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 720.0, 75.0, 121.0, 22.0 ],
                                    "text": "prepend ratio 9"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 435.0, 75.0, 128.0, 22.0 ],
                                    "text": "prepend ratio 10"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 855.0, 75.0, 128.0, 22.0 ],
                                    "text": "prepend ratio 11"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "midpoints": [ 39.5, 22.0, 67.0, 22.0, 67.0, 68.0, 39.5, 68.0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "midpoints": [ 444.5, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 563.0, 22.0, 563.0, 68.0, 563.0, 67.0, 577.0, 67.0, 577.0, 105.0, 577.0, 67.0, 571.0, 67.0, 571.0, 105.0, 729.5, 105.0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "midpoints": [ 534.5, 67.0, 714.0, 67.0, 714.0, 105.0, 714.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 571.0, 67.0, 571.0, 105.0, 864.5, 105.0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 39.5, 67.0, 294.0, 67.0, 294.0, 105.0, 294.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 577.0, 67.0, 577.0, 105.0, 577.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 427.0, 67.0, 427.0, 105.0, 427.0, 67.0, 847.0, 67.0, 847.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 999.5, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 991.0, 67.0, 991.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 1554.5, 67.0, 1119.0, 67.0, 1119.0, 105.0, 1119.0, 67.0, 1254.0, 67.0, 1254.0, 105.0, 1254.0, 67.0, 1402.0, 67.0, 1402.0, 105.0, 1402.0, 67.0, 1267.0, 67.0, 1267.0, 105.0, 1267.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 991.0, 67.0, 991.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 174.5, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 577.0, 67.0, 577.0, 105.0, 577.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 1134.5, 67.0, 982.0, 67.0, 982.0, 105.0, 982.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 991.0, 67.0, 991.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-18", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 1419.5, 67.0, 1119.0, 67.0, 1119.0, 105.0, 1119.0, 67.0, 1117.0, 67.0, 1117.0, 105.0, 1117.0, 67.0, 1267.0, 67.0, 1267.0, 105.0, 1267.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 991.0, 67.0, 991.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-19", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "midpoints": [ 84.5, 22.0, 158.0, 22.0, 158.0, 68.0, 158.0, 22.0, 203.0, 22.0, 203.0, 68.0, 203.0, 22.0, 248.0, 22.0, 248.0, 68.0, 248.0, 22.0, 293.0, 22.0, 293.0, 68.0, 293.0, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 22.0, 428.0, 22.0, 428.0, 68.0, 428.0, 22.0, 473.0, 22.0, 473.0, 68.0, 473.0, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 563.0, 22.0, 563.0, 68.0, 563.0, 67.0, 159.0, 67.0, 159.0, 105.0, 159.0, 67.0, 294.0, 67.0, 294.0, 105.0, 294.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 577.0, 67.0, 577.0, 105.0, 577.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 999.5, 105.0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 309.5, 67.0, 577.0, 67.0, 577.0, 105.0, 577.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 594.5, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 847.0, 67.0, 847.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 1284.5, 67.0, 1119.0, 67.0, 1119.0, 105.0, 1119.0, 67.0, 1117.0, 67.0, 1117.0, 105.0, 1117.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 991.0, 67.0, 991.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 729.5, 67.0, 847.0, 67.0, 847.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 444.5, 67.0, 714.0, 67.0, 714.0, 105.0, 714.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 847.0, 67.0, 847.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 864.5, 67.0, 849.0, 67.0, 849.0, 105.0, 849.5, 105.0 ],
                                    "source": [ "obj-25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "midpoints": [ 129.5, 22.0, 203.0, 22.0, 203.0, 68.0, 203.0, 22.0, 248.0, 22.0, 248.0, 68.0, 248.0, 22.0, 293.0, 22.0, 293.0, 68.0, 293.0, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 22.0, 428.0, 22.0, 428.0, 68.0, 428.0, 22.0, 473.0, 22.0, 473.0, 68.0, 473.0, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 563.0, 22.0, 563.0, 68.0, 563.0, 67.0, 159.0, 67.0, 159.0, 105.0, 159.0, 67.0, 982.0, 67.0, 982.0, 105.0, 982.0, 67.0, 294.0, 67.0, 294.0, 105.0, 294.0, 67.0, 1117.0, 67.0, 1117.0, 105.0, 1117.0, 67.0, 1402.0, 67.0, 1402.0, 105.0, 1402.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 714.0, 67.0, 714.0, 105.0, 714.0, 67.0, 1267.0, 67.0, 1267.0, 105.0, 1267.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 1554.5, 105.0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "midpoints": [ 174.5, 22.0, 202.0, 22.0, 202.0, 68.0, 174.5, 68.0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-18", 0 ],
                                    "midpoints": [ 219.5, 22.0, 293.0, 22.0, 293.0, 68.0, 293.0, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 22.0, 428.0, 22.0, 428.0, 68.0, 428.0, 22.0, 473.0, 22.0, 473.0, 68.0, 473.0, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 563.0, 22.0, 563.0, 68.0, 563.0, 67.0, 982.0, 67.0, 982.0, 105.0, 982.0, 67.0, 294.0, 67.0, 294.0, 105.0, 294.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 714.0, 67.0, 714.0, 105.0, 714.0, 67.0, 712.0, 67.0, 712.0, 105.0, 712.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 1134.5, 105.0 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "midpoints": [ 264.5, 22.0, 338.0, 22.0, 338.0, 68.0, 338.0, 22.0, 383.0, 22.0, 383.0, 68.0, 383.0, 22.0, 428.0, 22.0, 428.0, 68.0, 428.0, 22.0, 473.0, 22.0, 473.0, 68.0, 473.0, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 563.0, 22.0, 563.0, 68.0, 563.0, 67.0, 982.0, 67.0, 982.0, 105.0, 982.0, 67.0, 294.0, 67.0, 294.0, 105.0, 294.0, 67.0, 1117.0, 67.0, 1117.0, 105.0, 1117.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 714.0, 67.0, 714.0, 105.0, 714.0, 67.0, 1267.0, 67.0, 1267.0, 105.0, 1267.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 1419.5, 105.0 ],
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "midpoints": [ 309.5, 22.0, 337.0, 22.0, 337.0, 68.0, 309.5, 68.0 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "midpoints": [ 354.5, 22.0, 428.0, 22.0, 428.0, 68.0, 428.0, 22.0, 473.0, 22.0, 473.0, 68.0, 473.0, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 517.0, 22.0, 517.0, 68.0, 517.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 571.0, 67.0, 571.0, 105.0, 594.5, 105.0 ],
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-22", 0 ],
                                    "midpoints": [ 399.5, 22.0, 473.0, 22.0, 473.0, 68.0, 473.0, 22.0, 518.0, 22.0, 518.0, 68.0, 518.0, 22.0, 563.0, 22.0, 563.0, 68.0, 563.0, 67.0, 982.0, 67.0, 982.0, 105.0, 982.0, 67.0, 1117.0, 67.0, 1117.0, 105.0, 1117.0, 67.0, 429.0, 67.0, 429.0, 105.0, 429.0, 67.0, 714.0, 67.0, 714.0, 105.0, 714.0, 67.0, 849.0, 67.0, 849.0, 105.0, 849.0, 67.0, 571.0, 67.0, 571.0, 105.0, 571.0, 67.0, 847.0, 67.0, 847.0, 105.0, 1284.5, 105.0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 925.0, 175.0, 86.0, 22.0 ],
                    "text": "p ratios"
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-19",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 640.0, 55.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 64.0, 76.0, 22.0 ],
                    "text": "1/1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 1265.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 67.0, 26.0, 18.0 ],
                    "text": "0",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-21",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 730.0, 55.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 90.0, 76.0, 22.0 ],
                    "text": "17/16"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 920.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 93.0, 26.0, 18.0 ],
                    "text": "1",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-23",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 820.0, 55.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 116.0, 76.0, 22.0 ],
                    "text": "9/8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 965.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 119.0, 26.0, 18.0 ],
                    "text": "2",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-25",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 910.0, 55.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 142.0, 76.0, 22.0 ],
                    "text": "19/16"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 1025.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 145.0, 26.0, 18.0 ],
                    "text": "3",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-27",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1000.0, 55.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 168.0, 76.0, 22.0 ],
                    "text": "5/4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-28",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 1070.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 171.0, 26.0, 18.0 ],
                    "text": "4",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-29",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1090.0, 55.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 194.0, 76.0, 22.0 ],
                    "text": "21/16"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-30",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 1115.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 197.0, 26.0, 18.0 ],
                    "text": "5",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-31",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 640.0, 100.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 220.0, 76.0, 22.0 ],
                    "text": "11/8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-32",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 1175.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 223.0, 26.0, 18.0 ],
                    "text": "6",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-33",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 730.0, 100.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 246.0, 76.0, 22.0 ],
                    "text": "23/16"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-34",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 1220.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 249.0, 26.0, 18.0 ],
                    "text": "7",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-35",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 820.0, 100.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 272.0, 76.0, 22.0 ],
                    "text": "3/2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-36",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 135.0, 1265.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 275.0, 26.0, 18.0 ],
                    "text": "8",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-37",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 910.0, 100.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 298.0, 76.0, 22.0 ],
                    "text": "13/8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-38",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 920.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 301.0, 26.0, 18.0 ],
                    "text": "9",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-39",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1000.0, 100.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 324.0, 76.0, 22.0 ],
                    "text": "7/4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-40",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 965.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 327.0, 26.0, 18.0 ],
                    "text": "10",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontsize": 11.0,
                    "id": "obj-41",
                    "keymode": 1,
                    "maxclass": "textedit",
                    "nosymquotes": 1,
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1090.0, 100.0, 76.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 46.0, 350.0, 76.0, 22.0 ],
                    "text": "15/8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-42",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 1025.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 353.0, 26.0, 18.0 ],
                    "text": "11",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-43",
                    "maxclass": "newobj",
                    "numinlets": 13,
                    "numoutlets": 13,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                    "patching_rect": [ 120.0, 270.0, 233.0, 22.0 ],
                    "text": "route 0 1 2 3 4 5 6 7 8 9 10 11"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-44",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 105.0, 315.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 64.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-45",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 167.0, 315.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 90.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-46",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 229.0, 315.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 116.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-47",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 291.0, 315.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 142.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-48",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 353.0, 315.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 168.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-49",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 415.0, 315.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 194.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-50",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 105.0, 350.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 220.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-51",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 167.0, 350.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 246.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-52",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 229.0, 350.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 272.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-53",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 291.0, 350.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 298.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-54",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 353.0, 350.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 324.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-55",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numdecimalplaces": 2,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 415.0, 350.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 130.0, 350.0, 64.0, 22.0 ]
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
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1200.0, 230.0, 135.0, 22.0 ],
                    "text": "mc.sig~ @chans 12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-57",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1345.0, 230.0, 135.0, 22.0 ],
                    "text": "mc.sig~ @chans 12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-59",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1365.0, 275.0, 184.0, 22.0 ],
                    "text": "mc.rampsmooth~ 2205 2205"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-60",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1335.0, 320.0, 51.0, 22.0 ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-61",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1350.0, 365.0, 164.0, 22.0 ],
                    "text": "mc.mixdown~ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-62",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [ "signal", "signal", "", "" ],
                    "patching_rect": [ 645.0, 602.0, 177.0, 22.0 ],
                    "text": "adsr~ 10. 150. 0.7 400."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-63",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 1200.0, 410.0, 42.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-64",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 1215.0, 440.0, 58.0, 22.0 ],
                    "text": "*~ 0.1"
                }
            },
            {
                "box": {
                    "id": "obj-65",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1095.0, 780.0, 22.0, 140.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 620.0, 110.0, 30.0, 150.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-66",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 1125.0, 780.0, 15.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 655.0, 110.0, 15.0, 150.0 ]
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.92, 0.85, 0.85, 1.0 ],
                    "id": "obj-67",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 1080.0, 945.0, 45.0, 45.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-68",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "" ],
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
                        "rect": [ 100.0, 100.0, 400.0, 300.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "unused (re-init bang)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "voices init",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 60.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "complexity init",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 135.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "tonic init",
                                    "id": "obj-4",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 210.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "A4 init",
                                    "id": "obj-5",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 300.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "voicing init",
                                    "id": "obj-6",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 375.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "gain init",
                                    "id": "obj-7",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 450.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "dump cents",
                                    "id": "obj-8",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 540.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 75.0, 30.0, 72.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 12,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang" ],
                                    "patching_rect": [ 30.0, 75.0, 245.0, 22.0 ],
                                    "text": "trigger b b b b b b b b b b b b"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 120.0, 65.0, 22.0 ],
                                    "text": "dump"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 105.0, 120.0, 65.0, 22.0 ],
                                    "text": "5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-13",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 195.0, 120.0, 65.0, 22.0 ],
                                    "text": "0.5"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 270.0, 120.0, 65.0, 22.0 ],
                                    "text": "0"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 345.0, 120.0, 65.0, 22.0 ],
                                    "text": "440."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 435.0, 120.0, 65.0, 22.0 ],
                                    "text": "0"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 510.0, 120.0, 65.0, 22.0 ],
                                    "text": "120"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 585.0, 120.0, 40.0, 22.0 ],
                                    "text": "0.5"
                                }
                            },
                            {
                                "box": {
                                    "comment": "data from 0.5",
                                    "id": "obj-19",
                                    "index": 8,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 615.0, 165.0, 30.0, 30.0 ]
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 660.0, 120.0, 40.0, 22.0 ],
                                    "text": "5."
                                }
                            },
                            {
                                "box": {
                                    "comment": "data from 5.",
                                    "id": "obj-21",
                                    "index": 9,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 690.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 735.0, 120.0, 40.0, 22.0 ],
                                    "text": "10."
                                }
                            },
                            {
                                "box": {
                                    "comment": "data from 10.",
                                    "id": "obj-23",
                                    "index": 10,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 765.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 810.0, 120.0, 40.0, 22.0 ],
                                    "text": "0."
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 885.0, 120.0, 40.0, 22.0 ],
                                    "text": "0.3"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-26",
                                    "index": 11,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 840.0, 165.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-27",
                                    "index": 12,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 915.0, 165.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "midpoints": [ 39.5, 67.5, 39.5, 67.5 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-11", 0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 0 ],
                                    "midpoints": [ 60.04545454545455, 112.0, 103.0, 112.0, 103.0, 150.0, 114.5, 150.0 ],
                                    "source": [ "obj-10", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 80.5909090909091, 112.0, 103.0, 112.0, 103.0, 150.0, 103.0, 112.0, 178.0, 112.0, 178.0, 150.0, 204.5, 150.0 ],
                                    "source": [ "obj-10", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "midpoints": [ 101.13636363636363, 112.0, 103.0, 112.0, 103.0, 150.0, 103.0, 112.0, 178.0, 112.0, 178.0, 150.0, 178.0, 112.0, 187.0, 112.0, 187.0, 150.0, 279.5, 150.0 ],
                                    "source": [ "obj-10", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "midpoints": [ 121.68181818181819, 112.0, 178.0, 112.0, 178.0, 150.0, 178.0, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 262.0, 112.0, 262.0, 150.0, 354.5, 150.0 ],
                                    "source": [ "obj-10", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "midpoints": [ 142.22727272727275, 112.0, 178.0, 112.0, 178.0, 150.0, 178.0, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 262.0, 112.0, 262.0, 150.0, 262.0, 112.0, 337.0, 112.0, 337.0, 150.0, 444.5, 150.0 ],
                                    "source": [ "obj-10", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "midpoints": [ 162.77272727272725, 112.0, 178.0, 112.0, 178.0, 150.0, 178.0, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 343.0, 112.0, 343.0, 150.0, 343.0, 112.0, 337.0, 112.0, 337.0, 150.0, 337.0, 112.0, 427.0, 112.0, 427.0, 150.0, 519.5, 150.0 ],
                                    "source": [ "obj-10", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-18", 0 ],
                                    "midpoints": [ 183.3181818181818, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 343.0, 112.0, 343.0, 150.0, 343.0, 112.0, 418.0, 112.0, 418.0, 150.0, 418.0, 112.0, 427.0, 112.0, 427.0, 150.0, 427.0, 112.0, 502.0, 112.0, 502.0, 150.0, 594.5, 150.0 ],
                                    "source": [ "obj-10", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "midpoints": [ 203.86363636363637, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 343.0, 112.0, 343.0, 150.0, 343.0, 112.0, 418.0, 112.0, 418.0, 150.0, 418.0, 112.0, 427.0, 112.0, 427.0, 150.0, 427.0, 112.0, 502.0, 112.0, 502.0, 150.0, 502.0, 112.0, 577.0, 112.0, 577.0, 150.0, 669.5, 150.0 ],
                                    "source": [ "obj-10", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-22", 0 ],
                                    "midpoints": [ 224.4090909090909, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 343.0, 112.0, 343.0, 150.0, 343.0, 112.0, 418.0, 112.0, 418.0, 150.0, 418.0, 112.0, 508.0, 112.0, 508.0, 150.0, 508.0, 112.0, 502.0, 112.0, 502.0, 150.0, 502.0, 112.0, 577.0, 112.0, 577.0, 150.0, 577.0, 112.0, 652.0, 112.0, 652.0, 150.0, 744.5, 150.0 ],
                                    "source": [ "obj-10", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-10", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "source": [ "obj-10", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "midpoints": [ 39.5, 112.0, 178.0, 112.0, 178.0, 150.0, 178.0, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 112.0, 343.0, 112.0, 343.0, 150.0, 343.0, 112.0, 337.0, 112.0, 337.0, 150.0, 337.0, 112.0, 427.0, 112.0, 427.0, 150.0, 427.0, 112.0, 502.0, 112.0, 502.0, 150.0, 502.0, 157.0, 98.0, 157.0, 98.0, 203.0, 98.0, 157.0, 173.0, 157.0, 173.0, 203.0, 173.0, 157.0, 248.0, 157.0, 248.0, 203.0, 248.0, 157.0, 292.0, 157.0, 292.0, 203.0, 292.0, 157.0, 367.0, 157.0, 367.0, 203.0, 367.0, 157.0, 442.0, 157.0, 442.0, 203.0, 549.5, 203.0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "midpoints": [ 114.5, 112.0, 103.0, 112.0, 103.0, 150.0, 103.0, 157.0, 127.0, 157.0, 127.0, 203.0, 69.5, 203.0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "midpoints": [ 204.5, 112.0, 178.0, 112.0, 178.0, 150.0, 178.0, 157.0, 202.0, 157.0, 202.0, 203.0, 144.5, 203.0 ],
                                    "source": [ "obj-13", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "midpoints": [ 279.5, 112.0, 268.0, 112.0, 268.0, 150.0, 268.0, 157.0, 292.0, 157.0, 292.0, 203.0, 219.5, 203.0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "midpoints": [ 354.5, 112.0, 343.0, 112.0, 343.0, 150.0, 343.0, 157.0, 367.0, 157.0, 367.0, 203.0, 309.5, 203.0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 444.5, 112.0, 418.0, 112.0, 418.0, 150.0, 418.0, 157.0, 442.0, 157.0, 442.0, 203.0, 384.5, 203.0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "midpoints": [ 519.5, 112.0, 508.0, 112.0, 508.0, 150.0, 508.0, 157.0, 532.0, 157.0, 532.0, 203.0, 459.5, 203.0 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "source": [ "obj-18", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "source": [ "obj-25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "midpoints": [ 84.5, 63.5, 39.5, 63.5 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 105.0, 30.0, 86.0, 22.0 ],
                    "text": "p init"
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-69",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 1070.0, 327.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 10.0, 327.0, 24.0 ],
                    "text": "JI HARMONIZER — tuning + chord engine",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-70",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 195.0, 1115.0, 58.0, 20.0 ],
                    "text": "v0.9.0",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 120.0, 395.0, 149.0, 22.0 ],
                    "text": "prepend applyvalues"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-72",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 120.0, 430.0, 149.0, 22.0 ],
                    "text": "prepend applyvalues"
                }
            },
            {
                "box": {
                    "id": "obj-73",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 669.0, 30.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 66.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-74",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 759.0, 30.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 92.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-75",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 849.0, 30.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 118.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-76",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 939.0, 30.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 144.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1029.0, 30.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 170.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-78",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1119.0, 30.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 196.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-79",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 669.0, 128.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 222.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-80",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 759.0, 128.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 248.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-81",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 849.0, 128.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 274.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-82",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 939.0, 128.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 300.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-83",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1029.0, 128.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 326.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-84",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1119.0, 128.0, 18.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 203.0, 352.0, 18.0, 18.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-85",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 128.0, 107.0, 20.0 ],
                    "text": "degree enable"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-86",
                    "maxclass": "newobj",
                    "numinlets": 12,
                    "numoutlets": 13,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
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
                        "rect": [ 100.0, 100.0, 1199.0, 432.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "degree 0 toggle",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 50.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 1 toggle",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 130.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 2 toggle",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 210.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 3 toggle",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 290.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 4 toggle",
                                    "id": "obj-5",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 370.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 5 toggle",
                                    "id": "obj-6",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 450.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 6 toggle",
                                    "id": "obj-7",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 530.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 7 toggle",
                                    "id": "obj-8",
                                    "index": 8,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 610.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 8 toggle",
                                    "id": "obj-9",
                                    "index": 9,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 690.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 9 toggle",
                                    "id": "obj-10",
                                    "index": 10,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 770.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 10 toggle",
                                    "id": "obj-11",
                                    "index": 11,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 850.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree 11 toggle",
                                    "id": "obj-12",
                                    "index": 12,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 930.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "degree messages to ji-engine",
                                    "id": "obj-13",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 0",
                                    "id": "obj-14",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 130.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 1",
                                    "id": "obj-15",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 210.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 2",
                                    "id": "obj-16",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 290.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 3",
                                    "id": "obj-17",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 370.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 4",
                                    "id": "obj-18",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 450.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 5",
                                    "id": "obj-19",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 530.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 6",
                                    "id": "obj-20",
                                    "index": 8,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 610.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 7",
                                    "id": "obj-21",
                                    "index": 9,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 690.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 8",
                                    "id": "obj-22",
                                    "index": 10,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 770.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 9",
                                    "id": "obj-23",
                                    "index": 11,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 850.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 10",
                                    "id": "obj-24",
                                    "index": 12,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 930.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "set toggle 11",
                                    "id": "obj-25",
                                    "index": 13,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1010.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 0 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-27",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 1 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-28",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 2 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-29",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 290.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 3 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-30",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 370.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 4 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-31",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 450.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 5 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-32",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 530.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 6 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-33",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 610.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 7 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-34",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 690.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 8 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-35",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 770.0, 150.0, 93.0, 22.0 ],
                                    "text": "degree 9 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-36",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 850.0, 150.0, 100.0, 22.0 ],
                                    "text": "degree 10 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-37",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 930.0, 150.0, 100.0, 22.0 ],
                                    "text": "degree 11 $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-38",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 30.0, 210.0, 72.0, 22.0 ],
                                    "text": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-39",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 12,
                                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang" ],
                                    "patching_rect": [ 24.0, 367.0, 233.0, 22.0 ],
                                    "text": "trigger b b b b b b b b b b b b"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-40",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-41",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 110.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-42",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 190.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-43",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 270.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-44",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 350.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-45",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 430.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-46",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 510.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-47",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 590.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-48",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 670.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-49",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 750.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-50",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 830.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-51",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 910.0, 290.0, 51.0, 22.0 ],
                                    "text": "set 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "midpoints": [ 59.5, 63.0, 59.5, 63.0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-35", 0 ],
                                    "midpoints": [ 779.5, 63.0, 779.5, 63.0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-36", 0 ],
                                    "midpoints": [ 859.5, 63.0, 859.5, 63.0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-37", 0 ],
                                    "midpoints": [ 939.5, 63.0, 939.5, 63.0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "midpoints": [ 139.5, 63.0, 139.5, 63.0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 59.5, 195.0, 15.0, 195.0, 15.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 139.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-27", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 219.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-28", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 299.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-29", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-28", 0 ],
                                    "midpoints": [ 219.5, 63.0, 219.5, 63.0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 379.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-30", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 459.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-31", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 539.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-32", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 619.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 699.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-34", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 779.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-35", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 859.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-36", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "midpoints": [ 939.5, 237.0, 114.0, 237.0, 114.0, 246.0, 59.5, 246.0 ],
                                    "source": [ "obj-37", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-39", 0 ],
                                    "midpoints": [ 39.5, 243.0, 15.0, 243.0, 15.0, 354.0, 33.5, 354.0 ],
                                    "source": [ "obj-38", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-40", 0 ],
                                    "midpoints": [ 33.5, 390.0, 9.0, 390.0, 9.0, 285.0, 39.5, 285.0 ],
                                    "source": [ "obj-39", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-41", 0 ],
                                    "midpoints": [ 52.95454545454545, 399.0, 9.0, 399.0, 9.0, 324.0, 96.0, 324.0, 96.0, 285.0, 119.5, 285.0 ],
                                    "source": [ "obj-39", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-42", 0 ],
                                    "midpoints": [ 72.4090909090909, 399.0, 9.0, 399.0, 9.0, 324.0, 177.0, 324.0, 177.0, 285.0, 199.5, 285.0 ],
                                    "source": [ "obj-39", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-43", 0 ],
                                    "midpoints": [ 91.86363636363637, 399.0, 267.0, 399.0, 267.0, 285.0, 279.5, 285.0 ],
                                    "source": [ "obj-39", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-44", 0 ],
                                    "midpoints": [ 111.31818181818181, 399.0, 336.0, 399.0, 336.0, 285.0, 359.5, 285.0 ],
                                    "source": [ "obj-39", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-45", 0 ],
                                    "midpoints": [ 130.77272727272725, 399.0, 417.0, 399.0, 417.0, 285.0, 439.5, 285.0 ],
                                    "source": [ "obj-39", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-46", 0 ],
                                    "midpoints": [ 150.22727272727275, 399.0, 495.0, 399.0, 495.0, 285.0, 519.5, 285.0 ],
                                    "source": [ "obj-39", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-47", 0 ],
                                    "midpoints": [ 169.6818181818182, 399.0, 576.0, 399.0, 576.0, 285.0, 599.5, 285.0 ],
                                    "source": [ "obj-39", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-48", 0 ],
                                    "midpoints": [ 189.13636363636363, 399.0, 657.0, 399.0, 657.0, 285.0, 679.5, 285.0 ],
                                    "source": [ "obj-39", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-49", 0 ],
                                    "midpoints": [ 208.5909090909091, 399.0, 735.0, 399.0, 735.0, 285.0, 759.5, 285.0 ],
                                    "source": [ "obj-39", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-50", 0 ],
                                    "midpoints": [ 228.04545454545453, 399.0, 816.0, 399.0, 816.0, 285.0, 839.5, 285.0 ],
                                    "source": [ "obj-39", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-51", 0 ],
                                    "midpoints": [ 247.5, 390.0, 897.0, 390.0, 897.0, 285.0, 919.5, 285.0 ],
                                    "source": [ "obj-39", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-29", 0 ],
                                    "midpoints": [ 299.5, 63.0, 299.5, 63.0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "midpoints": [ 39.5, 324.0, 96.0, 324.0, 96.0, 246.0, 139.5, 246.0 ],
                                    "source": [ "obj-40", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "midpoints": [ 119.5, 324.0, 177.0, 324.0, 177.0, 246.0, 219.5, 246.0 ],
                                    "source": [ "obj-41", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "midpoints": [ 199.5, 324.0, 255.0, 324.0, 255.0, 246.0, 299.5, 246.0 ],
                                    "source": [ "obj-42", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "midpoints": [ 279.5, 324.0, 336.0, 324.0, 336.0, 246.0, 379.5, 246.0 ],
                                    "source": [ "obj-43", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-18", 0 ],
                                    "midpoints": [ 359.5, 324.0, 417.0, 324.0, 417.0, 246.0, 459.5, 246.0 ],
                                    "source": [ "obj-44", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "midpoints": [ 439.5, 324.0, 495.0, 324.0, 495.0, 246.0, 539.5, 246.0 ],
                                    "source": [ "obj-45", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "midpoints": [ 519.5, 324.0, 576.0, 324.0, 576.0, 246.0, 619.5, 246.0 ],
                                    "source": [ "obj-46", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "midpoints": [ 599.5, 324.0, 657.0, 324.0, 657.0, 246.0, 699.5, 246.0 ],
                                    "source": [ "obj-47", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-22", 0 ],
                                    "midpoints": [ 679.5, 324.0, 735.0, 324.0, 735.0, 246.0, 779.5, 246.0 ],
                                    "source": [ "obj-48", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "midpoints": [ 759.5, 324.0, 816.0, 324.0, 816.0, 246.0, 859.5, 246.0 ],
                                    "source": [ "obj-49", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-30", 0 ],
                                    "midpoints": [ 379.5, 63.0, 379.5, 63.0 ],
                                    "source": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "midpoints": [ 839.5, 324.0, 897.0, 324.0, 897.0, 246.0, 939.5, 246.0 ],
                                    "source": [ "obj-50", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "midpoints": [ 919.5, 324.0, 996.0, 324.0, 996.0, 246.0, 1019.5, 246.0 ],
                                    "source": [ "obj-51", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-31", 0 ],
                                    "midpoints": [ 459.5, 63.0, 459.5, 63.0 ],
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-32", 0 ],
                                    "midpoints": [ 539.5, 63.0, 539.5, 63.0 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "midpoints": [ 619.5, 63.0, 619.5, 63.0 ],
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-34", 0 ],
                                    "midpoints": [ 699.5, 63.0, 699.5, 63.0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 640.0, 156.0, 86.0, 22.0 ],
                    "text": "p degrees"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-87",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 153.0, 40.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 199.0, 42.0, 26.0, 18.0 ],
                    "text": "on",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "data": {
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
                            "rect": [ 100.0, 100.0, 600.0, 450.0 ],
                            "boxes": [
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "in 1",
                                        "patching_rect": [ 50.0, 20.0, 30.0, 22.0 ],
                                        "numoutlets": 1,
                                        "fontname": "Arial",
                                        "outlettype": [ "" ],
                                        "id": "obj-1",
                                        "numinlets": 0,
                                        "fontsize": 12.0
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "in 2",
                                        "patching_rect": [ 130.0, 20.0, 30.0, 22.0 ],
                                        "numoutlets": 1,
                                        "fontname": "Arial",
                                        "outlettype": [ "" ],
                                        "id": "obj-2",
                                        "numinlets": 0,
                                        "fontsize": 12.0
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "in 3",
                                        "patching_rect": [ 210.0, 20.0, 30.0, 22.0 ],
                                        "numoutlets": 1,
                                        "fontname": "Arial",
                                        "outlettype": [ "" ],
                                        "id": "obj-3",
                                        "numinlets": 0,
                                        "fontsize": 12.0
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "codebox",
                                        "patching_rect": [ 50.0, 80.0, 400.0, 200.0 ],
                                        "numoutlets": 1,
                                        "fontname": "<Monospaced>",
                                        "outlettype": [ "" ],
                                        "fontface": 0,
                                        "id": "obj-4",
                                        "numinlets": 3,
                                        "fontsize": 12.0,
                                        "code": "Param gaina(1.0, min=0, max=1);\nParam gainb(0.0, min=0, max=1);\nParam spacing(0., min=0, max=1);\nParam inversion(0.3, min=0, max=1);\nParam spacingratio(2., min=0.5, max=16.);\nParam inversionratio(0.5, min=0.03125, max=2.);\nParam spacingthresh(1., min=0., max=1.);\nParam inversionthresh(1., min=0., max=1.);\nParam lfoofs(0., min=0., max=6.2832);\nParam lforatea(0.5, min=0.01, max=20.);\nParam lfodeptha(0., min=0., max=1.);\nParam lforateb(0.5, min=0.01, max=20.);\nParam lfodepthb(0., min=0., max=1.);\nHistory phb(0);\nHistory phspc(0);\nHistory phinv(0);\nHistory phlfa(0);\nHistory phlfb(0);\nHistory sga(1.0);\nHistory sgb(0.0);\nHistory smix(0);\nHistory imix(0);\nBuffer wta(\"jiharmA\");\nBuffer wtb(\"jiharmB\");\n\n// dual morphing wavetable oscillator with spacing/inversion octave copies —\n// verbatim port of WavetableOscillator.h + WavetableVoice render/startNote\n// buffer layout: idx = mip*524288 + frame*2048 + sample (11 mips, 256 frames)\nf = max(in1, 0.);\n\n// v1.14 per-sub-voice LFOs: phases accumulate in lockstep across mc instances\n// (same rate history); per-instance random offset (lfoofs, root = 0) on top:\n// pos = clamp(basePos + sin(phase + ofs) * depth, 0, 1)\ntwopi = 6.28318530717959;\npla = wrap(phlfa + lforatea / samplerate, 0., 1.);\nphlfa = pla;\nplb = wrap(phlfb + lforateb / samplerate, 0., 1.);\nphlfb = plb;\nposa = clamp(in2 + sin(pla * twopi + lfoofs) * lfodeptha, 0., 1.);\nposb = clamp(in3 + sin(plb * twopi + lfoofs) * lfodepthb, 0., 1.);\n\n// spacing/inversion gates: live knob vs per-noteOn threshold, ~250 ms\n// one-pole crossfade (VST gainSmoothCoeff); baseMix = (1-s)(1-i)\nscoeff = 1. - exp(-1. / (0.25 * samplerate));\nsm = smix + ((spacing >= spacingthresh) - smix) * scoeff;\nsmix = sm;\nim = imix + ((inversion >= inversionthresh) - imix) * scoeff;\nimix = im;\nbasemix = (1. - sm) * (1. - im);\n\n// smoothed osc A/B gains (~20 ms), shared by all three groups\nga = sga + (gaina - sga) * 0.001;\nsga = ga;\ngb = sgb + (gainb - sgb) * 0.001;\nsgb = gb;\n\n// frame indices shared by all three groups (same modulated positions)\nfpa = posa * 255.;\nfa0 = floor(fpa);\nfa1 = min(fa0 + 1., 255.);\nffa = fpa - fa0;\nfpb = posb * 255.;\nfb0 = floor(fpb);\nfb1 = min(fb0 + 1., 255.);\nffb = fpb - fb0;\n\n// --- base group ---\nph = wrap(phb + f / samplerate, 0., 1.);\nphb = ph;\nlev = clamp(floor(log2(max(f, 1.) / 20.)), 0., 10.);\nmb = lev * 524288.;\nsp = ph * 2048.;\ns0 = floor(sp);\nsf = sp - s0;\ns1 = wrap(s0 + 1., 0., 2048.);\na00 = peek(wta, mb + fa0 * 2048. + s0, 0);\na01 = peek(wta, mb + fa0 * 2048. + s1, 0);\na10 = peek(wta, mb + fa1 * 2048. + s0, 0);\na11 = peek(wta, mb + fa1 * 2048. + s1, 0);\nla0 = a00 + sf * (a01 - a00);\nla1 = a10 + sf * (a11 - a10);\noa = la0 + ffa * (la1 - la0);\nb00 = peek(wtb, mb + fb0 * 2048. + s0, 0);\nb01 = peek(wtb, mb + fb0 * 2048. + s1, 0);\nb10 = peek(wtb, mb + fb1 * 2048. + s0, 0);\nb11 = peek(wtb, mb + fb1 * 2048. + s1, 0);\nlb0 = b00 + sf * (b01 - b00);\nlb1 = b10 + sf * (b11 - b10);\nob = lb0 + ffb * (lb1 - lb0);\ngbase = oa * ga + ob * gb;\n\n// --- spacing group (octave copies up, ratio rolled at noteOn) ---\nf2 = f * spacingratio;\nph2 = wrap(phspc + f2 / samplerate, 0., 1.);\nphspc = ph2;\nlev2 = clamp(floor(log2(max(f2, 1.) / 20.)), 0., 10.);\nmb2 = lev2 * 524288.;\nsp2 = ph2 * 2048.;\nt0 = floor(sp2);\ntf = sp2 - t0;\nt1 = wrap(t0 + 1., 0., 2048.);\nc00 = peek(wta, mb2 + fa0 * 2048. + t0, 0);\nc01 = peek(wta, mb2 + fa0 * 2048. + t1, 0);\nc10 = peek(wta, mb2 + fa1 * 2048. + t0, 0);\nc11 = peek(wta, mb2 + fa1 * 2048. + t1, 0);\nlc0 = c00 + tf * (c01 - c00);\nlc1 = c10 + tf * (c11 - c10);\noc = lc0 + ffa * (lc1 - lc0);\nd00 = peek(wtb, mb2 + fb0 * 2048. + t0, 0);\nd01 = peek(wtb, mb2 + fb0 * 2048. + t1, 0);\nd10 = peek(wtb, mb2 + fb1 * 2048. + t0, 0);\nd11 = peek(wtb, mb2 + fb1 * 2048. + t1, 0);\nld0 = d00 + tf * (d01 - d00);\nld1 = d10 + tf * (d11 - d10);\nod = ld0 + ffb * (ld1 - ld0);\ngspc = oc * ga + od * gb;\n\n// --- inversion group (octave copies down, ratio rolled at noteOn) ---\nf3 = f * inversionratio;\nph3 = wrap(phinv + f3 / samplerate, 0., 1.);\nphinv = ph3;\nlev3 = clamp(floor(log2(max(f3, 1.) / 20.)), 0., 10.);\nmb3 = lev3 * 524288.;\nsp3 = ph3 * 2048.;\nu0 = floor(sp3);\nuf = sp3 - u0;\nu1 = wrap(u0 + 1., 0., 2048.);\ne00 = peek(wta, mb3 + fa0 * 2048. + u0, 0);\ne01 = peek(wta, mb3 + fa0 * 2048. + u1, 0);\ne10 = peek(wta, mb3 + fa1 * 2048. + u0, 0);\ne11 = peek(wta, mb3 + fa1 * 2048. + u1, 0);\nle0 = e00 + uf * (e01 - e00);\nle1 = e10 + uf * (e11 - e10);\noe = le0 + ffa * (le1 - le0);\nv00 = peek(wtb, mb3 + fb0 * 2048. + u0, 0);\nv01 = peek(wtb, mb3 + fb0 * 2048. + u1, 0);\nv10 = peek(wtb, mb3 + fb1 * 2048. + u0, 0);\nv11 = peek(wtb, mb3 + fb1 * 2048. + u1, 0);\nlv0 = v00 + uf * (v01 - v00);\nlv1 = v10 + uf * (v11 - v10);\nov = lv0 + ffb * (lv1 - lv0);\nginv = oe * ga + ov * gb;\n\nout1 = gbase * basemix + gspc * sm + ginv * im;\n"
                                    }
                                },
                                {
                                    "box": {
                                        "maxclass": "newobj",
                                        "text": "out 1",
                                        "linecount": 2,
                                        "patching_rect": [ 50.0, 320.0, 30.0, 35.0 ],
                                        "numoutlets": 0,
                                        "fontname": "Arial",
                                        "id": "obj-5",
                                        "numinlets": 1,
                                        "fontsize": 12.0
                                    }
                                }
                            ],
                            "lines": [
                                {
                                    "patchline": {
                                        "source": [ "obj-1", 0 ],
                                        "destination": [ "obj-4", 0 ]
                                    }
                                },
                                {
                                    "patchline": {
                                        "source": [ "obj-2", 0 ],
                                        "destination": [ "obj-4", 1 ],
                                        "midpoints": [ 139.5, 12.0, 202.0, 12.0, 202.0, 50.0, 250.0, 50.0 ]
                                    }
                                },
                                {
                                    "patchline": {
                                        "source": [ "obj-3", 0 ],
                                        "destination": [ "obj-4", 2 ],
                                        "midpoints": [ 219.5, 61.0, 440.5, 61.0 ]
                                    }
                                },
                                {
                                    "patchline": {
                                        "source": [ "obj-4", 0 ],
                                        "destination": [ "obj-5", 0 ],
                                        "midpoints": [ 59.5, 300.0, 59.5, 300.0 ]
                                    }
                                }
                            ],
                            "bgcolor": [ 0.9, 0.9, 0.9, 1.0 ]
                        }
                    },
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-88",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1200.0, 275.0, 121.0, 22.0 ],
                    "text": "mc.gen~",
                    "wrapper_uniquekey": "u771000689"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-89",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 1200.0, 168.0, 282.0, 22.0 ],
                    "text": "buffer~ jiharmA bank00-ji-harmonic.wav"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-90",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 142.0, 380.0, 20.0 ],
                    "text": "per-osc banks: 20 rendered WAVs (11 mipmaps x 256 frames x 2048)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-91",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 4,
                    "outlettype": [ "signal", "signal", "signal", "" ],
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
                        "rect": [ 100.0, 100.0, 400.0, 300.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "Position A (0-1)",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "Position B (0-1)",
                                    "id": "obj-2",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "LFO Rate (Hz)",
                                    "id": "obj-3",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "LFO Depth (0-1)",
                                    "id": "obj-4",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 290.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "Position A signal",
                                    "id": "obj-5",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "Position B signal",
                                    "id": "obj-6",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 130.0, 250.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-7",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 100.0, 51.0, 22.0 ],
                                    "text": "$1 20"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-8",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 150.0, 100.0, 51.0, 22.0 ],
                                    "text": "$1 20"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "signal", "bang" ],
                                    "patching_rect": [ 45.0, 135.0, 51.0, 22.0 ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-10",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "signal", "bang" ],
                                    "patching_rect": [ 150.0, 135.0, 51.0, 22.0 ],
                                    "text": "line~"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-11",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 255.0, 105.0, 68.0, 22.0 ],
                                    "text": "cycle~"
                                }
                            },
                            {
                                "box": {
                                    "comment": "signal to cycle~",
                                    "id": "obj-15",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 370.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "signal to *~",
                                    "id": "obj-16",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 450.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "signal from cycle~",
                                    "id": "obj-19",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 210.0, 250.0, 30.0, 30.0 ]
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 185.0, 93.0, 22.0 ],
                                    "text": "lforatea $1"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 295.0, 215.0, 100.0, 22.0 ],
                                    "text": "lfodeptha $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-22",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 380.0, 185.0, 93.0, 22.0 ],
                                    "text": "lforateb $1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 465.0, 215.0, 100.0, 22.0 ],
                                    "text": "lfodepthb $1"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-24",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 285.0, 255.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-25",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "float", "float" ],
                                    "patching_rect": [ 210.0, 300.0, 93.0, 22.0 ],
                                    "text": "trigger f f"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-10", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "midpoints": [ 264.5, 142.0, 247.0, 142.0, 247.0, 180.0, 219.5, 180.0 ],
                                    "source": [ "obj-11", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-22", 0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-11", 0 ],
                                    "source": [ "obj-25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "source": [ "obj-25", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "midpoints": [ 59.5, 128.5, 54.5, 128.5 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "source": [ "obj-8", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 1250.0, 540.0, 86.0, 22.0 ],
                    "text": "p wtctl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 575.0, 72.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 130.0, 72.0, 20.0 ],
                    "text": "wt pos A"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-93",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1295.0, 585.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 152.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-94",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 605.0, 72.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 390.0, 130.0, 72.0, 20.0 ],
                    "text": "wt pos B"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-95",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1295.0, 630.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 390.0, 152.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-96",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 635.0, 72.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 186.0, 72.0, 20.0 ],
                    "text": "lfo A rate"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-97",
                    "maxclass": "flonum",
                    "maximum": 20.0,
                    "minimum": 0.01,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1295.0, 675.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 208.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-98",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 665.0, 79.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 310.0, 186.0, 72.0, 20.0 ],
                    "text": "lfo A depth"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-99",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1295.0, 720.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 310.0, 208.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-100",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 695.0, 86.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 310.0, 130.0, 72.0, 20.0 ],
                    "text": "osc gain A"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-101",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1295.0, 765.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 310.0, 152.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 725.0, 86.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 130.0, 72.0, 20.0 ],
                    "text": "osc gain B"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-103",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1295.0, 810.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 152.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1380.0, 695.0, 72.0, 22.0 ],
                    "text": "gaina $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-105",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1380.0, 725.0, 72.0, 22.0 ],
                    "text": "gainb $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 45.0, 660.0, 72.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 16,
                    "outlettype": [ "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang", "bang" ],
                    "patching_rect": [ 45.0, 700.0, 289.0, 22.0 ],
                    "text": "trigger b b b b b b b b b b b b b b b b"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 745.0, 40.0, 22.0 ],
                    "text": "0.5"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 107.0, 745.0, 40.0, 22.0 ],
                    "text": "0.5"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 169.0, 745.0, 40.0, 22.0 ],
                    "text": "0.5"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 231.0, 745.0, 44.0, 22.0 ],
                    "text": "0.25"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 293.0, 745.0, 40.0, 22.0 ],
                    "text": "1."
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 780.0, 40.0, 22.0 ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-114",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 120.0, 261.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 106.0, 260.0, 20.0 ],
                    "text": "WAVETABLE ENGINE (dual osc, 20 banks)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-115",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 120.0, 465.0, 149.0, 22.0 ],
                    "text": "prepend applyvalues"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-116",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1480.0, 540.0, 135.0, 22.0 ],
                    "text": "mc.sig~ @chans 12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-117",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1480.0, 630.0, 184.0, 22.0 ],
                    "text": "mc.rampsmooth~ 2205 2205"
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
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1480.0, 585.0, 51.0, 22.0 ],
                    "text": "mc.*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-119",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 1480.0, 675.0, 164.0, 22.0 ],
                    "text": "mc.mixdown~ 1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-120",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 1410.0, 410.0, 42.0, 22.0 ],
                    "text": "*~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-121",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 1410.0, 455.0, 58.0, 22.0 ],
                    "text": "*~ 0.1"
                }
            },
            {
                "box": {
                    "id": "obj-122",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1155.0, 780.0, 22.0, 140.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-123",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 1185.0, 780.0, 15.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 672.0, 110.0, 15.0, 150.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-124",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 530.0, 325.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 290.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-125",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 295.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 268.0, 72.0, 18.0 ],
                    "text": "spread",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-126",
                    "maxclass": "flonum",
                    "maximum": 50.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 590.0, 340.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 310.0, 290.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-127",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 592.0, 295.0, 79.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 310.0, 268.0, 72.0, 18.0 ],
                    "text": "detune ct",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-128",
                    "maxclass": "flonum",
                    "maximum": 100.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 650.0, 340.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 390.0, 290.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-129",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 654.0, 295.0, 79.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 390.0, 268.0, 72.0, 18.0 ],
                    "text": "timing ms",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-130",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 270.0, 275.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 244.0, 260.0, 18.0 ],
                    "text": "CHORD FEEL (spread / detune / timing)",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-131",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 1200.0, 196.0, 282.0, 22.0 ],
                    "text": "buffer~ jiharmB bank00-ji-harmonic.wav"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-132",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 30.0, 114.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 322.0, 100.0, 20.0 ],
                    "text": "bank A (osc A)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-133",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1400.0, 30.0, 114.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 410.0, 322.0, 100.0, 20.0 ],
                    "text": "bank B (osc B)"
                }
            },
            {
                "box": {
                    "id": "obj-134",
                    "items": [ "bank00-ji-harmonic.wav", ",", "bank01-warm-analog.wav", ",", "bank02-choir.wav", ",", "bank03-strings.wav", ",", "bank04-glass.wav", ",", "bank05-evolving.wav", ",", "bank06-organ.wav", ",", "bank07-ethereal.wav", ",", "bank08-dark-matter.wav", ",", "bank09-sine.wav", ",", "bank10-square.wav", ",", "bank11-triangle.wav", ",", "bank12-spectral-cloud.wav", ",", "bank13-metallic-resonance.wav", ",", "bank14-formant-vowel.wav", ",", "bank15-warm-sub.wav", ",", "bank16-soft-flute.wav", ",", "bank17-velvet-pad.wav", ",", "bank18-whisper.wav", ",", "bank19-deep-haze.wav" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1200.0, 55.0, 185.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 230.0, 344.0, 170.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-135",
                    "items": [ "bank00-ji-harmonic.wav", ",", "bank01-warm-analog.wav", ",", "bank02-choir.wav", ",", "bank03-strings.wav", ",", "bank04-glass.wav", ",", "bank05-evolving.wav", ",", "bank06-organ.wav", ",", "bank07-ethereal.wav", ",", "bank08-dark-matter.wav", ",", "bank09-sine.wav", ",", "bank10-square.wav", ",", "bank11-triangle.wav", ",", "bank12-spectral-cloud.wav", ",", "bank13-metallic-resonance.wav", ",", "bank14-formant-vowel.wav", ",", "bank15-warm-sub.wav", ",", "bank16-soft-flute.wav", ",", "bank17-velvet-pad.wav", ",", "bank18-whisper.wav", ",", "bank19-deep-haze.wav" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1400.0, 55.0, 185.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 410.0, 344.0, 170.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-136",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1200.0, 85.0, 121.0, 22.0 ],
                    "text": "prepend replace"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-137",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1400.0, 85.0, 121.0, 22.0 ],
                    "text": "prepend replace"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-138",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "signal" ],
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
                        "rect": [ 100.0, 100.0, 600.0, 450.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 20.0, 30.0, 22.0 ],
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 130.0, 20.0, 30.0, 22.0 ],
                                    "text": "in 2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 20.0, 30.0, 22.0 ],
                                    "text": "in 3"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param cutoff(8000., min=20., max=20000.);\nParam res(0.707, min=0.5, max=10.);\nParam lfodepth(0., min=0., max=1.);\nParam veltofilt(0., min=0., max=1.);\nParam vel(1., min=0., max=1.);\nHistory smoothcut(8000.);\nHistory s1l(0.);\nHistory s2l(0.);\nHistory s1r(0.);\nHistory s2r(0.);\n\n// master TPT SVF lowpass -- verbatim port of the VST master-bus filter\n// (JUCE StateVariableTPTFilter, Zavalishin TPT structure)\n// in1/in2 = L/R post-envelope, in3 = LFO A signal (sin of phase A)\n\n// velocity mod (VST v2.2.0): cutoff * (1 - veltofilt * (1 - lastNoteVelocity))\n// then ~20 ms one-pole smoothing (VST uses a 20 ms linear ramp)\ntarget = cutoff * (1. - veltofilt * (1. - vel));\nsc = smoothcut + (target - smoothcut) * 0.001;\nsmoothcut = sc;\n\n// filter LFO (VST v2.2.0): cutoff * 2^(sin(phaseA) * depth * 2), clamped\nfc = clamp(sc * pow(2., in3 * lfodepth * 2.), 20., 20000.);\n\ng = tan(3.14159265358979 * fc / samplerate);\nr2 = 1. / res;\nh = 1. / (1. + r2 * g + g * g);\n\nhpl = h * (in1 - s1l * (g + r2) - s2l);\nbpl = hpl * g + s1l;\ns1l = hpl * g + bpl;\nlpl = bpl * g + s2l;\ns2l = bpl * g + lpl;\n\nhpr = h * (in2 - s1r * (g + r2) - s2r);\nbpr = hpr * g + s1r;\ns1r = hpr * g + bpr;\nlpr = bpr * g + s2r;\ns2r = bpr * g + lpr;\n\nout1 = lpl;\nout2 = lpr;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-4",
                                    "maxclass": "codebox",
                                    "numinlets": 3,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 50.0, 80.0, 400.0, 200.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-5",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 320.0, 30.0, 22.0 ],
                                    "text": "out 1"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-6",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 130.0, 320.0, 30.0, 22.0 ],
                                    "text": "out 2"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 1 ],
                                    "midpoints": [ 139.5, 12.0, 202.0, 12.0, 202.0, 50.0, 250.0, 50.0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 2 ],
                                    "midpoints": [ 219.5, 61.0, 440.5, 61.0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "midpoints": [ 440.5, 300.0, 139.5, 300.0 ],
                                    "source": [ "obj-4", 1 ]
                                }
                            }
                        ],
                        "bgcolor": [ 0.9, 0.9, 0.9, 1.0 ]
                    },
                    "patching_rect": [ 530.0, 880.0, 121.0, 22.0 ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-139",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1200.0, 487.0, 100.0, 22.0 ],
                    "text": "send~ jhFinL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-140",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1410.0, 487.0, 100.0, 22.0 ],
                    "text": "send~ jhFinR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-141",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 530.0, 830.0, 121.0, 22.0 ],
                    "text": "receive~ jhFinL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-142",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 660.0, 830.0, 121.0, 22.0 ],
                    "text": "receive~ jhFinR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-143",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 960.0, 107.0, 22.0 ],
                    "text": "send~ jhFoutL"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-144",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 660.0, 960.0, 107.0, 22.0 ],
                    "text": "send~ jhFoutR"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 1275.0, 405.0, 128.0, 22.0 ],
                    "text": "receive~ jhFoutL"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 1475.0, 420.0, 128.0, 22.0 ],
                    "text": "receive~ jhFoutR"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-147",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [ "float", "float" ],
                    "patching_rect": [ 645.0, 692.0, 121.0, 22.0 ],
                    "text": "split 0.0001 1."
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 645.0, 727.0, 58.0, 22.0 ],
                    "text": "vel $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-149",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 530.0, 780.0, 240.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 496.0, 200.0, 20.0 ],
                    "text": "FILTER (master TPT LP, post-env)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-150",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 810.0, 79.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 520.0, 76.0, 20.0 ],
                    "text": "cutoff Hz"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-151",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 865.0, 810.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 542.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-152",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 930.0, 810.0, 79.0, 22.0 ],
                    "text": "cutoff $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-153",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 855.0, 79.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 95.0, 520.0, 76.0, 20.0 ],
                    "text": "resonance"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-154",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 865.0, 855.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 95.0, 542.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-155",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 930.0, 855.0, 58.0, 22.0 ],
                    "text": "res $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-156",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 900.0, 114.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 175.0, 520.0, 76.0, 20.0 ],
                    "text": "filter lfo (A)"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-157",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 865.0, 900.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 175.0, 542.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-158",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 930.0, 900.0, 93.0, 22.0 ],
                    "text": "lfodepth $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-159",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 945.0, 100.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 255.0, 520.0, 76.0, 20.0 ],
                    "text": "vel > filter"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-160",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 865.0, 945.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 255.0, 542.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-161",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 930.0, 945.0, 100.0, 22.0 ],
                    "text": "veltofilt $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-162",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 990.0, 86.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 335.0, 520.0, 76.0, 20.0 ],
                    "text": "lfo B rate"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-163",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 865.0, 990.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 335.0, 542.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-164",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 1035.0, 93.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 415.0, 520.0, 76.0, 20.0 ],
                    "text": "lfo B depth"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-165",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 865.0, 1035.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 415.0, 542.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-166",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 107.0, 780.0, 40.0, 22.0 ],
                    "text": "0.5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-167",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 169.0, 780.0, 40.0, 22.0 ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-168",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 231.0, 780.0, 51.0, 22.0 ],
                    "text": "8000."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-169",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 293.0, 780.0, 51.0, 22.0 ],
                    "text": "0.707"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-170",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 815.0, 40.0, 22.0 ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-171",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 107.0, 815.0, 40.0, 22.0 ],
                    "text": "0."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-172",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "float" ],
                    "patching_rect": [ 530.0, 692.0, 93.0, 22.0 ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-173",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 620.0, 532.0, 58.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 604.0, 76.0, 20.0 ],
                    "text": "atk ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-174",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 1.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 620.0, 557.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 626.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-175",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 680.0, 532.0, 58.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 95.0, 604.0, 76.0, 20.0 ],
                    "text": "dec ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-176",
                    "maxclass": "flonum",
                    "maximum": 5000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 680.0, 557.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 95.0, 626.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-177",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 740.0, 532.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 175.0, 604.0, 76.0, 20.0 ],
                    "text": "sus"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-178",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 740.0, 557.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 175.0, 626.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-179",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 800.0, 532.0, 58.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 255.0, 604.0, 76.0, 20.0 ],
                    "text": "rel ms"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-180",
                    "maxclass": "flonum",
                    "maximum": 10000.0,
                    "minimum": 10.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 800.0, 557.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 255.0, 626.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-181",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 169.0, 815.0, 40.0, 22.0 ],
                    "text": "10."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-182",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 231.0, 815.0, 44.0, 22.0 ],
                    "text": "150."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-183",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 293.0, 815.0, 40.0, 22.0 ],
                    "text": "0.7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-184",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 850.0, 44.0, 22.0 ],
                    "text": "400."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-185",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 620.0, 510.0, 73.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 15.0, 580.0, 200.0, 20.0 ],
                    "text": "ENVELOPE"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-186",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 710.0, 295.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 268.0, 72.0, 18.0 ],
                    "text": "spacing",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-187",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 770.0, 295.0, 66.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 550.0, 268.0, 72.0, 18.0 ],
                    "text": "inversion",
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-188",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 710.0, 340.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 470.0, 290.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-189",
                    "maxclass": "flonum",
                    "maximum": 1.0,
                    "minimum": 0.0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 770.0, 340.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 550.0, 290.0, 64.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-190",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 710.0, 370.0, 86.0, 22.0 ],
                    "text": "spacing $1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-191",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 830.0, 370.0, 100.0, 22.0 ],
                    "text": "inversion $1"
                }
            },
            {
                "box": {
                    "id": "obj-192",
                    "items": [ "Custom (harm 16-30)", ",", "12-TET", ",", "Pythagorean", ",", "Zarlino (Just Major)", ",", "Meantone 1/4", ",", "Werckmeister III", ",", "Kirnberger III", ",", "Vallotti", ",", "Well Tempered", ",", "Just Intonation", ",", "Bohlen-Pierce" ],
                    "maxclass": "umenu",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 45.0, 565.0, 150.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 96.0, 376.0, 128.0, 22.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-193",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 45.0, 540.0, 93.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 16.0, 378.0, 78.0, 18.0 ],
                    "text": "temperament"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 45.0, 610.0, 149.0, 22.0 ],
                    "text": "prepend temperament"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-195",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 12,
                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "" ],
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
                        "rect": [ 100.0, 100.0, 400.0, 300.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "[degree, ratiotext] from js outlet 6",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 30.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 30.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-3",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 120.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-4",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 210.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-5",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 300.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-6",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 390.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-7",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 480.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-8",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 570.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-9",
                                    "index": 8,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 660.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-10",
                                    "index": 9,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 750.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-11",
                                    "index": 10,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 840.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-12",
                                    "index": 11,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 930.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-13",
                                    "index": 12,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 1020.0, 225.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-14",
                                    "maxclass": "newobj",
                                    "numinlets": 13,
                                    "numoutlets": 13,
                                    "outlettype": [ "", "", "", "", "", "", "", "", "", "", "", "", "" ],
                                    "patching_rect": [ 30.0, 75.0, 233.0, 22.0 ],
                                    "text": "route 0 1 2 3 4 5 6 7 8 9 10 11"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-15",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 30.0, 150.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 120.0, 195.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-17",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 210.0, 150.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-18",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 300.0, 195.0, 97.0, 22.0 ],
                                    "text": "prepend set"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 390.0, 150.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-20",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 480.0, 195.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 570.0, 150.0, 97.0, 22.0 ],
                                    "text": "prepend set"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 660.0, 195.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 750.0, 150.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 840.0, 195.0, 97.0, 22.0 ],
                                    "text": "prepend set"
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 930.0, 150.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 1020.0, 195.0, 97.0, 22.0 ],
                                    "text": "prepend set"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "source": [ "obj-14", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "source": [ "obj-14", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-18", 0 ],
                                    "source": [ "obj-14", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "source": [ "obj-14", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "source": [ "obj-14", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-14", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-22", 0 ],
                                    "source": [ "obj-14", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-14", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-14", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "source": [ "obj-14", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "source": [ "obj-14", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "source": [ "obj-15", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-17", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-18", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-19", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-7", 0 ],
                                    "source": [ "obj-20", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "source": [ "obj-22", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-11", 0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 0 ],
                                    "source": [ "obj-25", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 1030.0, 220.0, 86.0, 22.0 ],
                    "text": "p ratioset"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-196",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 106.0, 220.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 106.0, 220.0, 20.0 ],
                    "text": "SOUNDING PITCHES"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-197",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 130.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 130.0, 20.0, 18.0 ],
                    "text": "#"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-198",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 130.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 130.0, 58.0, 18.0 ],
                    "text": "freq Hz"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-199",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 130.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 130.0, 112.0, 18.0 ],
                    "text": "interval (actual)"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-200",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 130.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 130.0, 64.0, 18.0 ],
                    "text": "note"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-201",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 152.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 152.0, 20.0, 18.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-202",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 152.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 152.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-203",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 152.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 152.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-204",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 152.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 152.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-205",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 172.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 172.0, 20.0, 18.0 ],
                    "text": "2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-206",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 172.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 172.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-207",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 172.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 172.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-208",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 172.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 172.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-209",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 192.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 192.0, 20.0, 18.0 ],
                    "text": "3"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-210",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 192.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 192.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-211",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 192.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 192.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-212",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 192.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 192.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n2"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-213",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 212.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 212.0, 20.0, 18.0 ],
                    "text": "4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-214",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 212.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 212.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f3"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-215",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 212.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 212.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i3"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-216",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 212.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 212.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n3"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-217",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 232.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 232.0, 20.0, 18.0 ],
                    "text": "5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-218",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 232.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 232.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-219",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 232.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 232.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-220",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 232.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 232.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-221",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 252.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 252.0, 20.0, 18.0 ],
                    "text": "6"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-222",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 252.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 252.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-223",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 252.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 252.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-224",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 252.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 252.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n5"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-225",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 272.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 272.0, 20.0, 18.0 ],
                    "text": "7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-226",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 272.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 272.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f6"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-227",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 272.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 272.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i6"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-228",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 272.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 272.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n6"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-229",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 292.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 292.0, 20.0, 18.0 ],
                    "text": "8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-230",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 292.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 292.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-231",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 292.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 292.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-232",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 292.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 292.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n7"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-233",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 312.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 312.0, 20.0, 18.0 ],
                    "text": "9"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-234",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 312.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 312.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-235",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 312.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 312.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-236",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 312.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 312.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n8"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-237",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 332.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 332.0, 20.0, 18.0 ],
                    "text": "10"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-238",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 332.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 332.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f9"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-239",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 332.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 332.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i9"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-240",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 332.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 332.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n9"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-241",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 352.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 352.0, 20.0, 18.0 ],
                    "text": "11"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-242",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 352.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 352.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f10"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-243",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 352.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 352.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i10"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-244",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 352.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 352.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n10"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-245",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1700.0, 372.0, 20.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 700.0, 372.0, 20.0, 18.0 ],
                    "text": "12"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-246",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1722.0, 372.0, 58.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 722.0, 372.0, 58.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_f11"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-247",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1786.0, 372.0, 112.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 786.0, 372.0, 112.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_i11"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-248",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1904.0, 372.0, 64.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 904.0, 372.0, 64.0, 18.0 ],
                    "text": "-",
                    "varname": "pd_n11"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-3", 1 ],
                    "midpoints": [ 59.0, 147.0, 213.5, 147.0 ],
                    "source": [ "obj-1", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 39.5, 147.0, 144.5, 147.0 ],
                    "source": [ "obj-1", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-104", 0 ],
                    "midpoints": [ 1304.5, 789.0, 1365.0, 789.0, 1365.0, 690.0, 1389.5, 690.0 ],
                    "source": [ "obj-101", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-105", 0 ],
                    "midpoints": [ 1304.5, 843.0, 1365.0, 843.0, 1365.0, 720.0, 1389.5, 720.0 ],
                    "source": [ "obj-103", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 1389.5, 720.0, 1356.0, 720.0, 1356.0, 474.0, 1185.0, 474.0, 1185.0, 270.0, 1209.5, 270.0 ],
                    "source": [ "obj-104", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 1389.5, 750.0, 1356.0, 750.0, 1356.0, 474.0, 1185.0, 474.0, 1185.0, 270.0, 1209.5, 270.0 ],
                    "source": [ "obj-105", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-107", 0 ],
                    "midpoints": [ 54.5, 684.0, 54.5, 684.0 ],
                    "source": [ "obj-106", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-108", 0 ],
                    "midpoints": [ 54.5, 723.0, 54.5, 723.0 ],
                    "source": [ "obj-107", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-109", 0 ],
                    "midpoints": [ 72.5, 732.0, 116.5, 732.0 ],
                    "source": [ "obj-107", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-110", 0 ],
                    "midpoints": [ 90.5, 732.0, 178.5, 732.0 ],
                    "source": [ "obj-107", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-111", 0 ],
                    "midpoints": [ 108.5, 732.0, 240.5, 732.0 ],
                    "source": [ "obj-107", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-112", 0 ],
                    "midpoints": [ 126.5, 732.0, 302.5, 732.0 ],
                    "source": [ "obj-107", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-113", 0 ],
                    "midpoints": [ 144.5, 732.0, 30.0, 732.0, 30.0, 777.0, 54.5, 777.0 ],
                    "source": [ "obj-107", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-166", 0 ],
                    "midpoints": [ 162.5, 732.0, 147.0, 732.0, 147.0, 777.0, 116.5, 777.0 ],
                    "source": [ "obj-107", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-167", 0 ],
                    "midpoints": [ 180.5, 732.0, 165.0, 732.0, 165.0, 774.0, 178.5, 774.0 ],
                    "source": [ "obj-107", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-168", 0 ],
                    "midpoints": [ 198.5, 732.0, 228.0, 732.0, 228.0, 774.0, 240.5, 774.0 ],
                    "source": [ "obj-107", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-169", 0 ],
                    "midpoints": [ 216.5, 732.0, 288.0, 732.0, 288.0, 774.0, 302.5, 774.0 ],
                    "source": [ "obj-107", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-170", 0 ],
                    "midpoints": [ 234.5, 732.0, 30.0, 732.0, 30.0, 810.0, 54.5, 810.0 ],
                    "source": [ "obj-107", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-171", 0 ],
                    "midpoints": [ 252.5, 732.0, 147.0, 732.0, 147.0, 810.0, 116.5, 810.0 ],
                    "source": [ "obj-107", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-181", 0 ],
                    "midpoints": [ 270.5, 732.0, 210.0, 732.0, 210.0, 810.0, 178.5, 810.0 ],
                    "source": [ "obj-107", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-182", 0 ],
                    "midpoints": [ 288.5, 732.0, 228.0, 732.0, 228.0, 807.0, 240.5, 807.0 ],
                    "source": [ "obj-107", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-183", 0 ],
                    "midpoints": [ 306.5, 732.0, 288.0, 732.0, 288.0, 807.0, 302.5, 807.0 ],
                    "source": [ "obj-107", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-184", 0 ],
                    "midpoints": [ 324.5, 732.0, 30.0, 732.0, 30.0, 846.0, 54.5, 846.0 ],
                    "source": [ "obj-107", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-93", 0 ],
                    "midpoints": [ 54.5, 768.0, 30.0, 768.0, 30.0, 642.0, 1185.0, 642.0, 1185.0, 561.0, 1245.0, 561.0, 1245.0, 570.0, 1299.0, 570.0, 1299.0, 582.0, 1304.5, 582.0 ],
                    "source": [ "obj-108", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-95", 0 ],
                    "midpoints": [ 116.5, 768.0, 147.0, 768.0, 147.0, 732.0, 516.0, 732.0, 516.0, 636.0, 1185.0, 636.0, 1185.0, 627.0, 1304.5, 627.0 ],
                    "source": [ "obj-109", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 3 ],
                    "midpoints": [ 725.5, 444.0, 690.0, 444.0, 690.0, 462.0, 688.2142857142857, 462.0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 0 ],
                    "midpoints": [ 178.5, 768.0, 210.0, 768.0, 210.0, 732.0, 516.0, 732.0, 516.0, 660.0, 1299.0, 660.0, 1299.0, 672.0, 1304.5, 672.0 ],
                    "source": [ "obj-110", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-99", 0 ],
                    "midpoints": [ 240.5, 768.0, 345.0, 768.0, 345.0, 759.0, 1290.0, 759.0, 1290.0, 717.0, 1304.5, 717.0 ],
                    "source": [ "obj-111", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-101", 0 ],
                    "midpoints": [ 302.5, 768.0, 345.0, 768.0, 345.0, 762.0, 1304.5, 762.0 ],
                    "source": [ "obj-112", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-103", 0 ],
                    "midpoints": [ 54.5, 804.0, 30.0, 804.0, 30.0, 732.0, 630.0, 732.0, 630.0, 765.0, 1281.0, 765.0, 1281.0, 807.0, 1304.5, 807.0 ],
                    "source": [ "obj-113", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-116", 0 ],
                    "midpoints": [ 129.5, 507.0, 1185.0, 507.0, 1185.0, 525.0, 1489.5, 525.0 ],
                    "source": [ "obj-115", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-117", 0 ],
                    "midpoints": [ 1489.5, 564.0, 1467.0, 564.0, 1467.0, 627.0, 1489.5, 627.0 ],
                    "source": [ "obj-116", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-118", 1 ],
                    "midpoints": [ 1489.5, 654.0, 1467.0, 654.0, 1467.0, 582.0, 1521.5, 582.0 ],
                    "source": [ "obj-117", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-119", 0 ],
                    "midpoints": [ 1489.5, 609.0, 1467.0, 609.0, 1467.0, 672.0, 1489.5, 672.0 ],
                    "source": [ "obj-118", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-120", 0 ],
                    "midpoints": [ 1489.5, 699.0, 1464.0, 699.0, 1464.0, 519.0, 1395.0, 519.0, 1395.0, 429.0, 1407.0, 429.0, 1407.0, 405.0, 1419.5, 405.0 ],
                    "source": [ "obj-119", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-140", 0 ],
                    "midpoints": [ 1419.5, 435.0, 1395.0, 435.0, 1395.0, 483.0, 1419.5, 483.0 ],
                    "source": [ "obj-120", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-122", 0 ],
                    "midpoints": [ 1419.5, 480.0, 1311.0, 480.0, 1311.0, 525.0, 1164.5, 525.0 ],
                    "source": [ "obj-121", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-123", 0 ],
                    "midpoints": [ 1164.5, 921.0, 1212.0, 921.0, 1212.0, 777.0, 1194.0, 777.0 ],
                    "order": 0,
                    "source": [ "obj-122", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 1 ],
                    "midpoints": [ 1164.5, 930.0, 1115.5, 930.0 ],
                    "order": 1,
                    "source": [ "obj-122", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 5 ],
                    "midpoints": [ 539.5, 405.0, 707.3571428571429, 405.0 ],
                    "source": [ "obj-124", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 6 ],
                    "midpoints": [ 599.5, 405.0, 711.0, 405.0, 711.0, 462.0, 716.9285714285714, 462.0 ],
                    "source": [ "obj-126", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 7 ],
                    "midpoints": [ 659.5, 405.0, 711.0, 405.0, 711.0, 462.0, 726.5, 462.0 ],
                    "source": [ "obj-128", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 4 ],
                    "midpoints": [ 787.5, 462.0, 697.7857142857143, 462.0 ],
                    "source": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-136", 0 ],
                    "midpoints": [ 1292.5, 78.0, 1209.5, 78.0 ],
                    "source": [ "obj-134", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-137", 0 ],
                    "midpoints": [ 1492.5, 78.0, 1409.5, 78.0 ],
                    "source": [ "obj-135", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-89", 0 ],
                    "midpoints": [ 1209.5, 108.0, 1185.0, 108.0, 1185.0, 165.0, 1209.5, 165.0 ],
                    "source": [ "obj-136", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-131", 0 ],
                    "midpoints": [ 1409.5, 108.0, 1185.0, 108.0, 1185.0, 192.0, 1209.5, 192.0 ],
                    "source": [ "obj-137", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-143", 0 ],
                    "midpoints": [ 539.5, 903.0, 539.5, 903.0 ],
                    "source": [ "obj-138", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 0 ],
                    "midpoints": [ 641.5, 945.0, 669.5, 945.0 ],
                    "source": [ "obj-138", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 0 ],
                    "midpoints": [ 539.5, 855.0, 539.5, 855.0 ],
                    "source": [ "obj-141", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 1 ],
                    "midpoints": [ 669.5, 867.0, 590.5, 867.0 ],
                    "source": [ "obj-142", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-64", 0 ],
                    "midpoints": [ 1284.5, 429.0, 1242.0, 429.0, 1242.0, 432.0, 1224.5, 432.0 ],
                    "source": [ "obj-145", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-121", 0 ],
                    "midpoints": [ 1484.5, 444.0, 1422.0, 444.0, 1422.0, 450.0, 1419.5, 450.0 ],
                    "source": [ "obj-146", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-148", 0 ],
                    "midpoints": [ 654.5, 717.0, 654.5, 717.0 ],
                    "source": [ "obj-147", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 0 ],
                    "midpoints": [ 654.5, 765.0, 516.0, 765.0, 516.0, 867.0, 539.5, 867.0 ],
                    "source": [ "obj-148", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 659.5, 489.0, 477.0, 489.0, 477.0, 225.0, 129.5, 225.0 ],
                    "source": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-152", 0 ],
                    "midpoints": [ 874.5, 834.0, 927.0, 834.0, 927.0, 807.0, 939.5, 807.0 ],
                    "source": [ "obj-151", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 0 ],
                    "midpoints": [ 939.5, 834.0, 852.0, 834.0, 852.0, 840.0, 783.0, 840.0, 783.0, 852.0, 756.0, 852.0, 756.0, 867.0, 539.5, 867.0 ],
                    "source": [ "obj-152", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-155", 0 ],
                    "midpoints": [ 874.5, 879.0, 927.0, 879.0, 927.0, 852.0, 939.5, 852.0 ],
                    "source": [ "obj-154", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 0 ],
                    "midpoints": [ 939.5, 879.0, 663.0, 879.0, 663.0, 867.0, 539.5, 867.0 ],
                    "source": [ "obj-155", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-158", 0 ],
                    "midpoints": [ 874.5, 924.0, 927.0, 924.0, 927.0, 897.0, 939.5, 897.0 ],
                    "source": [ "obj-157", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 0 ],
                    "midpoints": [ 939.5, 924.0, 915.0, 924.0, 915.0, 885.0, 663.0, 885.0, 663.0, 867.0, 539.5, 867.0 ],
                    "source": [ "obj-158", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-161", 0 ],
                    "midpoints": [ 874.5, 969.0, 927.0, 969.0, 927.0, 942.0, 939.5, 942.0 ],
                    "source": [ "obj-160", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 0 ],
                    "midpoints": [ 939.5, 969.0, 915.0, 969.0, 915.0, 930.0, 663.0, 930.0, 663.0, 867.0, 539.5, 867.0 ],
                    "source": [ "obj-161", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 4 ],
                    "midpoints": [ 874.5, 1014.0, 1065.0, 1014.0, 1065.0, 525.0, 1313.1, 525.0 ],
                    "source": [ "obj-163", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 5 ],
                    "midpoints": [ 874.5, 1068.0, 1065.0, 1068.0, 1065.0, 525.0, 1326.5, 525.0 ],
                    "source": [ "obj-165", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-163", 0 ],
                    "midpoints": [ 116.5, 810.0, 147.0, 810.0, 147.0, 906.0, 516.0, 906.0, 516.0, 1020.0, 861.0, 1020.0, 861.0, 987.0, 874.5, 987.0 ],
                    "source": [ "obj-166", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-165", 0 ],
                    "midpoints": [ 178.5, 810.0, 210.0, 810.0, 210.0, 906.0, 516.0, 906.0, 516.0, 1020.0, 870.0, 1020.0, 870.0, 1032.0, 874.5, 1032.0 ],
                    "source": [ "obj-167", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-151", 0 ],
                    "midpoints": [ 240.5, 804.0, 516.0, 804.0, 516.0, 765.0, 874.5, 765.0 ],
                    "source": [ "obj-168", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-154", 0 ],
                    "midpoints": [ 302.5, 804.0, 516.0, 804.0, 516.0, 867.0, 756.0, 867.0, 756.0, 885.0, 861.0, 885.0, 861.0, 852.0, 874.5, 852.0 ],
                    "source": [ "obj-169", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-157", 0 ],
                    "midpoints": [ 54.5, 846.0, 99.0, 846.0, 99.0, 867.0, 756.0, 867.0, 756.0, 885.0, 870.0, 885.0, 870.0, 897.0, 874.5, 897.0 ],
                    "source": [ "obj-170", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-160", 0 ],
                    "midpoints": [ 116.5, 867.0, 756.0, 867.0, 756.0, 930.0, 870.0, 930.0, 870.0, 942.0, 874.5, 942.0 ],
                    "source": [ "obj-171", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-147", 0 ],
                    "midpoints": [ 613.5, 717.0, 642.0, 717.0, 642.0, 687.0, 654.5, 687.0 ],
                    "source": [ "obj-172", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-62", 0 ],
                    "midpoints": [ 539.5, 717.0, 516.0, 717.0, 516.0, 597.0, 654.5, 597.0 ],
                    "source": [ "obj-172", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-62", 1 ],
                    "midpoints": [ 629.5, 597.0, 694.0, 597.0 ],
                    "source": [ "obj-174", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-62", 2 ],
                    "midpoints": [ 689.5, 597.0, 733.5, 597.0 ],
                    "source": [ "obj-176", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-62", 3 ],
                    "midpoints": [ 749.5, 594.0, 773.0, 594.0 ],
                    "source": [ "obj-178", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 934.5, 225.0, 129.5, 225.0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-62", 4 ],
                    "midpoints": [ 809.5, 597.0, 812.5, 597.0 ],
                    "source": [ "obj-180", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-174", 0 ],
                    "midpoints": [ 178.5, 849.0, 516.0, 849.0, 516.0, 552.0, 629.5, 552.0 ],
                    "source": [ "obj-181", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-176", 0 ],
                    "midpoints": [ 240.5, 849.0, 516.0, 849.0, 516.0, 552.0, 689.5, 552.0 ],
                    "source": [ "obj-182", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-178", 0 ],
                    "midpoints": [ 302.5, 849.0, 516.0, 849.0, 516.0, 552.0, 749.5, 552.0 ],
                    "source": [ "obj-183", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-180", 0 ],
                    "midpoints": [ 54.5, 882.0, 516.0, 882.0, 516.0, 636.0, 852.0, 636.0, 852.0, 552.0, 809.5, 552.0 ],
                    "source": [ "obj-184", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-190", 0 ],
                    "midpoints": [ 719.5, 363.0, 719.5, 363.0 ],
                    "source": [ "obj-188", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-191", 0 ],
                    "midpoints": [ 779.5, 363.0, 839.5, 363.0 ],
                    "source": [ "obj-189", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 0 ],
                    "midpoints": [ 649.5, 87.0, 906.0, 87.0, 906.0, 162.0, 934.5, 162.0 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 719.5, 402.0, 1185.0, 402.0, 1185.0, 270.0, 1209.5, 270.0 ],
                    "source": [ "obj-190", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 839.5, 402.0, 1185.0, 402.0, 1185.0, 270.0, 1209.5, 270.0 ],
                    "source": [ "obj-191", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-194", 0 ],
                    "midpoints": [ 54.5, 588.0, 54.5, 588.0 ],
                    "source": [ "obj-192", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 54.5, 633.0, 30.0, 633.0, 30.0, 237.0, 129.5, 237.0 ],
                    "source": [ "obj-194", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-19", 0 ],
                    "midpoints": [ 1039.5, 243.0, 807.0, 243.0, 807.0, 87.0, 627.0, 87.0, 627.0, 51.0, 649.5, 51.0 ],
                    "source": [ "obj-195", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-21", 0 ],
                    "midpoints": [ 1045.5909090909092, 243.0, 807.0, 243.0, 807.0, 87.0, 726.0, 87.0, 726.0, 51.0, 739.5, 51.0 ],
                    "source": [ "obj-195", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-23", 0 ],
                    "midpoints": [ 1051.6818181818182, 243.0, 816.0, 243.0, 816.0, 51.0, 829.5, 51.0 ],
                    "source": [ "obj-195", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-25", 0 ],
                    "midpoints": [ 1057.7727272727273, 252.0, 906.0, 252.0, 906.0, 51.0, 919.5, 51.0 ],
                    "source": [ "obj-195", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "midpoints": [ 1063.8636363636365, 252.0, 1017.0, 252.0, 1017.0, 207.0, 1023.0, 207.0, 1023.0, 156.0, 996.0, 156.0, 996.0, 51.0, 1009.5, 51.0 ],
                    "source": [ "obj-195", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "midpoints": [ 1069.9545454545455, 252.0, 1128.0, 252.0, 1128.0, 156.0, 1086.0, 156.0, 1086.0, 51.0, 1099.5, 51.0 ],
                    "source": [ "obj-195", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "midpoints": [ 1076.0454545454545, 252.0, 807.0, 252.0, 807.0, 87.0, 649.5, 87.0 ],
                    "source": [ "obj-195", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-33", 0 ],
                    "midpoints": [ 1082.1363636363637, 252.0, 807.0, 252.0, 807.0, 87.0, 739.5, 87.0 ],
                    "source": [ "obj-195", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "midpoints": [ 1088.2272727272727, 252.0, 897.0, 252.0, 897.0, 87.0, 829.5, 87.0 ],
                    "source": [ "obj-195", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "midpoints": [ 1094.318181818182, 252.0, 906.0, 252.0, 906.0, 96.0, 919.5, 96.0 ],
                    "source": [ "obj-195", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-39", 0 ],
                    "midpoints": [ 1100.409090909091, 252.0, 1017.0, 252.0, 1017.0, 207.0, 1023.0, 207.0, 1023.0, 156.0, 996.0, 156.0, 996.0, 96.0, 1009.5, 96.0 ],
                    "source": [ "obj-195", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 1106.5, 243.0, 1116.0, 243.0, 1116.0, 156.0, 1086.0, 156.0, 1086.0, 96.0, 1099.5, 96.0 ],
                    "source": [ "obj-195", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 1 ],
                    "midpoints": [ 461.5, 153.0, 225.0, 153.0, 225.0, 147.0, 213.5, 147.0 ],
                    "source": [ "obj-2", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 144.5, 144.0, 144.5, 144.0 ],
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 1 ],
                    "midpoints": [ 739.5, 87.0, 906.0, 87.0, 906.0, 162.0, 940.590909090909, 162.0 ],
                    "source": [ "obj-21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 2 ],
                    "midpoints": [ 829.5, 87.0, 906.0, 87.0, 906.0, 162.0, 946.6818181818181, 162.0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 3 ],
                    "midpoints": [ 919.5, 87.0, 906.0, 87.0, 906.0, 162.0, 952.7727272727273, 162.0 ],
                    "source": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 4 ],
                    "midpoints": [ 1009.5, 87.0, 987.0, 87.0, 987.0, 162.0, 958.8636363636363, 162.0 ],
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 5 ],
                    "midpoints": [ 1099.5, 87.0, 987.0, 87.0, 987.0, 162.0, 964.9545454545454, 162.0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 144.5, 225.0, 129.5, 225.0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 6 ],
                    "midpoints": [ 649.5, 123.0, 699.0, 123.0, 699.0, 141.0, 744.0, 141.0, 744.0, 162.0, 971.0454545454545, 162.0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 7 ],
                    "midpoints": [ 739.5, 162.0, 977.1363636363636, 162.0 ],
                    "source": [ "obj-33", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 8 ],
                    "midpoints": [ 829.5, 162.0, 983.2272727272726, 162.0 ],
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 9 ],
                    "midpoints": [ 919.5, 162.0, 989.3181818181818, 162.0 ],
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 10 ],
                    "midpoints": [ 1009.5, 162.0, 995.4090909090909, 162.0 ],
                    "source": [ "obj-39", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-115", 0 ],
                    "midpoints": [ 206.83333333333331, 264.0, 90.0, 264.0, 90.0, 462.0, 129.5, 462.0 ],
                    "source": [ "obj-4", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-172", 0 ],
                    "midpoints": [ 168.16666666666666, 264.0, 516.0, 264.0, 516.0, 678.0, 539.5, 678.0 ],
                    "source": [ "obj-4", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-195", 0 ],
                    "midpoints": [ 245.5, 264.0, 267.0, 264.0, 267.0, 216.0, 1039.5, 216.0 ],
                    "source": [ "obj-4", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-43", 0 ],
                    "midpoints": [ 187.5, 264.0, 129.5, 264.0 ],
                    "source": [ "obj-4", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-71", 0 ],
                    "midpoints": [ 129.5, 264.0, 90.0, 264.0, 90.0, 390.0, 129.5, 390.0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 0 ],
                    "midpoints": [ 148.83333333333334, 264.0, 90.0, 264.0, 90.0, 426.0, 129.5, 426.0 ],
                    "source": [ "obj-4", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 226.16666666666669, 264.0, 516.0, 264.0, 516.0, 255.0, 1185.0, 255.0, 1185.0, 270.0, 1209.5, 270.0 ],
                    "source": [ "obj-4", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 11 ],
                    "midpoints": [ 1099.5, 162.0, 1001.4999999999999, 162.0 ],
                    "source": [ "obj-41", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "midpoints": [ 129.5, 294.0, 117.0, 294.0, 117.0, 312.0, 114.5, 312.0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-45", 0 ],
                    "midpoints": [ 147.33333333333334, 312.0, 176.5, 312.0 ],
                    "source": [ "obj-43", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-46", 0 ],
                    "midpoints": [ 165.16666666666666, 309.0, 238.5, 309.0 ],
                    "source": [ "obj-43", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-47", 0 ],
                    "midpoints": [ 183.0, 312.0, 300.5, 312.0 ],
                    "source": [ "obj-43", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-48", 0 ],
                    "midpoints": [ 200.83333333333331, 294.0, 363.0, 294.0, 363.0, 312.0, 362.5, 312.0 ],
                    "source": [ "obj-43", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-49", 0 ],
                    "midpoints": [ 218.66666666666669, 294.0, 424.5, 294.0 ],
                    "source": [ "obj-43", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-50", 0 ],
                    "midpoints": [ 236.5, 294.0, 156.0, 294.0, 156.0, 342.0, 114.5, 342.0 ],
                    "source": [ "obj-43", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-51", 0 ],
                    "midpoints": [ 254.33333333333331, 294.0, 219.0, 294.0, 219.0, 345.0, 176.5, 345.0 ],
                    "source": [ "obj-43", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 0 ],
                    "midpoints": [ 272.16666666666663, 312.0, 279.0, 312.0, 279.0, 342.0, 238.5, 342.0 ],
                    "source": [ "obj-43", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-53", 0 ],
                    "midpoints": [ 290.0, 342.0, 300.5, 342.0 ],
                    "source": [ "obj-43", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-54", 0 ],
                    "midpoints": [ 307.83333333333337, 312.0, 348.0, 312.0, 348.0, 342.0, 362.5, 342.0 ],
                    "source": [ "obj-43", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-55", 0 ],
                    "midpoints": [ 325.66666666666663, 294.0, 411.0, 294.0, 411.0, 342.0, 424.5, 342.0 ],
                    "source": [ "obj-43", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 0 ],
                    "midpoints": [ 539.5, 462.0, 659.5, 462.0 ],
                    "source": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 1209.5, 255.0, 1209.5, 255.0 ],
                    "source": [ "obj-56", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-59", 0 ],
                    "midpoints": [ 1354.5, 270.0, 1374.5, 270.0 ],
                    "source": [ "obj-57", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-60", 1 ],
                    "midpoints": [ 1374.5, 300.0, 1376.5, 300.0 ],
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-61", 0 ],
                    "midpoints": [ 1344.5, 360.0, 1359.5, 360.0 ],
                    "source": [ "obj-60", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-63", 0 ],
                    "midpoints": [ 1359.5, 390.0, 1209.5, 390.0 ],
                    "source": [ "obj-61", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-120", 1 ],
                    "midpoints": [ 654.5, 636.0, 1185.0, 636.0, 1185.0, 474.0, 1395.0, 474.0, 1395.0, 429.0, 1407.0, 429.0, 1407.0, 405.0, 1442.5, 405.0 ],
                    "order": 0,
                    "source": [ "obj-62", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-63", 1 ],
                    "midpoints": [ 654.5, 636.0, 1185.0, 636.0, 1185.0, 396.0, 1232.5, 396.0 ],
                    "order": 1,
                    "source": [ "obj-62", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-139", 0 ],
                    "midpoints": [ 1209.5, 435.0, 1209.5, 435.0 ],
                    "source": [ "obj-63", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-65", 0 ],
                    "midpoints": [ 1224.5, 474.0, 1104.5, 474.0 ],
                    "source": [ "obj-64", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-122", 0 ],
                    "midpoints": [ 1108.0, 921.0, 1080.0, 921.0, 1080.0, 765.0, 1164.5, 765.0 ],
                    "source": [ "obj-65", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-66", 0 ],
                    "midpoints": [ 1104.5, 921.0, 1080.0, 921.0, 1080.0, 765.0, 1134.0, 765.0 ],
                    "order": 0,
                    "source": [ "obj-65", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "midpoints": [ 1104.5, 930.0, 1089.5, 930.0 ],
                    "order": 1,
                    "source": [ "obj-65", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "midpoints": [ 132.77272727272728, 75.0, 516.0, 75.0, 516.0, 405.0, 725.5, 405.0 ],
                    "source": [ "obj-68", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-124", 0 ],
                    "midpoints": [ 157.13636363636363, 75.0, 516.0, 75.0, 516.0, 321.0, 539.5, 321.0 ],
                    "source": [ "obj-68", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-126", 0 ],
                    "midpoints": [ 163.22727272727275, 75.0, 516.0, 75.0, 516.0, 321.0, 591.0, 321.0, 591.0, 327.0, 599.5, 327.0 ],
                    "source": [ "obj-68", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-128", 0 ],
                    "midpoints": [ 169.3181818181818, 75.0, 516.0, 75.0, 516.0, 321.0, 591.0, 321.0, 591.0, 327.0, 659.5, 327.0 ],
                    "source": [ "obj-68", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "midpoints": [ 138.86363636363637, 75.0, 516.0, 75.0, 516.0, 405.0, 787.5, 405.0 ],
                    "source": [ "obj-68", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-188", 0 ],
                    "midpoints": [ 175.4090909090909, 75.0, 516.0, 75.0, 516.0, 321.0, 591.0, 321.0, 591.0, 327.0, 719.5, 327.0 ],
                    "source": [ "obj-68", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-189", 0 ],
                    "midpoints": [ 181.5, 75.0, 516.0, 75.0, 516.0, 321.0, 591.0, 321.0, 591.0, 327.0, 779.5, 327.0 ],
                    "source": [ "obj-68", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 151.04545454545456, 75.0, 120.0, 75.0, 120.0, 225.0, 129.5, 225.0 ],
                    "source": [ "obj-68", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-5", 0 ],
                    "midpoints": [ 114.5, 225.0, 516.0, 225.0, 516.0, 405.0, 539.5, 405.0 ],
                    "source": [ "obj-68", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-65", 0 ],
                    "midpoints": [ 144.95454545454547, 75.0, 516.0, 75.0, 516.0, 765.0, 1104.5, 765.0 ],
                    "source": [ "obj-68", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "midpoints": [ 120.5909090909091, 225.0, 516.0, 225.0, 516.0, 405.0, 601.5, 405.0 ],
                    "source": [ "obj-68", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-9", 0 ],
                    "midpoints": [ 126.68181818181819, 75.0, 516.0, 75.0, 516.0, 405.0, 663.5, 405.0 ],
                    "source": [ "obj-68", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 1 ],
                    "midpoints": [ 601.5, 462.0, 669.0714285714286, 462.0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-56", 0 ],
                    "midpoints": [ 129.5, 420.0, 90.0, 420.0, 90.0, 207.0, 1185.0, 207.0, 1185.0, 225.0, 1209.5, 225.0 ],
                    "source": [ "obj-71", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-57", 0 ],
                    "midpoints": [ 129.5, 453.0, 516.0, 453.0, 516.0, 402.0, 1185.0, 402.0, 1185.0, 309.0, 1332.0, 309.0, 1332.0, 264.0, 1341.0, 264.0, 1341.0, 225.0, 1354.5, 225.0 ],
                    "source": [ "obj-72", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 0 ],
                    "midpoints": [ 678.5, 51.0, 627.0, 51.0, 627.0, 123.0, 649.5, 123.0 ],
                    "source": [ "obj-73", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 1 ],
                    "midpoints": [ 768.5, 51.0, 726.0, 51.0, 726.0, 141.0, 687.0, 141.0, 687.0, 153.0, 655.590909090909, 153.0 ],
                    "source": [ "obj-74", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 2 ],
                    "midpoints": [ 858.5, 51.0, 816.0, 51.0, 816.0, 87.0, 717.0, 87.0, 717.0, 141.0, 687.0, 141.0, 687.0, 153.0, 661.6818181818181, 153.0 ],
                    "source": [ "obj-75", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 3 ],
                    "midpoints": [ 948.5, 51.0, 906.0, 51.0, 906.0, 87.0, 717.0, 87.0, 717.0, 141.0, 687.0, 141.0, 687.0, 153.0, 667.7727272727273, 153.0 ],
                    "source": [ "obj-76", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 4 ],
                    "midpoints": [ 1038.5, 51.0, 996.0, 51.0, 996.0, 87.0, 717.0, 87.0, 717.0, 141.0, 687.0, 141.0, 687.0, 153.0, 673.8636363636363, 153.0 ],
                    "source": [ "obj-77", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 5 ],
                    "midpoints": [ 1128.5, 51.0, 1086.0, 51.0, 1086.0, 87.0, 717.0, 87.0, 717.0, 141.0, 687.0, 141.0, 687.0, 153.0, 679.9545454545454, 153.0 ],
                    "source": [ "obj-78", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 6 ],
                    "midpoints": [ 678.5, 153.0, 686.0454545454545, 153.0 ],
                    "source": [ "obj-79", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 7 ],
                    "midpoints": [ 768.5, 147.0, 738.0, 147.0, 738.0, 141.0, 693.0, 141.0, 693.0, 153.0, 692.1363636363636, 153.0 ],
                    "source": [ "obj-80", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 8 ],
                    "midpoints": [ 858.5, 156.0, 738.0, 156.0, 738.0, 141.0, 699.0, 141.0, 699.0, 153.0, 698.2272727272726, 153.0 ],
                    "source": [ "obj-81", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 9 ],
                    "midpoints": [ 948.5, 156.0, 738.0, 156.0, 738.0, 141.0, 704.3181818181818, 141.0 ],
                    "source": [ "obj-82", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 10 ],
                    "midpoints": [ 1038.5, 156.0, 726.0, 156.0, 726.0, 153.0, 710.4090909090909, 153.0 ],
                    "source": [ "obj-83", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-86", 11 ],
                    "midpoints": [ 1128.5, 156.0, 726.0, 156.0, 726.0, 153.0, 716.4999999999999, 153.0 ],
                    "source": [ "obj-84", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 649.5, 225.0, 129.5, 225.0 ],
                    "source": [ "obj-86", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-73", 0 ],
                    "midpoints": [ 655.0833333333334, 180.0, 636.0, 180.0, 636.0, 150.0, 639.0, 150.0, 639.0, 123.0, 627.0, 123.0, 627.0, 27.0, 678.5, 27.0 ],
                    "source": [ "obj-86", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-74", 0 ],
                    "midpoints": [ 660.6666666666667, 189.0, 738.0, 189.0, 738.0, 132.0, 726.0, 132.0, 726.0, 27.0, 768.5, 27.0 ],
                    "source": [ "obj-86", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-75", 0 ],
                    "midpoints": [ 666.25, 189.0, 816.0, 189.0, 816.0, 27.0, 858.5, 27.0 ],
                    "source": [ "obj-86", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-76", 0 ],
                    "midpoints": [ 671.8333333333334, 189.0, 906.0, 189.0, 906.0, 27.0, 948.5, 27.0 ],
                    "source": [ "obj-86", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-77", 0 ],
                    "midpoints": [ 677.4166666666667, 189.0, 906.0, 189.0, 906.0, 87.0, 996.0, 87.0, 996.0, 27.0, 1038.5, 27.0 ],
                    "source": [ "obj-86", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-78", 0 ],
                    "midpoints": [ 683.0, 189.0, 906.0, 189.0, 906.0, 87.0, 1086.0, 87.0, 1086.0, 27.0, 1128.5, 27.0 ],
                    "source": [ "obj-86", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-79", 0 ],
                    "midpoints": [ 688.5833333333334, 189.0, 738.0, 189.0, 738.0, 132.0, 687.0, 132.0, 687.0, 123.0, 678.5, 123.0 ],
                    "source": [ "obj-86", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-80", 0 ],
                    "midpoints": [ 694.1666666666667, 189.0, 744.0, 189.0, 744.0, 123.0, 768.5, 123.0 ],
                    "source": [ "obj-86", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-81", 0 ],
                    "midpoints": [ 699.75, 189.0, 834.0, 189.0, 834.0, 123.0, 858.5, 123.0 ],
                    "source": [ "obj-86", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-82", 0 ],
                    "midpoints": [ 705.3333333333334, 180.0, 912.0, 180.0, 912.0, 132.0, 936.0, 132.0, 936.0, 123.0, 948.5, 123.0 ],
                    "source": [ "obj-86", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-83", 0 ],
                    "midpoints": [ 710.9166666666667, 180.0, 912.0, 180.0, 912.0, 156.0, 1014.0, 156.0, 1014.0, 123.0, 1038.5, 123.0 ],
                    "source": [ "obj-86", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-84", 0 ],
                    "midpoints": [ 716.5, 180.0, 912.0, 180.0, 912.0, 156.0, 1104.0, 156.0, 1104.0, 123.0, 1128.5, 123.0 ],
                    "source": [ "obj-86", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-118", 0 ],
                    "midpoints": [ 1209.5, 396.0, 1260.0, 396.0, 1260.0, 435.0, 1284.0, 435.0, 1284.0, 474.0, 1395.0, 474.0, 1395.0, 582.0, 1489.5, 582.0 ],
                    "order": 0,
                    "source": [ "obj-88", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-60", 0 ],
                    "midpoints": [ 1209.5, 315.0, 1344.5, 315.0 ],
                    "order": 1,
                    "source": [ "obj-88", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-15", 2 ],
                    "midpoints": [ 663.5, 462.0, 678.6428571428571, 462.0 ],
                    "source": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-138", 2 ],
                    "midpoints": [ 1304.1666666666667, 564.0, 861.0, 564.0, 861.0, 795.0, 771.0, 795.0, 771.0, 807.0, 756.0, 807.0, 756.0, 816.0, 651.0, 816.0, 651.0, 867.0, 641.5, 867.0 ],
                    "source": [ "obj-91", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 0 ],
                    "midpoints": [ 1326.5, 564.0, 1347.0, 564.0, 1347.0, 474.0, 1185.0, 474.0, 1185.0, 270.0, 1209.5, 270.0 ],
                    "source": [ "obj-91", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 2 ],
                    "midpoints": [ 1281.8333333333333, 564.0, 1236.0, 564.0, 1236.0, 519.0, 1185.0, 519.0, 1185.0, 309.0, 1332.0, 309.0, 1332.0, 270.0, 1311.5, 270.0 ],
                    "source": [ "obj-91", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-88", 1 ],
                    "midpoints": [ 1259.5, 564.0, 1236.0, 564.0, 1236.0, 519.0, 1185.0, 519.0, 1185.0, 270.0, 1260.5, 270.0 ],
                    "source": [ "obj-91", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 0 ],
                    "midpoints": [ 1304.5, 609.0, 1272.0, 609.0, 1272.0, 564.0, 1245.0, 564.0, 1245.0, 537.0, 1259.5, 537.0 ],
                    "source": [ "obj-93", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 1 ],
                    "midpoints": [ 1304.5, 654.0, 1356.0, 654.0, 1356.0, 525.0, 1272.9, 525.0 ],
                    "source": [ "obj-95", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 2 ],
                    "midpoints": [ 1304.5, 699.0, 1356.0, 699.0, 1356.0, 525.0, 1286.3, 525.0 ],
                    "source": [ "obj-97", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-91", 3 ],
                    "midpoints": [ 1304.5, 744.0, 1356.0, 744.0, 1356.0, 525.0, 1299.7, 525.0 ],
                    "source": [ "obj-99", 0 ]
                }
            }
        ],
        "autosave": 0,
        "editing_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ]
    }
}