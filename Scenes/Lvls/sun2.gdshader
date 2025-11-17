shader_type canvas_item;

uniform float brightness = 1.5;
uniform float ray_brightness = 10.0;
uniform float gamma = 8.0;
uniform float spot_brightness = 15.0;
uniform float ray_density = 3.5;
uniform float curvature = 15.0;
uniform vec3 rgb = vec3(4.0, 1.0, 0.1);
uniform float sin_freq = 13.0;
//uniform sampler2D noiseTexture;  // use if you want a custom noise texture

float hash( float n )
{
    return fract(sin(n)*43758.5453);
}

float noise( in vec2 x )
{
    // procedural noise:
    x *= 1.75;
    vec2 p = floor(x);
    vec2 f = fract(x);

    f = f * f * (3.0 - 2.0 * f);

    float n = p.x + p.y * 57.0;

    float res = mix(mix( hash(n+  0.0), hash(n+  1.0), f.x),
                    mix( hash(n+ 57.0), hash(n+ 58.0), f.x), f.y);
    return res;
    
    // To use your own noise from a texture, comment out the procedural noise stuff above and use this instead
    //return texture(noiseTexture, x*.01).x;
}

float fbm( in vec2 p )
{
    vec2 part1 = vec2(0.80, 0.60);
    vec2 part2 = vec2(-0.60, 0.80);
    mat2 m2 = mat2(part1, part2);
    
    float z = 2.0;
    float rz = 0.0;
    p *= 0.25;
    for (float i= 1.0; i < 6.0; i++)
    {
        rz += abs((noise(p) - 0.5) * 2.0) / z;
        z = z * 2.0;
        p = p * 2.0 * m2;
    }
    return rz;
}

void fragment()
{
    float t = -TIME * 0.03;
    vec2 uv = UV.xy / (1.0 / TEXTURE_PIXEL_SIZE).xy - 0.5;
    uv.x *= (1.0 / TEXTURE_PIXEL_SIZE).x / (1.0 / TEXTURE_PIXEL_SIZE).y;
    uv *= curvature * 0.05 + 0.0001;
    
    float r  = sqrt(dot(uv, uv));
    float x = dot(normalize(uv), vec2(0.5, 0.0)) + t;
    float y = dot(normalize(uv), vec2(0.0, 0.5)) + t;
    
    float val;
    val = fbm(vec2(r + y * ray_density, r + x * ray_density - y));
    val = smoothstep(gamma * 0.02 - 0.1, ray_brightness + (gamma * 0.02 - 0.1) + 0.001, val);
    val = sqrt(val);
    
    vec3 col = val / rgb;
    col = clamp(1.0 - col, 0.0, 1.0);
    col = mix(col, vec3(1.0), spot_brightness - r / 0.1 / curvature * 200.0 / brightness);
    col = clamp(col, 0.0, 1.0);
    col = pow(col, vec3(1.7));
    
    COLOR = vec4(col, 1.0);
}