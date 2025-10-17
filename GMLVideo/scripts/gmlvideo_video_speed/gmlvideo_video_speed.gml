// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function gmlvideo_video_speed()
{
	var video = argument[0];
	
	if _gmlvideo_is_seek(video)
		exit;
	
	var s = argument[1];
	_gmlvideo_video_speed(video, s);
}