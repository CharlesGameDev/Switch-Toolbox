﻿#version 330

layout(location = 0) in vec3 position;
layout(location = 1) in vec4 color;
layout(location = 2) in vec2 texCoord0;
layout(location = 3) in vec2 texCoord1;
layout(location = 4) in vec2 texCoord2;

uniform mat4 modelViewMatrix;
uniform vec2 uvScale0;
uniform vec2 uvRotate0;
uniform vec2 uvTranslate0;
uniform int flipTexture;

out vec2 uv0;

vec2 rotateUV(vec2 uv, float rotation)
{
    float mid = 0.5;
    return vec2(
        cos(rotation) * (uv.x - mid) + sin(rotation) * (uv.y - mid) + mid,
        cos(rotation) * (uv.y - mid) - sin(rotation) * (uv.x - mid) + mid
    );
}

vec2 SetFlip(vec2 tex)
{
     vec2 outTexCoord = tex;

	if (flipTexture == 1) //FlipH
	      return vec2(-1, 1) * tex + vec2(1, 0);
	else if (flipTexture == 2) //FlipV
	      return vec2(1, -1) * tex + vec2(0, 1);
	else if (flipTexture == 3) //Rotate90
	      return rotateUV(tex, 90.0);
	else if (flipTexture == 4) //Rotate180
	      return rotateUV(tex, 180.0);
	else if (flipTexture == 5) //Rotate270
	      return rotateUV(tex, 270.0);

	return outTexCoord;
}

void main()
{
	vec2 texCoord0Transformed = uvScale0 * texCoord0.xy + uvTranslate0;
	uv0 = SetFlip(texCoord0Transformed);
	gl_Position = modelViewMatrix * vec4(position,1);
}