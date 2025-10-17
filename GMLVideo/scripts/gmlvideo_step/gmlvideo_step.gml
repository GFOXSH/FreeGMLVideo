function gmlvideo_step()
{
	if (!instance_exists(obj_gmlvideo_magager))
	    instance_create_depth(0, 0, 0, obj_gmlvideo_magager);
}