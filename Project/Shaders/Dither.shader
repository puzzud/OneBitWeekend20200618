shader_type canvas_item;
render_mode unshaded;

uniform sampler2D bayerTexture : hint_black;

float dither(vec2 position, float brightness)
{
	float bayer = textureLod(bayerTexture, position, 1.0).r;
	bayer = pow(bayer, 1.0 / 2.2); // Gamma correction
	
	return bayer;
	//return step(0.5, brightness);
	//return step(bayer, brightness);
}

void fragment()
{
	vec2 uv = SCREEN_UV;
	//vec4 sourceColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	float brightness = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).r;
	
	//Dithering is inherently screenspace so use fragCoord
	vec2 position;
	vec2 pixelSize = 1.0 / vec2(textureSize(bayerTexture, 0));
	position = FRAGCOORD.xy / pixelSize;
	float ditheredBrightess = dither(position, brightness);
	
	//COLOR = sourceColor;//vec4(1.0, 1.0, 1.0, 1.0);
	//COLOR = vec4(vec3(brightness), 1.0);
	COLOR = vec4(vec3(ditheredBrightess), 1.0);
	
	//uv -= mod(uv, vec2(0.008, 0.008));
	//COLOR = textureLod(SCREEN_TEXTURE, uv, 0.0);
}
