function gmlvideo_video_stop()
{
	var video = argument0;
	
	ds_map_set(video, "playing", 0);
	ds_map_set(video, "frame", 0);
	ds_map_set(video, "frame_progress", 0);
	
	_gmlvideo_sync_audio(video);
	
	var audio_inst = ds_map_find_value(video, "audio_instance");
	if (!is_undefined(audio_inst))
	{
		audio_pause_sound(audio_inst);
	}
}