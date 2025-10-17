function filename_removeExt()
{
	var s = argument0;
	var l = string_length(s);
	var i = l;
	var lastchar = "";

	while (i > 0 && lastchar != ".")
	{
	    lastchar = string_char_at(s, i);
	    i--;
	}

	if (i == 1)
	    return "";
	else
	    return string_copy(s, 0, i);
}