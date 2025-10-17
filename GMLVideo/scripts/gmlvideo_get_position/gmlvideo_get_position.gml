// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlvideo_get_position()
{
	var video = argument0;
	var manifest = ds_map_find_value(video, "manifest");
	return ds_map_find_value(video, "frame") / ds_map_find_value(manifest, "target_fps");
}