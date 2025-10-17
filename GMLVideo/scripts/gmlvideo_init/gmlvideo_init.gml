function gmlvideo_init() {
	vertex_format_begin();
	vertex_format_add_custom(vertex_type_color, vertex_usage_color);
	var vertex_vid = vertex_format_end();
	global.gmlvideo = dm("buffer_frames", 2, "vertex_vid", vertex_vid);
	global.gmlvideo_instances = ds_list_create();
	global.gmlvideo_asyncAssoc = dm();
}