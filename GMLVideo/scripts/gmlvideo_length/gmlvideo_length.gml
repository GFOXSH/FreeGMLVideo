// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlvideo_length()
{
	var video = argument0;
	var manifest = ds_map_find_value(video, "manifest");
	return ds_map_find_value(manifest, "frame_count") / ds_map_find_value(manifest, "target_fps");
}