function _gmlvideo_is_seek()
{
	return ds_map_find_value(argument0, "seek") >= 0;
}