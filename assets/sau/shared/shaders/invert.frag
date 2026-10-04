#pragma header

uniform float strength;

void main()
{
    vec2 uv = openfl_TextureCoordv;
    vec4 col = flixel_texture2D(bitmap, uv);
    
    vec4 invertedCol = vec4((0.0-col.r)+1.0,(0.0-col.g)+1.0,(0.0-col.b)+1.0,col.a);

    gl_FragColor = mix(col, invertedCol, strength);
}