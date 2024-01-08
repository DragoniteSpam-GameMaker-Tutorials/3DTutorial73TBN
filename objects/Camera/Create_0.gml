/// @description Set up 3D things

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format_add_color();
vertex_format_add_color();
vertex_format_tbn = vertex_format_end();

instance_create_depth(0, 0, 0, Player);

var buffer = buffer_load("sword.vbuff");
vb_sword = vertex_create_buffer_from_buffer(buffer, vertex_format);
buffer_delete(buffer);
buffer = buffer_load("sheath.vbuff");
vb_sheath = vertex_create_buffer_from_buffer(buffer, vertex_format);
buffer_delete(buffer);
buffer = buffer_load("sphere.vbuff");
vb_sphere = vertex_create_buffer_from_buffer(buffer, vertex_format);
buffer_delete(buffer);
buffer = buffer_load("ground.vbuff");
vb_ground = vertex_create_buffer_from_buffer(buffer, vertex_format);
buffer_delete(buffer);

vb_sword_tbn = calculate_tangents(vb_sword, vertex_format_tbn);
vb_sheath_tbn = calculate_tangents(vb_sheath, vertex_format_tbn);
vb_sphere_tbn = calculate_tangents(vb_sphere, vertex_format_tbn);
vb_ground_tbn = calculate_tangents(vb_ground, vertex_format_tbn);

vb_sphere_wire = generate_normal_wireframe(vb_sphere, vertex_format);
vb_sheath_wire = generate_normal_wireframe(vb_sheath, vertex_format);
vb_sword_wire = generate_normal_wireframe(vb_sword, vertex_format);

vb_sphere_wire_tbn = generate_tbn_wireframe(vb_sphere_tbn, vertex_format);
vb_sheath_wire_tbn = generate_tbn_wireframe(vb_sheath_tbn, vertex_format);
vb_sword_wire_tbn = generate_tbn_wireframe(vb_sword_tbn, vertex_format);