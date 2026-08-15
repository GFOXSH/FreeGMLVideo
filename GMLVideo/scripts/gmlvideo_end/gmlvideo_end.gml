function gmlvideo_end()
{
	if (ds_exists(global.gmlvideo, ds_type_map))
		ds_map_destroy(global.gmlvideo);

	if (ds_exists(global.gmlvideo_instances, ds_type_list))
	{
		while (ds_list_size(global.gmlvideo_instances) > 0)
			gmlvideo_destroy(ds_list_find_value(global.gmlvideo_instances, 0));
			
		ds_list_destroy(global.gmlvideo_instances);
	}

	if (ds_exists(global.gmlvideo_asyncAssoc, ds_type_map))
		ds_map_destroy(global.gmlvideo_asyncAssoc);
}