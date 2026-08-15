function _gmlvideo_video_framejump()
{
	var _video = argument[0];
	var _frameinc = 1;
	var _progress = 0;
	var _index = ds_map_find_value(_video, "frame");
	var _manifest = ds_map_find_value(_video, "manifest");
	var _framecount = ds_map_find_value(_manifest, "frame_count");
	var _loop = bool(ds_map_find_value(_video, "loop"));
	var _audioSync = 0;

	if (argument_count > 1)
	{
		_frameinc = argument[1];
		if (argument_count > 2)
			_progress = argument[2];
	}

	_index += _frameinc;

	if (_index >= _framecount)
	{
		if (_loop)
		{
			_index = _index % _framecount;
			_audioSync = 1;
		}
		else
		{
			gmlvideo_video_stop(_video);
		}
	}

	ds_map_set(_video, "frame", _index);
	ds_map_set(_video, "frame_progress", _progress);
	ds_map_set(_video, "frame_redraw", 1);

	if (_audioSync)
		_gmlvideo_sync_audio(_video);
}