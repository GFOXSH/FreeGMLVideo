function gmlvideo_video_speed()
{
	var _video = argument[0];
	var _s = argument[1];
	
	ds_map_set(_video, "speed", _s);
	_gmlvideo_sync_audio(_video);
}