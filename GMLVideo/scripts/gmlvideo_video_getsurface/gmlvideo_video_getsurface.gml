function gmlvideo_video_getsurface()
{
	var video = argument[0];
	var manifest = ds_map_find_value(video, "manifest");
	var xx = 0;
	var yy = 0;
	var ww = ds_map_find_value(manifest, "width");
	var hh = ds_map_find_value(manifest, "height");
	var redraw = isset_default(ds_map_find_value(video, "frame_redraw"), 0);
	var getSurface = 1;

	if (redraw)
	{
	    _gmlvideo_video_drawframe(video, ds_map_find_value(video, "frame"));
	    ds_map_set(video, "frame_redraw", 0);
	}
	
	if (ds_map_find_value(video, "seek") != -1)
		return -1;
	
	if (getSurface)
	    return ds_map_find_value(video, "frame_surface");
}