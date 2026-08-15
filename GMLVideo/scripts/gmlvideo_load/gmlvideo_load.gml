function gmlvideo_load()
{
	var _file_path = argument[0];
	var _fn = filename_change_ext(filename_name(_file_path), "");
	var _ext = filename_ext(_file_path);
	var _failed = true;
	var _temp_dir = "_GMLVID_";
	var _vid_dir = _temp_dir + _fn + "\\";
	var _manifest = undefined;
	var _videoObject = undefined;

	if (_ext == ".vid")
	{
		if (!(directory_exists(_vid_dir) && file_exists(_vid_dir + "video.dat")))
		{
			var _archiveName = _fn + ".zip";
			file_copy(_file_path, working_directory + _archiveName);
			
			if (!directory_exists(_vid_dir))
				directory_create(_vid_dir);
			
			var _r = zip_unzip(working_directory + _archiveName, _vid_dir);
			file_delete(working_directory + _archiveName);
			
			if (_r > 0 && file_exists(_vid_dir + "video.dat"))
			{
				_failed = false;
			}
		}
		else
		{
			_failed = false;
		}
		
		if (!_failed)
		{
			var _manifest_file = _vid_dir + "video.dat";
			var _f = file_text_open_read(_manifest_file);
			var _manifestText = "";
			while (!file_text_eof(_f))
				_manifestText += file_text_readln(_f);
			file_text_close(_f);
			
			if (_manifestText != "")
			{
				_manifest = json_decode(_manifestText);
				var _ver = ds_map_find_value(_manifest, "version");
				if (!is_undefined(_ver) && _ver != 1003)
					show_error("Video seems to have been created with a different version of the converter. Video will be attempted to be played but compatability is not guarenteed", false);
			}
			else
			{
				_failed = true;
			}
		}
	}

	if (_failed)
	{
		if (!is_undefined(_manifest))
			ds_map_destroy(_manifest);
		return -1;
	}
	else
	{
		var _opts = undefined;
		if (argument_count > 1)
			_opts = argument[1];
		
		_videoObject = ds_map_create();
		ds_map_add(_videoObject, "frame", 0);
		ds_map_add(_videoObject, "frame_progress", 0);
		ds_map_add(_videoObject, "frame_lastinterval", current_time);
		ds_map_add(_videoObject, "speed", 1);
		ds_map_add(_videoObject, "frame_surface", -1);
		ds_map_add(_videoObject, "playing", 1);
		ds_map_add(_videoObject, "loop", 1);
		ds_map_add(_videoObject, "file_root", _vid_dir);
		ds_map_add(_videoObject, "autoplay", 1);
		ds_map_add(_videoObject, "seek", -1);
		
		if (!is_undefined(_opts))
		{
			var _opt_key = ds_map_find_first(_opts);
			var _opt_size = ds_map_size(_opts);
			for (var _o = 0; _o < _opt_size; _o++)
			{
				ds_map_set(_videoObject, _opt_key, ds_map_find_value(_opts, _opt_key));
				_opt_key = ds_map_find_next(_opts, _opt_key);
			}
			ds_map_destroy(_opts);
		}
		
		ds_map_add_map(_videoObject, "manifest", _manifest);
		
		var _frame_count = ds_map_find_value(_manifest, "frame_count");
		var _fb_list = ds_list_create();
		for (var _f_i = 0; _f_i < _frame_count; _f_i++)
			ds_list_add(_fb_list, -1);
		ds_map_add_list(_videoObject, "frame_buffer", _fb_list);
		
		var _audioLo = ds_map_find_value(_videoObject, "file_root") + "output_audio.ogg";
		if (file_exists(_audioLo))
		{
			var _audio_stream = audio_create_stream(_audioLo);
			ds_map_set(_videoObject, "audio", _audio_stream);
			var _audio_inst = audio_play_sound(_audio_stream, 1, true);
			ds_map_set(_videoObject, "audio_instance", _audio_inst);
			audio_pause_sound(_audio_inst);
		}
		
		ds_list_add(global.gmlvideo_instances, _videoObject);
		gmlvideo_video_play(_videoObject, ds_map_find_value(_videoObject, "autoplay"));
		return _videoObject;
	}
}