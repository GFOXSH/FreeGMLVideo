function ds_get_embedded()
{
	var _ds = argument[0];
	var c = argument_count;

	for (var i = 1; i < c; i++)
	{
	    if (is_undefined(_ds))
	        return undefined;
    
	    if (is_string(argument[i]))
	        _ds = ds_map_find_value(_ds, argument[i]);
	    else
	        _ds = ds_list_find_value(_ds, argument[i]);
	}

	return _ds;
}