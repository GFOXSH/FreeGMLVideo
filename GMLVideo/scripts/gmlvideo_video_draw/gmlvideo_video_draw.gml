function gmlvideo_video_draw()
{
	var _video = argument[0];
	var _manifest = ds_map_find_value(_video, "manifest");
	var _xx = argument[1];
	var _yy = argument[2];
	var _ww = ds_map_find_value(_manifest, "width");
	var _hh = ds_map_find_value(_manifest, "height");
	var _s = gmlvideo_video_getsurface(_video);

	if (argument_count > 3)
	{
		_ww = argument[3];
		if (argument_count > 4)
			_hh = argument[4];
	}

	if (surface_exists(_s))
		draw_surface_stretched(_s, _xx, _yy, _ww, _hh);
}