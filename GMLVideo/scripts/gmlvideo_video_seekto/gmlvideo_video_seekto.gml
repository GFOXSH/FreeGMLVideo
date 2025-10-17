// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlvideo_video_seekto()
{
	var video = argument0
	gmlvideo_video_stop(video)
	gmlvideo_video_play(video, 1)
	var seek = clamp(argument1, 0, gmlvideo_length(video) - 1)
	ds_map_replace(video, "seek", seek)
}