varying vec2 v_uv;
varying mat3 v_tbn;

uniform sampler2D samp_normal;

void main() {
    vec4 starting_color = texture2D(gm_BaseTexture, v_uv);
    vec3 ambient_color = vec3(0.1, 0.1, 0.1);
    vec3 light_color = vec3(1);
    
    
    vec3 normal_color = texture2D(samp_normal, v_uv).rgb * 2.0 - 1.0;
    vec3 transformed_normal = normalize(v_tbn * normal_color);
    
    vec3 L = normalize(vec3(-0.5));
    float NdotL = max(0.0, -dot(transformed_normal, L));
    vec3 diffuse_color = NdotL * light_color;
    
    vec3 final_color = starting_color.rgb * (ambient_color + diffuse_color);
    gl_FragColor = vec4(final_color, starting_color.a);
}