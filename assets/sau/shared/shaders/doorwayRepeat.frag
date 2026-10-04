#pragma header

uniform float doorWidth;
uniform float repeatGap;
uniform float repeatCount;

void main()
{
	//repeating here since having lots of different sprites caused issues
	vec2 uv = openfl_TextureCoordv.xy;
	uv.x = mod(uv.x*(doorWidth + repeatGap)*repeatCount, repeatGap);
	uv.x = uv.x / doorWidth;
	if (uv.x > 1.0)
	{
		gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
		return;
	}
	//uv.x = mod(uv.x, 1.0);
	vec4 spritecolor = flixel_texture2D(bitmap, uv);

	gl_FragColor = spritecolor;
}