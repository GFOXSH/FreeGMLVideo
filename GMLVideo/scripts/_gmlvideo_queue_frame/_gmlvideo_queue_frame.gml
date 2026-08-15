function _gmlvideo_queue_frame()
{
	var _video = argument[0];
	var _index = argument[1];
	var _framebuffer = ds_map_find_value(_video, "frame_buffer");

	if (ds_list_find_value(_framebuffer, _index) == -1)
	{
		var _manifest = ds_map_find_value(_video, "manifest");
		var _frameSize = ds_map_find_value(_manifest, "frameSizePrecalc");
		var _start_frame = ds_map_find_value(_manifest, "start_frame");
		if (is_undefined(_start_frame))
			_start_frame = 0;
		
		var _frame_total_size = ds_list_find_value(_frameSize, _index);
		if (_frame_total_size <= 0)
			return 0;
		
		var _b = buffer_create(_frame_total_size, buffer_fast, 1);
		var _frame_file = ds_map_find_value(_video, "file_root") + "frame_" + string(_start_frame + _index) + ".dat";
		var _uuid = buffer_load_async(_b, _frame_file, 0, _frame_total_size);
		
		var _assoc_map = ds_map_create();
		ds_map_add(_assoc_map, "frame_buffer", _framebuffer);
		ds_map_add(_assoc_map, "frame_index", _index);
		ds_map_add(_assoc_map, "buffer_index", _b);
		ds_map_add_map(global.gmlvideo_asyncAssoc, _uuid, _assoc_map);
		
		var _fb_map = ds_map_create();
		ds_map_add(_fb_map, "status", -2);
		ds_map_add(_fb_map, "id", _uuid);
		ds_list_set(_framebuffer, _index, _fb_map);
		ds_list_mark_as_map(_framebuffer, _index);
	}
}