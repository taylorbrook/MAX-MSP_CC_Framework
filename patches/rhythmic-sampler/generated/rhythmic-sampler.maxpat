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
        "rect": [ 1891.0, -189.0, 1811.0, 1068.0 ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 18.0,
                    "id": "obj-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1185.0, -9.0, 196.0, 27.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 10.0, 200.0, 27.0 ],
                    "text": "RHYTHMIC SAMPLER"
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
                    "patching_rect": [ 95.0, 161.0, 40.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 50.0, 60.0, 20.0 ],
                    "text": "BPM"
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
                    "patching_rect": [ 30.0, 165.0, 50.0, 22.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 75.0, 45.0, 60.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 30.0, 18.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 150.0, 45.0, 30.0, 30.0 ]
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
                    "patching_rect": [ 10.0, 76.0, 44.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 200.0, 50.0, 60.0, 20.0 ],
                    "text": "PLAY"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 30.0, 195.0, 105.0, 22.0 ],
                    "text": "expr 60000./$f1/4."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 30.0, 240.0, 69.0, 22.0 ],
                    "text": "metro 125"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 285.0, 97.5, 22.0 ],
                    "text": "send tick"
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
                    "patching_rect": [ 75.0, 18.0, 62.0, 22.0 ],
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
                    "numoutlets": 3,
                    "outlettype": [ "bang", "bang", "bang" ],
                    "patching_rect": [ 60.0, 75.0, 80.5, 22.0 ],
                    "text": "trigger b b b"
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
                    "patching_rect": [ 75.0, 120.0, 40.0, 22.0 ],
                    "text": "120"
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
                    "patching_rect": [ 135.0, 120.0, 40.0, 22.0 ],
                    "text": "128"
                }
            },
            {
                "box": {
                    "args": [ "slot-1", "slot-1-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-13",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 1185.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 90.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-2", "slot-2-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-14",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 1605.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 420.0, 90.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-3", "slot-3-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-15",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 2010.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 830.0, 90.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-4", "slot-4-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-16",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 2430.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1240.0, 90.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-5", "slot-5-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-17",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 2850.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 500.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-6", "slot-6-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-18",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 3255.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 420.0, 500.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-7", "slot-7-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-19",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 3675.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 830.0, 500.0, 400.0, 400.0 ],
                    "viewvisibility": 1
                }
            },
            {
                "box": {
                    "args": [ "slot-8", "slot-8-out" ],
                    "bgmode": 0,
                    "border": 0,
                    "clickthrough": 0,
                    "enablehscroll": 0,
                    "enablevscroll": 0,
                    "id": "obj-20",
                    "lockeddragscroll": 0,
                    "lockedsize": 0,
                    "maxclass": "bpatcher",
                    "name": "slot.maxpat",
                    "numinlets": 0,
                    "numoutlets": 0,
                    "offset": [ 0.0, 0.0 ],
                    "patching_rect": [ 4095.0, 30.0, 400.0, 400.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1240.0, 500.0, 400.0, 400.0 ],
                    "viewvisibility": 1
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 972.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-1-out"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 848.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-2-out"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 730.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-3-out"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 615.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-4-out"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 495.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-5-out"
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
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 381.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-6-out"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 267.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-7-out"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-28",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 150.0, 18.0, 108.0, 22.0 ],
                    "text": "receive~ slot-8-out"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-29",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 885.0, 75.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 855.0, 120.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 735.0, 165.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 615.0, 195.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 495.0, 240.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 390.0, 285.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 285.0, 330.0, 47.5, 22.0 ],
                    "text": "+~"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 300.0, 375.0, 42.0, 22.0 ],
                    "text": "*~ 0.3"
                }
            },
            {
                "box": {
                    "id": "obj-37",
                    "maxclass": "gain~",
                    "multichannelvariant": 0,
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "signal", "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 225.0, 405.0, 22.0, 140.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 910.0, 200.0, 50.0 ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [ 225.0, 577.0, 35.0, 22.0 ],
                    "text": "dac~"
                }
            },
            {
                "box": {
                    "id": "obj-39",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 255.0, 405.0, 15.0, 100.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 220.0, 910.0, 100.0, 50.0 ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 11.0,
                    "id": "obj-40",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 4500.0, 30.0, 58.0, 19.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 895.0, 80.0, 19.0 ],
                    "text": "MASTER"
                }
            },
            {
                "box": {
                    "id": "obj-41",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 690.0, 45.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 10.0, 1020.0, 25.0, 25.0 ]
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
                    "patching_rect": [ 750.0, 120.0, 93.0, 22.0 ],
                    "text": "startwindow"
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
                    "patching_rect": [ 690.0, 120.0, 44.0, 22.0 ],
                    "text": "stop"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-44",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "bang", "" ],
                    "patching_rect": [ 690.0, 75.0, 71.0, 22.0 ],
                    "text": "select 0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 10.0,
                    "id": "obj-45",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 4500.0, 75.0, 100.0, 18.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 40.0, 1025.0, 80.0, 18.0 ],
                    "text": "Audio On/Off"
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
                    "patching_rect": [ 165.0, 120.0, 40.0, 22.0 ],
                    "text": "1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 30.0, 330.0, 121.0, 22.0 ],
                    "text": "send global_bpm"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 130.0, 60.0, 128.0, 22.0 ],
                    "text": "send global_play"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-49",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 550.0, -2.0, 58.0, 20.0 ],
                    "text": "v0.2.2"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "midpoints": [ 100.25, 99.0, 87.0, 99.0, 87.0, 117.0, 84.5, 117.0 ],
                    "source": [ "obj-10", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-12", 0 ],
                    "midpoints": [ 131.0, 117.0, 144.5, 117.0 ],
                    "source": [ "obj-10", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-46", 0 ],
                    "midpoints": [ 69.5, 99.0, 174.5, 99.0 ],
                    "source": [ "obj-10", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-3", 0 ],
                    "midpoints": [ 84.5, 144.0, 39.5, 144.0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "midpoints": [ 144.5, 153.0, 234.5, 153.0 ],
                    "source": [ "obj-12", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "midpoints": [ 981.5, 60.0, 894.5, 60.0 ],
                    "source": [ "obj-21", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 1 ],
                    "midpoints": [ 857.5, 60.0, 923.0, 60.0 ],
                    "source": [ "obj-22", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 1 ],
                    "midpoints": [ 739.5, 60.0, 870.0, 60.0, 870.0, 117.0, 893.0, 117.0 ],
                    "source": [ "obj-23", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 1 ],
                    "midpoints": [ 624.5, 162.0, 773.0, 162.0 ],
                    "source": [ "obj-24", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 1 ],
                    "midpoints": [ 504.5, 180.0, 653.0, 180.0 ],
                    "source": [ "obj-25", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-33", 1 ],
                    "midpoints": [ 390.5, 225.0, 533.0, 225.0 ],
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 1 ],
                    "midpoints": [ 276.5, 270.0, 428.0, 270.0 ],
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 1 ],
                    "midpoints": [ 159.5, 51.0, 323.0, 51.0 ],
                    "source": [ "obj-28", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "midpoints": [ 894.5, 99.0, 864.5, 99.0 ],
                    "source": [ "obj-29", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-47", 0 ],
                    "midpoints": [ 39.5, 189.0, 15.0, 189.0, 15.0, 327.0, 39.5, 327.0 ],
                    "order": 0,
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-6", 0 ],
                    "midpoints": [ 39.5, 189.0, 39.5, 189.0 ],
                    "order": 1,
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "midpoints": [ 864.5, 162.0, 744.5, 162.0 ],
                    "source": [ "obj-30", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 0 ],
                    "midpoints": [ 744.5, 189.0, 672.0, 189.0, 672.0, 180.0, 624.5, 180.0 ],
                    "source": [ "obj-31", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-33", 0 ],
                    "midpoints": [ 624.5, 219.0, 504.5, 219.0 ],
                    "source": [ "obj-32", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "midpoints": [ 504.5, 264.0, 399.5, 264.0 ],
                    "source": [ "obj-33", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "midpoints": [ 399.5, 309.0, 294.5, 309.0 ],
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-36", 0 ],
                    "midpoints": [ 294.5, 372.0, 309.5, 372.0 ],
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "midpoints": [ 309.5, 399.0, 282.0, 399.0, 282.0, 390.0, 234.5, 390.0 ],
                    "source": [ "obj-36", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-38", 1 ],
                    "midpoints": [ 234.5, 564.0, 250.5, 564.0 ],
                    "order": 1,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-38", 0 ],
                    "midpoints": [ 234.5, 546.0, 234.5, 546.0 ],
                    "order": 2,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-39", 0 ],
                    "midpoints": [ 234.5, 546.0, 282.0, 546.0, 282.0, 402.0, 264.0, 402.0 ],
                    "order": 0,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-48", 0 ],
                    "midpoints": [ 39.5, 57.0, 139.5, 57.0 ],
                    "order": 0,
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 0 ],
                    "midpoints": [ 39.5, 63.0, 6.0, 63.0, 6.0, 237.0, 39.5, 237.0 ],
                    "order": 1,
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-44", 0 ],
                    "midpoints": [ 699.5, 72.0, 699.5, 72.0 ],
                    "source": [ "obj-41", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-38", 0 ],
                    "midpoints": [ 759.5, 144.0, 720.0, 144.0, 720.0, 564.0, 234.5, 564.0 ],
                    "source": [ "obj-42", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-38", 0 ],
                    "midpoints": [ 699.5, 564.0, 234.5, 564.0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-42", 0 ],
                    "midpoints": [ 751.5, 117.0, 759.5, 117.0 ],
                    "source": [ "obj-44", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-43", 0 ],
                    "midpoints": [ 699.5, 99.0, 699.5, 99.0 ],
                    "source": [ "obj-44", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "midpoints": [ 174.5, 153.0, 675.0, 153.0, 675.0, 42.0, 699.5, 42.0 ],
                    "source": [ "obj-46", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-7", 1 ],
                    "midpoints": [ 39.5, 234.0, 89.5, 234.0 ],
                    "source": [ "obj-6", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-8", 0 ],
                    "midpoints": [ 39.5, 264.0, 39.5, 264.0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-10", 0 ],
                    "midpoints": [ 84.5, 60.0, 69.5, 60.0 ],
                    "source": [ "obj-9", 0 ]
                }
            }
        ],
        "autosave": 0
    }
}