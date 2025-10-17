var iid = ds_map_find_value(async_load, "id");
var framebuffer_data = ds_map_find_value(global.gmlvideo_asyncAssoc, iid);

if (!is_undefined(framebuffer_data))
{
    if (ds_map_find_value(async_load, "status"))
    {
        ds_set_embedded(ds_map_find_value(framebuffer_data, "frame_buffer"), ds_map_find_value(framebuffer_data, "buffer_index"), ds_map_find_value(framebuffer_data, "frame_index"), "buffer");
        ds_set_embedded(ds_map_find_value(framebuffer_data, "frame_buffer"), -3, ds_map_find_value(framebuffer_data, "frame_index"), "status");
    }
    else
    {
        show_debug_message("Failed to load buffer");
        buffer_delete(ds_map_find_value(framebuffer_data, "buffer_index"));
        ds_set_embedded(ds_map_find_value(framebuffer_data, "frame_buffer"), -1, ds_map_find_value(framebuffer_data, "frame_index"));
    }
    
    ds_map_destroy(ds_map_find_value(global.gmlvideo_asyncAssoc, iid));
    ds_map_delete(global.gmlvideo_asyncAssoc, iid);
}
