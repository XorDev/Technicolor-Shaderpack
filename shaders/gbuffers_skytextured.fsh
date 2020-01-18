#version 120

uniform sampler2D texture;

varying vec4 color;
varying vec3 world;
varying vec2 coord0;

vec3 hash3(vec3 p)
{
  return fract(cos(p*mat3(-31.14,15.92,65.35,-89.79,-32.38,46.26,43.38,32.79,-02.88))*41.97);
}
vec3 value3(vec3 p)
{
  vec3 f = floor(p);
  vec3 s = p-f; s*= s*s*(3.-s-s);
  const vec2 o = vec2(0,1);
  return mix(mix(mix(hash3(f+o.xxx),hash3(f+o.yxx),s.x),
                 mix(hash3(f+o.xyx),hash3(f+o.yyx),s.x),s.y),
             mix(mix(hash3(f+o.xxy),hash3(f+o.yxy),s.x),
                 mix(hash3(f+o.xyy),hash3(f+o.yyy),s.x),s.y),s.z);
}

void main()
{

    vec4 tex = texture2D(texture,coord0);
    vec3 col = value3(world*.02)*8.+value3((world+world.zxy)*.04)*3.;
    gl_FragData[0] = color * tex * vec4(cos(col)*.5+.5,1);
}
