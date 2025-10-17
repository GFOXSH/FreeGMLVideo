function _gmlvideo_video_speed()
{
	var video = argument[0];
	var s = max(argument[1], 0);
	ds_map_set(video, "speed", s);
	_gmlvideo_sync_audio(video);
}