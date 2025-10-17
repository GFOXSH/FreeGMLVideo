function ds_list_set_all()
{
	var l = argument0;
	var s = ds_list_size(l);

	for (var i = 0; i < s; i++)
	    ds_list_set(l, i, argument1);
}