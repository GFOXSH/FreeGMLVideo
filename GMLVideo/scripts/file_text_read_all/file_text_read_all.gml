function file_text_read_all()
{
	if (!file_exists(argument0))
	{
	    show_debug_message("Could not load file: " + string(argument0));
	    return "";
	}

	var f = file_text_open_read(argument0);
	var s = "";

	while (!file_text_eof(f))
	    s += file_text_readln(f);

	file_text_close(f);
	return s;
}