function gmlvideo_video_play() {
	var video = argument[0];
	var play = !ds_map_find_value(video, "playing");

	if (argument_count > 1)
	    play = argument[1];

	ds_map_set(video, "playing", play);
	_gmlvideo_sync_audio(video);

	if (isset(ds_map_find_value(video, "audio_instance")))
	{
	    if (play)
	        audio_resume_sound(ds_map_find_value(video, "audio_instance"));
	    else
	        audio_pause_sound(ds_map_find_value(video, "audio_instance"));
	}
}