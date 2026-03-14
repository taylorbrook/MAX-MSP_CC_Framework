// scala-parser.js -- Parses Scala .scl files, writes MIDI-to-freq table to buffer~
// Inlets: 0 = bang (init 12-TET) or read <path>
// Outlets: 0 = scale name (symbol), 1 = num degrees (int)

inlets = 1;
outlets = 2;

var buf = new Buffer("scala-tuning");
var base_freq = 261.6255653;
var base_note = 60;
var scale_name = "12-TET";
var ratios = [];

function read(path) {
    var f = new File(path, "r");
    if (!f.isopen) {
        post("scala-parser: could not open " + path + "\n");
        return;
    }
    var lines = [];
    while (f.position < f.eof) {
        var line = f.readline();
        if (line !== null) lines.push(line);
    }
    f.close();
    parse_scl(lines);
    build_table();
}

function parse_scl(lines) {
    ratios = [];
    var header_done = false;
    var num_notes = 0;
    var count = 0;

    for (var i = 0; i < lines.length; i++) {
        var line = lines[i].trim();
        if (line.length === 0 || line.charAt(0) === '!') continue;

        if (!header_done) {
            scale_name = line;
            header_done = true;
            continue;
        }
        if (num_notes === 0) {
            num_notes = parseInt(line);
            continue;
        }
        if (count < num_notes) {
            var ratio = parse_pitch(line);
            if (ratio > 0) {
                ratios.push(ratio);
                count++;
            }
        }
    }
}

function parse_pitch(line) {
    var token = line.split(/\s+/)[0];
    if (token.indexOf('.') >= 0 && token.indexOf('/') < 0) {
        return Math.pow(2, parseFloat(token) / 1200);
    } else if (token.indexOf('/') >= 0) {
        var frac = token.split('/');
        return parseFloat(frac[0]) / parseFloat(frac[1]);
    } else {
        var val = parseInt(token);
        if (val > 24) return Math.pow(2, val / 1200);
        return val;
    }
}

function build_table() {
    var num_degrees = ratios.length;
    if (num_degrees === 0) {
        for (var i = 0; i < 128; i++) {
            buf.poke(1, i, 440 * Math.pow(2, (i - 69) / 12));
        }
        outlet(0, "12-TET");
        outlet(1, 12);
        return;
    }

    var period = ratios[num_degrees - 1];
    for (var midi = 0; midi < 128; midi++) {
        var degree_offset = midi - base_note;
        var periods_from_base, degree_in_scale;

        if (degree_offset >= 0) {
            periods_from_base = Math.floor(degree_offset / num_degrees);
            degree_in_scale = degree_offset % num_degrees;
        } else {
            periods_from_base = -Math.ceil(-degree_offset / num_degrees);
            degree_in_scale = ((degree_offset % num_degrees) + num_degrees) % num_degrees;
        }

        var ratio = (degree_in_scale === 0) ? 1.0 : ratios[degree_in_scale - 1];
        var freq = base_freq * Math.pow(period, periods_from_base) * ratio;
        buf.poke(1, midi, freq);
    }

    outlet(0, scale_name);
    outlet(1, num_degrees);
}

function bang() {
    build_table();
}

function msg_float(v) {
    if (inlet === 0) {
        base_freq = v;
        if (ratios.length > 0) build_table();
    }
}