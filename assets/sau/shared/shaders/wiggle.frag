#pragma header
//uniform float tx, ty; // x,y waves phase
uniform float uTime;

const int EFFECT_TYPE_DREAMY = 0;
const int EFFECT_TYPE_WAVY = 1;
const int EFFECT_TYPE_HEAT_WAVE_HORIZONTAL = 2;
const int EFFECT_TYPE_HEAT_WAVE_VERTICAL = 3;
const int EFFECT_TYPE_FLAG = 4;

uniform int effectType;

/**
	* How fast the waves move over time
	*/
uniform float uSpeed;

/**
	* Number of waves over time
	*/
uniform float uFrequency;

/**
	* How much the pixels are going to stretch over the waves
	*/
uniform float uWaveAmplitude;

vec2 sineWave(vec2 pt)
{
	float x = 0.0;
	float y = 0.0;
	
	if (effectType == EFFECT_TYPE_DREAMY) 
	{
		float offsetX = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
		pt.x += offsetX; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
	}
	else if (effectType == EFFECT_TYPE_WAVY) 
	{
		float offsetY = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
		pt.y += offsetY; // * (pt.y - 1.0); // <- Uncomment to stop bottom part of the screen from moving
	}
	else if (effectType == EFFECT_TYPE_HEAT_WAVE_HORIZONTAL)
	{
		x = sin(pt.x * uFrequency + uTime * uSpeed) * uWaveAmplitude;
	}
	else if (effectType == EFFECT_TYPE_HEAT_WAVE_VERTICAL)
	{
		y = sin(pt.y * uFrequency + uTime * uSpeed) * uWaveAmplitude;
	}
	else if (effectType == EFFECT_TYPE_FLAG)
	{
		y = sin(pt.y * uFrequency + 10.0 * pt.x + uTime * uSpeed) * uWaveAmplitude;
		x = sin(pt.x * uFrequency + 5.0 * pt.y + uTime * uSpeed) * uWaveAmplitude;
	}
	
	return vec2(pt.x + x, pt.y + y);
}

vec4 render( vec2 uv )
{            
	//funny mirroring shit
	if ((uv.x > 1.0 || uv.x < 0.0) && abs(mod(uv.x, 2.0)) > 1.0)
		uv.x = (0.0-uv.x)+1.0;
	if ((uv.y > 1.0 || uv.y < 0.0) && abs(mod(uv.y, 2.0)) > 1.0)
		uv.y = (0.0-uv.y)+1.0;

	return textureCam( bitmap, vec2(abs(mod(uv.x, 1.0)), abs(mod(uv.y, 1.0))) );
}

void main()
{
	vec2 uv = sineWave(getCamPos(openfl_TextureCoordv));
	gl_FragColor = render(uv);
}