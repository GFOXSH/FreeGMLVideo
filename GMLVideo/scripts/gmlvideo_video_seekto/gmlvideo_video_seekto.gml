function gmlvideo_video_seekto()
{
	var _video = argument[0];
	var _target_time = clamp(argument[1], 0, gmlvideo_length(_video));
	
	var _audio_inst = ds_map_find_value(_video, "audio_instance");
	if (!is_undefined(_audio_inst))
	{
		audio_pause_sound(_audio_inst);
	}
	
	ds_map_replace(_video, "seek", _target_time);
}