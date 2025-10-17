function gmlvideo_load()
{
	var fn = filename_removeExt(filename_name(argument[0]));
	var ext = filename_ext(argument[0]);
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
	            var archiveName = filename_removeExt(filename_name(argument[0])) + ".zip";
	            file_copy(argument[0], working_directory + archiveName);
            
	            if (!directory_exists(vid_dir))
	                directory_create(vid_dir);
            
	            var r = zip_unzip(working_directory + archiveName, vid_dir);
	            file_delete(working_directory + archiveName);
            
	            if (r <= 0)
	                break;
	        }
        
	        var manifestText = file_text_read_all(vid_dir + "video.dat");
        
	        if (manifestText == "")
	            break;
        
	        manifest = json_decode(manifestText);
        
	        if (isset(ds_map_find_value(manifest, "version")) && ds_map_find_value(manifest, "version") != 1003)
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
    
	    videoObject = dm("frame", 0, "frame_progress", 0, "frame_lastinterval", current_time, "speed", 1, "frame_surface", -1, "backup_buffer", -1, "playing", 1, "loop", 1, "file_root", vid_dir, "autoplay", 1, "seek", -1);
    
	    if (!is_undefined(opts))
	    {
	        ds_map_merge(videoObject, opts);
	        ds_map_destroy(opts);
	    }
    
	    ds_map_add_map(videoObject, "manifest", manifest);
	    ds_map_add_list(videoObject, "frame_buffer", ds_list_create());
	    ds_set_embedded(videoObject, -1, "frame_buffer", ds_map_find_value(manifest, "frame_count") - 1);
	    ds_list_set_all(ds_map_find_value(videoObject, "frame_buffer"), -1);
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