function ds_map_merge_isset() {
	var map1 = argument0;
	var map2 = argument1;
	var size = ds_map_size(map2);
	var key = ds_map_find_first(map2);

	for (var i = 0; i < size; i++)
	{
	    var v = ds_map_find_value(map2, key);
    
	    if (isset(v))
	        ds_map_set(map1, key, ds_map_find_value(map2, key));
    
	    key = ds_map_find_next(map2, key);
	}

	return map1;
}