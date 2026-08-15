function gmlvideo_get_volume()
{
	var _video = argument[0];
	var _audio_inst = ds_map_find_value(_video, "audio_instance");

	if (!is_undefined(_audio_inst))
		return audio_sound_get_gain(_audio_inst);
	
	return 0;
}