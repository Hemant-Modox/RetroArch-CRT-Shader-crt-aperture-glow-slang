#version 450

// CRT APERTURE GLOW (Slang) - Vulkan / GLCore / D3D11 / D3D12
// Every effect has its own Enable switch (T_ parameters).

#pragma parameter CURVE "Screen Curvature" 0.28 0.0 1.0 0.01
#pragma parameter T_CURVE "  Screen Curvature - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter ZOOM "Screen Zoom" 1.0 0.8 1.2 0.01
#pragma parameter T_ZOOM "  Screen Zoom - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter BORDER "Black Border Size" 0.035 -10.0 0.3 0.005
#pragma parameter T_BORDER "  Black Border Size - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter CORNER "Corner Roundness" 0.12 0.0 0.5 0.01
#pragma parameter T_CORNER "  Corner Roundness - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter EDGE_SOFT "Edge Smoothness" 0.12 0.001 0.25 0.005
#pragma parameter T_EDGE_SOFT "  Edge Smoothness - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter SCAN "Scanline Intensity" 0.1 0.0 1.0 0.01
#pragma parameter T_SCAN "  Scanline Intensity - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter SCAN_BRIGHT "Scanline Fade On Bright" 0.5 0.0 1.0 0.05
#pragma parameter T_SCAN_BRIGHT "  Scanline Fade On Bright - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter MASK "Phosphor Mask Strength" 0.18 0.0 1.0 0.01
#pragma parameter T_MASK "  Phosphor Mask Strength - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter NOISE "Noise Amount" 0.045 0.0 0.3 0.005
#pragma parameter T_NOISE "  Noise Amount - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter BLUR "Blur Amount" 1.3 0.0 3.0 0.05
#pragma parameter T_BLUR "  Blur Amount - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter BLOOM "Bloom Strength" 0.45 0.0 2.0 0.05
#pragma parameter T_BLOOM "  Bloom Strength - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter BLOOM_RAD "Bloom Radius" 3.0 1.0 8.0 0.25
#pragma parameter T_BLOOM_RAD "  Bloom Radius - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter BLOOM_THR "Bloom Threshold" 0.45 0.0 1.0 0.01
#pragma parameter T_BLOOM_THR "  Bloom Threshold - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter GLASS "Glass Reflection" 0.1 0.0 0.5 0.01
#pragma parameter T_GLASS "  Glass Reflection - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter VIGNETTE "Vignette" 0.3 0.0 1.0 0.01
#pragma parameter T_VIGNETTE "  Vignette - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter FLICKER "Flicker" 0.01 0.0 0.05 0.001
#pragma parameter T_FLICKER "  Flicker - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter BRIGHT "Brightness" 1.15 0.5 2.0 0.01
#pragma parameter T_BRIGHT "  Brightness - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter SAT "Saturation" 1.1 0.0 2.0 0.01
#pragma parameter T_SAT "  Saturation - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0

#pragma parameter FILM_GRAIN "Film Grain Strength" 0.035 0.0 0.30 0.005
#pragma parameter T_FILM_GRAIN "  Film Grain - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter GRAIN_SIZE "Film Grain Size" 1.0 1.0 5.0 0.25
#pragma parameter GRAIN_SPEED "Film Grain Animation Speed" 1.0 0.0 5.0 0.25
#pragma parameter TEXTURE_SMOOTH "Texture Smoothness" 0.0 0.0 2.0 0.05
#pragma parameter T_TEXTURE_SMOOTH "  Texture Smoothness - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0
#pragma parameter SPRITE_SMOOTH "Sprite Smoothness" 0.0 0.0 1.0 0.05
#pragma parameter T_SPRITE_SMOOTH "  Sprite Smoothness - Enable (1=on 0=off)" 1.0 0.0 1.0 1.0

layout(push_constant) uniform Push
{
    vec4 SourceSize;
    vec4 OriginalSize;
    vec4 OutputSize;
    uint FrameCount;
} params;

layout(std140, set = 0, binding = 0) uniform UBO
{
    mat4 MVP;
    float CURVE;
    float ZOOM;
    float BORDER;
    float CORNER;
    float EDGE_SOFT;
    float SCAN;
    float SCAN_BRIGHT;
    float MASK;
    float NOISE;
    float BLUR;
    float BLOOM;
    float BLOOM_RAD;
    float BLOOM_THR;
    float GLASS;
    float VIGNETTE;
    float FLICKER;
    float BRIGHT;
    float SAT;
    float T_CURVE;
    float T_ZOOM;
    float T_BORDER;
    float T_CORNER;
    float T_EDGE_SOFT;
    float T_SCAN;
    float T_SCAN_BRIGHT;
    float T_MASK;
    float T_NOISE;
    float T_BLUR;
    float T_BLOOM;
    float T_BLOOM_RAD;
    float T_BLOOM_THR;
    float T_GLASS;
    float T_VIGNETTE;
    float T_FLICKER;
    float T_BRIGHT;
    float T_SAT;
    float FILM_GRAIN;
    float T_FILM_GRAIN;
    float GRAIN_SIZE;
    float GRAIN_SPEED;
    float TEXTURE_SMOOTH;
    float T_TEXTURE_SMOOTH;
    float SPRITE_SMOOTH;
    float T_SPRITE_SMOOTH;
} global;

#define CURVE global.CURVE
#define ZOOM global.ZOOM
#define BORDER global.BORDER
#define CORNER global.CORNER
#define EDGE_SOFT global.EDGE_SOFT
#define SCAN global.SCAN
#define SCAN_BRIGHT global.SCAN_BRIGHT
#define MASK global.MASK
#define NOISE global.NOISE
#define BLUR global.BLUR
#define BLOOM global.BLOOM
#define BLOOM_RAD global.BLOOM_RAD
#define BLOOM_THR global.BLOOM_THR
#define GLASS global.GLASS
#define VIGNETTE global.VIGNETTE
#define FLICKER global.FLICKER
#define BRIGHT global.BRIGHT
#define SAT global.SAT
#define T_CURVE global.T_CURVE
#define T_ZOOM global.T_ZOOM
#define T_BORDER global.T_BORDER
#define T_CORNER global.T_CORNER
#define T_EDGE_SOFT global.T_EDGE_SOFT
#define T_SCAN global.T_SCAN
#define T_SCAN_BRIGHT global.T_SCAN_BRIGHT
#define T_MASK global.T_MASK
#define T_NOISE global.T_NOISE
#define T_BLUR global.T_BLUR
#define T_BLOOM global.T_BLOOM
#define T_BLOOM_RAD global.T_BLOOM_RAD
#define T_BLOOM_THR global.T_BLOOM_THR
#define T_GLASS global.T_GLASS
#define T_VIGNETTE global.T_VIGNETTE
#define T_FLICKER global.T_FLICKER
#define T_BRIGHT global.T_BRIGHT
#define T_SAT global.T_SAT
#define FILM_GRAIN global.FILM_GRAIN
#define T_FILM_GRAIN global.T_FILM_GRAIN
#define GRAIN_SIZE global.GRAIN_SIZE
#define GRAIN_SPEED global.GRAIN_SPEED
#define TEXTURE_SMOOTH global.TEXTURE_SMOOTH
#define T_TEXTURE_SMOOTH global.T_TEXTURE_SMOOTH
#define SPRITE_SMOOTH global.SPRITE_SMOOTH
#define T_SPRITE_SMOOTH global.T_SPRITE_SMOOTH

#define V_CURVE (T_CURVE > 0.5 ? CURVE : 0.0)
#define V_ZOOM (T_ZOOM > 0.5 ? ZOOM : 1.0)
#define V_BORDER (T_BORDER > 0.5 ? BORDER : -10.0)
#define V_CORNER (T_CORNER > 0.5 ? CORNER : 0.001)
#define V_EDGE_SOFT (T_EDGE_SOFT > 0.5 ? EDGE_SOFT : 0.001)
#define V_SCAN (T_SCAN > 0.5 ? SCAN : 0.0)
#define V_SCAN_BRIGHT (T_SCAN_BRIGHT > 0.5 ? SCAN_BRIGHT : 0.0)
#define V_MASK (T_MASK > 0.5 ? MASK : 0.0)
#define V_NOISE (T_NOISE > 0.5 ? NOISE : 0.0)
#define V_BLUR (T_BLUR > 0.5 ? BLUR : 0.0)
#define V_BLOOM (T_BLOOM > 0.5 ? BLOOM : 0.0)
#define V_BLOOM_RAD (T_BLOOM_RAD > 0.5 ? BLOOM_RAD : 3.0)
#define V_BLOOM_THR (T_BLOOM_THR > 0.5 ? BLOOM_THR : 0.45)
#define V_GLASS (T_GLASS > 0.5 ? GLASS : 0.0)
#define V_VIGNETTE (T_VIGNETTE > 0.5 ? VIGNETTE : 0.0)
#define V_FLICKER (T_FLICKER > 0.5 ? FLICKER : 0.0)
#define V_BRIGHT (T_BRIGHT > 0.5 ? BRIGHT : 1.0)
#define V_SAT (T_SAT > 0.5 ? SAT : 1.0)
#define V_GRAIN (T_FILM_GRAIN > 0.5 ? FILM_GRAIN : 0.0)
#define V_TEXTURE_SMOOTH (T_TEXTURE_SMOOTH > 0.5 ? TEXTURE_SMOOTH : 0.0)
#define V_SPRITE_SMOOTH (T_SPRITE_SMOOTH > 0.5 ? SPRITE_SMOOTH : 0.0)

#pragma stage vertex
layout(location = 0) in vec4 Position;
layout(location = 1) in vec2 TexCoord;
layout(location = 0) out vec2 vTexCoord;

void main()
{
    gl_Position = global.MVP * Position;
    vTexCoord = TexCoord;
}

#pragma stage fragment
layout(location = 0) in vec2 vTexCoord;
layout(location = 0) out vec4 FragColor;
layout(set = 0, binding = 2) uniform sampler2D Source;

#define UV vTexCoord
#define PIXEL params.SourceSize.zw
#define SRC_H params.SourceSize.y
#define FRAME_T float(params.FrameCount % 600u)
// Sprite smoothness blends original sampler with explicit bilinear texel sampling.
vec3 sourceSample(vec2 uv)
{
    vec3 original = texture(Source, uv).rgb;
    if (V_SPRITE_SMOOTH <= 0.001) return original;
    vec2 xy = clamp(uv, vec2(0.0), vec2(1.0)) * params.SourceSize.xy - 0.5;
    ivec2 base = ivec2(floor(xy));
    vec2 f = smoothstep(vec2(0.0), vec2(1.0), fract(xy));
    ivec2 hi = ivec2(params.SourceSize.xy) - ivec2(1);
    vec3 a = texelFetch(Source, clamp(base, ivec2(0), hi), 0).rgb;
    vec3 b = texelFetch(Source, clamp(base + ivec2(1,0), ivec2(0), hi), 0).rgb;
    vec3 c = texelFetch(Source, clamp(base + ivec2(0,1), ivec2(0), hi), 0).rgb;
    vec3 d = texelFetch(Source, clamp(base + ivec2(1,1), ivec2(0), hi), 0).rgb;
    vec3 softened = mix(mix(a,b,f.x), mix(c,d,f.x), f.y);
    return mix(original, softened, V_SPRITE_SMOOTH);
}
#define SAMPLE(p) sourceSample(p)
#define OUTCOLOR(c) FragColor = vec4((c), 1.0)

float hash(vec2 p)
{
    p = fract(p * vec2(443.897, 441.423));
    p += dot(p, p.yx + 19.19);
    return fract((p.x + p.y) * p.x);
}

vec2 curveUV(vec2 uv)
{
    vec2 cc = uv * 2.0 - 1.0;
    cc *= V_ZOOM;
    vec2 off = abs(cc.yx) / vec2(5.0, 4.0);
    cc += cc * off * off * V_CURVE * 6.0;
    return cc * 0.5 + 0.5;
}

vec3 tap(vec2 p)
{
    p = clamp(p, 0.0, 1.0);
    return pow(SAMPLE(p), vec3(2.2));
}

void main()
{
    vec2 p  = curveUV(UV);
    vec2 px = PIXEL;

    // rounded black border. Fade goes OUTWARD from the border line, so
    // BORDER = 0 shows the full picture and negative values remove the frame.
    vec2  q     = abs(p * 2.0 - 1.0);
    float halfS = 1.0 - V_BORDER * 2.0;
    float r     = max(V_CORNER, 0.001);
    vec2  qq    = q - (halfS - r);
    float d     = length(max(qq, 0.0)) + min(max(qq.x, qq.y), 0.0) - r;
    float edge  = 1.0 - smoothstep(0.0, V_EDGE_SOFT, d);

    // blur
    vec3 col = vec3(0.0);
    float wsum = 0.0;
    for (int i = -2; i <= 2; i++)
    {
        for (int j = -2; j <= 2; j++)
        {
            vec2 o = vec2(float(i), float(j));
            float w = exp(-dot(o, o) / 2.0);
            col += w * tap(p + o * px * V_BLUR * 0.75);
            wsum += w;
        }
    }
    col /= wsum;

    // bloom
    vec3 glow = vec3(0.0);
    for (int k = 0; k < 12; k++)
    {
        float a = float(k) * 0.5235988;
        vec2 dir = vec2(cos(a), sin(a));
        vec3 s1 = tap(p + dir * px * V_BLOOM_RAD);
        vec3 s2 = tap(p + dir * px * V_BLOOM_RAD * 2.2);
        glow += max(s1 - V_BLOOM_THR, 0.0) + 0.6 * max(s2 - V_BLOOM_THR, 0.0);
    }
    glow /= 12.0;
    col += glow * V_BLOOM * 2.0;

    // scanlines
    float lum  = dot(col, vec3(0.299, 0.587, 0.114));
    float line = 0.5 + 0.5 * cos(p.y * SRC_H * 6.2831853);
    col *= 1.0 - V_SCAN * line * (1.0 - V_SCAN_BRIGHT * clamp(lum, 0.0, 1.0));

    // phosphor mask
    float m = mod(gl_FragCoord.x, 3.0);
    vec3 tri = vec3(1.0 - V_MASK);
    if (m < 1.0)      tri.r = 1.0 + V_MASK * 0.5;
    else if (m < 2.0) tri.g = 1.0 + V_MASK * 0.5;
    else              tri.b = 1.0 + V_MASK * 0.5;
    col *= tri;

    // saturation / brightness
    float l2 = dot(col, vec3(0.299, 0.587, 0.114));
    col = mix(vec3(l2), col, V_SAT) * V_BRIGHT;

    col = pow(max(col, 0.0), vec3(1.0 / 2.2));

    // glass reflection
    vec2 cc = p * 2.0 - 1.0;
    float refl = smoothstep(1.1, 0.0, length(cc - vec2(-0.55, -0.65)));
    col += V_GLASS * refl * refl * vec3(0.9, 0.95, 1.0);

    // noise & flicker
    float t = FRAME_T;
    float n = hash(gl_FragCoord.xy + t * 1.37) - 0.5;
    col += n * V_NOISE;
    col *= 1.0 - V_FLICKER * (0.5 + 0.5 * sin(t * 0.9));

    // Animated, output-resolution film grain, separate from existing noise.
    if (V_GRAIN > 0.0)
    {
        vec2 grainCell = floor(gl_FragCoord.xy / GRAIN_SIZE);
        float grainFrame = floor(FRAME_T * GRAIN_SPEED);
        float grain = hash(grainCell + vec2(grainFrame * 17.17, grainFrame * 3.71)) - 0.5;
        col += grain * V_GRAIN;
    }

    // vignette
    col *= clamp(1.0 - V_VIGNETTE * dot(cc * 0.55, cc * 0.55), 0.0, 1.0);

    col *= edge;

    OUTCOLOR(clamp(col, 0.0, 1.0));
}
