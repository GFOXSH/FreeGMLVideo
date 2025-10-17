function gmlvideo_video_seekto()
{
	var video = argument0
	
	if _gmlvideo_is_seek(video)
		exit;
	
	gmlvideo_video_stop(video)
	gmlvideo_video_play(video, 1)
	var seek = clamp(argument1, 0, gmlvideo_length(video) - 1)
	ds_map_replace(video, "seek", seek)
}