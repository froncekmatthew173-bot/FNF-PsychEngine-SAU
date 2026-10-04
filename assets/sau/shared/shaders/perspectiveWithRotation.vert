#pragma header

#define ASPECT 1.5;
#define PI 3.14159265359

attribute float alpha;
attribute vec4 colorMultiplier;
attribute vec4 colorOffset;
uniform bool hasColorTransform;

uniform mat4 perspectiveMatrix;
uniform mat4 viewMatrix;
uniform float zOffset;

attribute float vertexXOffset;
attribute float vertexYOffset;
attribute float vertexZOffset;

uniform float angleX;
uniform float angleY;
uniform float angleZ;

uniform float screenX;
uniform float screenY;

//https://github.com/dmnsgn/glsl-rotate/blob/main/rotation-3d.glsl
mat4 rotation3d(vec3 axis, float angle) 
{
	axis = normalize(axis);
	float s = sin(angle);
	float c = cos(angle);
	float oc = 1.0 - c;

	return mat4(
		oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
		oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
		oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
		0.0,                                0.0,                                0.0,                                1.0
	);
}

void main(void)
{
    #pragma body

	float rad = PI / 180.0;
    
    openfl_Alphav = openfl_Alpha * alpha;
    
    if (hasColorTransform)
    {
        openfl_ColorOffsetv = colorOffset / 255.0;
        openfl_ColorMultiplierv = colorMultiplier;
    }

	vec4 pos = openfl_Position;

	pos.x -= screenX;
	pos.y -= screenY;

	//rotate and scale
	vec4 p = vec4(pos.x, pos.y, 0.0, 1.0);

	p = rotation3d(vec3(1.0, 0.0, 0.0), angleX * rad) * rotation3d(vec3(0.0, 1.0, 0.0), angleY * rad) * rotation3d(vec3(0.0, 0.0, 1.0), angleZ * rad) * p;

	pos.x = p.x;
	pos.y = p.y;

	pos.x += screenX;
	pos.y += screenY;

	pos.x += vertexXOffset;
	pos.y += vertexYOffset;
	pos = openfl_Matrix * pos;
	pos.z = ((zOffset + vertexZOffset + p.z) * 0.001 * 1.5); //need to apply z after so it looks right
	gl_Position = perspectiveMatrix * viewMatrix * pos;
}