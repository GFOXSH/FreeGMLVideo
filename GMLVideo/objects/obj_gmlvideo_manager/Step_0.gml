var videos = global.gmlvideo_instances;
var s = ds_list_size(videos);
var d = delta_time / 1000000;
var frames_to_buffer = ds_map_find_value(global.gmlvideo, "buffer_frames");

for (var i = 0; i < s; i++)
{
    var video = ds_list_find_value(videos, i);
    var video_fps = ds_get_embedded(video, "manifest", "target_fps");
    var frame_count = ds_get_embedded(video, "manifest", "frame_count");
    
    var seek = ds_map_find_value(video, "seek");
    if (seek >= 0)
    {
        var target_frame = floor(seek * video_fps);
        target_frame = clamp(target_frame, 0, frame_count - 1);
        
        var last_drawn = isset_default(ds_map_find_value(video, "frame_lastdrawn"), -1);
        var start_f = last_drawn + 1;
        
        var manifest = ds_map_find_value(video, "manifest");
        var has_surface = surface_exists(ds_map_find_value(video, "frame_surface"));
        
        if (!has_surface)
        {
            ds_map_set(video, "frame_surface", surface_create(ds_map_find_value(manifest, "width"), ds_map_find_value(manifest, "height")));
            start_f = 0;
        }
        
        if (target_frame < last_drawn || start_f < 0)
        {
            start_f = 0;
        }
        
		if (start_f <= target_frame)
		{
		    var frameSize = ds_map_find_value(manifest, "frameSizePrecalc");
		    var start_offset = isset_default(ds_map_find_value(manifest, "start_frame"), 0);
    
		    var old_blend = gpu_get_blendmode();
		    gpu_set_blendmode(bm_normal);
    
		    surface_set_target(ds_map_find_value(video, "frame_surface"));
    
		    if (start_f == 0)
		    {
		        draw_clear_alpha(c_black, 1.0); 
		    }
    
		    for (var f = start_f; f <= target_frame; f++)
		    {
		        var frame_total_size = ds_list_find_value(frameSize, f);
		        if (frame_total_size > 0)
		        {
		            var frame_file = ds_map_find_value(video, "file_root") + "frame_" + string(start_offset + f) + ".dat";
		            var b = buffer_load(frame_file);
            
		            if (b != -1)
		            {
		                var vb = _gmlvideo_video_framebuffer_to_vertexbuffer(ds_get_embedded(manifest, "frameSize", f), b);
		                _gmlvideo_drawVertexFrame(manifest, vb);
		                _gmlvideo_frameVertexArrayClear(vb);
		                buffer_delete(b);
		            }
		        }
		    }

		    surface_reset_target();
		    gpu_set_blendmode(old_blend);
    
		    ds_map_set(video, "frame_lastdrawn", target_frame);
		}
        
        var framebuffer = ds_map_find_value(video, "frame_buffer");
        var q_size = ds_list_size(framebuffer);
        for (var u = 0; u < q_size; u++)
        {
            var fb_item = ds_list_find_value(framebuffer, u);
            if (fb_item != -1)
            {
                var status = ds_get_embedded(fb_item, "status");
                if (status == -3)
                {
                    var b = ds_get_embedded(fb_item, "buffer");
                    if (!is_undefined(b) && buffer_exists(b)) buffer_delete(b);
                }
                else
                {
                    ds_map_delete(global.gmlvideo_asyncAssoc, ds_get_embedded(fb_item, "id"));
                }
                
                ds_map_destroy(fb_item);
                ds_list_set(framebuffer, u, -1);
            }
        }
        
        ds_map_set(video, "frame", target_frame);
        ds_map_set(video, "frame_progress", 0);
        ds_map_set(video, "frame_redraw", 1);
        ds_map_replace(video, "seek", -1);
        
        _gmlvideo_sync_audio(video);
    }
    
    if (ds_map_find_value(video, "playing"))
    {
        ds_map_set(video, "frame_progress", ds_map_find_value(video, "frame_progress") + (ds_map_find_value(video, "speed") * d * video_fps));
        
        if (ds_map_find_value(video, "frame_progress") >= 1)
        {
            if (ds_map_find_value(video, "frame_lastdrawn") != ds_map_find_value(video, "frame") && _gmlvideo_frame_is_keyframe(ds_map_find_value(video, "manifest"), ds_map_find_value(video, "frame")))
            {
                ds_map_set(video, "frame_progress", 1);
                ds_map_set(video, "frame_redraw", 1);
            }
            else
            {
                var advance = max(floor(ds_map_find_value(video, "frame_progress")), 1);
                ds_map_set(video, "frame_progress", frac(ds_map_find_value(video, "frame_progress")));
                _gmlvideo_video_framejump(video, advance, ds_map_find_value(video, "frame_progress"));
            }
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