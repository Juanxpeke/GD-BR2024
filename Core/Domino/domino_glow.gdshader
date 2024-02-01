shader_type canvas_item;

uniform vec4 glow_color: source_color;
uniform float intensity_threshold = 0.5;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 current_color = texture(TEXTURE, UV);
	
	if (current_color.r <= intensity_threshold && current_color.g <= intensity_threshold && current_color.b <= intensity_threshold)
	{
		vec4 anim_color = mix(current_color, glow_color, abs(sin(TIME * 1.0)));
		COLOR = anim_color;
	}
	else
	{
		COLOR = current_color;
	}
}