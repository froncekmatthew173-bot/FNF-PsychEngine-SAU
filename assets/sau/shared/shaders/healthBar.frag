#pragma header

uniform float percent;

uniform int characterCount;

uniform vec3 color0;
uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;
uniform vec3 color4;
uniform vec3 color5;
uniform vec3 color6;
uniform vec3 color7;
uniform vec3 color8;
uniform vec3 color9;
uniform vec3 color10;
uniform vec3 color11;
uniform vec3 color12;
uniform vec3 color13;
uniform vec3 color14;
uniform vec3 color15;

void main()
{
	vec2 uv = openfl_TextureCoordv.xy;
	float a = flixel_texture2D(bitmap, uv).a;
	if (uv.x >= percent)
	{
		vec3 col = color0;

		float p = uv.y * float(characterCount);

		//me when no array :(
		if (p <= 1.0) col = color0;
		else if (p <= 2.0) col = color1;
		else if (p <= 3.0) col = color2;
		else if (p <= 4.0) col = color3;
		else if (p <= 5.0) col = color4;
		else if (p <= 6.0) col = color5;
		else if (p <= 7.0) col = color6;
		else if (p <= 8.0) col = color7;
		else if (p <= 9.0) col = color8;
		else if (p <= 10.0) col = color9;
		else if (p <= 11.0) col = color10;
		else if (p <= 12.0) col = color11;
		else if (p <= 13.0) col = color12;
		else if (p <= 14.0) col = color13;
		else if (p <= 15.0) col = color14;
		else if (p <= 16.0) col = color15;

		gl_FragColor = vec4(col.r, col.g, col.b, a);
		return;
	}
	else
	{
		float square = mod(uv.x*15.0, 1.0);
		if ((uv.y >= 0.5 && square < 0.5) || (uv.y < 0.5 && square >= 0.5))
		{
			gl_FragColor = vec4(0.9,0.9,0.9,1.0)*a;
			return;
		}
	}

	gl_FragColor = vec4(1.0,1.0,1.0,1.0);
}