var videos = global.gmlvideo_instances;
var s = ds_list_size(videos);
var d = delta_time / 1000000;
var frames_to_buffer = ds_map_find_value(global.gmlvideo, "buffer_frames");
var seeker = false
for (var i = 0; i < s; i++)
{
    var video = ds_list_find_value(videos, i);
    var video_fps = ds_get_embedded(video, "manifest", "target_fps");
    var frame_count = ds_get_embedded(video, "manifest", "frame_count");
    
	var seek = ds_map_find_value(video, "seek");
	if (seek >= 0)
	{
		var current_pos = gmlvideo_get_position(video)
		var distance = seek - current_pos
		var acceleration = 10 * distance
		_gmlvideo_video_speed(video, acceleration);
		
		gmlvideo_video_volume(video, 0);
		
		if (current_pos >= seek || acceleration < 1)
		{
			_gmlvideo_video_speed(video, 1);
			ds_map_replace(video, "seek", -1)
			gmlvideo_video_volume(video, 1)
		}
		else
		{
			seeker = true
		}
	}
	
    if (ds_map_find_value(video, "playing"))
    {
        ds_map_set(video, "frame_progress", ds_map_find_value(video, "frame_progress") + (ds_map_find_value(video, "speed") * d * video_fps));
        
        if (ds_map_find_value(video, "frame_progress") >= 1)
        {
            if (ds_map_find_value(video, "frame_lastdrawn") != ds_map_find_value(video, "frame") && frame_is_keyframe(ds_map_find_value(video, "manifest"), ds_map_find_value(video, "frame")))
            {
                ds_map_set(video, "frame_progress", 1);
                ds_map_set(video, "frame_redraw", 1);
            }
            else
            {
                var advance = max(floor(ds_map_find_value(video, "frame_progress")), 1);
                ds_map_set(video, "frame_progress", frac(ds_map_find_value(video, "frame_progress")));
                gmlvideo_video_framejump(video, advance, ds_map_find_value(video, "frame_progress"));
            }
        }
    }
    
    if (os_is_paused())
        ds_map_set(video, "frame_redraw", 1);
    
    var u_s = ds_list_size(ds_map_find_value(video, "frame_buffer"));
    
    for (var u = 0; u < u_s; u++)
    {
        var u_frame = (u + ds_map_find_value(video, "frame")) % frame_count;
        
        if (u <= frames_to_buffer)
            _gmlvideo_queue_frame(video, u_frame);
        else
            _gmlvideo_dequeue_frame(video, u_frame);
    }
}

if seeker
{
	game_set_speed(999, gamespeed_fps)
}
else
{
	game_set_speed(gamespeed, gamespeed_fps)
}