{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ 134.0, 166.0, 1400.0, 827.0 ],
        "boxes": [
            {
                "box": {
                    "bgcolor": [ 0.88, 0.9, 0.95, 1.0 ],
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 16.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 10.0, 10.0, 153.0, 24.0 ],
                    "text": "Mixer Controls",
                    "textcolor": [ 0.2, 0.25, 0.42, 1.0 ]
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
                    "patching_rect": [ 10.0, 38.0, 58.0, 20.0 ],
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
                    "patching_rect": [ 73.0, 38.0, 58.0, 20.0 ],
                    "text": "Busses"
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 10.0, 55.0, 50.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 73.0, 55.0, 50.0, 22.0 ]
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 10.0, 85.0, 97.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 115.0, 85.0, 97.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 10.0, 115.0, 135.0, 22.0 ],
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
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 10.0, 145.0, 69.0, 22.0 ],
                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                    "text": "thispatcher"
                }
            },
            {
                "box": {
                    "bgcolor": [ 0.85, 0.92, 0.85, 1.0 ],
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-50",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 266.0, 11.0, 62.0, 22.0 ],
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
                    "outlettype": [ "bang", "bang", "bang" ],
                    "patching_rect": [ 266.0, 39.0, 46.0, 22.0 ],
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 266.0, 66.0, 56.0, 22.0 ],
                    "text": "init 4 2"
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
                    "outlettype": [ "" ],
                    "patching_rect": [ 326.0, 66.0, 40.0, 22.0 ],
                    "text": "set 4"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-54",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 376.0, 66.0, 40.0, 22.0 ],
                    "text": "set 2"
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
                    "patching_rect": [ 10.0, 170.0, 356.0, 18.0 ],
                    "text": "Strips and busses created dynamically by mixer-manager.js",
                    "textcolor": [ 0.55, 0.55, 0.6, 1.0 ]
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
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 602.0, 190.0, 118.0, 438.0 ],
                    "varname": "master",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 1 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 10.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-1",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 2 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 102.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-2",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 3 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 194.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-3",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 4 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 286.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-4",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 1, "bus-1-L", "bus-1-R" ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 394.0, 190.0, 88.0, 428.0 ],
                    "varname": "bus-1",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 2, "bus-2-L", "bus-2-R" ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 486.0, 190.0, 88.0, 428.0 ],
                    "varname": "bus-2",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 1 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 10.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-1[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 2 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 102.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-2[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 3 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 194.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-3[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 4 ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 286.0, 190.0, 88.0, 563.0 ],
                    "varname": "strip-4[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 1, "bus-1-L", "bus-1-R" ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 394.0, 190.0, 88.0, 428.0 ],
                    "varname": "bus-1[1]",
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ 2, "bus-2-L", "bus-2-R" ],
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
                    "offset": [ 0.0, 0.0 ],
                    "outlettype": [ "signal", "signal" ],
                    "patching_rect": [ 486.0, 190.0, 88.0, 428.0 ],
                    "varname": "bus-2[1]",
                    "viewvisibility": 1
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-43", 0 ],
                    "midpoints": [ 19.5, 78.0, 19.5, 78.0 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-42", 0 ],
                    "midpoints": [ 19.5, 138.0, 19.5, 138.0 ],
                    "source": [ "obj-41", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 19.5, 108.0, 19.5, 108.0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 124.5, 108.0, 19.5, 108.0 ],
                    "source": [ "obj-44", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-51", 0 ],
                    "midpoints": [ 275.5, 34.0, 275.5, 34.0 ],
                    "source": [ "obj-50", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 0 ],
                    "midpoints": [ 275.5, 64.0, 275.5, 64.0 ],
                    "source": [ "obj-51", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-53", 0 ],
                    "midpoints": [ 289.0, 61.0, 335.5, 61.0 ],
                    "source": [ "obj-51", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-54", 0 ],
                    "midpoints": [ 302.5, 61.0, 385.5, 61.0 ],
                    "source": [ "obj-51", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 275.5, 111.0, 19.5, 111.0 ],
                    "source": [ "obj-52", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 335.5, 99.0, 180.0, 99.0, 180.0, 72.0, 123.0, 72.0, 123.0, 78.0, 6.0, 78.0, 6.0, 51.0, 19.5, 51.0 ],
                    "source": [ "obj-53", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "midpoints": [ 385.5, 99.0, 180.0, 99.0, 180.0, 72.0, 123.0, 72.0, 123.0, 78.0, 69.0, 78.0, 69.0, 51.0, 82.5, 51.0 ],
                    "source": [ "obj-54", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "midpoints": [ 82.5, 78.0, 124.5, 78.0 ],
                    "source": [ "obj-6", 0 ]
                }
            }
        ],
        "autosave": 0,
        "editing_bgcolor": [ 0.333, 0.333, 0.333, 1.0 ]
    }
}