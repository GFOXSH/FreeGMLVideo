function _gmlvideo_video_drawframe()
{
	var video = argument[0];
	var target_frame = argument[1];
	var manifest = ds_map_find_value(video, "manifest");
	var framebuffer = ds_map_find_value(video, "frame_buffer");
	var frame_count = ds_map_find_value(manifest, "frame_count");
	
	target_frame = clamp(target_frame, 0, frame_count - 1);
	
	var surf = ds_map_find_value(video, "frame_surface");
	if (!surface_exists(surf))
	{
		surf = surface_create(ds_map_find_value(manifest, "width"), ds_map_find_value(manifest, "height"));
		ds_map_set(video, "frame_surface", surf);
		ds_map_set(video, "frame_lastdrawn", -1);
	}
	
	var last_drawn = isset_default(ds_map_find_value(video, "frame_lastdrawn"), -1);
	var start_f = last_drawn + 1;
	var jumped = false;
	
	var kf_rate = ds_map_find_value(manifest, "keyframe_rate");
	var nearest_kf = 0;
	if (!is_undefined(kf_rate) && kf_rate > 0)
	{
		nearest_kf = target_frame - (target_frame % kf_rate);
	}
	
	if (target_frame < last_drawn || start_f < 0 || nearest_kf > last_drawn)
	{
		start_f = nearest_kf;
		jumped = true;
	}
	
	if (start_f <= target_frame)
	{
		var frameSizePrecalc = ds_map_find_value(manifest, "frameSizePrecalc");
		var start_offset = isset_default(ds_map_find_value(manifest, "start_frame"), 0);
		
		surface_set_target(surf);
		
		if (start_f == 0 || jumped)
		{
			draw_clear_alpha(c_black, 1.0);
		}
		
		for (var f = start_f; f <= target_frame; f++)
		{
			var frame_total_size = ds_list_find_value(frameSizePrecalc, f);
			if (frame_total_size > 0)
			{
				var b = -1;
				var need_delete = false;
				
				if (f < ds_list_size(framebuffer))
				{
					var fb_item = ds_list_find_value(framebuffer, f);
					if (fb_item != -1 && isset_equality(ds_get_embedded(fb_item, "status"), -3))
					{
						b = ds_get_embedded(fb_item, "buffer");
					}
				}
				
				if (b == -1 || !buffer_exists(b))
				{
					var frame_file = ds_map_find_value(video, "file_root") + "frame_" + string(start_offset + f) + ".dat";
					b = buffer_load(frame_file);
					need_delete = true;
				}
				
				if (b != -1 && buffer_exists(b))
				{
					_gmlvideo_drawVertexFrame(manifest, ds_get_embedded(manifest, "frameSize", f), b);
					if (need_delete)
						buffer_delete(b);
				}
			}
		}
		
		surface_reset_target();
		ds_map_set(video, "frame_lastdrawn", target_frame);
	}
}