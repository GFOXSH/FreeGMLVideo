function _gmlvideo_dequeue_frame()
{
	var index = argument[1];
	var video = argument[0];
	var framebuffer = ds_map_find_value(video, "frame_buffer");

	if (ds_list_find_value(framebuffer, index) != -1)
	{
	    if (ds_get_embedded(ds_list_find_value(framebuffer, index), "status") == -3)
	    {
	        var b = ds_get_embedded(framebuffer, index, "buffer");
        
	        if (!is_undefined(b))
	            buffer_delete(b);
        
	        ds_map_destroy(ds_list_find_value(framebuffer, index));
	        ds_list_set(framebuffer, index, -1);
	    }
	    else
	    {
	        ds_map_delete(global.gmlvideo_asyncAssoc, ds_get_embedded(ds_list_find_value(framebuffer, index), "id"));
	    }
	}
}