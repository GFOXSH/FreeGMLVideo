function gmlvideo_get_position()
{
	var _video = argument[0];
	var _manifest = ds_map_find_value(_video, "manifest");
	var _fps = ds_map_find_value(_manifest, "target_fps");
	var _frame = ds_map_find_value(_video, "frame");
	return _frame / _fps;
}