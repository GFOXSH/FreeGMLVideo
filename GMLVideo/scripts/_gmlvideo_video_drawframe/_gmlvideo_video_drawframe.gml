function _gmlvideo_video_drawframe()
{
	var _video = argument[0];
	var _target_frame = argument[1];
	var _manifest = ds_map_find_value(_video, "manifest");
	var _framebuffer = ds_map_find_value(_video, "frame_buffer");
	var _frame_count = ds_map_find_value(_manifest, "frame_count");
	
	_target_frame = clamp(_target_frame, 0, _frame_count - 1);
	
	var _surf = ds_map_find_value(_video, "frame_surface");
	if (!surface_exists(_surf))
	{
		_surf = surface_create(ds_map_find_value(_manifest, "width"), ds_map_find_value(_manifest, "height"));
		ds_map_set(_video, "frame_surface", _surf);
		ds_map_set(_video, "frame_lastdrawn", -1);
	}
	
	var _last_drawn = ds_map_find_value(_video, "frame_lastdrawn");
	if (is_undefined(_last_drawn))
		_last_drawn = -1;
	
	var _start_f = _last_drawn + 1;
	var _jumped = false;
	
	var _kf_rate = ds_map_find_value(_manifest, "keyframe_rate");
	var _nearest_kf = 0;
	if (!is_undefined(_kf_rate) && _kf_rate > 0)
	{
		_nearest_kf = _target_frame - (_target_frame % _kf_rate);
	}
	
	if (_target_frame < _last_drawn || _start_f < 0 || _nearest_kf > _last_drawn)
	{
		_start_f = _nearest_kf;
		_jumped = true;
	}
	
	if (_start_f <= _target_frame)
	{
		var _frameSizePrecalc = ds_map_find_value(_manifest, "frameSizePrecalc");
		var _start_offset = ds_map_find_value(_manifest, "start_frame");
		if (is_undefined(_start_offset))
			_start_offset = 0;
		
		surface_set_target(_surf);
		
		if (_start_f == 0 || _jumped)
		{
			draw_clear_alpha(c_black, 1.0);
		}
		
		var _manifest_frameSize = ds_map_find_value(_manifest, "frameSize");
		
		for (var _f = _start_f; _f <= _target_frame; _f++)
		{
			var _frame_total_size = ds_list_find_value(_frameSizePrecalc, _f);
			if (_frame_total_size > 0)
			{
				var _b = -1;
				var _need_delete = false;
				
				if (_f < ds_list_size(_framebuffer))
				{
					var _fb_item = ds_list_find_value(_framebuffer, _f);
					if (_fb_item != -1 && !is_undefined(_fb_item))
					{
						var _st = ds_map_find_value(_fb_item, "status");
						if (!is_undefined(_st) && _st == -3)
							_b = ds_map_find_value(_fb_item, "buffer");
					}
				}
				
				if (_b == -1 || !buffer_exists(_b))
				{
					var _frame_file = ds_map_find_value(_video, "file_root") + "frame_" + string(_start_offset + _f) + ".dat";
					if (file_exists(_frame_file))
					{
						_b = buffer_load(_frame_file);
						_need_delete = true;
					}
				}
				
				if (_b != -1 && buffer_exists(_b))
				{
					var _current_frame_size_list = ds_list_find_value(_manifest_frameSize, _f);
					_gmlvideo_drawVertexFrame(_manifest, _current_frame_size_list, _b);
					if (_need_delete)
						buffer_delete(_b);
				}
			}
		}
		
		surface_reset_target();
		ds_map_set(_video, "frame_lastdrawn", _target_frame);
	}
}