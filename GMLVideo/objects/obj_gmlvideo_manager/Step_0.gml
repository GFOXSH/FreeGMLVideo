var videos = global.gmlvideo_instances;
var s = ds_list_size(videos);
var d = delta_time / 1000000;
var frames_to_buffer = ds_map_find_value(global.gmlvideo, "buffer_frames");

for (var i = 0; i < s; i++)
{
    var video = ds_list_find_value(videos, i);
    var manifest = ds_map_find_value(video, "manifest");
    var video_fps = ds_map_find_value(manifest, "target_fps");
    var frame_count = ds_map_find_value(manifest, "frame_count");
    
    var seek = ds_map_find_value(video, "seek");
    if (seek >= 0)
    {
        var target_frame = floor(seek * video_fps);
        target_frame = clamp(target_frame, 0, frame_count - 1);
        
        var framebuffer = ds_map_find_value(video, "frame_buffer");
        var q_size = ds_list_size(framebuffer);
        for (var u = 0; u < q_size; u++)
        {
            var fb_item = ds_list_find_value(framebuffer, u);
            if (fb_item != -1)
            {
                var status = ds_map_find_value(fb_item, "status");
                if (status == -3)
                {
                    var b = ds_map_find_value(fb_item, "buffer");
                    if (!is_undefined(b) && buffer_exists(b))
                        buffer_delete(b);
                }
                else
                {
                    ds_map_delete(global.gmlvideo_asyncAssoc, ds_map_find_value(fb_item, "id"));
                }
                
                ds_map_destroy(fb_item);
                ds_list_set(framebuffer, u, -1);
            }
        }
        
        ds_map_set(video, "frame", target_frame);
        ds_map_set(video, "frame_progress", 0);
        ds_map_set(video, "frame_redraw", 1);
        ds_map_replace(video, "seek", -1);
        
        _gmlvideo_video_drawframe(video, target_frame);
        _gmlvideo_sync_audio(video);
    }
    
    if (ds_map_find_value(video, "playing"))
    {
        ds_map_set(video, "frame_progress", ds_map_find_value(video, "frame_progress") + (ds_map_find_value(video, "speed") * d * video_fps));
        
        if (ds_map_find_value(video, "frame_progress") >= 1)
        {
            var advance = max(floor(ds_map_find_value(video, "frame_progress")), 1);
            ds_map_set(video, "frame_progress", frac(ds_map_find_value(video, "frame_progress")));
            _gmlvideo_video_framejump(video, advance, ds_map_find_value(video, "frame_progress"));
        }
    }
    
    if (os_is_paused())
        ds_map_set(video, "frame_redraw", 1);
    
    var u_s = ds_list_size(ds_map_find_value(video, "frame_buffer"));
    
    for (var u = 0; u < u_s; u++)
    {
        var u_frame = (u + ds_map_find_value(video, "frame")) % frame_count;
        
        if (u <= frames_to_buffer)
            _gmlvideo_queue_frame(video, u_frame);
        else
            _gmlvideo_dequeue_frame(video, u_frame);
    }
}