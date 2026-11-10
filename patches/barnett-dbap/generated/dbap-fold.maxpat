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
        "rect": [ 100.0, 100.0, 1180.0, 800.0 ],
        "bglocked": 0,
        "openinpresentation": 1,
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
                    "id": "obj-39",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1520.0, 36.0, 269, 124 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 320.0, 36.0, 269.0, 124.0 ],
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
                    "maxclass": "panel",
                    "id": "obj-38",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1220.0, 36.0, 290, 124 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 36.0, 290.0, 124.0 ],
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
                    "maxclass": "inlet",
                    "id": "obj-1",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 40.0, 50.0, 30.0, 30.0 ],
                    "parameter_enable": 0,
                    "comment": "8-channel mc signal: patch EVERY dbap-source outlet here (the cords sum)"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 1,
                    "numoutlets": 8,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 40.0, 100.0, 250.0, 22.0 ],
                    "text": "mc.unpack~ 8",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-3",
                    "numinlets": 8,
                    "numoutlets": 17,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                    "patching_rect": [ 40.0, 170.0, 500.0, 22.0 ],
                    "text": "matrix~ 8 16 1. @ramp 20",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-4",
                    "numinlets": 16,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 40.0, 220.0, 470.0, 22.0 ],
                    "text": "mc.pack~ 16",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-5",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 40.0, 270.0, 110.0, 22.0 ],
                    "text": "mc.*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "multichannelsignal" ],
                    "patching_rect": [ 250.0, 330.0, 121.0, 22.0 ],
                    "text": "mc.sfrecord~ 16",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 1,
                    "numoutlets": 16,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 40.0, 390.0, 470.0, 22.0 ],
                    "text": "mc.unpack~ 16",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 560.0, 430.0, 12.0, 84.0 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 104.0, 64.0, 12.0, 84.0 ],
                    "bgcolor": [ 0.1, 0.1, 0.12, 1.0 ],
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-9",
                    "numinlets": 16,
                    "numoutlets": 17,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "" ],
                    "patching_rect": [ 40.0, 450.0, 500.0, 22.0 ],
                    "text": "matrix~ 16 16 1. @ramp 20",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-10",
                    "numinlets": 16,
                    "numoutlets": 3,
                    "outlettype": [ "signal", "signal", "" ],
                    "patching_rect": [ 40.0, 520.0, 470.0, 22.0 ],
                    "text": "abc_3d_binaural3~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 150.0, 580.0, 42.0, 22.0 ],
                    "text": "*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 260.0, 580.0, 42.0, 22.0 ],
                    "text": "*~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 370.0, 580.0, 12.0, 84.0 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 474.0, 64.0, 12.0, 84.0 ],
                    "bgcolor": [ 0.1, 0.1, 0.12, 1.0 ],
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 390.0, 580.0, 12.0, 84.0 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 490.0, 64.0, 12.0, 84.0 ],
                    "bgcolor": [ 0.1, 0.1, 0.12, 1.0 ],
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 40.0, 700.0, 30.0, 30.0 ],
                    "parameter_enable": 0,
                    "comment": "16-channel mc signal: 3rd-order AmbiX (ACN, SN3D), after the fold trim"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 150.0, 700.0, 30.0, 30.0 ],
                    "parameter_enable": 0,
                    "comment": "headphone monitor L (binaural) -> dac~ 1"
                }
            },
            {
                "box": {
                    "maxclass": "outlet",
                    "id": "obj-17",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 260.0, 700.0, 30.0, 30.0 ],
                    "parameter_enable": 0,
                    "comment": "headphone monitor R (binaural) -> dac~ 2"
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-18",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 640, 440, 400.0, 62.0 ],
                    "text": "0 0 1., 1 1 1.732051, 2 2 1.732051, 3 3 1.732051, 4 4 2.236068, 5 5 2.236068, 6 6 2.236068, 7 7 2.236068, 8 8 2.236068, 9 9 2.645751, 10 10 2.645751, 11 11 2.645751, 12 12 2.645751, 13 13 2.645751, 14 14 2.645751, 15 15 2.645751",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-19",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 640.0, 408.0, 72.0, 22.0 ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [ 0.85, 0.92, 0.85, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-20",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 730, 392, 330.0, 46.0 ],
                    "text": "MONITOR ONLY: AmbiX is SN3D, the abclib (ambitools) decoder takes N3D, so each order l is scaled by sqrt(2l+1). Outlet 1 and the recorder stay SN3D.",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-21",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 640.0, 50.0, 142.0, 22.0 ],
                    "text": "receive dbap-venue",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-22",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 820.0, 20.0, 87.5, 22.0 ],
                    "text": "loadmess 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-23",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 820.0, 50.0, 24.0, 24.0 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 140.0, 64.0, 20.0, 20.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-24",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 820, 84, 65.0, 22.0 ],
                    "text": "flat $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-25",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 640, 124, 135.0, 22.0 ],
                    "text": "js fold.js",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-26",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 820, 126, 300.0, 19.0 ],
                    "text": "listener",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [ 225.0, 12.0, 364.0, 17.0 ],
                    "textcolor": [ 0.62, 0.64, 0.68, 1.0 ],
                    "textjustification": 2
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-27",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 640, 150, 330.0, 19.0 ],
                    "text": "venue -> 8 x 16 encode gains (128 '<in> <out> <gain>' lists)",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-28",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 640.0, 190.0, 60.0, 48.0 ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [ 30.0, 64.0, 60.0, 48.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "varname": "foldtrim",
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [ -9.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "fold trim",
                            "parameter_mmax": 0.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "trim",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-29",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 640, 252, 100.0, 22.0 ],
                    "text": "p gaininterp",
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
                        "rect": [ 100.0, 100.0, 400.0, 300.0 ],
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
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 30.0, 30.0, 30.0 ],
                                    "parameter_enable": 0,
                                    "comment": "fold trim, dB (-70 = mute)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-2",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [ 50.0, 250.0, 30.0, 30.0 ],
                                    "parameter_enable": 0,
                                    "comment": "linear gain, 20 ms ramp (signal)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 100.0, 310.0, 22.0 ],
                                    "text": "expr ($f1 > -69.95) * exp($f1 * 0.1151293)",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "message",
                                    "id": "obj-4",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50, 130, 51.0, 22.0 ],
                                    "text": "$1 20",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "signal", "" ],
                                    "patching_rect": [ 50.0, 160.0, 51.0, 22.0 ],
                                    "text": "line~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [ "obj-1", 0 ],
                                    "destination": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [ "obj-3", 0 ],
                                    "destination": [ "obj-4", 0 ]
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
                                    "source": [ "obj-5", 0 ],
                                    "destination": [ "obj-2", 0 ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-30",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 820, 300, 44.0, 22.0 ],
                    "text": "open",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [ 140.0, 94.0, 44.0, 22.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-31",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 900.0, 270.0, 87.5, 22.0 ],
                    "text": "loadmess 0",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-32",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 900.0, 300.0, 24.0, 24.0 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 190.0, 95.0, 20.0, 20.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-33",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 930, 302, 230.0, 19.0 ],
                    "text": "open, then rec: a 16-channel AmbiX file",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "live.dial",
                    "id": "obj-34",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 640.0, 530.0, 60.0, 48.0 ],
                    "parameter_enable": 1,
                    "presentation": 1,
                    "presentation_rect": [ 390.0, 64.0, 60.0, 48.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "varname": "monitor",
                    "saved_attribute_attributes": {
                        "textcolor": {
                            "expression": ""
                        },
                        "valueof": {
                            "parameter_initial": [ -12.0 ],
                            "parameter_initial_enable": 1,
                            "parameter_longname": "monitor level",
                            "parameter_mmax": 0.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "level",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    }
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-35",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 740.0, 520.0, 87.5, 22.0 ],
                    "text": "loadmess 1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "toggle",
                    "id": "obj-36",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 740.0, 550.0, 24.0, 24.0 ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [ 330.0, 64.0, 20.0, 20.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-37",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 640, 610, 86.0, 22.0 ],
                    "text": "p mongain",
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
                        "rect": [ 100.0, 100.0, 400.0, 300.0 ],
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
                                    "maxclass": "inlet",
                                    "id": "obj-1",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 40.0, 30.0, 30.0 ],
                                    "parameter_enable": 0,
                                    "comment": "monitor level, dB (-70 = mute)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "inlet",
                                    "id": "obj-2",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 300.0, 40.0, 30.0, 30.0 ],
                                    "parameter_enable": 0,
                                    "comment": "monitor on / off (0 / 1)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "outlet",
                                    "id": "obj-3",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [ 50.0, 250.0, 30.0, 30.0 ],
                                    "parameter_enable": 0,
                                    "comment": "linear gain, 20 ms ramp (signal)"
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-4",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 300.0, 80.0, 51.0, 22.0 ],
                                    "text": "t b i",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 130.0, 408.0, 22.0 ],
                                    "text": "expr ($f2 > 0.5) * ($f1 > -69.95) * exp($f1 * 0.1151293)",
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
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50, 165, 51.0, 22.0 ],
                                    "text": "$1 20",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-7",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "signal", "" ],
                                    "patching_rect": [ 50.0, 200.0, 51.0, 22.0 ],
                                    "text": "line~",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "source": [ "obj-1", 0 ],
                                    "destination": [ "obj-5", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [ "obj-2", 0 ],
                                    "destination": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [ "obj-4", 1 ],
                                    "destination": [ "obj-5", 1 ]
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
                                    "source": [ "obj-5", 0 ],
                                    "destination": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [ "obj-6", 0 ],
                                    "destination": [ "obj-7", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "source": [ "obj-7", 0 ],
                                    "destination": [ "obj-3", 0 ]
                                }
                            }
                        ],
                        "dependency_cache": [],
                        "autosave": 0
                    },
                    "saved_object_attributes": {
                        "description": "",
                        "digest": "",
                        "globalpatchername": "",
                        "tags": ""
                    }
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-40",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1220.0, 8.0, 300.0, 22.0 ],
                    "text": "AMBISONIC FOLD-DOWN",
                    "fontname": "Arial",
                    "fontsize": 14.0,
                    "presentation": 1,
                    "presentation_rect": [ 20.0, 8.0, 300.0, 22.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-42",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1230.0, 42.0, 90.0, 20.0 ],
                    "text": "FOLD-DOWN",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [ 30.0, 42.0, 90.0, 20.0 ],
                    "textcolor": [ 1.0, 0.73, 0.24, 1.0 ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-43",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1299.0, 146.0, 22.0, 14.0 ],
                    "text": "W",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [ 99.0, 146.0, 22.0, 14.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-44",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1362.0, 65.0, 40.0, 19.0 ],
                    "text": "flat",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [ 162.0, 65.0, 40.0, 19.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-45",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1412.0, 96.0, 70.0, 19.0 ],
                    "text": "rec 16 ch",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [ 212.0, 96.0, 70.0, 19.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-46",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1530.0, 42.0, 90.0, 20.0 ],
                    "text": "MONITOR",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [ 330.0, 42.0, 90.0, 20.0 ],
                    "textcolor": [ 1.0, 0.73, 0.24, 1.0 ],
                    "fontface": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-47",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1552.0, 65.0, 30.0, 19.0 ],
                    "text": "on",
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "presentation": 1,
                    "presentation_rect": [ 352.0, 65.0, 30.0, 19.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-48",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1669.0, 146.0, 22.0, 14.0 ],
                    "text": "L",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [ 469.0, 146.0, 22.0, 14.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-49",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1685.0, 146.0, 22.0, 14.0 ],
                    "text": "R",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [ 485.0, 146.0, 22.0, 14.0 ],
                    "textcolor": [ 0.8, 0.8, 0.82, 1.0 ],
                    "textjustification": 1
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-50",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [ 1528.0, 124.0, 130.0, 30.0 ],
                    "text": "binaural (KU100)\nheadphones only",
                    "fontname": "Arial",
                    "fontsize": 9.0,
                    "presentation": 1,
                    "presentation_rect": [ 328.0, 124.0, 130.0, 30.0 ],
                    "textcolor": [ 0.62, 0.64, 0.68, 1.0 ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [ "obj-1", 0 ],
                    "destination": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 0 ],
                    "destination": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 1 ],
                    "destination": [ "obj-3", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 2 ],
                    "destination": [ "obj-3", 2 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 3 ],
                    "destination": [ "obj-3", 3 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 4 ],
                    "destination": [ "obj-3", 4 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 5 ],
                    "destination": [ "obj-3", 5 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 6 ],
                    "destination": [ "obj-3", 6 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-2", 7 ],
                    "destination": [ "obj-3", 7 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 0 ],
                    "destination": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 1 ],
                    "destination": [ "obj-4", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 2 ],
                    "destination": [ "obj-4", 2 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 3 ],
                    "destination": [ "obj-4", 3 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 4 ],
                    "destination": [ "obj-4", 4 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 5 ],
                    "destination": [ "obj-4", 5 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 6 ],
                    "destination": [ "obj-4", 6 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 7 ],
                    "destination": [ "obj-4", 7 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 8 ],
                    "destination": [ "obj-4", 8 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 9 ],
                    "destination": [ "obj-4", 9 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 10 ],
                    "destination": [ "obj-4", 10 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 11 ],
                    "destination": [ "obj-4", 11 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 12 ],
                    "destination": [ "obj-4", 12 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 13 ],
                    "destination": [ "obj-4", 13 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 14 ],
                    "destination": [ "obj-4", 14 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-3", 15 ],
                    "destination": [ "obj-4", 15 ]
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
                    "source": [ "obj-5", 0 ],
                    "destination": [ "obj-15", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-5", 0 ],
                    "destination": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-5", 0 ],
                    "destination": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 0 ],
                    "destination": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-19", 0 ],
                    "destination": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-18", 0 ],
                    "destination": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 0 ],
                    "destination": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 0 ],
                    "destination": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 1 ],
                    "destination": [ "obj-9", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 1 ],
                    "destination": [ "obj-10", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 2 ],
                    "destination": [ "obj-9", 2 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 2 ],
                    "destination": [ "obj-10", 2 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 3 ],
                    "destination": [ "obj-9", 3 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 3 ],
                    "destination": [ "obj-10", 3 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 4 ],
                    "destination": [ "obj-9", 4 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 4 ],
                    "destination": [ "obj-10", 4 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 5 ],
                    "destination": [ "obj-9", 5 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 5 ],
                    "destination": [ "obj-10", 5 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 6 ],
                    "destination": [ "obj-9", 6 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 6 ],
                    "destination": [ "obj-10", 6 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 7 ],
                    "destination": [ "obj-9", 7 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 7 ],
                    "destination": [ "obj-10", 7 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 8 ],
                    "destination": [ "obj-9", 8 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 8 ],
                    "destination": [ "obj-10", 8 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 9 ],
                    "destination": [ "obj-9", 9 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 9 ],
                    "destination": [ "obj-10", 9 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 10 ],
                    "destination": [ "obj-9", 10 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 10 ],
                    "destination": [ "obj-10", 10 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 11 ],
                    "destination": [ "obj-9", 11 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 11 ],
                    "destination": [ "obj-10", 11 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 12 ],
                    "destination": [ "obj-9", 12 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 12 ],
                    "destination": [ "obj-10", 12 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 13 ],
                    "destination": [ "obj-9", 13 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 13 ],
                    "destination": [ "obj-10", 13 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 14 ],
                    "destination": [ "obj-9", 14 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 14 ],
                    "destination": [ "obj-10", 14 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-7", 15 ],
                    "destination": [ "obj-9", 15 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-9", 15 ],
                    "destination": [ "obj-10", 15 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-10", 0 ],
                    "destination": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-10", 1 ],
                    "destination": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-11", 0 ],
                    "destination": [ "obj-16", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-12", 0 ],
                    "destination": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-11", 0 ],
                    "destination": [ "obj-13", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-12", 0 ],
                    "destination": [ "obj-14", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-21", 0 ],
                    "destination": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-22", 0 ],
                    "destination": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-23", 0 ],
                    "destination": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-24", 0 ],
                    "destination": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-25", 0 ],
                    "destination": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-25", 1 ],
                    "destination": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-28", 0 ],
                    "destination": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-29", 0 ],
                    "destination": [ "obj-5", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-30", 0 ],
                    "destination": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-31", 0 ],
                    "destination": [ "obj-32", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-32", 0 ],
                    "destination": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-35", 0 ],
                    "destination": [ "obj-36", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-34", 0 ],
                    "destination": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-36", 0 ],
                    "destination": [ "obj-37", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-37", 0 ],
                    "destination": [ "obj-11", 1 ]
                }
            },
            {
                "patchline": {
                    "source": [ "obj-37", 0 ],
                    "destination": [ "obj-12", 1 ]
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