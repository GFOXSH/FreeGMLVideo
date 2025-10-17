function _gmlvideo_video_drawframe()
{
	var video = argument[0];
	var manifest = ds_map_find_value(video, "manifest");
	var framebuffer = ds_map_find_value(video, "frame_buffer");
	var index = argument[1];

	if (ds_list_find_value(framebuffer, index) != -1 && isset_equality(ds_get_embedded(framebuffer, index, "status"), -3))
	{
	    var vb = _gmlvideo_video_framebuffer_to_vertexbuffer(ds_get_embedded(manifest, "frameSize", index), ds_get_embedded(framebuffer, index, "buffer"));
    
	    if (!surface_exists(ds_map_find_value(video, "frame_surface")))
	    {
	        ds_map_set(video, "frame_surface", surface_create(ds_map_find_value(manifest, "width"), ds_map_find_value(manifest, "height")));
        
	        if (buffer_exists(ds_map_find_value(video, "backup_buffer")))
	            buffer_set_surface(ds_map_find_value(video, "backup_buffer"), ds_map_find_value(video, "frame_surface"), 0);
	    }
    
	    surface_set_target(ds_map_find_value(video, "frame_surface"));
	    _gmlvideo_drawVertexFrame(manifest, vb);
	    surface_reset_target();
		
		if (!buffer_exists(ds_map_find_value(video, "backup_buffer")))
			ds_map_set(video, "backup_buffer", buffer_create(4 * ds_map_find_value(manifest, "width") * ds_map_find_value(manifest, "height"), buffer_fixed, 1));
		
		buffer_get_surface(ds_map_find_value(video, "backup_buffer"), ds_map_find_value(video, "frame_surface"), 0);
	    
		ds_map_set(video, "frame_lastdrawn", index);
	    frameVertexArrayClear(vb);
	}
}