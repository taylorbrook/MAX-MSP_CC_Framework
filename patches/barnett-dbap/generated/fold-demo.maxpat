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
        "rect": [ 60.0, 60.0, 1300.0, 900.0 ],
        "bglocked": 0,
        "openinpresentation": 0,
        "default_fontsize": 12.0,
        "default_fontface": 0,
        "default_fontname": "Arial",
        "gridonopen": 1,
        "gridsize": [ 15.0, 15.0 ],
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
                    "maxclass": "panel",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 660, 580, 599, 262 ],
                    "parameter_enable": 0,
                    "background": 1,
                    "ignoreclick": 1,
                    "border": 0,
                    "rounded": 6,
                    "mode": 0,
                    "bgcolor": [ 0.19, 0.19, 0.22, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 30, 10, 420.0, 24.0 ],
                    "text": "BARNETT DBAP   ambisonic fold-down demo",
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 460, 8, 800.0, 33.0 ],
                    "text": "Two sources -> dbap-fold -> headphones. Turn DSP on (bottom left), open or drop a file in each source and press play, then move the pucks. Nothing here needs the 8-speaker rig.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-3",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 30, 60, 599, 500 ],
                    "args": [ "A", 1 ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [ 0.0, 0.0 ],
                    "viewvisibility": 1,
                    "name": "dbap-source.maxpat",
                    "lockedsize": 0,
                    "varname": "srcA"
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-4",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [ "multichannelsignal", "" ],
                    "patching_rect": [ 660, 60, 599, 500 ],
                    "args": [ "B", 2 ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [ 0.0, 0.0 ],
                    "viewvisibility": 1,
                    "name": "dbap-source.maxpat",
                    "lockedsize": 0,
                    "varname": "srcB"
                }
            },
            {
                "box": {
                    "maxclass": "bpatcher",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "multichannelsignal", "signal", "signal" ],
                    "patching_rect": [ 30, 620, 600, 166 ],
                    "args": [],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "lockeddragscroll": 0,
                    "offset": [ 0.0, 0.0 ],
                    "viewvisibility": 1,
                    "name": "dbap-fold.maxpat",
                    "lockedsize": 0,
                    "varname": "fold"
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 30, 580, 420.0, 19.0 ],
                    "text": "both 8-channel outlets into the ONE inlet: the cords sum",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-8",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 330.0, 820.0, 72.0, 22.0 ],
                    "text": "dac~ 1 2",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [ 0.92, 0.85, 0.85, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 400.0, 819.0, 24.0, 24.0 ],
                    "parameter_enable": 0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-10",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 432, 822, 400.0, 19.0 ],
                    "text": "DSP on / off.   Monitor L / R -> outputs 1 / 2 (headphones).",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 30, 796, 290.0, 33.0 ],
                    "text": "outlet 1: 16-channel AmbiX (ACN, SN3D) for further routing, e.g. mc.dac~ or another decoder",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [ "", "", "", "", "" ],
                    "patching_rect": [ 30.0, 860.0, 149.0, 22.0 ],
                    "text": "dict venue @embed 1",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "data": {
                        "name": "Roy Barnett Recital Hall (O-Octagon OQ4 traced layout, not measured)",
                        "units": "metres",
                        "speakers": {
                            "s1": {
                                "x": 0.5,
                                "y": 4.5,
                                "z": 4.5,
                                "delayMs": 0.0
                            },
                            "s2": {
                                "x": 12.5,
                                "y": 4.5,
                                "z": 4.5,
                                "delayMs": 0.0
                            },
                            "s3": {
                                "x": 12.5,
                                "y": 9.85,
                                "z": 4.7,
                                "delayMs": 0.0
                            },
                            "s4": {
                                "x": 12.5,
                                "y": 16.0,
                                "z": 5.1,
                                "delayMs": 0.0
                            },
                            "s5": {
                                "x": 9.8,
                                "y": 19.5,
                                "z": 5.4,
                                "delayMs": 0.0
                            },
                            "s6": {
                                "x": 3.2,
                                "y": 19.5,
                                "z": 5.4,
                                "delayMs": 0.0
                            },
                            "s7": {
                                "x": 0.5,
                                "y": 16.0,
                                "z": 5.1,
                                "delayMs": 0.0
                            },
                            "s8": {
                                "x": 0.5,
                                "y": 9.85,
                                "z": 4.7,
                                "delayMs": 0.0
                            }
                        },
                        "rake": {
                            "front": 1.1,
                            "rear": 3.2
                        }
                    },
                    "saved_object_attributes": {
                        "embed": 1,
                        "legacy": 1,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    }
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 186, 862, 200.0, 19.0 ],
                    "text": "venue (copy of the host's)",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 674, 588, 300.0, 20.0 ],
                    "text": "HOW IT WORKS",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "textcolor": [ 1.0, 0.73, 0.24, 1.0 ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 674, 612, 570.0, 150.0 ],
                    "text": "Each speaker feed is treated as a point source at that speaker's direction from the listener (the rig centroid at ear height) and encoded to 3rd-order AmbiX. The fold-down therefore carries exactly what the hall gets, trims and master included.\n\ntrim: W adds the eight feeds, 0 to +9 dB above one source, so the default is -9 dB.\nflat: put every speaker on the horizon.\nopen, then rec: write a 16-channel file; channels 1-4 are valid first order.\nMONITOR: binaural decode for headphones only, with its own level and on / off. It is not in the recorded stream.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 674, 768, 300.0, 19.0 ],
                    "text": "TRY",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 1.0, 0.73, 0.24, 1.0 ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 674, 788, 570.0, 46.0 ],
                    "text": "Puck to audience left / right: the image follows in the headphones. Stage vs. rear is subtler; raise rolloff toward 12 to sharpen it.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [ "obj-3", 0 ],
                    "destination": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-4", 0 ],
                    "destination": [ "obj-5", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-5", 1 ],
                    "destination": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-5", 2 ],
                    "destination": [ "obj-8", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 0 ],
                    "destination": [ "obj-8", 0 ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
        "bgcolor": [ 0.333, 0.333, 0.333, 1.0 ],
        "editing_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ],
        "locked_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ]
    }
}