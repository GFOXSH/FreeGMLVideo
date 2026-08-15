function _gmlvideo_sync_audio()
{
	var _video = argument[0];
	var _manifest = ds_map_find_value(_video, "manifest");
	var _audio_inst = ds_map_find_value(_video, "audio_instance");

	if (!is_undefined(_audio_inst))
	{
		var _fps = ds_map_find_value(_manifest, "target_fps");
		var _frame = ds_map_find_value(_video, "frame");
		var _speed = ds_map_find_value(_video, "speed");
		audio_sound_set_track_position(_audio_inst, _frame / _fps);
		audio_sound_pitch(_audio_inst, _speed);
	}
}