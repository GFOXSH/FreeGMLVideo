function gmlvideo_video_getsurface()
{
	var video = argument[0];
	var redraw = isset_default(ds_map_find_value(video, "frame_redraw"), 0);
	
	if (!surface_exists(ds_map_find_value(video, "frame_surface")))
	{
		gmlvideo_video_seekto(video, gmlvideo_get_position(video));
		return -1;
	}

	if (redraw)
	{
	    _gmlvideo_video_drawframe(video, ds_map_find_value(video, "frame"));
	    ds_map_set(video, "frame_redraw", 0);
	}
	
	return ds_map_find_value(video, "frame_surface");
}