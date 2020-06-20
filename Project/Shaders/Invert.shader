shader_type canvas_item;

uniform bool invert = false;

void fragment() {
	vec4 sourceColor = texture(TEXTURE, UV);
	
	if (invert && sourceColor.a > 0.0)
	{
		if (sourceColor.r == 1.0)
		{
			COLOR = vec4(0.0, 0.0, 0.0, 1.0);
		}
		else
		{
			COLOR = vec4(1.0, 1.0, 1.0, 1.0);
		}
	}
	else
	{
		COLOR = sourceColor;
	}
}
