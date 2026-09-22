// pick.js -- random slice picker filtered by k-means cluster.
//
// inlet 0:
//   dictionary <name>  labelset dump from fluid.labelset~ (via route dump);
//                      rebuilds the cluster -> [slice ids] table
//   cluster N          select the active cluster
//   bang               emit a random slice id from the active cluster
// outlet 0: picked slice id (int)
// outlet 1: the labels dict, forwarded for the plotter (labels <dict>)

inlets = 1;
outlets = 2;

var clusters = {};      // cluster id -> array of slice ids
var activeCluster = 0;

function toArray(v) {
    if (v === undefined || v === null) return [];
    return Array.isArray(v) ? v : [v];
}

function clusterNumber(label) {
    // FluCoMa kmeans labels may be "3" or "cluster_3" -- take the trailing int
    var m = String(label).match(/(\d+)\s*$/);
    return m ? parseInt(m[1], 10) : -1;
}

function dictionary(name) {
    var d = new Dict(name);
    var data = d.get("data");
    clusters = {};
    var total = 0;
    if (data && typeof data.getkeys === "function") {
        var keys = toArray(data.getkeys());
        for (var i = 0; i < keys.length; i++) {
            var id = parseInt(keys[i], 10);
            var label = toArray(data.get(keys[i]))[0];
            var c = clusterNumber(label);
            if (isNaN(id) || c < 0) continue;
            if (!clusters[c]) clusters[c] = [];
            clusters[c].push(id);
            total++;
        }
    }
    post("pick: " + total + " slices in " + Object.keys(clusters).length + " clusters\n");
    outlet(1, "dictionary", name);
}

function cluster(n) {
    activeCluster = Math.floor(n);
}

function bang() {
    var ids = clusters[activeCluster];
    if (!ids || ids.length === 0) return;
    outlet(0, ids[Math.floor(Math.random() * ids.length)]);
}
