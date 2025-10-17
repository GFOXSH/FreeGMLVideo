function ds_set_embedded() {
	var _ds = argument[0];
	var c = argument_count;

	for (var i = 2; i < c; i++)
	{
	    if (is_string(argument[i]))
	    {
	        if (i == (c - 1))
	            ds_map_set(_ds, argument[i], argument[1]);
	        else
	            _ds = ds_map_find_value(_ds, argument[i]);
	    }
	    else if (i == (c - 1))
	    {
	        ds_list_set(_ds, argument[i], argument[1]);
	    }
	    else
	    {
	        _ds = ds_list_find_value(_ds, argument[i]);
	    }
	}
}