attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour;
attribute vec4 in_Colour1;
attribute vec4 in_Colour2;

varying vec2 v_uv;
varying mat3 v_tbn;

void main() {
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4(in_Position, 1);
    
    vec3 ws_normal = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Normal, 0)).xyz);
    vec3 ws_tangent = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Colour1.rgb * 2.0 - 1.0, 0)).xyz);
    vec3 ws_bitangent = normalize((gm_Matrices[MATRIX_WORLD] * vec4(in_Colour2.rgb * 2.0 - 1.0, 0)).xyz);
    
    v_tbn = mat3(
        -ws_tangent,
        -ws_bitangent,
        ws_normal
    );
    
    v_uv = in_TextureCoord;
}