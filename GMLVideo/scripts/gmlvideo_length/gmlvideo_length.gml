function gmlvideo_length()
{
	var _video = argument[0];
	var _manifest = ds_map_find_value(_video, "manifest");
	var _count = ds_map_find_value(_manifest, "frame_count");
	var _fps = ds_map_find_value(_manifest, "target_fps");
	return _count / _fps;
}