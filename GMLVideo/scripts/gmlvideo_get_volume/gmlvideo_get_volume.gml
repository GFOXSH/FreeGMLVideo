function gmlvideo_get_volume()
{
	var video = argument[0];

	if (!is_undefined(ds_map_find_value(video, "audio_instance")))
		return audio_sound_get_gain(ds_map_find_value(video, "audio_instance"));
	
	return 0;
}