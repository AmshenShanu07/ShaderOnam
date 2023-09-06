varying vec2 vUv;

uniform float uTime;


vec3 palette( float t) {

    vec3 a = vec3(.5 , 0.2, 0.2);
    vec3 b = vec3(0.5 , 0.2, 0.2);
    vec3 c = vec3(.7 , .5, .5);
    vec3 d = vec3(0.263 , 0416, 0.577);

    return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
    vec2 uvMod = vUv;
    vec2 uv0 = uvMod;
    vec3 finalColor = vec3(0.0);

    uv0 -= 0.5;
    uvMod -= 0.5;
    uvMod *= 2.f;

    for(float i = 0.0; i < 3.0; i++) {

        uvMod = fract(uvMod * 1.5) - 0.5;


        vec3 color = palette(length(uv0) + (i * 0.4) + (uTime * 0.5));

        float len = length(uvMod) * exp(-length(uv0));

        len = sin(len * 8.f + uTime) / 8.;
        len = abs(len);
        len = smoothstep(0.0, 0.1, len);

        len = pow(0.08 / len, 0.6);

        color *= len; 
        finalColor += color * len;
    }


    gl_FragColor = vec4(finalColor, 1.0);
}