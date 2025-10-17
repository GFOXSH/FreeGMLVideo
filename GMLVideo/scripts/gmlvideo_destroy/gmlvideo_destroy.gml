function gmlvideo_destroy()
{
	var G = argument0;

	if (surface_exists(ds_map_find_value(G, "frame_surface")))
	    surface_free(ds_map_find_value(G, "frame_surface"));

	if (buffer_exists(ds_map_find_value(G, "backup_buffer")))
	    buffer_delete(ds_map_find_value(G, "backup_buffer"));

	if (isset(ds_map_find_value(G, "audio")))
	    audio_destroy_stream(ds_map_find_value(G, "audio"));

	ds_map_destroy(G);
	var pos = ds_list_find_index(global.gmlvideo_instances, G);

	if (pos != -1)
	    ds_list_delete(global.gmlvideo_instances, pos);

	show_debug_message("DESTROY FRAMES MUST BE IMPLEMENTED");
}