function generate_normal_wireframe(vbuff, vertex_format) {
    var buffer = buffer_create_from_vertex_buffer(vbuff, buffer_fixed, 1);
    var new_buffer = buffer_create(buffer_get_size(buffer) * 2, buffer_fixed, 1);
    
    for (var i = 0, n = buffer_get_size(buffer); i < n; i += 36 * 3) {
        buffer_seek(buffer, buffer_seek_start, i);
        
        var x1 = buffer_peek(buffer, i + 00, buffer_f32);
        var y1 = buffer_peek(buffer, i + 04, buffer_f32);
        var z1 = buffer_peek(buffer, i + 08, buffer_f32);
        var x2 = buffer_peek(buffer, i + 36, buffer_f32);
        var y2 = buffer_peek(buffer, i + 40, buffer_f32);
        var z2 = buffer_peek(buffer, i + 44, buffer_f32);
        var x3 = buffer_peek(buffer, i + 72, buffer_f32);
        var y3 = buffer_peek(buffer, i + 76, buffer_f32);
        var z3 = buffer_peek(buffer, i + 80, buffer_f32);
        
        var cx = mean(x1, x2, x3);
        var cy = mean(y1, y2, y3);
        var cz = mean(z1, z2, z3);
        
        var nx =  buffer_peek(buffer, i + 12, buffer_f32);
        var ny =  buffer_peek(buffer, i + 16, buffer_f32);
        var nz =  buffer_peek(buffer, i + 20, buffer_f32);
        
        buffer_write(new_buffer, buffer_f32, cx);
        buffer_write(new_buffer, buffer_f32, cy);
        buffer_write(new_buffer, buffer_f32, cz);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_u32, 0xff0000ff);
        buffer_write(new_buffer, buffer_f32, cx + nx);
        buffer_write(new_buffer, buffer_f32, cy + ny);
        buffer_write(new_buffer, buffer_f32, cz + nz);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_f32, 0);
        buffer_write(new_buffer, buffer_u32, 0xff0000ff);
    }
    
    var wire_vbuff = vertex_create_buffer_from_buffer(new_buffer, vertex_format);
    buffer_delete(new_buffer);
    return wire_vbuff;
}