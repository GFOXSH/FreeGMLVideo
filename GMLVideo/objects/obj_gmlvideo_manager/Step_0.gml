var _videos = global.gmlvideo_instances;
var _s = ds_list_size(_videos);
var _d = delta_time / 1000000;
var _frames_to_buffer = ds_map_find_value(global.gmlvideo, "buffer_frames");

for (var _i = 0; _i < _s; _i++)
{
	var _video = ds_list_find_value(_videos, _i);
	var _manifest = ds_map_find_value(_video, "manifest");
	var _video_fps = ds_map_find_value(_manifest, "target_fps");
	var _frame_count = ds_map_find_value(_manifest, "frame_count");
	
	var _seek = ds_map_find_value(_video, "seek");
	if (_seek >= 0)
	{
		var _target_frame = floor(_seek * _video_fps);
		_target_frame = clamp(_target_frame, 0, _frame_count - 1);
		
		var _framebuffer = ds_map_find_value(_video, "frame_buffer");
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
				else
				{
					ds_map_delete(global.gmlvideo_asyncAssoc, ds_map_find_value(_fb_item, "id"));
				}
				
				ds_map_destroy(_fb_item);
				ds_list_set(_framebuffer, _u, -1);
			}
		}
		
		ds_map_set(_video, "frame", _target_frame);
		ds_map_set(_video, "frame_progress", 0);
		ds_map_set(_video, "frame_redraw", 1);
		ds_map_replace(_video, "seek", -1);
		
		_gmlvideo_video_drawframe(_video, _target_frame);
		_gmlvideo_sync_audio(_video);
		
		var _audio_inst = ds_map_find_value(_video, "audio_instance");
		if (!is_undefined(_audio_inst) && ds_map_find_value(_video, "playing"))
		{
			audio_resume_sound(_audio_inst);
		}
	}
	
	if (ds_map_find_value(_video, "playing"))
	{
		ds_map_set(_video, "frame_progress", ds_map_find_value(_video, "frame_progress") + (ds_map_find_value(_video, "speed") * _d * _video_fps));
		
		if (ds_map_find_value(_video, "frame_progress") >= 1)
		{
			var _advance = max(floor(ds_map_find_value(_video, "frame_progress")), 1);
			ds_map_set(_video, "frame_progress", frac(ds_map_find_value(_video, "frame_progress")));
			_gmlvideo_video_framejump(_video, _advance, ds_map_find_value(_video, "frame_progress"));
		}
	}
	
	if (os_is_paused())
		ds_map_set(_video, "frame_redraw", 1);
	
	var _fb_list = ds_map_find_value(_video, "frame_buffer");
	var _u_s = ds_list_size(_fb_list);
	
	for (var _u = 0; _u < _u_s; _u++)
	{
		var _u_frame = (_u + ds_map_find_value(_video, "frame")) % _frame_count;
		
		if (_u <= _frames_to_buffer)
			_gmlvideo_queue_frame(_video, _u_frame);
		else
			_gmlvideo_dequeue_frame(_video, _u_frame);
	}
}