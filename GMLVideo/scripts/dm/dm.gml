function dm()
{
	var a = ds_map_create();

	for (var i = 0; i < argument_count; i += 2)
	    ds_map_set(a, argument[i], argument[i + 1]);

	return a;
}