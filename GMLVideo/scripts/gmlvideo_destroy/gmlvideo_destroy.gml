function gmlvideo_destroy()
{
	var _video = argument[0];

	var _surf = ds_map_find_value(_video, "frame_surface");
	if (surface_exists(_surf))
		surface_free(_surf);

	var _audio_inst = ds_map_find_value(_video, "audio_instance");
	if (!is_undefined(_audio_inst))
		audio_stop_sound(_audio_inst);
		
	var _audio_stream = ds_map_find_value(_video, "audio");
	if (!is_undefined(_audio_stream))
		audio_destroy_stream(_audio_stream);

	var _framebuffer = ds_map_find_value(_video, "frame_buffer");
	if (!is_undefined(_framebuffer))
	{
		var _q_size = ds_list_size(_framebuffer);
		for (var _u = 0; _u < _q_size; _u++)
		{
			var _fb_item = ds_list_find_value(_framebuffer, _u);
			if (_fb_item != -1 && !is_undefined(_fb_item))
			{
				var _status = ds_map_find_value(_fb_item, "status");
				if (_status == -3)
				{
					var _b = ds_map_find_value(_fb_item, "buffer");
					if (!is_undefined(_b) && buffer_exists(_b))
						buffer_delete(_b);
				}
				else if (_status == -2)
				{
					ds_map_delete(global.gmlvideo_asyncAssoc, ds_map_find_value(_fb_item, "id"));
				}
				ds_map_destroy(_fb_item);
			}
		}
		ds_list_destroy(_framebuffer);
	}

	var _manifest = ds_map_find_value(_video, "manifest");
	if (!is_undefined(_manifest)) 
		ds_map_destroy(_manifest);

	var _pos = ds_list_find_index(global.gmlvideo_instances, _video);
	if (_pos != -1)
		ds_list_delete(global.gmlvideo_instances, _pos);

	ds_map_destroy(_video);
}