#pragma header

float blendOverlay(float base, float blend) {
	if (base < 0.5) return (2.0*base*blend);
	return (1.0-2.0*(1.0-base)*(1.0-blend));
}

vec3 blendOverlay(vec3 base, vec3 blend) {
	return vec3(blendOverlay(base.r,blend.r),blendOverlay(base.g,blend.g),blendOverlay(base.b,blend.b));
}

vec3 blendOverlay(vec3 base, vec3 blend, float opacity) {
	return (blendOverlay(base, blend) * opacity + base * (1.0 - opacity));
}

vec3 blendHardLight(vec3 base, vec3 blend) {
	return blendOverlay(blend,base);
}

vec3 blendHardLight(vec3 base, vec3 blend, float opacity) {
	return (blendHardLight(base, blend) * opacity + base * (1.0 - opacity));
}

uniform float missStrength;

void main()
{
	vec2 uv = openfl_TextureCoordv.xy;
	vec4 spritecolor = flixel_texture2D(bitmap, uv);

	if (length(spritecolor.rgb) > 0.1 && missStrength == 1.0) //ignore black areas (normally the outline)
		spritecolor.rgb = blendHardLight(spritecolor.rgb, vec3(0.403, 0.403, 0.662), spritecolor.a); //apply blend

	

	gl_FragColor = spritecolor;
}