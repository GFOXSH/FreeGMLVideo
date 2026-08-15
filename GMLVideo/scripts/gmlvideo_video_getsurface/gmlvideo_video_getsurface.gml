function gmlvideo_video_getsurface()
{
	var video = argument[0];
	var redraw = ds_map_find_value(video, "frame_redraw");
	if (is_undefined(redraw)) redraw = 0;
	
	var manifest = ds_map_find_value(video, "manifest");
	var surf = ds_map_find_value(video, "frame_surface");
	
	if (!surface_exists(surf))
	{
		surf = surface_create(ds_map_find_value(manifest, "width"), ds_map_find_value(manifest, "height"));
		ds_map_set(video, "frame_surface", surf);
		ds_map_set(video, "frame_lastdrawn", -1);
		redraw = 1;
	}

	if (redraw || ds_map_find_value(video, "frame_lastdrawn") != ds_map_find_value(video, "frame"))
	{
	    _gmlvideo_video_drawframe(video, ds_map_find_value(video, "frame"));
	    ds_map_set(video, "frame_redraw", 0);
	}
	
	return ds_map_find_value(video, "frame_surface");
}