function gmlvideo_video_draw()
{
	var video = argument[0];
	var manifest = ds_map_find_value(video, "manifest");
	var xx = argument[1];
	var yy = argument[2];
	var ww = ds_map_find_value(manifest, "width");
	var hh = ds_map_find_value(manifest, "height");
	var s = gmlvideo_video_getsurface(video);

	if (argument_count > 3)
	{
	    ww = argument[3];
    
	    if (argument_count > 4)
	        hh = argument[4];
	}

	if (surface_exists(s))
	    draw_surface_stretched(s, xx, yy, ww, hh);
}