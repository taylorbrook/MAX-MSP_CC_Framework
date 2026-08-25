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
            640.0,
            480.0
        ],
        "bglocked": 0,
        "openinpresentation": 1,
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
                    "maxclass": "flonum",
                    "id": "obj-14",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        ""
                    ],
                    "patching_rect": [
                        320.0,
                        30.0,
                        60.0,
                        60.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        95.0,
                        205.0,
                        50.0,
                        22.0
                    ],
                    "numdecimalplaces": 2,
                    "ignoreclick": 1
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-1",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [
                        "signal",
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        30,
                        30,
                        64.0,
                        22.0
                    ],
                    "text": "adc~",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-2",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        "signal"
                    ],
                    "patching_rect": [
                        30,
                        120,
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
                                        50.0,
                                        20.0,
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
                                        130.0,
                                        20.0,
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
                                    "numoutlets": 2,
                                    "outlettype": [
                                        "",
                                        ""
                                    ],
                                    "patching_rect": [
                                        50.0,
                                        80.0,
                                        400.0,
                                        200.0
                                    ],
                                    "parameter_enable": 0,
                                    "code": "// disintegrate v0.1.0 -- one-knob perceptual disintegration\n// amount 0 = bypass, 1 = silence. Stages are overlapping ramps of amount:\n//   wobble 0.10-0.90 | drive 0.20-0.80 | LP/HP converge 0.30-0.95 | fade 0.85-1.0\nParam amount(0, min=0, max=1);\nDelay dl(4096);\nDelay dr(4096);\nHistory amt_s(0);\nHistory ou_l(0);\nHistory ou_r(0.1);\nHistory ous_l(0);\nHistory ous_r(0);\nHistory lfo_ph(0);\nHistory lp1l(0);\nHistory lp2l(0);\nHistory lp1r(0);\nHistory lp2r(0);\nHistory hp1l(0);\nHistory hp2l(0);\nHistory hp1r(0);\nHistory hp2r(0);\nHistory dcxl(0);\nHistory dcyl(0);\nHistory dcxr(0);\nHistory dcyr(0);\n\nxl = in1;\nxr = in2;\n\n// 20 ms smoother on the knob (no zipper)\na = amount + exp(-1 / (0.02 * samplerate)) * (amt_s - amount);\namt_s = a;\n\n// ---- stage curves (hermite ramps of a) ----\ntw = clamp((a - 0.0) / 0.1, 0, 1);\nwet = tw * tw * (3 - 2 * tw);\ntb = clamp((a - 0.1) / 0.8, 0, 1);\nwob = tb * tb * (3 - 2 * tb);\ntd = clamp((a - 0.2) / 0.6, 0, 1);\ndrv = td * td * (3 - 2 * td);\ntf = clamp((a - 0.3) / 0.65, 0, 1);\nfl = tf * tf * (3 - 2 * tf);\nte = clamp((a - 0.85) / 0.15, 0, 1);\nfade = 1 - te * te * (3 - 2 * te);\n\n// ---- wobble: Ornstein-Uhlenbeck drift (per channel) + shared LFO ----\nnl = ou_l + sqrt(1 / samplerate) * noise() * (0.3 + wob * 1.5);\nnl = nl + 20 * (0 - nl) * (1 / samplerate);\nou_l = nl;\nosl = nl + exp(0 - twopi * 10 / samplerate) * (ous_l - nl);\nous_l = osl;\n\nnr = ou_r + sqrt(1 / samplerate) * noise() * (0.3 + wob * 1.5);\nnr = nr + 20 * (0 - nr) * (1 / samplerate);\nou_r = nr;\nosr = nr + exp(0 - twopi * 10 / samplerate) * (ous_r - nr);\nous_r = osr;\n\nph = wrap(lfo_ph + twopi * (0.5 + wob * 4) / samplerate, 0, twopi);\nlfo_ph = ph;\ndepth = wob * wob * 40;\nposl = clamp(60 + depth * sin(ph) + osl * 60 * wob, 1, 4000);\nposr = clamp(60 + depth * sin(ph + 0.7) + osr * 60 * wob, 1, 4000);\n\ndl.write(xl);\ndr.write(xr);\nwl = dl.read(posl);\nwr = dr.read(posr);\n\n// ---- saturation (mild loudness rise, then DC block) ----\ng = 1 + drv * 24;\nnorm = 1 + drv * 12;\nsl = tanh(wl * g) / norm;\nsr_ = tanh(wr * g) / norm;\ndl_out = sl - dcxl + 0.995 * dcyl;\ndcxl = sl;\ndcyl = dl_out;\ndr_out = sr_ - dcxr + 0.995 * dcyr;\ndcxr = sr_;\ndcyr = dr_out;\n\n// ---- LP falls 20k -> 200 Hz, HP rises 20 -> 2k Hz (log curves), 12 dB/oct each ----\nlpfc = 20000 * pow(0.01, fl);\nhpfc = 20 * pow(100, fl);\nlc = clamp(1 - exp(0 - twopi * lpfc / samplerate), 0.0001, 0.999);\nhc = clamp(1 - exp(0 - twopi * hpfc / samplerate), 0.0001, 0.999);\n\nl1 = lp1l + lc * (dl_out - lp1l);\nlp1l = l1;\nl2 = lp2l + lc * (l1 - lp2l);\nlp2l = l2;\nh1s = hp1l + hc * (l2 - hp1l);\nhp1l = h1s;\nh1 = l2 - h1s;\nh2s = hp2l + hc * (h1 - hp2l);\nhp2l = h2s;\nyl = h1 - h2s;\n\nr1 = lp1r + lc * (dr_out - lp1r);\nlp1r = r1;\nr2 = lp2r + lc * (r1 - lp2r);\nlp2r = r2;\nk1s = hp1r + hc * (r2 - hp1r);\nhp1r = k1s;\nk1 = r2 - k1s;\nk2s = hp2r + hc * (k1 - hp2r);\nhp2r = k2s;\nyr = k1 - k2s;\n\n// ---- final fade + bypass crossfade ----\nout1 = xl + wet * (yl * fade - xl);\nout2 = xr + wet * (yr * fade - xr);\n",
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
                                        50.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1",
                                    "fontname": "Arial",
                                    "fontsize": 12.0
                                }
                            },
                            {
                                "box": {
                                    "maxclass": "newobj",
                                    "id": "obj-5",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "outlettype": [],
                                    "patching_rect": [
                                        130.0,
                                        320.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 2",
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
                            },
                            {
                                "patchline": {
                                    "source": [
                                        "obj-3",
                                        1
                                    ],
                                    "destination": [
                                        "obj-5",
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
                    },
                    "varname": "disint"
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-3",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        225.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        40.0,
                        22.0,
                        160.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "gain~",
                    "id": "obj-4",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "signal",
                        ""
                    ],
                    "patching_rect": [
                        75.0,
                        225.0,
                        22.0,
                        140.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        256.0,
                        40.0,
                        22.0,
                        160.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-5",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        135.0,
                        225.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        284.0,
                        40.0,
                        14.0,
                        160.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "meter~",
                    "id": "obj-6",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        225.0,
                        15.0,
                        100.0
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        302.0,
                        40.0,
                        14.0,
                        160.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-7",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        30.0,
                        375.0,
                        44.0,
                        22.0
                    ],
                    "text": "dac~",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-8",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        230,
                        225,
                        191.0,
                        20.0
                    ],
                    "text": "gain~ L drives R (linked)",
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
                    "maxclass": "dial",
                    "id": "obj-9",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        320,
                        30,
                        60,
                        60
                    ],
                    "parameter_enable": 0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        40.0,
                        160.0,
                        160.0
                    ],
                    "floatoutput": 1,
                    "size": 1.0,
                    "min": 0.0
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-10",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        320,
                        110,
                        79.0,
                        22.0
                    ],
                    "text": "amount $1",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "newobj",
                    "id": "obj-11",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        30,
                        72.0,
                        22.0
                    ],
                    "text": "loadbang",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "bgcolor": [
                        0.85,
                        0.92,
                        0.85,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "maxclass": "message",
                    "id": "obj-12",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        420,
                        70,
                        40.0,
                        22.0
                    ],
                    "text": "0.",
                    "fontname": "Arial",
                    "fontsize": 12.0
                }
            },
            {
                "box": {
                    "maxclass": "comment",
                    "id": "obj-13",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        320,
                        95,
                        100.0,
                        20.0
                    ],
                    "text": "disintegrate",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        40.0,
                        10.0,
                        160.0,
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
                    "maxclass": "comment",
                    "id": "obj-15",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        390,
                        110,
                        177.0,
                        20.0
                    ],
                    "text": "0 = bypass, 1 = silence",
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
                    "maxclass": "comment",
                    "id": "obj-16",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "outlettype": [],
                    "patching_rect": [
                        230,
                        205,
                        40.0,
                        20.0
                    ],
                    "text": "out",
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "presentation": 1,
                    "presentation_rect": [
                        230.0,
                        205.0,
                        60.0,
                        22.0
                    ],
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
                        "obj-1",
                        0
                    ],
                    "destination": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-1",
                        1
                    ],
                    "destination": [
                        "obj-2",
                        1
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
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-2",
                        1
                    ],
                    "destination": [
                        "obj-4",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-3",
                        1
                    ],
                    "destination": [
                        "obj-4",
                        0
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
                        "obj-5",
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
                        0
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
                        "obj-7",
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
                        "obj-7",
                        1
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
            },
            {
                "patchline": {
                    "source": [
                        "obj-10",
                        0
                    ],
                    "destination": [
                        "obj-2",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-11",
                        0
                    ],
                    "destination": [
                        "obj-12",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "obj-12",
                        0
                    ],
                    "destination": [
                        "obj-9",
                        0
                    ]
                }
            }
        ],
        "dependency_cache": [],
        "autosave": 0,
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