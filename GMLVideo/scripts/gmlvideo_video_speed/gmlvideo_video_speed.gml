function gmlvideo_video_speed()
{
	var video = argument[0];
	var s = argument[1];
	ds_map_set(video, "speed", s);
	_gmlvideo_sync_audio(video);
}