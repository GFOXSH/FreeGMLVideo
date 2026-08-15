function gmlvideo_is_playing()
{
	var _video = argument[0];
	return ds_map_find_value(_video, "playing");
}