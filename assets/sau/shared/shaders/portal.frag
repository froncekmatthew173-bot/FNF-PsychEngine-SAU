#pragma header

uniform float iTime;

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898,12.1414))) * 83758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n);
    vec2 f = fract(n);
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

void main()
{
    vec2 uv = openfl_TextureCoordv;
	uv.x -= 0.5;
	uv.x += sin((uv.y*15.0)+iTime)*0.2;
	//uv.x += (noise(uv*10.0 + iTime));
	
	float effect = (0.0-((abs(uv.x))*4.0))+1.0;
	
    vec4 col = vec4(effect);
    
    gl_FragColor = col;
}