shader_type canvas_item;
render_mode blend_premul_alpha;

// EVERTHING ARE MAKED IN SPANISH, IF
// YOU WANT YOU CAN TRANSLATE IT, BUT
// KEEP EVERTHING

// CREATED BY oLe Studios (Oficial Material)
// 2024 7/11/2024
// Please give credit for oLe Studios

uniform float speed : hint_range(0.0, 5.0) = 1.0; // Velocidad de movimiento de la línea
uniform float line_width : hint_range(0.0, 0.2) = 0.15; // Ancho de la línea de brillo
uniform vec4 line_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Color de la línea de brillo
uniform float pause_duration : hint_range(0.0, 2.0) = 0.15; // Duración de la pausa al final del recorrido
uniform float offset = 2.0;

void fragment() {
    // Configuración del tiempo con pausa al final del recorrido
    float cycle_duration = offset + pause_duration; // Duración total del ciclo
    float adjusted_time = mod(TIME * speed, cycle_duration);

    // Movimiento de la línea con pausa (invertido, de derecha a izquierda)
    float line_position;
    if (adjusted_time <= offset) {
        line_position = offset - adjusted_time; // Movimiento de la línea hacia la izquierda (invertido)
    } else {
        line_position = -0.3; // Pausa
    }

    // Rotación diagonal de la línea
    vec2 rotated_uv = vec2(UV.x + UV.y, UV.y - UV.x) * 0.5;
    float dist = abs(rotated_uv.x - line_position);

    // Control de ancho y suavidad de la línea
    float line_intensity = smoothstep(line_width, 0.0, dist);

    // Máscara de alfa del `Sprite` para limitar el área de la línea solo a los píxeles opacos
    vec4 base_texture = texture(TEXTURE, UV); // Color base del `Sprite`
    float alpha_mask = step(0.01, base_texture.a); // Máscara de alfa (evita completamente los píxeles transparentes)

    // Aplicar el color de la línea solo a los píxeles opacos
    vec3 final_color = mix(base_texture.rgb, line_color.rgb, line_intensity * alpha_mask);

    // Combinar la transparencia del sprite original y la intensidad de la línea
    COLOR = vec4(final_color, base_texture.a * alpha_mask);
}
