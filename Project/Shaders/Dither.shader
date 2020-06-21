shader_type canvas_item;
render_mode unshaded;

uniform sampler2D bayerTexture : hint_black;

float dither(vec2 position, float brightness)
{
	if (brightness == 0.0)
	{
		return 0.0;
	}
	
	float bayer = textureLod(bayerTexture, position, 0.0).r;
	bayer = pow(bayer, 1.0 / 2.1); // Gamma correction
	return step(bayer, brightness);
}

void fragment()
{
	vec2 position = fract(FRAGCOORD.xy / 8.0);
	float brightness = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).r;
	float ditheredBrightess = dither(position, brightness);
	COLOR = vec4(vec3(ditheredBrightess), 1.0);
}
