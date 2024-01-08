function calculate_tangents(vbuff, vertex_format) {
    var original_data = buffer_create_from_vertex_buffer(vbuff, buffer_fixed, 1);
    var new_vbuff = vertex_create_buffer();
    vertex_begin(new_vbuff, vertex_format);
    
    var vertex_count = vertex_get_number(vbuff);
    
    repeat (vertex_count / 3) {
        var x1 = buffer_read(original_data, buffer_f32);
        var y1 = buffer_read(original_data, buffer_f32);
        var z1 = buffer_read(original_data, buffer_f32);
        var nx1 = buffer_read(original_data, buffer_f32);
        var ny1 = buffer_read(original_data, buffer_f32);
        var nz1 = buffer_read(original_data, buffer_f32);
        var u1 = buffer_read(original_data, buffer_f32);
        var v1 = buffer_read(original_data, buffer_f32);
        var c1 = buffer_read(original_data, buffer_u32);
        
        var x2 = buffer_read(original_data, buffer_f32);
        var y2 = buffer_read(original_data, buffer_f32);
        var z2 = buffer_read(original_data, buffer_f32);
        var nx2 = buffer_read(original_data, buffer_f32);
        var ny2 = buffer_read(original_data, buffer_f32);
        var nz2 = buffer_read(original_data, buffer_f32);
        var u2 = buffer_read(original_data, buffer_f32);
        var v2 = buffer_read(original_data, buffer_f32);
        var c2 = buffer_read(original_data, buffer_u32);
        
        var x3 = buffer_read(original_data, buffer_f32);
        var y3 = buffer_read(original_data, buffer_f32);
        var z3 = buffer_read(original_data, buffer_f32);
        var nx3 = buffer_read(original_data, buffer_f32);
        var ny3 = buffer_read(original_data, buffer_f32);
        var nz3 = buffer_read(original_data, buffer_f32);
        var u3 = buffer_read(original_data, buffer_f32);
        var v3 = buffer_read(original_data, buffer_f32);
        var c3 = buffer_read(original_data, buffer_u32);
        
        var e1x = x2 - x1;
        var e1y = y2 - y1;
        var e1z = z2 - z1;
        
        var e1u = u2 - u1;
        var e1v = v2 - v1;
        
        var e2x = x3 - x1;
        var e2y = y3 - y1;
        var e2z = z3 - z1;
        
        var e2u = u3 - u1;
        var e2v = v3 - v1;
        
        var det = 1 / (e1u * e2v - e1v * e2u);
        var tx = det * (e2v * e1x - e1v * e2x);
        var ty = det * (e2v * e1y - e1v * e2y);
        var tz = det * (e2v * e1z - e1v * e2z);
        
        var bx = det * (e1u * e2x - e2u * e1x);
        var by = det * (e1u * e2y - e2u * e1y);
        var bz = det * (e1u * e2z - e2u * e1z);
        
        var mag = point_distance_3d(0, 0, 0, tx, ty, tz);
        tx /= mag;
        ty /= mag;
        tz /= mag;
        
        mag = point_distance_3d(0, 0, 0, bx, by, bz);
        bx /= mag;
        by /= mag;
        bz /= mag;
        
        tx = ((tx / 0.5) + 0.5) * 255;
        ty = ((ty / 0.5) + 0.5) * 255;
        tz = ((tz / 0.5) + 0.5) * 255;
        var tangent_color = make_color_rgb(tx, ty, tz);
        
        bx = ((bx / 0.5) + 0.5) * 255;
        by = ((by / 0.5) + 0.5) * 255;
        bz = ((bz / 0.5) + 0.5) * 255;
        var bitangent_color = make_color_rgb(bx, by, bz);
        
        vertex_position_3d(new_vbuff, x1, y1, z1);
        vertex_normal(new_vbuff, nx1, ny1, nz1);
        vertex_texcoord(new_vbuff, u1, v1);
        vertex_color(new_vbuff, c1 & 0x00ffffff, (c1 >> 24) / 255);
        vertex_color(new_vbuff, tangent_color, 1);
        vertex_color(new_vbuff, bitangent_color, 1);
        
        vertex_position_3d(new_vbuff, x2, y2, z2);
        vertex_normal(new_vbuff, nx2, ny2, nz2);
        vertex_texcoord(new_vbuff, u2, v2);
        vertex_color(new_vbuff, c2 & 0x00ffffff, (c2 >> 24) / 255);
        vertex_color(new_vbuff, tangent_color, 1);
        vertex_color(new_vbuff, bitangent_color, 1);
        
        vertex_position_3d(new_vbuff, x3, y3, z3);
        vertex_normal(new_vbuff, nx3, ny3, nz3);
        vertex_texcoord(new_vbuff, u3, v3);
        vertex_color(new_vbuff, c3 & 0x00ffffff, (c3 >> 24) / 255);
        vertex_color(new_vbuff, tangent_color, 1);
        vertex_color(new_vbuff, bitangent_color, 1);
    }
    
    vertex_end(new_vbuff);
    buffer_delete(original_data);
    
    return new_vbuff;
}