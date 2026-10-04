#pragma header

uniform float scaleX;
uniform float scaleY;

vec4 render( vec2 uv )
{
    
    //funny mirroring shit
    if ((uv.x > 1.0 || uv.x < 0.0) && abs(mod(uv.x, 2.0)) > 1.0)
        uv.x = (0.0-uv.x)+1.0;
    if ((uv.y > 1.0 || uv.y < 0.0) && abs(mod(uv.y, 2.0)) > 1.0)
        uv.y = (0.0-uv.y)+1.0;

    return flixel_texture2D( bitmap, vec2(abs(mod(uv.x, 1.0)), abs(mod(uv.y, 1.0))) );
}

void main()
{
    vec2 uv = openfl_TextureCoordv;
	uv.x *= scaleX;
	uv.y *= scaleY;
	//if (uv.x < 0.1)
	//{
		//uv.y *= scaleY;
	//}


    gl_FragColor = render(uv);
}