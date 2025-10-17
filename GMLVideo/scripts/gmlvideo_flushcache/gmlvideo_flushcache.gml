function gmlvideo_flushcache()
{
	var f = file_find_first("_GMLVID*", 16);

	while (f != "")
	{
	    directory_destroy(f);
	    f = file_find_next();
	}

	file_find_close();
}