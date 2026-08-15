function _gmlvideo_dequeue_frame()
{
	var _video = argument[0];
	var _index = argument[1];
	var _framebuffer = ds_map_find_value(_video, "frame_buffer");

	var _fb_item = ds_list_find_value(_framebuffer, _index);
	if (_fb_item != -1 && !is_undefined(_fb_item))
	{
		var _status = ds_map_find_value(_fb_item, "status");
		if (_status == -3)
		{
			var _b = ds_map_find_value(_fb_item, "buffer");
			if (!is_undefined(_b) && buffer_exists(_b)) 
				buffer_delete(_b);
		}
		else
		{
			ds_map_delete(global.gmlvideo_asyncAssoc, ds_map_find_value(_fb_item, "id"));
		}
		
		ds_map_destroy(_fb_item);
		ds_list_set(_framebuffer, _index, -1);
	}
}