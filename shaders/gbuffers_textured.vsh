#version 120

attribute float mc_Entity;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;

uniform vec3 cameraPosition;
uniform vec3 shadowLightPosition;

varying vec4 color;
varying vec3 world;
varying vec2 coord0;
varying vec2 coord1;
varying float lambert;

void main()
{
    vec3 pos = (gl_ModelViewMatrix * gl_Vertex).xyz;
    pos = mat3(gbufferModelViewInverse) * pos  + gbufferModelViewInverse[3].xyz;
    world = pos+cameraPosition;

    gl_Position = gl_ProjectionMatrix * gbufferModelView * vec4(pos,1);

    vec3 normal = gl_NormalMatrix * gl_Normal;
    normal = (mc_Entity==1.) ? vec3(0,1,0) : (gbufferModelViewInverse * vec4(normal,0)).xyz;

    color = gl_Color;
    lambert = dot(normal,normalize(shadowLightPosition))*.3+.9;
    coord0 = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    coord1 = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
}
