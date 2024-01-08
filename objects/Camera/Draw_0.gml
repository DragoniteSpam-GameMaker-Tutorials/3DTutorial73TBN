/// @description Draw the 3D world

gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
draw_clear(c_black);
gpu_set_texrepeat(true);

// 3D projections require a view and projection matrix
var camera = camera_get_active();

var xfrom = Player.x;
var yfrom = Player.y;
var zfrom = Player.z + 64;
var xto = xfrom - dcos(Player.look_dir) * dcos(Player.look_pitch);
var yto = yfrom + dsin(Player.look_dir) * dcos(Player.look_pitch);
var zto = zfrom + dsin(Player.look_pitch);

var view_mat = matrix_build_lookat(xfrom, yfrom, zfrom, xto, yto, zto, 0, 0, 1);
var proj_mat = matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 10_000);
camera_set_view_mat(camera, view_mat);
camera_set_proj_mat(camera, proj_mat);
camera_apply(camera);

shader_set(shd_normal_mapping);
//shader_set(shd_diffuse);

var rotation = current_time / 1000 * 60;
shader_set_uniform_f(shader_get_uniform(shd_normal_mapping, "light_direction"), dcos(rotation * 1.5), -dsin(rotation * 1.5), -0.5);

texture_set_stage(shader_get_sampler_index(shd_normal_mapping, "samp_normal"), sprite_get_texture(spr_ground_normal, 0));
vertex_submit(vb_ground_tbn, pr_trianglelist, sprite_get_texture(spr_ground, 0));

matrix_set(matrix_world, matrix_build(50, 50, 32, 30, 30, rotation, 1, 1, 1));
vertex_submit(vb_sphere_tbn, pr_trianglelist, -1);

matrix_set(matrix_world, matrix_build(100, 100, 32, 30, 30, rotation, 1, 1, 1));
texture_set_stage(shader_get_sampler_index(shd_normal_mapping, "samp_normal"), sprite_get_texture(spr_sword_norm, 0));
vertex_submit(vb_sword_tbn, pr_trianglelist, sprite_get_texture(spr_sword, 0));

matrix_set(matrix_world, matrix_build(50, 150, 32, 30, 30, rotation, 1, 1, 1));
vertex_submit(vb_sword_tbn, pr_trianglelist, sprite_get_texture(spr_sword, 0));
texture_set_stage(shader_get_sampler_index(shd_normal_mapping, "samp_normal"), sprite_get_texture(spr_sheath_norm, 0));
vertex_submit(vb_sheath_tbn, pr_trianglelist, sprite_get_texture(spr_sheath, 0));

if (keyboard_check(vk_space)) {
    shader_set(shd_wireframe);
    matrix_set(matrix_world, matrix_build(50, 50, 32, 30, 30, rotation, 1, 1, 1));
    vertex_submit(vb_sphere_wire_tbn, pr_linelist, -1);
    matrix_set(matrix_world, matrix_build(100, 100, 32, 30, 30, rotation, 1, 1, 1));
    vertex_submit(vb_sword_wire_tbn, pr_linelist, -1);
    matrix_set(matrix_world, matrix_build(50, 150, 32, 30, 30, rotation, 1, 1, 1));
    vertex_submit(vb_sheath_wire_tbn, pr_linelist, -1);
}

matrix_set(matrix_world, matrix_build_identity());
shader_reset();
gpu_set_zwriteenable(false);
gpu_set_ztestenable(false);