function gmlvideo_end()
{
	ds_map_destroy(global.gmlvideo);

	while (ds_list_size(global.gmlvideo_instances) > 0)
	    gmlvideo_destroy(ds_list_find_value(global.gmlvideo_instances, 0));

	ds_list_destroy(global.gmlvideo_instances);
}