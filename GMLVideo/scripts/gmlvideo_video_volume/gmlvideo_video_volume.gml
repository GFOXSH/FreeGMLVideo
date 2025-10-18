function gmlvideo_video_volume()
{
	var video = argument[0];

	if (!is_undefined(ds_map_find_value(video, "audio_instance")))
	{
	    if (argument_count == 1)
	    {
	        if (audio_sound_get_gain(ds_map_find_value(video, "audio_instance")) > 0)
	            audio_sound_gain(ds_map_find_value(video, "audio_instance"), 0, 0);
	        else
	            audio_sound_gain(ds_map_find_value(video, "audio_instance"), 1, 0);
	    }
	    else
	    {
	        audio_sound_gain(ds_map_find_value(video, "audio_instance"), clamp(argument[1], 0, 1), 0);
	    }
	}
}