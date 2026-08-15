function gmlvideo_video_play()
{
	var _video = argument[0];
	var _play = !ds_map_find_value(_video, "playing");

	if (argument_count > 1)
		_play = argument[1];

	ds_map_set(_video, "playing", _play);
	_gmlvideo_sync_audio(_video);

	var _audio_inst = ds_map_find_value(_video, "audio_instance");
	if (!is_undefined(_audio_inst))
	{
		if (_play)
			audio_resume_sound(_audio_inst);
		else
			audio_pause_sound(_audio_inst);
	}
}