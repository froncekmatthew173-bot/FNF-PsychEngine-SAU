#pragma header


uniform float iTime;


void main()
{
	vec2 uv = openfl_TextureCoordv.xy;
	uv.y *= 20.0;
	/*uv -= vec2(0.5, 0.5);

	uv.x *= 2.0;

	uv.x = uv.x / ((0.0 - abs(uv.x)) + 1.0);

	uv.x /= 8.0;

	uv += vec2(0.5, 0.5);
	*/

	float col = (sin(uv.y + iTime)*0.5) + 0.6;

	vec4 spritecolor = vec4(col,col,col,1.0);

	gl_FragColor = spritecolor;
}