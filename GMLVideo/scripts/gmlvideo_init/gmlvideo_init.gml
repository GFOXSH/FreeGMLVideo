function gmlvideo_init()
{
	global.gmlvideo = ds_map_create();
	ds_map_add(global.gmlvideo, "buffer_frames", 2);
	
	global.gmlvideo_instances = ds_list_create();
	global.gmlvideo_asyncAssoc = ds_map_create();
}