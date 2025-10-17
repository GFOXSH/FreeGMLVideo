function gmlvideo_video_stop()
{
	var video = argument0;
	ds_map_set(video, "playing", 0);
	ds_map_set(video, "frame", 0);
	ds_map_set(video, "frame_progress", 0);
	
	_gmlvideo_sync_audio(video);
	if (isset(ds_map_find_value(video, "audio_instance")))
	{
		audio_pause_sound(ds_map_find_value(video, "audio_instance"));
	}
}