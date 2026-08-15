function gmlvideo_video_volume()
{
	var _video = argument[0];
	var _audio_inst = ds_map_find_value(_video, "audio_instance");

	if (!is_undefined(_audio_inst))
	{
		if (argument_count == 1)
		{
			if (audio_sound_get_gain(_audio_inst) > 0)
				audio_sound_gain(_audio_inst, 0, 0);
			else
				audio_sound_gain(_audio_inst, 1, 0);
		}
		else
		{
			audio_sound_gain(_audio_inst, clamp(argument[1], 0, 1), 0);
		}
	}
}