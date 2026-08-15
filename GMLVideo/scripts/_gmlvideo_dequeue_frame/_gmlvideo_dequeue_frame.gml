function _gmlvideo_dequeue_frame()
{
	var video = argument[0];
	var index = argument[1];
	var framebuffer = ds_map_find_value(video, "frame_buffer");

	var fb_item = ds_list_find_value(framebuffer, index);
	if (fb_item != -1)
	{
	    var status = ds_map_find_value(fb_item, "status");
	    if (status == -3)
	    {
	        var b = ds_map_find_value(fb_item, "buffer");
	        if (!is_undefined(b) && buffer_exists(b)) 
                buffer_delete(b);
	    }
	    else
	    {
	        ds_map_delete(global.gmlvideo_asyncAssoc, ds_map_find_value(fb_item, "id"));
	    }
	    
	    ds_map_destroy(fb_item);
	    ds_list_set(framebuffer, index, -1);
	}
}