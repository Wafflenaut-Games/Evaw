// CC0, shadecore_dev
shader_type canvas_item;
render_mode blend_mix;

/** Amount of pixels on X and Y axes.
Set this value to the canvas item's size to achieve a perfect pixel effect.*/
uniform vec2 pixelation = vec2(64.0, 64.0);

/** Color gradient for rays.*/
uniform sampler2D gradient;

/** Ray length.*/
uniform float spread : hint_range(0.01, 0.4) = 0.33;

/** Ray size.*/
uniform float size : hint_range(-1.0, 1.0) = 0.365;

/** Ray rotation speed.*/
uniform float speed = 1.0;

/** First ray group density.*/
uniform float ray1_density : hint_range(0.0, 16.0) = 8.5;

/** Second ray group density.*/
uniform float ray2_density : hint_range(0.0, 16.0) = 8.5;

/** Second ray group intensity.*/
uniform float ray2_intensity : hint_range(-2.0, 10.0) = 0.5;

/** Intensity for the center.
Use negative values for halo effect.*/
uniform float core_intensity : hint_range(-1.0, 1.0) = 2.0;

/** Enable/disable HDR. */
uniform bool hdr = false;

/** Ray noise seed. */
uniform float seed = 1.0;

float random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(in vec2 uv) {
    vec2 i = floor(uv);
    vec2 f = fract(uv);
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0-2.0 * f);
    return mix(a, b, u.x) + (c - a)* u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void fragment() {
	vec2 pixelated_uv = floor(UV * pixelation) / pixelation;
	
    vec2 centered_uv = (pixelated_uv - 0.5) * (1.0 - size);
    float radius = length(centered_uv);
    float angle = atan(centered_uv.y, centered_uv.x) + PI;
    
    vec2 ray1 = vec2(angle * ray1_density + TIME * -speed + seed + sin(angle * 3.0), radius * 2.0);
    vec2 ray2 = vec2(angle * ray2_density + TIME * speed * 1.5 + seed + cos(angle * 2.0), radius * 2.0);
    
    float cut = 1.0 - smoothstep(0.33, 0.53, radius);
    ray1 *= cut;
    ray2 *= cut;
    
    float rays = hdr ? 
        noise(ray1) + (noise(ray2) * ray2_intensity) :
        clamp(noise(ray1) + (noise(ray2) * ray2_intensity), 0., 1.);
    
    rays *= smoothstep(spread, spread * 0.3, radius);
    float core = smoothstep(0.2, 0.0, radius) * core_intensity;
    rays += core;
    
    vec4 gradient_color = texture(gradient, vec2(rays, 0.5));
    vec3 shine = vec3(rays) * gradient_color.rgb;
    
	shine = vec4(shine, rays).rgb;
    
    COLOR = vec4(shine, rays * gradient_color.a);
}
