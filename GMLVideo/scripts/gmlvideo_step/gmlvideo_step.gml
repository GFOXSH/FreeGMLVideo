function gmlvideo_step() {
	if (!instance_exists(GMLVIDEO_MANAGER))
	    instance_create_depth(0, 0, 0, GMLVIDEO_MANAGER);
}