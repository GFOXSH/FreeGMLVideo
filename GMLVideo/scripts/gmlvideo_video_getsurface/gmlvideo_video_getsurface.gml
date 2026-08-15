function gmlvideo_video_getsurface()
{
	var _video = argument[0];
	var _redraw = ds_map_find_value(_video, "frame_redraw");
	if (is_undefined(_redraw))
		_redraw = 0;
	
	var _manifest = ds_map_find_value(_video, "manifest");
	var _surf = ds_map_find_value(_video, "frame_surface");
	
	if (!surface_exists(_surf))
	{
		_surf = surface_create(ds_map_find_value(_manifest, "width"), ds_map_find_value(_manifest, "height"));
		ds_map_set(_video, "frame_surface", _surf);
		ds_map_set(_video, "frame_lastdrawn", -1);
		_redraw = 1;
	}

	if (_redraw || ds_map_find_value(_video, "frame_lastdrawn") != ds_map_find_value(_video, "frame"))
	{
		_gmlvideo_video_drawframe(_video, ds_map_find_value(_video, "frame"));
		ds_map_set(_video, "frame_redraw", 0);
	}
	
	return ds_map_find_value(_video, "frame_surface");
}