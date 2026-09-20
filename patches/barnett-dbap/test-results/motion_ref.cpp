// Cross-check reference for preflight_motion.js: prints oo::motion::evaluate() from the plugin's
// own MotionPath.h / PerlinNoise.h. Build: see preflight_motion.js (OCTAGON_SRC env or default path).
#include "DSP/MotionPath.h"
#include <cstdio>
int main()
{
    PerlinNoise perlin;
    const int seeds[] = { 1, 7, 64 };
    const double cyc[] = { 0.0, 0.125, 0.3, 0.5, 0.77, 1.0, 3.25, 17.6, 123.456 };
    for (int seed : seeds)
    {
        perlin.seed (static_cast<std::uint32_t> (seed));
        for (int path = 0; path < oo::motion::kNumPaths; ++path)
            for (int variant = 0; variant < 2; ++variant)
                for (double c : cyc)
                {
                    oo::motion::MotionParams m;
                    m.path = path;
                    if (variant == 1) { m.sizeM = 9.5f; m.ratio = 0.4f; m.angleDeg = 37.0f; m.heightM = 2.5f; m.phaseDeg = 110.0f; }
                    const auto v = oo::motion::evaluate (m, c, perlin);
                    std::printf ("%d %d %d %.9g %.9g %.9g %.9g\n", seed, path, variant, c, (double) v.x, (double) v.y, (double) v.z);
                }
    }
    return 0;
}
