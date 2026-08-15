function gmlvideo_set_framecache()
{
	var _frames = argument[0];
	ds_map_set(global.gmlvideo, "buffer_frames", _frames);
}