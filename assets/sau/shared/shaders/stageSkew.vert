attribute float openfl_Alpha;
attribute vec4 openfl_ColorMultiplier;
attribute vec4 openfl_ColorOffset;
attribute vec4 openfl_Position;
attribute vec2 openfl_TextureCoord;

varying float openfl_Alphav;
varying vec4 openfl_ColorMultiplierv;
varying vec4 openfl_ColorOffsetv;
varying vec2 openfl_TextureCoordv;

uniform mat4 openfl_Matrix;
uniform bool openfl_HasColorTransform;
uniform vec2 openfl_TextureSize;

attribute float alpha;
attribute vec4 colorMultiplier;
attribute vec4 colorOffset;
uniform bool hasColorTransform;
uniform float skewX;
uniform float skewY;

void main(void)
{
	openfl_Alphav = openfl_Alpha * alpha;
	openfl_TextureCoordv = openfl_TextureCoord;

	if(openfl_HasColorTransform)
	{
		openfl_ColorOffsetv = openfl_ColorOffset / 255.0;
		openfl_ColorMultiplierv = openfl_ColorMultiplier;
	}
	if(hasColorTransform)
	{
		openfl_ColorOffsetv = colorOffset / 255.0;
		openfl_ColorMultiplierv = colorMultiplier;
	}

	vec4 pos = openfl_Position;
	pos.x += skewX * (openfl_TextureCoord.y - 0.5) * openfl_TextureSize.y;
	pos.y += skewY * (openfl_TextureCoord.x - 0.5) * openfl_TextureSize.x;
	gl_Position = openfl_Matrix * pos;
}
