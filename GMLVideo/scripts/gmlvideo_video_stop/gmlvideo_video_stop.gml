function gmlvideo_video_stop()
{
	var _video = argument[0];
	
	ds_map_set(_video, "playing", 0);
	ds_map_set(_video, "frame", 0);
	ds_map_set(_video, "frame_progress", 0);
	
	_gmlvideo_sync_audio(_video);
	
	var _audio_inst = ds_map_find_value(_video, "audio_instance");
	if (!is_undefined(_audio_inst))
	{
		audio_pause_sound(_audio_inst);
	}
}