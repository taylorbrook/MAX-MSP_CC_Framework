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
        "rect": [
            34.0,
            104.0,
            1333.0,
            740.0
        ],
        "openinpresentation": 1,
        "boxes": [
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        740.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "text": "48000."
                }
            },
            {
                "box": {
                    "id": "obj-21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        740.0,
                        105.0,
                        50.0,
                        22.0
                    ],
                    "text": "4800"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "format": 6,
                    "id": "obj-139",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        763.0,
                        83.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        361.0,
                        30.0,
                        39.0,
                        22.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "start_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-124",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        33.0,
                        730.0,
                        33.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        122.5,
                        39.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "pitch_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-125",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        143.0,
                        730.0,
                        32.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        73.5,
                        122.5,
                        38.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "cutoff_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-126",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        253.0,
                        730.0,
                        33.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        133.0,
                        122.5,
                        39.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "reso_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-127",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        493.0,
                        730.0,
                        33.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        288.0,
                        122.0,
                        39.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "degrade_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-128",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        653.0,
                        730.0,
                        33.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        348.0,
                        122.0,
                        39.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "vol_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-129",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        763.0,
                        730.0,
                        33.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        13.0,
                        202.5,
                        39.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "atk_readout"
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.0,
                        0.0,
                        0.0,
                        0.0
                    ],
                    "fontsize": 10.0,
                    "format": 6,
                    "id": "obj-130",
                    "ignoreclick": 1,
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        873.0,
                        730.0,
                        33.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        73.0,
                        202.5,
                        39.0,
                        20.0
                    ],
                    "textcolor": [
                        1.0,
                        1.0,
                        1.0,
                        1.0
                    ],
                    "triangle": 0,
                    "varname": "dec_readout"
                }
            },
            {
                "box": {
                    "id": "obj-83",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        600.0,
                        345.0,
                        150.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        220.0,
                        65.0,
                        55.0,
                        20.0
                    ],
                    "text": "STEPS:"
                }
            },
            {
                "box": {
                    "id": "obj-82",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        600.0,
                        325.0,
                        150.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        65.0,
                        92.0,
                        20.0
                    ],
                    "text": "LOAD SOUND"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "bang"
                    ],
                    "patching_rect": [
                        130.0,
                        18.0,
                        147.0,
                        22.0
                    ],
                    "text": "buffer~ #1",
                    "varname": "buffer"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        10.0,
                        845.0,
                        210.0,
                        22.0
                    ],
                    "text": "groove~ #1",
                    "varname": "groove"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 10,
                    "outlettype": [
                        "float",
                        "list",
                        "float",
                        "float",
                        "float",
                        "float",
                        "float",
                        "",
                        "int",
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        18.0,
                        258.43748474121094,
                        22.0
                    ],
                    "text": "info~ #1",
                    "varname": "info"
                }
            },
            {
                "box": {
                    "buffername": "#1",
                    "id": "obj-4",
                    "maxclass": "waveform~",
                    "numinlets": 5,
                    "numoutlets": 6,
                    "outlettype": [
                        "float",
                        "float",
                        "float",
                        "float",
                        "list",
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        55.0,
                        350.0,
                        60.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        0.0,
                        0.0,
                        345.0,
                        60.0
                    ],
                    "selectioncolor": [
                        1.0,
                        0.3,
                        0.2,
                        0.8
                    ],
                    "varname": "waveform"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 4,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        280.0,
                        845.0,
                        88.0,
                        22.0
                    ],
                    "text": "svf~",
                    "varname": "svf"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        280.0,
                        875.0,
                        160.0,
                        22.0
                    ],
                    "text": "selector~ 4",
                    "varname": "selector"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        450.0,
                        875.0,
                        72.0,
                        22.0
                    ],
                    "text": "degrade~",
                    "varname": "degrade"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-8",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        580.0,
                        875.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~",
                    "varname": "env_mult"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-9",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        700.0,
                        875.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~",
                    "varname": "vol_mult"
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
                    "outlettype": [
                        "signal",
                        "bang"
                    ],
                    "patching_rect": [
                        580.0,
                        825.0,
                        39.0,
                        22.0
                    ],
                    "text": "line~",
                    "varname": "env_line"
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
                        700.0,
                        940.0,
                        88.0,
                        22.0
                    ],
                    "text": "send~ #2",
                    "varname": "send_out"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        30.0,
                        785.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "pitch_sig"
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
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        140.0,
                        785.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "cutoff_sig"
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
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        250.0,
                        785.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "reso_sig"
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
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        490.0,
                        785.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "degrade_sr_sig"
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
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        560.0,
                        785.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "degrade_bd_sig"
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
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        650.0,
                        785.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "vol_sig"
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        800.0,
                        905.0,
                        15.0,
                        58.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        185.0,
                        270.0,
                        55.0
                    ],
                    "varname": "meter"
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        80.0,
                        100.0,
                        22.0
                    ],
                    "text": "setbuffer #1",
                    "varname": "setbuf_msg"
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        450.0,
                        55.0,
                        58.0,
                        22.0
                    ],
                    "text": "set #1",
                    "varname": "set_buf_name_msg"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-30",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 4,
                    "outlettype": [
                        "int",
                        "",
                        "",
                        "int"
                    ],
                    "patching_rect": [
                        10.0,
                        275.0,
                        81.5,
                        22.0
                    ],
                    "text": "counter 0 15",
                    "varname": "counter"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-31",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        10.0,
                        305.0,
                        80.5,
                        22.0
                    ],
                    "text": "trigger i i",
                    "varname": "trig_seq"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-32",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        440.0,
                        375.0,
                        135.0,
                        22.0
                    ],
                    "saved_object_attributes": {
                        "filename": "slot-engine.js",
                        "parameter_enable": 0
                    },
                    "text": "js slot-engine.js",
                    "varname": "js_engine"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-33",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        365.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend fetch",
                    "varname": "prepend_fetch"
                }
            },
            {
                "box": {
                    "id": "obj-34",
                    "maxclass": "multislider",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        150.0,
                        365.0,
                        220.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        250.0,
                        390.0,
                        80.0
                    ],
                    "setminmax": [
                        0.0,
                        127.0
                    ],
                    "setstyle": 1,
                    "size": 16,
                    "varname": "mslider"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        150.0,
                        500.0,
                        103.5,
                        22.0
                    ],
                    "text": "split 1 127",
                    "varname": "split_vel"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-36",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "float"
                    ],
                    "patching_rect": [
                        150.0,
                        530.0,
                        80.5,
                        22.0
                    ],
                    "text": "trigger b f",
                    "varname": "trig_vel"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-37",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        80.0,
                        560.0,
                        40.5,
                        22.0
                    ],
                    "text": "/ 127.",
                    "varname": "vel_div"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-38",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        80.0,
                        595.0,
                        88.0,
                        22.0
                    ],
                    "text": "pack f f f",
                    "varname": "env_pack"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        80.0,
                        630.0,
                        100.0,
                        22.0
                    ],
                    "text": "$1 $2 0. $3",
                    "varname": "env_msg"
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        240.0,
                        560.0,
                        79.0,
                        22.0
                    ],
                    "text": "startloop",
                    "varname": "start_msg"
                }
            },
            {
                "box": {
                    "id": "obj-41",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        10.0,
                        15.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        65.0,
                        50.0,
                        20.0
                    ],
                    "varname": "load_btn"
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        50.0,
                        18.0,
                        44.0,
                        22.0
                    ],
                    "text": "read",
                    "varname": "load_msg"
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        440.0,
                        345.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        280.0,
                        64.0,
                        100.0,
                        22.0
                    ],
                    "varname": "num_slices"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-44",
                    "maxclass": "dial",
                    "min": -1200.0,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        105.0,
                        55.0,
                        55.0
                    ],
                    "size": 2401.0,
                    "varname": "pitch_dial"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-45",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        755.0,
                        198.0,
                        22.0
                    ],
                    "text": "expr pow(2.\\, $f1 / 1200.)",
                    "varname": "pitch_expr"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-46",
                    "maxclass": "dial",
                    "mult": 100.0,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        140.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        105.0,
                        55.0,
                        55.0
                    ],
                    "size": 201.0,
                    "varname": "cutoff_dial"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-48",
                    "maxclass": "dial",
                    "mult": 0.01,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        250.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        105.0,
                        55.0,
                        55.0
                    ],
                    "size": 101.0,
                    "varname": "reso_dial"
                }
            },
            {
                "box": {
                    "id": "obj-50",
                    "items": [
                        "LP",
                        ",",
                        "HP",
                        ",",
                        "BP",
                        ",",
                        "Notch"
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
                        360.0,
                        685.0,
                        70.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        185.0,
                        105.0,
                        66.0,
                        22.0
                    ],
                    "varname": "filter_umenu"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-51",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        360.0,
                        715.0,
                        32.5,
                        22.0
                    ],
                    "text": "+ 1",
                    "varname": "filter_plus"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-52",
                    "maxclass": "dial",
                    "min": 0.1,
                    "mult": 0.01,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        490.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        280.0,
                        105.0,
                        55.0,
                        55.0
                    ],
                    "size": 91.0,
                    "varname": "degrade_dial"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-54",
                    "maxclass": "dial",
                    "mult": 0.01,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        650.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        340.0,
                        105.0,
                        55.0,
                        55.0
                    ],
                    "size": 121.0,
                    "varname": "vol_dial"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-56",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        760.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        185.0,
                        55.0,
                        55.0
                    ],
                    "size": 201.0,
                    "varname": "atk_dial"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-57",
                    "maxclass": "dial",
                    "mult": 0.01,
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        870.0,
                        685.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        185.0,
                        55.0,
                        55.0
                    ],
                    "size": 101.0,
                    "varname": "dec_dial"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-72",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        30.0,
                        665.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        90.0,
                        55.0,
                        20.0
                    ],
                    "text": "Pitch",
                    "varname": "pitch_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-73",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        140.0,
                        665.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        90.0,
                        55.0,
                        20.0
                    ],
                    "text": "Cutoff",
                    "varname": "cutoff_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-74",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        250.0,
                        665.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        125.0,
                        90.0,
                        55.0,
                        20.0
                    ],
                    "text": "Reso",
                    "varname": "reso_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-75",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        360.0,
                        665.0,
                        44.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        185.0,
                        90.0,
                        55.0,
                        20.0
                    ],
                    "text": "Type",
                    "varname": "type_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-76",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        490.0,
                        665.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        280.0,
                        90.0,
                        55.0,
                        20.0
                    ],
                    "text": "Degrd",
                    "varname": "degrade_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-77",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        650.0,
                        665.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        340.0,
                        90.0,
                        55.0,
                        20.0
                    ],
                    "text": "Vol",
                    "varname": "vol_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-78",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        760.0,
                        665.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        170.0,
                        55.0,
                        20.0
                    ],
                    "text": "Atk",
                    "varname": "atk_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-79",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        870.0,
                        665.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        65.0,
                        170.0,
                        55.0,
                        20.0
                    ],
                    "text": "Dec",
                    "varname": "dec_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-80",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        150.0,
                        345.0,
                        100.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        335.0,
                        390.0,
                        20.0
                    ],
                    "text": "Step Pattern",
                    "varname": "step_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-90",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "int",
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        600.0,
                        345.0,
                        107.0,
                        22.0
                    ],
                    "text": "trigger i i i",
                    "varname": "steps_trig"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-91",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        600.0,
                        375.0,
                        37.0,
                        22.0
                    ],
                    "text": "- 1",
                    "varname": "steps_minus1"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-92",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        700.0,
                        375.0,
                        100.0,
                        22.0
                    ],
                    "text": "prepend size",
                    "varname": "steps_prep_size"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-95",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        920.0,
                        15.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.3.0"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-96",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        175.0,
                        149.0,
                        22.0
                    ],
                    "text": "receive global_play",
                    "varname": "recv_play"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-97",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "int",
                        "int"
                    ],
                    "patching_rect": [
                        10.0,
                        205.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger i i",
                    "varname": "play_trig"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-98",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        ""
                    ],
                    "patching_rect": [
                        140.0,
                        205.0,
                        72.0,
                        22.0
                    ],
                    "text": "select 1",
                    "varname": "play_sel"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-99",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        140.0,
                        235.0,
                        65.0,
                        22.0
                    ],
                    "text": "0",
                    "varname": "reset_msg"
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
                        "bang"
                    ],
                    "patching_rect": [
                        10.0,
                        240.0,
                        79.0,
                        22.0
                    ],
                    "text": "metro 125",
                    "varname": "bpm_metro"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-101",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        175.0,
                        142.0,
                        22.0
                    ],
                    "text": "receive global_bpm",
                    "varname": "recv_bpm"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-102",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        270.0,
                        205.0,
                        37.0,
                        22.0
                    ],
                    "text": "int",
                    "varname": "bpm_int"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-103",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        240.0,
                        83.0,
                        22.0
                    ],
                    "text": "switch 2",
                    "varname": "bpm_switch"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-104",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        270.0,
                        275.0,
                        105.0,
                        22.0
                    ],
                    "text": "expr 60000./$f1/4.",
                    "varname": "bpm_expr"
                }
            },
            {
                "box": {
                    "id": "obj-105",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        440.0,
                        175.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        150.0,
                        356.0,
                        22.0,
                        22.0
                    ],
                    "varname": "ovrd_toggle"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-106",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "int"
                    ],
                    "patching_rect": [
                        440.0,
                        205.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b i",
                    "varname": "ovrd_trig"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-107",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        510.0,
                        240.0,
                        37.0,
                        22.0
                    ],
                    "text": "+ 1",
                    "varname": "ovrd_plus"
                }
            },
            {
                "box": {
                    "id": "obj-108",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        580.0,
                        175.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        175.0,
                        356.0,
                        55.0,
                        22.0
                    ],
                    "varname": "ovrd_num"
                }
            },
            {
                "box": {
                    "id": "obj-109",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        870.0,
                        845.0,
                        24.0,
                        24.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        45.0,
                        356.0,
                        22.0,
                        22.0
                    ],
                    "varname": "mute_toggle"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-110",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        870.0,
                        905.0,
                        44.0,
                        22.0
                    ],
                    "text": "sig~",
                    "varname": "mute_sig"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-111",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        700.0,
                        905.0,
                        42.0,
                        22.0
                    ],
                    "text": "*~",
                    "varname": "mute_mult"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-112",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        870.0,
                        825.0,
                        65.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        5.0,
                        358.0,
                        42.0,
                        20.0
                    ],
                    "text": "MUTE",
                    "varname": "mute_lbl"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-113",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        440.0,
                        155.0,
                        73.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        80.0,
                        358.0,
                        73.0,
                        20.0
                    ],
                    "text": "BPM OVRD",
                    "varname": "ovrd_lbl"
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
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        870.0,
                        875.0,
                        44.0,
                        22.0
                    ],
                    "text": "== 0",
                    "varname": "mute_inv"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-122",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        400.0,
                        310.0,
                        32.5,
                        22.0
                    ],
                    "text": "*",
                    "varname": "dec_mult"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-123",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "float"
                    ],
                    "patching_rect": [
                        270.0,
                        310.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b f",
                    "varname": "bpm_trig"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-131",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        280.0,
                        905.0,
                        100.0,
                        22.0
                    ],
                    "text": "snapshot~ 50"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-137",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        760.0,
                        15.0,
                        51.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        355.0,
                        0.0,
                        40.0,
                        20.0
                    ],
                    "text": "Start",
                    "varname": "start_lbl"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-138",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        760.0,
                        35.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        350.0,
                        15.0,
                        45.0,
                        45.0
                    ],
                    "size": 101.0,
                    "varname": "start_dial"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-144",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "patching_rect": [
                        640.0,
                        55.0,
                        80.5,
                        22.0
                    ],
                    "text": "trigger b"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-146",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "float",
                        "float"
                    ],
                    "patching_rect": [
                        280.0,
                        935.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger f f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-147",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        430.0,
                        965.0,
                        51.0,
                        22.0
                    ],
                    "text": "+ 10."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-148",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        850.0,
                        55.0,
                        58.0,
                        22.0
                    ],
                    "text": "/ 100."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-149",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        "int"
                    ],
                    "patching_rect": [
                        850.0,
                        85.0,
                        32.5,
                        22.0
                    ],
                    "text": "*"
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-150",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        280.0,
                        965.0,
                        226.0,
                        22.0
                    ],
                    "text": "expr ($f1 * ($f2 - $f3)) + $f3",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "id": "obj-p-init",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 16,
                    "outlettype": [
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        "",
                        ""
                    ],
                    "patching_rect": [
                        10.0,
                        920.0,
                        560.0,
                        22.0
                    ],
                    "text": "p init",
                    "fontname": "Arial",
                    "fontsize": 12.0,
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
                        "rect": [
                            100.0,
                            100.0,
                            850.0,
                            500.0
                        ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "so-0",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        30.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-1",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        75.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-2",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        120.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-3",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        165.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-4",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-5",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        255.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-6",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        300.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-7",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        345.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-8",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        390.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-9",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        435.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-10",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        480.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-11",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        525.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-12",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        570.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-13",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        615.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-14",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        660.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "id": "so-15",
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        705.0,
                                        400.0,
                                        25.0,
                                        25.0
                                    ],
                                    "comment": ""
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-62",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        560.0,
                                        110.0,
                                        79.0,
                                        22.0
                                    ],
                                    "text": "loop 1",
                                    "varname": "init_loop"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-63",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        640.0,
                                        110.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "16",
                                    "varname": "init_slices"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-69",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        300.0,
                                        160.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "200",
                                    "varname": "init_cutoff"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-66",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        90.0,
                                        160.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "24.",
                                    "varname": "init_bitdepth"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-60",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        110.0,
                                        457.0,
                                        22.0
                                    ],
                                    "text": "127 127 127 127 127 127 127 127 127 127 127 127 127 127 127 127",
                                    "varname": "init_steps"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-114",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        240.0,
                                        72.0,
                                        22.0
                                    ],
                                    "text": "loadbang",
                                    "varname": "init_lb2"
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
                                        700.0,
                                        110.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "5",
                                    "varname": "init_atk"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-68",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        230.0,
                                        160.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "100",
                                    "varname": "init_vol"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-70",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        370.0,
                                        160.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "90",
                                    "varname": "init_degrade_sr"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-65",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        160.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "100",
                                    "varname": "init_dec"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-71",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        460.0,
                                        160.0,
                                        100.0,
                                        22.0
                                    ],
                                    "text": "setbuffer #1",
                                    "varname": "init_setbuf"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-117",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        210.0,
                                        320.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "120",
                                    "varname": "init_ovrd_bpm"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-118",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        120.0,
                                        320.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "0",
                                    "varname": "init_ovrd"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-59",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 14,
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
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        60.0,
                                        261.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b b b b b b b b b b b",
                                    "varname": "init_trig"
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
                                    "id": "obj-58",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        30.0,
                                        62.0,
                                        22.0
                                    ],
                                    "text": "loadbang",
                                    "varname": "loadbang"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-119",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        320.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "1",
                                    "varname": "init_mute"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-67",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        160.0,
                                        160.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "1200",
                                    "varname": "init_pitch"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-61",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        500.0,
                                        110.0,
                                        40.0,
                                        22.0
                                    ],
                                    "text": "0",
                                    "varname": "init_filter_type"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-115",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 4,
                                    "outlettype": [
                                        "bang",
                                        "bang",
                                        "bang",
                                        "bang"
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        270.0,
                                        121.0,
                                        22.0
                                    ],
                                    "text": "trigger b b b b",
                                    "varname": "init_trig2"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-116",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        310.0,
                                        320.0,
                                        65.0,
                                        22.0
                                    ],
                                    "text": "120",
                                    "varname": "init_bpm_int"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-115",
                                        0
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
                                        "obj-116",
                                        0
                                    ],
                                    "source": [
                                        "obj-115",
                                        3
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-117",
                                        0
                                    ],
                                    "source": [
                                        "obj-115",
                                        2
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-118",
                                        0
                                    ],
                                    "source": [
                                        "obj-115",
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
                                    "source": [
                                        "obj-115",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-59",
                                        0
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
                                        "obj-60",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        11
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-61",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        10
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-62",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        9
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-63",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        8
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
                                        "obj-59",
                                        7
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-65",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        6
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-66",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        5
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-67",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        4
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-68",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        3
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-69",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        2
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-70",
                                        0
                                    ],
                                    "source": [
                                        "obj-59",
                                        1
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-71",
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
                                        "so-0",
                                        0
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
                                        "so-1",
                                        0
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
                                        "so-2",
                                        0
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
                                        "so-3",
                                        0
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
                                        "so-4",
                                        0
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
                                        "so-5",
                                        0
                                    ],
                                    "source": [
                                        "obj-61",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "so-6",
                                        0
                                    ],
                                    "source": [
                                        "obj-62",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "so-7",
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
                                        "so-8",
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
                                    "destination": [
                                        "so-9",
                                        0
                                    ],
                                    "source": [
                                        "obj-65",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "so-10",
                                        0
                                    ],
                                    "source": [
                                        "obj-66",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "so-11",
                                        0
                                    ],
                                    "source": [
                                        "obj-67",
                                        0
                                    ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [
                                        "so-12",
                                        0
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
                                        "so-13",
                                        0
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
                                        "so-14",
                                        0
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
                                        "so-15",
                                        0
                                    ],
                                    "source": [
                                        "obj-71",
                                        0
                                    ]
                                }
                            }
                        ],
                        "editing_bgcolor": [
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
                    "id": "obj-hdr-1",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        0.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- FILE & BUFFER ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "id": "obj-hdr-2",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        155.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- CLOCK & BPM ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "id": "obj-hdr-3",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        335.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- STEP SEQUENCER ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "id": "obj-hdr-4",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        485.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- VELOCITY & ENVELOPE ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "id": "obj-hdr-5",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        650.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- CONTROLS ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "id": "obj-hdr-6",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        815.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- DSP CHAIN ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            },
            {
                "box": {
                    "id": "obj-hdr-7",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        10.0,
                        905.0,
                        200.0,
                        20.0
                    ],
                    "text": "--- INITIALIZATION ---",
                    "fontface": 1,
                    "fontsize": 11.0
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-144",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-1",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-27",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-1",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-28",
                        0
                    ],
                    "order": 2,
                    "source": [
                        "obj-1",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-8",
                        1
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
                        "obj-30",
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
                        "obj-102",
                        0
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
                        1
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
                        "obj-104",
                        0
                    ],
                    "source": [
                        "obj-103",
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
                    "order": 1,
                    "source": [
                        "obj-104",
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
                    "order": 0,
                    "source": [
                        "obj-104",
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
                    "source": [
                        "obj-105",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-102",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-106",
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
                    "order": 0,
                    "source": [
                        "obj-106",
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
                    "source": [
                        "obj-107",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-103",
                        2
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
                        "obj-120",
                        0
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
                        "obj-111",
                        1
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
                        "obj-11",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-111",
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
                    "order": 0,
                    "source": [
                        "obj-111",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        0
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
                        "obj-110",
                        0
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
                        "obj-38",
                        2
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
                        "obj-122",
                        1
                    ],
                    "source": [
                        "obj-123",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-122",
                        0
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
                        "obj-5",
                        1
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
                        "obj-139",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-138",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-149",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-138",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-32",
                        3
                    ],
                    "order": 2,
                    "source": [
                        "obj-138",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        2
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
                        "obj-3",
                        0
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
                        "obj-147",
                        0
                    ],
                    "source": [
                        "obj-146",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-4",
                        2
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
                        "obj-4",
                        3
                    ],
                    "source": [
                        "obj-147",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-149",
                        1
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
                        "obj-2",
                        1
                    ],
                    "order": 1,
                    "source": [
                        "obj-149",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-21",
                        1
                    ],
                    "order": 0,
                    "source": [
                        "obj-149",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        1
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
                        "obj-7",
                        2
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
                        "obj-9",
                        1
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
                        "obj-131",
                        0
                    ],
                    "source": [
                        "obj-2",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-5",
                        0
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
                        "obj-32",
                        1
                    ],
                    "source": [
                        "obj-27",
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
                    "source": [
                        "obj-28",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-148",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-3",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-23",
                        1
                    ],
                    "order": 0,
                    "source": [
                        "obj-3",
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
                    "source": [
                        "obj-30",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-32",
                        0
                    ],
                    "source": [
                        "obj-31",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-33",
                        0
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
                        "obj-2",
                        2
                    ],
                    "source": [
                        "obj-32",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        1
                    ],
                    "source": [
                        "obj-32",
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
                    "source": [
                        "obj-33",
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
                    "source": [
                        "obj-34",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-36",
                        0
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
                        "obj-37",
                        0
                    ],
                    "source": [
                        "obj-36",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-40",
                        0
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
                        "obj-38",
                        0
                    ],
                    "source": [
                        "obj-37",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-39",
                        0
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
                        "obj-10",
                        0
                    ],
                    "source": [
                        "obj-39",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        0
                    ],
                    "source": [
                        "obj-40",
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
                    "source": [
                        "obj-41",
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
                    "source": [
                        "obj-42",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-90",
                        0
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
                        "obj-124",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-45",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-44",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-12",
                        0
                    ],
                    "source": [
                        "obj-45",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-125",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-46",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-13",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-46",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-126",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-14",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-48",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        4
                    ],
                    "source": [
                        "obj-5",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        3
                    ],
                    "source": [
                        "obj-5",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        2
                    ],
                    "source": [
                        "obj-5",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        1
                    ],
                    "source": [
                        "obj-5",
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
                    "source": [
                        "obj-50",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
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
                        "obj-127",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-52",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-15",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-52",
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
                    "order": 0,
                    "source": [
                        "obj-54",
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
                    "order": 1,
                    "source": [
                        "obj-54",
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
                    "order": 0,
                    "source": [
                        "obj-56",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-38",
                        1
                    ],
                    "order": 1,
                    "source": [
                        "obj-56",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-122",
                        0
                    ],
                    "order": 1,
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-130",
                        0
                    ],
                    "order": 0,
                    "source": [
                        "obj-57",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-7",
                        0
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
                        "obj-8",
                        0
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
                        "obj-9",
                        0
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
                        "obj-111",
                        0
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
                        "obj-32",
                        2
                    ],
                    "source": [
                        "obj-90",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-91",
                        0
                    ],
                    "source": [
                        "obj-90",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-92",
                        0
                    ],
                    "source": [
                        "obj-90",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-30",
                        4
                    ],
                    "source": [
                        "obj-91",
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
                    "source": [
                        "obj-92",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-97",
                        0
                    ],
                    "source": [
                        "obj-96",
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
                        "obj-97",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-98",
                        0
                    ],
                    "source": [
                        "obj-97",
                        1
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
                        "obj-98",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-30",
                        3
                    ],
                    "source": [
                        "obj-99",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-131",
                        0
                    ],
                    "destination": [
                        "obj-150",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        6
                    ],
                    "destination": [
                        "obj-150",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-149",
                        0
                    ],
                    "destination": [
                        "obj-150",
                        2
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-150",
                        0
                    ],
                    "destination": [
                        "obj-146",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-102",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-108",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-105",
                        0
                    ],
                    "source": [
                        "obj-p-init",
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
                    "source": [
                        "obj-p-init",
                        3
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-34",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        4
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-50",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        5
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        6
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-43",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        7
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-56",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        8
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-57",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        9
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-16",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        10
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-44",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        11
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-54",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        12
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-46",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        13
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-52",
                        0
                    ],
                    "source": [
                        "obj-p-init",
                        14
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-32",
                        1
                    ],
                    "source": [
                        "obj-p-init",
                        15
                    ]
                }
            }
        ],
        "autosave": 0
    }
}