shader_type canvas_item;

// Stronger defaults
uniform float radius:    hint_range(0.0, 1.0) = 0.22;  // where darkening starts (smaller = more encroachment)
uniform float softness:  hint_range(0.0, 1.0) = 0.38;  // feather width toward center
uniform float intensity: hint_range(0.0, 3.0) = 2.00;  // overall darkness
uniform float contrast:  hint_range(0.5, 4.0) = 2.20;  // >1.0 sharpens falloff
uniform vec4 vignette_color: source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 centered = uv - vec2(0.5);

    // Edge-driven shape (0 at center, 1 at edges):
    // Chebyshev distance = pushes from ALL edges uniformly
    float edge_box = max(abs(centered.x) * 2.0, abs(centered.y) * 2.0);

    // Blend a little radial in to avoid a "boxy" look (optional)
    float edge_radial = length(centered) * 2.0; // 0 center -> ~1 corners
    float shape = mix(edge_box, edge_radial, 0.25);

    // Darken from radius inward with feather = softness
    float v = smoothstep(radius, radius + softness, shape);
    v = pow(v, contrast);

    vec4 overlay = vignette_color;
    overlay.a = clamp(v * intensity, 0.0, 1.0);

    // Output just the vignette color/alpha (use on a full-screen ColorRect)
    COLOR = overlay;
}
