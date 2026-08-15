function _gmlvideo_queue_frame()
{
	var video = argument[0];
	var index = argument[1];
	var framebuffer = ds_map_find_value(video, "frame_buffer");

	if (ds_list_find_value(framebuffer, index) == -1)
	{
	    var manifest = ds_map_find_value(video, "manifest");
	    var frameSize = ds_map_find_value(manifest, "frameSizePrecalc");
	    var start_frame = ds_map_find_value(manifest, "start_frame");
	    if (is_undefined(start_frame)) start_frame = 0;
	    
	    var frame_total_size = ds_list_find_value(frameSize, index);
    
	    if (frame_total_size <= 0)
	        return 0;
    
	    var b = buffer_create(frame_total_size, buffer_fast, 1);
	    var frame_file = ds_map_find_value(video, "file_root") + "frame_" + string(start_frame + index) + ".dat";
	    var uuid = buffer_load_async(b, frame_file, 0, frame_total_size);
	    
	    var assoc_map = ds_map_create();
	    ds_map_add(assoc_map, "frame_buffer", framebuffer);
	    ds_map_add(assoc_map, "frame_index", index);
	    ds_map_add(assoc_map, "buffer_index", b);
	    ds_map_add_map(global.gmlvideo_asyncAssoc, uuid, assoc_map);
	    
	    var fb_map = ds_map_create();
	    ds_map_add(fb_map, "status", -2);
	    ds_map_add(fb_map, "id", uuid);
	    ds_list_set(framebuffer, index, fb_map);
	    ds_list_mark_as_map(framebuffer, index);
	}
}