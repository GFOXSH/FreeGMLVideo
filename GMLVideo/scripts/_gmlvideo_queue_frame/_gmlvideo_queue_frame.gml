function _gmlvideo_queue_frame()
{
	var index = argument[1];
	var video = argument[0];
	var framebuffer = ds_map_find_value(video, "frame_buffer");

	if (ds_list_find_value(framebuffer, index) == -1)
	{
	    var manifest = ds_map_find_value(video, "manifest");
	    var frameSize = ds_map_find_value(manifest, "frameSizePrecalc");
	    var start_frame = isset_default(ds_map_find_value(manifest, "start_frame"), 0);
	    var frame_total_size = ds_list_find_value(frameSize, index);
    
	    if (frame_total_size <= 0)
	        return 0;
    
	    var b = buffer_create(frame_total_size, buffer_fast, 1);
	    var frame_file = ds_map_find_value(video, "file_root") + "frame_" + string(start_frame + index) + ".dat";
	    var uuid = buffer_load_async(b, frame_file, 0, frame_total_size);
	    ds_map_add_map(global.gmlvideo_asyncAssoc, uuid, dm("frame_buffer", framebuffer, "frame_index", index, "buffer_index", b));
	    ds_list_set_map(framebuffer, index, dm("status", -2, "id", uuid));
	}
}