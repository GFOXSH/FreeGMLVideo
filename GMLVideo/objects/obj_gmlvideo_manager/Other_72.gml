var iid = ds_map_find_value(async_load, "id");
var framebuffer_data = ds_map_find_value(global.gmlvideo_asyncAssoc, iid);

if (!is_undefined(framebuffer_data))
{
    var fb_list = ds_map_find_value(framebuffer_data, "frame_buffer");
    var f_idx = ds_map_find_value(framebuffer_data, "frame_index");
    var b_idx = ds_map_find_value(framebuffer_data, "buffer_index");
    var target_item = ds_list_find_value(fb_list, f_idx);

    if (ds_map_find_value(async_load, "status"))
    {
        if (target_item != -1)
        {
            ds_map_set(target_item, "buffer", b_idx);
            ds_map_set(target_item, "status", -3);
        }
    }
    else
    {
        show_debug_message("Failed to load buffer");
        buffer_delete(b_idx);
        if (target_item != -1)
            ds_map_destroy(target_item);
        ds_list_set(fb_list, f_idx, -1);
    }
    
    ds_map_destroy(framebuffer_data);
    ds_map_delete(global.gmlvideo_asyncAssoc, iid);
}