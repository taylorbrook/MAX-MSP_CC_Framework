#!/usr/bin/env python3
"""Extract MAX/MSP object definitions from XML refpages into domain-organized JSON.

Parses all .maxref.xml files from the local MAX installation and outputs
normalized JSON object databases per domain (Max, MSP, Jitter, MC, Gen, M4L,
Packages, RNBO).

Usage:
    python3 .claude/scripts/extract_objects.py                    # Extract all
    python3 .claude/scripts/extract_objects.py --max-path /path   # Custom MAX path
    python3 .claude/scripts/extract_objects.py --domain msp       # Single domain
    python3 .claude/scripts/extract_objects.py --dry-run           # Count files only
"""

import argparse
import json
import sys
import xml.etree.ElementTree as ET
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

DEFAULT_MAX_PATH = Path("/Applications/Max.app/Contents/Resources/C74")

# Maps source directory patterns to (module_hint, domain_hint)
SOURCE_DIRS = [
    ("docs/refpages/max-ref", "max", "Max"),
    ("docs/refpages/msp-ref", "msp", "MSP"),
    ("docs/refpages/jit-ref", "jit", "Jitter"),
    ("docs/refpages/m4l-ref", "m4l", "M4L"),
    ("packages/Gen/docs/refpages/dsp", "gen-dsp", "Gen"),
    ("packages/Gen/docs/refpages/jit", "gen-jit", "Gen"),
    ("packages/Gen/docs/refpages/common", "gen-common", "Gen"),
    ("packages/RNBO/docs/refpages/rnbo", "rnbo", "RNBO"),
    ("packages/RNBO/docs/refpages/max", "rnbo-max", "RNBO"),
]

# Package directories that contain .maxref.xml files
PACKAGE_GLOBS = [
    "packages/ableton-dsp",
    "packages/jit.mo",
    "packages/maxforlive-elements",
    "packages/mira",
    "packages/VIDDLL",
]

# Inlet/outlet type normalization map
INLET_TYPE_MAP = {
    # Signal types
    "signal": "signal",
    "Signal": "signal",
    "signal/float": "signal/float",
    "Signal/Float": "signal/float",
    "signal or float": "signal/float",
    "float / signal": "signal/float",
    "float/signal": "signal/float",
    "signal, float": "signal/float",
    "int / signal": "signal/int",
    "int/signal": "signal/int",
    "signal, int": "signal/int",
    "int/float/sig": "signal/float",
    "signal/message": "signal/message",
    "signal/msg": "signal/message",
    "signal, message": "signal/message",
    "signal, list": "signal/list",
    "signal or multi-channel signal": "signal/mc",
    # Multichannel signal types
    "multi-channel signal": "mc_signal",
    "multichannelsignal": "mc_signal",
    "multi-channel signal, float": "mc_signal/float",
    "multi-channel signal, message": "mc_signal/message",
    # Matrix types
    "matrix": "matrix",
    "texture/matrix": "texture/matrix",
    # Control types
    "INLET_TYPE": "control",
    "OUTLET_TYPE": "control",
    "int": "int",
    "float": "float",
    "bang": "bang",
    "list": "list",
    "List": "list",
    "symbol": "symbol",
    "anything": "anything",
    "message": "message",
    "number": "number",
    "int/float": "number",
    "int, list": "int/list",
    "int/list": "int/list",
    "int/float/list": "anything",
    "bang/int": "bang/int",
    "bang/anything": "bang/anything",
    "dict": "dict",
    "dictionary": "dict",
    "midievent": "midievent",
    "inactive": "inactive",
    # Empty / missing
    "": "control",
}

SIGNAL_TYPES = frozenset({
    "signal", "signal/float", "signal/int", "signal/message",
    "signal/list", "signal/mc", "mc_signal", "mc_signal/float",
    "mc_signal/message",
})

# Module normalization
MODULE_MAP = {
    "max": "max",
    "Max": "max",
    "core": "max",
    "msp": "msp",
    "MSP": "msp",
    "jit": "jit",
    "Jit": "jit",
    "jitter": "jit",
    "m4l": "m4l",
    "M4L": "m4l",
    "gen-dsp": "gen-dsp",
    "gen-jit": "gen-jit",
    "gen-common": "gen-common",
    "gen_dsp": "gen-dsp",
    "gen_jit": "gen-jit",
    "gen_common": "gen-common",
    "rnbo": "rnbo",
    "RNBO": "rnbo",
}

# Domain assignment from normalized module
MODULE_TO_DOMAIN = {
    "max": "Max",
    "msp": "MSP",
    "jit": "Jitter",
    "m4l": "M4L",
    "gen-dsp": "Gen",
    "gen-jit": "Gen",
    "gen-common": "Gen",
    "rnbo": "RNBO",
}

# Variable I/O objects with rules
VARIABLE_IO_RULES = {
    "trigger": {
        "description": "Number of arguments determines number of outlets. Each argument (i, f, b, l, s, or a constant) creates one outlet. Default: 2 outlets (int, int).",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "t": {
        "description": "Alias for trigger. Number of arguments determines number of outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "pack": {
        "description": "Number of arguments determines number of inlets. Default: 2 inlets (0, 0).",
        "inlet_count": "arg_count",
        "outlet_count": "fixed:1",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "unpack": {
        "description": "Number of arguments determines number of outlets. Default: 2 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "route": {
        "description": "Outlets = arg count + 1 (extra outlet for unmatched). Default: 3 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count_plus_1",
        "default_inlets": 1,
        "default_outlets": 3,
    },
    "routepass": {
        "description": "Outlets = arg count + 1 (extra outlet passes unmatched). Default: 3 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count_plus_1",
        "default_inlets": 1,
        "default_outlets": 3,
    },
    "select": {
        "description": "Outlets = arg count + 1 (extra outlet for non-match). Default: 2 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count_plus_1",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "sel": {
        "description": "Alias for select. Outlets = arg count + 1.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count_plus_1",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "gate": {
        "description": "First arg sets outlet count. Inlets = 2 (control + input). Default: 1 outlet.",
        "inlet_count": "fixed:2",
        "outlet_count": "first_arg",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "switch": {
        "description": "First arg sets inlet count (+1 for control). Outlets = 1. Default: 2 inlets.",
        "inlet_count": "first_arg_plus_1",
        "outlet_count": "fixed:1",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "spray": {
        "description": "First arg sets outlet count. Inlets = 1. Default: 2 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "first_arg",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "funnel": {
        "description": "First arg sets inlet count. Outlets = 1. Default: 2 inlets.",
        "inlet_count": "first_arg",
        "outlet_count": "fixed:1",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "matrix~": {
        "description": "First arg = inlets, second arg = outlets. Default: 1 inlet, 1 outlet.",
        "inlet_count": "first_arg",
        "outlet_count": "second_arg",
        "default_inlets": 1,
        "default_outlets": 1,
    },
    "selector~": {
        "description": "First arg sets inlet count (+1 for selector). Outlets = 1. Default: 2 inlets.",
        "inlet_count": "first_arg_plus_1",
        "outlet_count": "fixed:1",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "router": {
        "description": "First arg = inlets, second arg = outlets. Variable routing matrix.",
        "inlet_count": "first_arg",
        "outlet_count": "second_arg",
        "default_inlets": 2,
        "default_outlets": 2,
    },
    "join": {
        "description": "Number of arguments determines number of inlets. Default: 2 inlets.",
        "inlet_count": "arg_count",
        "outlet_count": "fixed:1",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "unjoin": {
        "description": "Number of arguments determines number of outlets. Default: 2 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "arg_count",
        "default_inlets": 1,
        "default_outlets": 2,
    },
    "combine": {
        "description": "Number of arguments determines number of inlets. Default: 2 inlets.",
        "inlet_count": "arg_count",
        "outlet_count": "fixed:1",
        "default_inlets": 2,
        "default_outlets": 1,
    },
    "cycle": {
        "description": "First arg sets number of outlets to cycle through. Default: 2 outlets.",
        "inlet_count": "fixed:1",
        "outlet_count": "first_arg",
        "default_inlets": 1,
        "default_outlets": 2,
    },
}


# ---------------------------------------------------------------------------
# Type normalization helpers
# ---------------------------------------------------------------------------

def normalize_type(raw_type: str) -> str:
    """Normalize a raw XML inlet/outlet type to a canonical form."""
    raw = raw_type.strip()
    if raw in INLET_TYPE_MAP:
        return INLET_TYPE_MAP[raw]
    # Handle case-insensitive fallback
    lower = raw.lower()
    for key, val in INLET_TYPE_MAP.items():
        if key.lower() == lower:
            return val
    # Unknown type -- return as-is but lowercased
    return lower if lower else "control"


def is_signal_type(normalized_type: str) -> bool:
    """Returns True if the type carries audio signal."""
    return normalized_type in SIGNAL_TYPES


def infer_hot_cold(inlets: list[dict], module: str) -> list[dict]:
    """Apply hot/cold inference based on MAX conventions.

    - For MSP objects, all signal inlets are hot (processed at audio rate).
    - For control objects, inlet 0 (leftmost) is hot, others are cold.
    """
    for inlet in inlets:
        if module in ("msp", "rnbo") and is_signal_type(inlet.get("type", "")):
            inlet["hot"] = True
        elif inlet.get("id", -1) == 0:
            inlet["hot"] = True
        else:
            inlet["hot"] = False
    return inlets


def normalize_module(raw_module: str, source_hint: str = "") -> str:
    """Normalize the module attribute from XML."""
    if raw_module in MODULE_MAP:
        return MODULE_MAP[raw_module]
    raw_lower = raw_module.lower().strip()
    if raw_lower in MODULE_MAP:
        return MODULE_MAP[raw_lower]
    # Infer from source hint
    if source_hint:
        return source_hint
    return raw_lower if raw_lower else "max"


def assign_domain(name: str, module: str, source_domain_hint: str) -> str:
    """Assign domain from module, handling MC objects specially."""
    # MC objects: name starts with mc. and comes from msp-ref
    if name.startswith("mc."):
        return "MC"
    if module in MODULE_TO_DOMAIN:
        return MODULE_TO_DOMAIN[module]
    return source_domain_hint


def infer_signal_types_for_tilde_objects(obj: dict) -> dict:
    """For MSP/MC objects with ~ in their name, infer signal types from INLET_TYPE/OUTLET_TYPE.

    Many MSP objects have generic 'INLET_TYPE' in XML which gets normalized to 'control'.
    For audio objects (name ends with ~), these should be 'signal' instead.
    MC objects (mc.xxx~) similarly should use 'mc_signal'.
    """
    name = obj.get("name", "")
    module = obj.get("module", "")
    domain = obj.get("domain", "")

    if "~" not in name:
        return obj

    is_mc = name.startswith("mc.")

    # Infer inlet types
    for inlet in obj.get("inlets", []):
        if inlet.get("type") == "control":
            if is_mc:
                inlet["type"] = "mc_signal"
            else:
                inlet["type"] = "signal"
            inlet["signal"] = True
            # Re-apply hot: signal inlets are hot for MSP/MC
            if module in ("msp",) or domain in ("MSP", "MC"):
                inlet["hot"] = True

    # Infer outlet types
    for outlet in obj.get("outlets", []):
        if outlet.get("type") == "control":
            if is_mc:
                outlet["type"] = "mc_signal"
            else:
                outlet["type"] = "signal"
            outlet["signal"] = True

    return obj


# ---------------------------------------------------------------------------
# Standard refpage parser
# ---------------------------------------------------------------------------

def parse_standard_xml(filepath: Path, module_hint: str, domain_hint: str) -> dict | None:
    """Parse a standard .maxref.xml file (core MAX/MSP/Jitter/M4L objects)."""
    try:
        tree = ET.parse(filepath)
    except ET.ParseError as e:
        return {"_error": str(e), "_file": str(filepath)}

    root = tree.getroot()
    if root.tag != "c74object":
        return None

    name = root.get("name", "")
    if not name:
        # Try to get name from filename
        name = filepath.stem.replace(".maxref", "")

    raw_module = root.get("module", "")
    module = normalize_module(raw_module, module_hint)
    category = root.get("category", "")

    # When module was empty in XML and we're parsing a package, prefer the package domain
    if not raw_module.strip() and domain_hint == "Packages":
        domain = "Packages"
    else:
        domain = assign_domain(name, module, domain_hint)

    # Extract digest
    digest = ""
    digest_el = root.find("digest")
    if digest_el is not None and digest_el.text:
        digest = digest_el.text.strip()

    # Extract description
    description = ""
    desc_el = root.find("description")
    if desc_el is not None:
        # Description may contain XML markup -- get all text
        description = "".join(desc_el.itertext()).strip()

    # Extract inlets
    inlets = []
    inletlist = root.find("inletlist")
    if inletlist is not None:
        for inlet_el in inletlist.findall("inlet"):
            raw_type = inlet_el.get("type", "INLET_TYPE")
            norm_type = normalize_type(raw_type)
            inlet_data = {
                "id": int(inlet_el.get("id", len(inlets))),
                "type": norm_type,
                "signal": is_signal_type(norm_type),
                "digest": "",
            }
            dig = inlet_el.find("digest")
            if dig is not None and dig.text:
                inlet_data["digest"] = dig.text.strip()
            inlets.append(inlet_data)

    # Apply hot/cold inference
    inlets = infer_hot_cold(inlets, module)

    # Extract outlets
    outlets = []
    outletlist = root.find("outletlist")
    if outletlist is not None:
        for outlet_el in outletlist.findall("outlet"):
            raw_type = outlet_el.get("type", "OUTLET_TYPE")
            norm_type = normalize_type(raw_type)
            outlet_data = {
                "id": int(outlet_el.get("id", len(outlets))),
                "type": norm_type,
                "signal": is_signal_type(norm_type),
                "digest": "",
            }
            dig = outlet_el.find("digest")
            if dig is not None and dig.text:
                outlet_data["digest"] = dig.text.strip()
            outlets.append(outlet_data)

    # Extract arguments
    arguments = []
    objarglist = root.find("objarglist")
    if objarglist is not None:
        for arg_el in objarglist.findall("objarg"):
            arg_data = {
                "name": arg_el.get("name", ""),
                "type": arg_el.get("type", ""),
                "optional": arg_el.get("optional", "0") == "1",
            }
            dig = arg_el.find("digest")
            if dig is not None and dig.text:
                arg_data["digest"] = dig.text.strip()
            arguments.append(arg_data)

    # Extract messages
    messages = []
    methodlist = root.find("methodlist")
    if methodlist is not None:
        for method_el in methodlist.findall("method"):
            msg_name = method_el.get("name", "")
            if msg_name:
                messages.append(msg_name)

    # Extract attributes
    attributes = {}
    attrlist = root.find("attributelist")
    if attrlist is not None:
        for attr_el in attrlist.findall("attribute"):
            attr_name = attr_el.get("name", "")
            if attr_name:
                attributes[attr_name] = {
                    "type": attr_el.get("type", ""),
                    "get": attr_el.get("get", "1") == "1",
                    "set": attr_el.get("set", "1") == "1",
                }

    # Extract seealso
    seealso = []
    seealsolist = root.find("seealsolist")
    if seealsolist is not None:
        for sa_el in seealsolist.findall("seealso"):
            sa_name = sa_el.get("name", "")
            # Some seealso use display name
            display_name = sa_el.get("display", sa_name)
            if sa_name:
                seealso.append(display_name if display_name else sa_name)

    # Extract tags from metadata
    tags = []
    metadatalist = root.find("metadatalist")
    if metadatalist is not None:
        for md_el in metadatalist.findall("metadata"):
            if md_el.get("name") == "tag" and md_el.text:
                tags.append(md_el.text.strip())

    # Build the maxclass
    maxclass = name

    # Check for variable I/O
    variable_io = name in VARIABLE_IO_RULES
    io_rule = VARIABLE_IO_RULES.get(name)

    # Determine verified status - true if we have at least basic data
    verified = bool(name and (inlets or outlets or domain == "Gen"))

    obj = {
        "name": name,
        "maxclass": maxclass,
        "module": module,
        "domain": domain,
        "category": category,
        "digest": digest,
        "description": description,
        "inlets": inlets,
        "outlets": outlets,
        "arguments": arguments,
        "messages": messages,
        "attributes": attributes,
        "seealso": seealso,
        "tags": tags,
        "min_version": 8,
        "verified": verified,
        "variable_io": variable_io,
    }

    if io_rule:
        obj["io_rule"] = io_rule

    # Post-process: infer signal types for ~ objects with generic INLET_TYPE
    obj = infer_signal_types_for_tilde_objects(obj)

    return obj


# ---------------------------------------------------------------------------
# Gen~ parser
# ---------------------------------------------------------------------------

def parse_gen_xml(filepath: Path, module_hint: str = "gen-dsp") -> dict | None:
    """Parse a Gen~ .maxref.xml with its different schema."""
    try:
        tree = ET.parse(filepath)
    except ET.ParseError as e:
        return {"_error": str(e), "_file": str(filepath)}

    root = tree.getroot()
    if root.tag != "c74object":
        return None

    raw_name = root.get("name", "")
    if not raw_name:
        raw_name = filepath.stem.replace(".maxref", "")

    # Gen~ object names in files are prefixed: gen_dsp_xxx, gen_jit_xxx, gen_common_xxx
    # Display name strips that prefix
    display_name = raw_name
    for prefix in ("gen_dsp_", "gen_jit_", "gen_common_"):
        if display_name.startswith(prefix):
            display_name = display_name[len(prefix):]
            break

    raw_module = root.get("module", module_hint)
    module = normalize_module(raw_module, module_hint)
    category = root.get("category", "")
    kind = root.get("kind", "")

    # Extract digest
    digest = ""
    digest_el = root.find("digest")
    if digest_el is not None and digest_el.text:
        digest = digest_el.text.strip()

    # Extract description
    description = ""
    desc_el = root.find("description")
    if desc_el is not None:
        description = "".join(desc_el.itertext()).strip()

    # Gen~ inlets from <geninletlist>/<geninlet>
    inlets = []
    geninletlist = root.find("geninletlist")
    if geninletlist is not None:
        for i, inlet_el in enumerate(geninletlist.findall("geninlet")):
            inlet_type = inlet_el.get("type", "float")
            norm_type = "signal" if "signal" in inlet_type.lower() else "signal"
            # Gen~ inlets are always signal-rate in DSP context
            is_dsp = "dsp" in module or "dsp" in kind
            if is_dsp:
                norm_type = "signal"
            inlet_data = {
                "id": i,
                "name": inlet_el.get("name", ""),
                "type": norm_type,
                "signal": True if is_dsp else is_signal_type(norm_type),
                "hot": True,  # Gen~ inlets are all active
                "optional": inlet_el.get("optional", "0") == "1",
                "digest": "",
            }
            dig = inlet_el.find("digest")
            if dig is not None and dig.text:
                inlet_data["digest"] = dig.text.strip()
            inlets.append(inlet_data)

    # Gen~ typically has 1 signal outlet (DSP objects)
    # XML rarely has <genoutletlist>, so we infer
    outlets = []
    genoutletlist = root.find("genoutletlist")
    if genoutletlist is not None:
        for i, outlet_el in enumerate(genoutletlist.findall("genoutlet")):
            outlet_type = outlet_el.get("type", "signal")
            outlets.append({
                "id": i,
                "type": "signal",
                "signal": True,
                "digest": "",
            })
    else:
        # Default: 1 signal outlet for DSP gen objects
        is_dsp = "dsp" in module or "dsp" in kind
        if is_dsp or "jit" not in module:
            outlets = [{"id": 0, "type": "signal", "signal": True, "digest": "Output"}]

    # Extract constructors as arguments
    arguments = []
    constructorlist = root.find("constructorlist")
    if constructorlist is not None:
        for con_el in constructorlist.findall("constructor"):
            dig = con_el.find("digest")
            if dig is not None and dig.text:
                arguments.append({
                    "name": con_el.get("name", ""),
                    "type": "constructor",
                    "optional": True,
                    "digest": dig.text.strip(),
                })

    # Extract attributes
    attributes = {}
    attrlist = root.find("attributelist")
    if attrlist is not None:
        for attr_el in attrlist.findall("attribute"):
            attr_name = attr_el.get("name", "")
            if attr_name:
                attributes[attr_name] = {
                    "type": attr_el.get("type", ""),
                    "get": attr_el.get("get", "1") == "1",
                    "set": attr_el.get("set", "1") == "1",
                }

    # Extract seealso
    seealso = []
    seealsolist = root.find("seealsolist")
    if seealsolist is not None:
        for sa_el in seealsolist.findall("seealso"):
            display = sa_el.get("display", sa_el.get("name", ""))
            if display:
                seealso.append(display)

    # Extract tags
    tags = []
    metadatalist = root.find("metadatalist")
    if metadatalist is not None:
        for md_el in metadatalist.findall("metadata"):
            if md_el.get("name") == "tag" and md_el.text:
                tags.append(md_el.text.strip())

    obj = {
        "name": display_name,
        "maxclass": "gen~",  # Gen~ objects live inside gen~ patchers
        "module": module,
        "domain": "Gen",
        "category": category,
        "kind": kind,
        "digest": digest,
        "description": description,
        "inlets": inlets,
        "outlets": outlets,
        "arguments": arguments,
        "messages": [],
        "attributes": attributes,
        "seealso": seealso,
        "tags": tags,
        "min_version": 8,
        "verified": True,
        "variable_io": False,
    }

    return obj


# ---------------------------------------------------------------------------
# RNBO parser
# ---------------------------------------------------------------------------

def parse_rnbo_xml(filepath: Path) -> dict | None:
    """Parse an RNBO .maxref.xml file."""
    try:
        tree = ET.parse(filepath)
    except ET.ParseError as e:
        return {"_error": str(e), "_file": str(filepath)}

    root = tree.getroot()
    if root.tag != "c74object":
        return None

    raw_name = root.get("name", "")
    if not raw_name:
        raw_name = filepath.stem.replace(".maxref", "")

    # RNBO names are prefixed with rnbo_ in filenames but not always in XML
    display_name = raw_name
    if display_name.startswith("rnbo_"):
        display_name = display_name[5:]

    category = root.get("category", "")
    kind = root.get("kind", "")

    # Extract digest
    digest = ""
    digest_el = root.find("digest")
    if digest_el is not None and digest_el.text:
        digest = digest_el.text.strip()

    # Extract description
    description = ""
    desc_el = root.find("description")
    if desc_el is not None:
        description = "".join(desc_el.itertext()).strip()

    # RNBO inlets from <rnboinletlist>
    inlets = []
    rnboinletlist = root.find("rnboinletlist")
    if rnboinletlist is not None:
        for i, inlet_el in enumerate(rnboinletlist.findall("inlet")):
            raw_type = inlet_el.get("type", "number")
            # RNBO types: number, signal, list, bang, etc.
            is_sig = "signal" in raw_type.lower()
            norm_type = "signal" if is_sig else normalize_type(raw_type)
            inlet_data = {
                "id": i,
                "name": inlet_el.get("name", ""),
                "type": norm_type,
                "signal": is_sig,
                "hot": i == 0 or is_sig,
                "digest": "",
            }
            dig = inlet_el.find("digest")
            if dig is not None and dig.text:
                inlet_data["digest"] = dig.text.strip()
            inlets.append(inlet_data)

    # RNBO outlets from <rnbooutletlist>
    outlets = []
    rnbooutletlist = root.find("rnbooutletlist")
    if rnbooutletlist is not None:
        for i, outlet_el in enumerate(rnbooutletlist.findall("outlet")):
            raw_type = outlet_el.get("type", "number")
            is_sig = "signal" in raw_type.lower()
            norm_type = "signal" if is_sig else normalize_type(raw_type)
            outlet_data = {
                "id": i,
                "name": outlet_el.get("name", ""),
                "type": norm_type,
                "signal": is_sig,
                "digest": "",
            }
            dig = outlet_el.find("digest")
            if dig is not None and dig.text:
                outlet_data["digest"] = dig.text.strip()
            outlets.append(outlet_data)

    # Also check for standard inletlist/outletlist as fallback
    if not inlets:
        inletlist = root.find("inletlist")
        if inletlist is not None:
            for inlet_el in inletlist.findall("inlet"):
                raw_type = inlet_el.get("type", "INLET_TYPE")
                norm_type = normalize_type(raw_type)
                inlet_data = {
                    "id": int(inlet_el.get("id", len(inlets))),
                    "type": norm_type,
                    "signal": is_signal_type(norm_type),
                    "digest": "",
                }
                dig = inlet_el.find("digest")
                if dig is not None and dig.text:
                    inlet_data["digest"] = dig.text.strip()
                inlet_data["hot"] = inlet_data["id"] == 0 or inlet_data["signal"]
                inlets.append(inlet_data)

    if not outlets:
        outletlist = root.find("outletlist")
        if outletlist is not None:
            for outlet_el in outletlist.findall("outlet"):
                raw_type = outlet_el.get("type", "OUTLET_TYPE")
                norm_type = normalize_type(raw_type)
                outlet_data = {
                    "id": int(outlet_el.get("id", len(outlets))),
                    "type": norm_type,
                    "signal": is_signal_type(norm_type),
                    "digest": "",
                }
                dig = outlet_el.find("digest")
                if dig is not None and dig.text:
                    outlet_data["digest"] = dig.text.strip()
                outlets.append(outlet_data)

    # Extract RNBO attributes
    attributes = {}
    rnboattrlist = root.find("rnboattributelist")
    if rnboattrlist is not None:
        for attr_el in rnboattrlist.findall("attribute"):
            attr_name = attr_el.get("name", "")
            if attr_name and not attr_name.startswith("in") and attr_name != "reset":
                attributes[attr_name] = {
                    "type": attr_el.get("type", ""),
                    "size": attr_el.get("size", "1"),
                }

    # Extract RNBO options
    options = {}
    rnbooptionlist = root.find("rnbooptionlist")
    if rnbooptionlist is not None:
        for opt_el in rnbooptionlist.findall("option"):
            opt_name = opt_el.get("name", "")
            if opt_name:
                options[opt_name] = {
                    "type": opt_el.get("type", ""),
                    "size": opt_el.get("size", "1"),
                }

    # Extract seealso
    seealso = []
    seealsolist = root.find("seealsolist")
    if seealsolist is not None:
        for sa_el in seealsolist.findall("seealso"):
            display = sa_el.get("display", sa_el.get("name", ""))
            if display:
                seealso.append(display)

    # Extract tags
    tags = []
    metadatalist = root.find("metadatalist")
    if metadatalist is not None:
        for md_el in metadatalist.findall("metadata"):
            if md_el.get("name") == "tag" and md_el.text:
                tags.append(md_el.text.strip())

    obj = {
        "name": display_name,
        "maxclass": display_name,
        "module": "rnbo",
        "domain": "RNBO",
        "category": category,
        "kind": kind,
        "digest": digest,
        "description": description,
        "inlets": inlets,
        "outlets": outlets,
        "arguments": [],
        "messages": [],
        "attributes": attributes,
        "seealso": seealso,
        "tags": tags,
        "min_version": 8,
        "verified": bool(inlets or outlets),
        "variable_io": False,
    }

    if options:
        obj["rnbo_options"] = options

    return obj


# ---------------------------------------------------------------------------
# Discovery
# ---------------------------------------------------------------------------

def discover_xml_files(c74_root: Path, domain_filter: str | None = None) -> list[tuple[Path, str, str]]:
    """Discover all .maxref.xml files, returning (path, module_hint, domain_hint) tuples."""
    files = []

    for rel_dir, module_hint, domain_hint in SOURCE_DIRS:
        if domain_filter and domain_hint.lower() != domain_filter.lower():
            continue
        full_dir = c74_root / rel_dir
        if full_dir.exists():
            for xml_file in sorted(full_dir.glob("*.maxref.xml")):
                files.append((xml_file, module_hint, domain_hint))

    # Package directories
    if not domain_filter or domain_filter.lower() == "packages":
        for pkg_glob in PACKAGE_GLOBS:
            pkg_dir = c74_root / pkg_glob
            if pkg_dir.exists():
                for xml_file in sorted(pkg_dir.rglob("*.maxref.xml")):
                    files.append((xml_file, "", "Packages"))

    return files


# ---------------------------------------------------------------------------
# Main extraction
# ---------------------------------------------------------------------------

def extract_all(c74_root: Path, domain_filter: str | None = None, dry_run: bool = False) -> dict:
    """Run the full extraction pipeline.

    Returns a dict with:
      - domains: {domain_dir: {name: obj_dict}}
      - log: extraction statistics dict
    """
    xml_files = discover_xml_files(c74_root, domain_filter)

    if dry_run:
        # Count files per source
        counts = defaultdict(int)
        for _, _, domain in xml_files:
            counts[domain] += 1
        total = sum(counts.values())
        print(f"Dry run: found {total} .maxref.xml files")
        for domain, count in sorted(counts.items()):
            print(f"  {domain}: {count}")
        return {"domains": {}, "log": {"total_files_found": total, "domain_counts": dict(counts)}}

    # Initialize domain buckets
    domain_buckets: dict[str, dict] = {
        "max": {},
        "msp": {},
        "jitter": {},
        "mc": {},
        "gen": {},
        "m4l": {},
        "rnbo": {},
        "packages": {},
    }

    # Stats tracking
    stats = {
        "total_files_found": len(xml_files),
        "total_objects": 0,
        "domain_counts": {},
        "error_count": 0,
        "errors": [],
        "inlet_type_fallback_count": 0,
        "variable_io_count": 0,
        "empty_inlets_count": 0,
        "empty_outlets_count": 0,
        "extraction_timestamp": datetime.now(timezone.utc).isoformat(),
        "max_installation_path": str(c74_root),
    }

    for filepath, module_hint, domain_hint in xml_files:
        # Route to appropriate parser
        if domain_hint == "Gen":
            obj = parse_gen_xml(filepath, module_hint)
        elif domain_hint == "RNBO":
            obj = parse_rnbo_xml(filepath)
        else:
            obj = parse_standard_xml(filepath, module_hint, domain_hint)

        if obj is None:
            continue

        if "_error" in obj:
            stats["error_count"] += 1
            stats["errors"].append({"file": obj["_file"], "error": obj["_error"]})
            continue

        name = obj.get("name", "")
        if not name:
            continue

        domain = obj.get("domain", "")

        # Route to correct bucket
        bucket_key = {
            "Max": "max",
            "MSP": "msp",
            "Jitter": "jitter",
            "MC": "mc",
            "Gen": "gen",
            "M4L": "m4l",
            "RNBO": "rnbo",
            "Packages": "packages",
        }.get(domain, "packages")

        domain_buckets[bucket_key][name] = obj
        stats["total_objects"] += 1

        # Track stats
        if obj.get("variable_io"):
            stats["variable_io_count"] += 1
        if not obj.get("inlets"):
            stats["empty_inlets_count"] += 1
        if not obj.get("outlets"):
            stats["empty_outlets_count"] += 1

    # Count per domain
    for key, bucket in domain_buckets.items():
        stats["domain_counts"][key] = len(bucket)

    return {"domains": domain_buckets, "log": stats}


def write_output(result: dict, output_root: Path) -> None:
    """Write domain JSON files and extraction log."""
    output_root.mkdir(parents=True, exist_ok=True)

    for domain_key, objects in result["domains"].items():
        domain_dir = output_root / domain_key
        domain_dir.mkdir(parents=True, exist_ok=True)
        json_path = domain_dir / "objects.json"
        # Sort objects by name for deterministic output
        sorted_objects = dict(sorted(objects.items()))
        json_path.write_text(
            json.dumps(sorted_objects, indent=2, ensure_ascii=False) + "\n"
        )
        print(f"  Wrote {len(objects)} objects to {json_path}")

    # Write extraction log
    log_path = output_root / "extraction-log.json"
    log_path.write_text(
        json.dumps(result["log"], indent=2, ensure_ascii=False) + "\n"
    )
    print(f"  Wrote extraction log to {log_path}")


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Extract MAX/MSP object definitions from XML refpages"
    )
    parser.add_argument(
        "--max-path",
        type=Path,
        default=DEFAULT_MAX_PATH,
        help="Path to MAX C74 resources (default: /Applications/Max.app/Contents/Resources/C74)",
    )
    parser.add_argument(
        "--domain",
        type=str,
        default=None,
        help="Extract only a single domain (max, msp, jitter, m4l, gen, rnbo, packages)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Count files without extracting",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(".claude/max-objects"),
        help="Output root directory (default: .claude/max-objects)",
    )
    args = parser.parse_args()

    if not args.max_path.exists():
        print(f"Error: MAX path not found: {args.max_path}", file=sys.stderr)
        sys.exit(1)

    print(f"MAX installation: {args.max_path}")
    result = extract_all(args.max_path, args.domain, args.dry_run)

    if not args.dry_run:
        log = result["log"]
        print(f"\nExtraction complete:")
        print(f"  Total files found: {log['total_files_found']}")
        print(f"  Total objects extracted: {log['total_objects']}")
        print(f"  Errors: {log['error_count']}")
        print(f"\n  Per-domain counts:")
        for domain, count in sorted(log["domain_counts"].items()):
            print(f"    {domain}: {count}")

        write_output(result, args.output)
        print(f"\nDone.")


if __name__ == "__main__":
    main()
