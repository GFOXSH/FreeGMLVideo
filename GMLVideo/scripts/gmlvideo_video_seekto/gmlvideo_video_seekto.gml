function gmlvideo_video_seekto()
{
	var video = argument0;
	var target_time = clamp(argument1, 0, gmlvideo_length(video));
	
	var audio_inst = ds_map_find_value(video, "audio_instance");
	if (!is_undefined(audio_inst))
	{
		audio_pause_sound(audio_inst);
	}
	
	ds_map_replace(video, "seek", target_time);
}