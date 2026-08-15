function gmlvideo_video_play()
{
	var video = argument[0];
	
	var play = !ds_map_find_value(video, "playing");

	if (argument_count > 1)
	    play = argument[1];

	ds_map_set(video, "playing", play);
	_gmlvideo_sync_audio(video);

	var audio_inst = ds_map_find_value(video, "audio_instance");
	if (!is_undefined(audio_inst))
	{
	    if (play)
	        audio_resume_sound(audio_inst);
	    else
	        audio_pause_sound(audio_inst);
	}
}