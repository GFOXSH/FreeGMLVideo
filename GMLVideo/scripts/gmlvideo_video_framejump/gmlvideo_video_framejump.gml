function gmlvideo_video_framejump()
{
	var video = argument[0];
	var frameinc = 1;
	var progress = 0;
	var index = ds_map_find_value(video, "frame");
	var framecount = ds_get_embedded(video, "manifest", "frame_count");
	var loop = !!ds_map_find_value(video, "loop");
	var audioSync = 0;

	if (argument_count > 1)
	{
	    frameinc = argument[1];
    
	    if (argument_count > 2)
	        progress = argument[2];
	}

	index += frameinc;

	if (index >= framecount)
	{
	    if (loop)
	    {
	        index = index % framecount;
	        audioSync = 1;
	    }
	    else
	    {
	        gmlvideo_video_stop(video);
	    }
	}

	ds_map_set(video, "frame", index);
	ds_map_set(video, "frame_progress", progress);
	ds_map_set(video, "frame_redraw", 1);

	if (audioSync)
	    _gmlvideo_sync_audio(video);
}