var _iid = ds_map_find_value(async_load, "id");
var _framebuffer_data = ds_map_find_value(global.gmlvideo_asyncAssoc, _iid);

if (!is_undefined(_framebuffer_data))
{
	var _fb_list = ds_map_find_value(_framebuffer_data, "frame_buffer");
	var _f_idx = ds_map_find_value(_framebuffer_data, "frame_index");
	var _b_idx = ds_map_find_value(_framebuffer_data, "buffer_index");
	var _target_item = ds_list_find_value(_fb_list, _f_idx);

	if (ds_map_find_value(async_load, "status"))
	{
		if (_target_item != -1 && !is_undefined(_target_item))
		{
			ds_map_set(_target_item, "buffer", _b_idx);
			ds_map_set(_target_item, "status", -3);
		}
		else
		{
			if (buffer_exists(_b_idx))
				buffer_delete(_b_idx);
		}
	}
	else
	{
		if (buffer_exists(_b_idx))
			buffer_delete(_b_idx);
			
		if (_target_item != -1 && !is_undefined(_target_item))
			ds_map_destroy(_target_item);
			
		ds_list_set(_fb_list, _f_idx, -1);
	}
	
	ds_map_destroy(_framebuffer_data);
	ds_map_delete(global.gmlvideo_asyncAssoc, _iid);
}