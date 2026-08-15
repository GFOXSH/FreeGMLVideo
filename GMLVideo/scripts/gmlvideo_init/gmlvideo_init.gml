function gmlvideo_init()
{
	global.gmlvideo = dm("buffer_frames", 2);
	global.gmlvideo_instances = ds_list_create();
	global.gmlvideo_asyncAssoc = dm();
}