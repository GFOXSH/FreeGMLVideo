function gmlvideo_flushcache()
{
	var _f = file_find_first("_GMLVID*", fa_directory);

	while (_f != "")
	{
		directory_destroy(_f);
		_f = file_find_next();
	}

	file_find_close();
}