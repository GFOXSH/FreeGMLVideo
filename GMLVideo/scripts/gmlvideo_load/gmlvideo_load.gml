function gmlvideo_load()
{
	var file_path = argument[0];
	var fn = filename_change_ext(filename_name(file_path), "");
	var ext = filename_ext(file_path);
	var failed = 1;
	var temp_dir = "_GMLVID_";
	var vid_dir = temp_dir + fn + "\\";
	var manifest = undefined;
	var videoObject = undefined;

	do
	{
	    if (ext == ".vid")
	    {
	        if !(directory_exists(vid_dir) && file_exists(vid_dir + "video.dat"))
	        {
	            var archiveName = fn + ".zip";
	            file_copy(file_path, working_directory + archiveName);
            
	            if (!directory_exists(vid_dir))
	                directory_create(vid_dir);
            
	            var r = zip_unzip(working_directory + archiveName, vid_dir);
	            file_delete(working_directory + archiveName);
            
	            if (r <= 0)
	                break;
	        }
        
	        var manifest_file = vid_dir + "video.dat";
	        if (!file_exists(manifest_file))
	            break;
	            
	        var f = file_text_open_read(manifest_file);
	        var manifestText = "";
	        while (!file_text_eof(f))
	            manifestText += file_text_readln(f);
	        file_text_close(f);
        
	        if (manifestText == "")
	            break;
        
	        manifest = json_decode(manifestText);
        
	        var ver = ds_map_find_value(manifest, "version");
	        if (!is_undefined(ver) && ver != 1003)
	            show_error("Video seems to have been created with a different version of the converter. Video will be attempted to be played but compatability is not guarenteed", 0);
        
	        failed = 0;
	    }
	}
	until (1);

	if (failed)
	{
	    if (!is_undefined(manifest))
	        ds_map_destroy(manifest);
    
	    return -1;
	}
	else
	{
	    var opts = undefined;
	    if (argument_count > 1)
	        opts = argument[1];
    
	    videoObject = ds_map_create();
	    ds_map_add(videoObject, "frame", 0);
	    ds_map_add(videoObject, "frame_progress", 0);
	    ds_map_add(videoObject, "frame_lastinterval", current_time);
	    ds_map_add(videoObject, "speed", 1);
	    ds_map_add(videoObject, "frame_surface", -1);
	    ds_map_add(videoObject, "playing", 1);
	    ds_map_add(videoObject, "loop", 1);
	    ds_map_add(videoObject, "file_root", vid_dir);
	    ds_map_add(videoObject, "autoplay", 1);
	    ds_map_add(videoObject, "seek", -1);
    
	    if (!is_undefined(opts))
	    {
	        var opt_key = ds_map_find_first(opts);
	        var opt_size = ds_map_size(opts);
	        for (var o = 0; o < opt_size; o++)
	        {
	            ds_map_set(videoObject, opt_key, ds_map_find_value(opts, opt_key));
	            opt_key = ds_map_find_next(opts, opt_key);
	        }
	        ds_map_destroy(opts);
	    }
    
	    ds_map_add_map(videoObject, "manifest", manifest);
	    
	    var frame_count = ds_map_find_value(manifest, "frame_count");
	    var fb_list = ds_list_create();
	    for (var f_i = 0; f_i < frame_count; f_i++)
	        ds_list_add(fb_list, -1);
	    ds_map_add_list(videoObject, "frame_buffer", fb_list);
	    
	    var audioLo = ds_map_find_value(videoObject, "file_root") + "output_audio.ogg";
	    if (file_exists(audioLo))
	    {
	        ds_map_set(videoObject, "audio", audio_create_stream(audioLo));
	        ds_map_set(videoObject, "audio_instance", audio_play_sound(ds_map_find_value(videoObject, "audio"), 1, true));
	        audio_pause_sound(ds_map_find_value(videoObject, "audio_instance"));
	    }
    
	    ds_list_add(global.gmlvideo_instances, videoObject);
	    gmlvideo_video_play(videoObject, ds_map_find_value(videoObject, "autoplay"));
	    return videoObject;
	}
}