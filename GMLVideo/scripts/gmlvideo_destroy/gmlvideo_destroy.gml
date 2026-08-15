function gmlvideo_destroy()
{
	var G = argument0;

	if (surface_exists(ds_map_find_value(G, "frame_surface")))
	    surface_free(ds_map_find_value(G, "frame_surface"));

	var audio_inst = ds_map_find_value(G, "audio_instance");
	if (!is_undefined(audio_inst))
	    audio_stop_sound(audio_inst);
	    
	var audio_stream = ds_map_find_value(G, "audio");
	if (!is_undefined(audio_stream))
	    audio_destroy_stream(audio_stream);

	var framebuffer = ds_map_find_value(G, "frame_buffer");
	if (!is_undefined(framebuffer))
	{
	    var q_size = ds_list_size(framebuffer);
	    for (var u = 0; u < q_size; u++)
	    {
	        var fb_item = ds_list_find_value(framebuffer, u);
	        if (fb_item != -1)
	        {
	            var status = ds_map_find_value(fb_item, "status");
	            if (status == -3) {
	                var b = ds_map_find_value(fb_item, "buffer");
	                if (!is_undefined(b) && buffer_exists(b)) buffer_delete(b);
	            } else if (status == -2) {
	                ds_map_delete(global.gmlvideo_asyncAssoc, ds_map_find_value(fb_item, "id"));
	            }
	            ds_map_destroy(fb_item);
	        }
	    }
	    ds_list_destroy(framebuffer);
	}

	var manifest = ds_map_find_value(G, "manifest");
	if (!is_undefined(manifest)) 
        ds_map_destroy(manifest);

	ds_map_destroy(G);

	var pos = ds_list_find_index(global.gmlvideo_instances, G);
	if (pos != -1)
	    ds_list_delete(global.gmlvideo_instances, pos);
}