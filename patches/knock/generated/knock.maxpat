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
            85.0,
            104.0,
            807.0,
            515.0
        ],
        "boxes": [
            {
                "box": {
                    "angle": 270.0,
                    "background": 1,
                    "grad1": [
                        0.20784313725490197,
                        0.20784313725490197,
                        0.3254901960784314,
                        1.0
                    ],
                    "grad2": [
                        0.4745098039215686,
                        0.5647058823529412,
                        0.8156862745098039,
                        1.0
                    ],
                    "id": "obj-19",
                    "maxclass": "panel",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        30.0,
                        144.0,
                        134.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        10.0,
                        10.0,
                        439.0,
                        170.0
                    ],
                    "proportion": 0.39,
                    "rounded": 7
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "number",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "",
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        30.0,
                        45.0,
                        50.0,
                        22.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        90.0,
                        75.0,
                        52.0,
                        22.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 6,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        30.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "scale 0 127 0. 1."
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [
                        "bang",
                        "float"
                    ],
                    "patching_rect": [
                        30.0,
                        107.0,
                        93.0,
                        22.0
                    ],
                    "text": "trigger b f"
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-4",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        90.0,
                        165.0,
                        97.0,
                        22.0
                    ],
                    "text": "prepend vel"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "bang"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        212.0,
                        119.0,
                        41.0,
                        41.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        70.0,
                        32.0,
                        32.0
                    ]
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
                    "outlettype": [
                        "signal"
                    ],
                    "patching_rect": [
                        195.0,
                        165.0,
                        58.0,
                        22.0
                    ],
                    "text": "click~"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-7",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        180.0,
                        30.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        170.0,
                        62.0,
                        48.0,
                        48.0
                    ],
                    "size": 1.0
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        180.0,
                        75.0,
                        142.0,
                        22.0
                    ],
                    "text": "prepend randomness"
                }
            },
            {
                "box": {
                    "floatoutput": 1,
                    "id": "obj-9",
                    "maxclass": "dial",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "parameter_enable": 0,
                    "patching_rect": [
                        330.0,
                        30.0,
                        40.0,
                        40.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        253.0,
                        62.0,
                        48.0,
                        48.0
                    ],
                    "size": 1.0
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        330.0,
                        75.0,
                        135.0,
                        22.0
                    ],
                    "text": "prepend bassiness"
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
                    "outlettype": [
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        39.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.3"
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
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        72.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 0.5"
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
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        103.0,
                        128.0,
                        22.0
                    ],
                    "text": "loadmess set 100"
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
                        ""
                    ],
                    "patching_rect": [
                        593.0,
                        133.0,
                        100.0,
                        22.0
                    ],
                    "text": "loadmess 120"
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
                            600.0,
                            450.0
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
                                        30.0,
                                        30.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "in 1"
                                }
                            },
                            {
                                "box": {
                                    "code": "Param bassiness(0.5, min=0, max=1);\nParam randomness(0.3, min=0, max=1);\nParam vel(0.79, min=0, max=1);\nHistory prevtrig(0);\nHistory vindex(0);\nHistory outlp(0);\nHistory kickph1(0);\nHistory bodyph1(0);\nHistory tapph1(0);\nHistory kickenv1(0);\nHistory bodyenv1(0);\nHistory tapenv1(0);\nHistory sweepenv1(0);\nHistory kcoef1(0);\nHistory bcoef1(0);\nHistory tcoef1(0);\nHistory scoef1(0);\nHistory swmul1(2);\nHistory velamp1(0);\nHistory freqmul1(1);\nHistory tapfreq1(750);\nHistory taplvl1(0);\nHistory kickph2(0);\nHistory bodyph2(0);\nHistory tapph2(0);\nHistory kickenv2(0);\nHistory bodyenv2(0);\nHistory tapenv2(0);\nHistory sweepenv2(0);\nHistory kcoef2(0);\nHistory bcoef2(0);\nHistory tcoef2(0);\nHistory scoef2(0);\nHistory swmul2(2);\nHistory velamp2(0);\nHistory freqmul2(1);\nHistory tapfreq2(750);\nHistory taplvl2(0);\nHistory kickph3(0);\nHistory bodyph3(0);\nHistory tapph3(0);\nHistory kickenv3(0);\nHistory bodyenv3(0);\nHistory tapenv3(0);\nHistory sweepenv3(0);\nHistory kcoef3(0);\nHistory bcoef3(0);\nHistory tcoef3(0);\nHistory scoef3(0);\nHistory swmul3(2);\nHistory velamp3(0);\nHistory freqmul3(1);\nHistory tapfreq3(750);\nHistory taplvl3(0);\nHistory kickph4(0);\nHistory bodyph4(0);\nHistory tapph4(0);\nHistory kickenv4(0);\nHistory bodyenv4(0);\nHistory tapenv4(0);\nHistory sweepenv4(0);\nHistory kcoef4(0);\nHistory bcoef4(0);\nHistory tcoef4(0);\nHistory scoef4(0);\nHistory swmul4(2);\nHistory velamp4(0);\nHistory freqmul4(1);\nHistory tapfreq4(750);\nHistory taplvl4(0);\n\ntrg = 0.;\nif (in1 > 0.5) {\n    if (prevtrig <= 0.5) {\n        trg = 1.;\n    }\n}\nprevtrig = in1;\n\ng1 = 0.;\ng2 = 0.;\ng3 = 0.;\ng4 = 0.;\nrdec = 0.;\nrswp = 0.;\nratk = 0.;\nrpit = 0.;\nrtap = 0.;\ntkick = 0.;\ntbody = 0.;\nnkc = 0.;\nnbc = 0.;\nntc = 0.;\nnsc = 0.;\nnsw = 0.;\nnfm = 1.;\nntf = 750.;\nntl = 0.;\nnva = 0.;\nif (trg > 0.5) {\n    rdec = noise() * randomness;\n    rswp = noise() * randomness;\n    ratk = noise() * randomness;\n    rpit = noise() * randomness;\n    rtap = noise() * randomness;\n    tkick = (0.5 + 0.4 * bassiness) * (1. + 1.1 * rdec);\n    tkick = max(tkick, 0.04);\n    tbody = (0.14 + 0.1 * bassiness) * (1. + 0.9 * rdec);\n    tbody = max(tbody, 0.02);\n    nkc = exp(-1. / (tkick * samplerate));\n    nbc = exp(-1. / (tbody * samplerate));\n    ntc = exp(-1. / (0.012 * samplerate));\n    nsc = exp(-1. / (0.045 * samplerate));\n    nsw = 2. * (1. + 1.4 * rswp);\n    nsw = max(nsw, 0.15);\n    nfm = 1. + 0.35 * rpit;\n    nfm = clamp(nfm, 0.5, 1.8);\n    ntf = 750. * (1. + 0.5 * rtap);\n    ntf = clamp(ntf, 380., 1400.);\n    ntl = 0.38 * (0.5 + 0.5 * vel) * (1. + 0.8 * ratk);\n    ntl = max(ntl, 0.);\n    nva = vel * vel;\n    vindex = vindex + 1.;\n    if (vindex > 3.5) {\n        vindex = 0.;\n    }\n    g1 = (vindex < 0.5);\n    g2 = (vindex > 0.5) * (vindex < 1.5);\n    g3 = (vindex > 1.5) * (vindex < 2.5);\n    g4 = (vindex > 2.5);\n}\n\nif (g1 > 0.5) {\n    kcoef1 = nkc;\n    bcoef1 = nbc;\n    tcoef1 = ntc;\n    scoef1 = nsc;\n    swmul1 = nsw;\n    freqmul1 = nfm;\n    tapfreq1 = ntf;\n    taplvl1 = ntl;\n    velamp1 = nva;\n    kickph1 = 0.;\n    bodyph1 = 0.;\n    tapph1 = 0.;\n    kickenv1 = 1.;\n    bodyenv1 = 1.;\n    tapenv1 = 1.;\n    sweepenv1 = 1.;\n}\n\nif (g2 > 0.5) {\n    kcoef2 = nkc;\n    bcoef2 = nbc;\n    tcoef2 = ntc;\n    scoef2 = nsc;\n    swmul2 = nsw;\n    freqmul2 = nfm;\n    tapfreq2 = ntf;\n    taplvl2 = ntl;\n    velamp2 = nva;\n    kickph2 = 0.;\n    bodyph2 = 0.;\n    tapph2 = 0.;\n    kickenv2 = 1.;\n    bodyenv2 = 1.;\n    tapenv2 = 1.;\n    sweepenv2 = 1.;\n}\n\nif (g3 > 0.5) {\n    kcoef3 = nkc;\n    bcoef3 = nbc;\n    tcoef3 = ntc;\n    scoef3 = nsc;\n    swmul3 = nsw;\n    freqmul3 = nfm;\n    tapfreq3 = ntf;\n    taplvl3 = ntl;\n    velamp3 = nva;\n    kickph3 = 0.;\n    bodyph3 = 0.;\n    tapph3 = 0.;\n    kickenv3 = 1.;\n    bodyenv3 = 1.;\n    tapenv3 = 1.;\n    sweepenv3 = 1.;\n}\n\nif (g4 > 0.5) {\n    kcoef4 = nkc;\n    bcoef4 = nbc;\n    tcoef4 = ntc;\n    scoef4 = nsc;\n    swmul4 = nsw;\n    freqmul4 = nfm;\n    tapfreq4 = ntf;\n    taplvl4 = ntl;\n    velamp4 = nva;\n    kickph4 = 0.;\n    bodyph4 = 0.;\n    tapph4 = 0.;\n    kickenv4 = 1.;\n    bodyenv4 = 1.;\n    tapenv4 = 1.;\n    sweepenv4 = 1.;\n}\n\nhard = 2.2 + 1.3 * bassiness;\nvsum = 0.;\n\nbasef1 = (40. - 18. * bassiness) * freqmul1;\nkfreq1 = basef1 * (1. + swmul1 * sweepenv1 * sweepenv1);\nbfreq1 = basef1 * 2.7;\nkickph1 = wrap(kickph1 + kfreq1 / samplerate, 0., 1.);\nbodyph1 = wrap(bodyph1 + bfreq1 / samplerate, 0., 1.);\ntapph1 = wrap(tapph1 + tapfreq1 / samplerate, 0., 1.);\nvsig1 = sin(kickph1 * twopi) * kickenv1 * kickenv1 * 0.95;\nvsig1 = vsig1 + sin(bodyph1 * twopi) * bodyenv1 * bodyenv1 * 0.28;\nvsig1 = vsig1 + sin(tapph1 * twopi) * tapenv1 * tapenv1 * taplvl1;\nvsum = vsum + tanh(vsig1 * hard) * velamp1 * 0.85;\nkickenv1 = kickenv1 * kcoef1;\nbodyenv1 = bodyenv1 * bcoef1;\ntapenv1 = tapenv1 * tcoef1;\nsweepenv1 = sweepenv1 * scoef1;\n\nbasef2 = (40. - 18. * bassiness) * freqmul2;\nkfreq2 = basef2 * (1. + swmul2 * sweepenv2 * sweepenv2);\nbfreq2 = basef2 * 2.7;\nkickph2 = wrap(kickph2 + kfreq2 / samplerate, 0., 1.);\nbodyph2 = wrap(bodyph2 + bfreq2 / samplerate, 0., 1.);\ntapph2 = wrap(tapph2 + tapfreq2 / samplerate, 0., 1.);\nvsig2 = sin(kickph2 * twopi) * kickenv2 * kickenv2 * 0.95;\nvsig2 = vsig2 + sin(bodyph2 * twopi) * bodyenv2 * bodyenv2 * 0.28;\nvsig2 = vsig2 + sin(tapph2 * twopi) * tapenv2 * tapenv2 * taplvl2;\nvsum = vsum + tanh(vsig2 * hard) * velamp2 * 0.85;\nkickenv2 = kickenv2 * kcoef2;\nbodyenv2 = bodyenv2 * bcoef2;\ntapenv2 = tapenv2 * tcoef2;\nsweepenv2 = sweepenv2 * scoef2;\n\nbasef3 = (40. - 18. * bassiness) * freqmul3;\nkfreq3 = basef3 * (1. + swmul3 * sweepenv3 * sweepenv3);\nbfreq3 = basef3 * 2.7;\nkickph3 = wrap(kickph3 + kfreq3 / samplerate, 0., 1.);\nbodyph3 = wrap(bodyph3 + bfreq3 / samplerate, 0., 1.);\ntapph3 = wrap(tapph3 + tapfreq3 / samplerate, 0., 1.);\nvsig3 = sin(kickph3 * twopi) * kickenv3 * kickenv3 * 0.95;\nvsig3 = vsig3 + sin(bodyph3 * twopi) * bodyenv3 * bodyenv3 * 0.28;\nvsig3 = vsig3 + sin(tapph3 * twopi) * tapenv3 * tapenv3 * taplvl3;\nvsum = vsum + tanh(vsig3 * hard) * velamp3 * 0.85;\nkickenv3 = kickenv3 * kcoef3;\nbodyenv3 = bodyenv3 * bcoef3;\ntapenv3 = tapenv3 * tcoef3;\nsweepenv3 = sweepenv3 * scoef3;\n\nbasef4 = (40. - 18. * bassiness) * freqmul4;\nkfreq4 = basef4 * (1. + swmul4 * sweepenv4 * sweepenv4);\nbfreq4 = basef4 * 2.7;\nkickph4 = wrap(kickph4 + kfreq4 / samplerate, 0., 1.);\nbodyph4 = wrap(bodyph4 + bfreq4 / samplerate, 0., 1.);\ntapph4 = wrap(tapph4 + tapfreq4 / samplerate, 0., 1.);\nvsig4 = sin(kickph4 * twopi) * kickenv4 * kickenv4 * 0.95;\nvsig4 = vsig4 + sin(bodyph4 * twopi) * bodyenv4 * bodyenv4 * 0.28;\nvsig4 = vsig4 + sin(tapph4 * twopi) * tapenv4 * tapenv4 * taplvl4;\nvsum = vsum + tanh(vsig4 * hard) * velamp4 * 0.85;\nkickenv4 = kickenv4 * kcoef4;\nbodyenv4 = bodyenv4 * bcoef4;\ntapenv4 = tapenv4 * tcoef4;\nsweepenv4 = sweepenv4 * scoef4;\n\nlpc = 1. - exp(-6.2831853 * 2200. / samplerate);\noutlp = outlp + lpc * (vsum - outlp);\nout1 = outlp;\n",
                                    "fontface": 0,
                                    "fontname": "<Monospaced>",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "codebox",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [
                                        ""
                                    ],
                                    "patching_rect": [
                                        30.0,
                                        75.0,
                                        400.0,
                                        200.0
                                    ]
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-3",
                                    "linecount": 2,
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [
                                        210.0,
                                        300.0,
                                        30.0,
                                        22.0
                                    ],
                                    "text": "out 1"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [
                                        "obj-2",
                                        0
                                    ],
                                    "midpoints": [
                                        39.5,
                                        63.5,
                                        39.5,
                                        63.5
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
                                        0
                                    ],
                                    "source": [
                                        "obj-2",
                                        0
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
                        195.0,
                        195.0,
                        121.0,
                        22.0
                    ],
                    "text": "gen~"
                }
            },
            {
                "box": {
                    "id": "obj-16",
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
                        237.0,
                        240.0,
                        28.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        327.0,
                        26.0,
                        24.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [
                        "float"
                    ],
                    "patching_rect": [
                        270.0,
                        240.0,
                        15.0,
                        100.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        357.0,
                        26.0,
                        14.0,
                        120.0
                    ]
                }
            },
            {
                "box": {
                    "bgcolor": [
                        0.92,
                        0.85,
                        0.85,
                        1.0
                    ],
                    "id": "obj-18",
                    "maxclass": "ezdac~",
                    "numinlets": 2,
                    "numoutlets": 0,
                    "patching_rect": [
                        225.0,
                        405.0,
                        45.0,
                        45.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        390.0,
                        63.5,
                        45.0,
                        45.0
                    ]
                }
            },
            {
                "box": {
                    "fontface": 1,
                    "fontname": "Arial",
                    "fontsize": 18.0,
                    "id": "obj-20",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        176.0,
                        74.0,
                        27.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        25.0,
                        20.0,
                        90.0,
                        27.0
                    ],
                    "text": "KNOCK",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-21",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        585.0,
                        212.0,
                        40.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        35.0,
                        108.0,
                        40.0,
                        20.0
                    ],
                    "text": "hit",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-22",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        586.0,
                        242.0,
                        72.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        88.0,
                        108.0,
                        60.0,
                        20.0
                    ],
                    "text": "velocity",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        586.0,
                        271.0,
                        86.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        158.0,
                        115.0,
                        78.0,
                        20.0
                    ],
                    "text": "randomness",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        671.0,
                        176.0,
                        79.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        246.0,
                        115.0,
                        68.0,
                        20.0
                    ],
                    "text": "bassiness",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        671.0,
                        212.0,
                        58.0,
                        20.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        327.0,
                        151.0,
                        44.0,
                        20.0
                    ],
                    "text": "output",
                    "textcolor": [
                        0.92,
                        0.92,
                        0.92,
                        1.0
                    ]
                }
            },
            {
                "box": {
                    "fontname": "Arial",
                    "fontsize": 12.0,
                    "id": "obj-26",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [
                        550.0,
                        10.0,
                        58.0,
                        20.0
                    ],
                    "text": "v0.1.2"
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [
                        "obj-2",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        69.0,
                        39.5,
                        69.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        339.5,
                        180.0,
                        255.0,
                        180.0,
                        255.0,
                        192.0,
                        204.5,
                        192.0
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
                        "obj-7",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        63.0,
                        477.0,
                        63.0,
                        477.0,
                        15.0,
                        189.5,
                        15.0
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
                        "obj-9",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        96.0,
                        477.0,
                        96.0,
                        477.0,
                        27.0,
                        339.5,
                        27.0
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
                        "obj-1",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        126.0,
                        477.0,
                        126.0,
                        477.0,
                        15.0,
                        39.5,
                        15.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        602.5,
                        156.0,
                        327.0,
                        156.0,
                        327.0,
                        237.0,
                        246.5,
                        237.0
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
                        "obj-16",
                        0
                    ],
                    "midpoints": [
                        204.5,
                        237.0,
                        246.5,
                        237.0
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
                        "obj-17",
                        0
                    ],
                    "midpoints": [
                        246.5,
                        351.0,
                        297.0,
                        351.0,
                        297.0,
                        237.0,
                        279.0,
                        237.0
                    ],
                    "order": 0,
                    "source": [
                        "obj-16",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-18",
                        1
                    ],
                    "midpoints": [
                        246.5,
                        390.0,
                        260.5,
                        390.0
                    ],
                    "order": 1,
                    "source": [
                        "obj-16",
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
                        246.5,
                        390.0,
                        234.5,
                        390.0
                    ],
                    "order": 2,
                    "source": [
                        "obj-16",
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
                    "midpoints": [
                        39.5,
                        99.0,
                        39.5,
                        99.0
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
                        113.5,
                        150.0,
                        99.5,
                        150.0
                    ],
                    "source": [
                        "obj-3",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "destination": [
                        "obj-6",
                        0
                    ],
                    "midpoints": [
                        39.5,
                        150.0,
                        201.0,
                        150.0,
                        201.0,
                        162.0,
                        204.5,
                        162.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        99.5,
                        198.0,
                        192.0,
                        198.0,
                        192.0,
                        192.0,
                        204.5,
                        192.0
                    ],
                    "source": [
                        "obj-4",
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
                    "midpoints": [
                        221.5,
                        162.0,
                        204.5,
                        162.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        204.5,
                        189.0,
                        204.5,
                        189.0
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
                    "midpoints": [
                        189.5,
                        72.0,
                        189.5,
                        72.0
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
                        "obj-15",
                        0
                    ],
                    "midpoints": [
                        189.5,
                        192.0,
                        204.5,
                        192.0
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
                        "obj-10",
                        0
                    ],
                    "midpoints": [
                        339.5,
                        72.0,
                        339.5,
                        72.0
                    ],
                    "source": [
                        "obj-9",
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
        ]
    }
}