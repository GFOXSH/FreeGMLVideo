function frame_is_keyframe() {
	var manifest = argument[0];
	var i = argument[1];
	return i == 0 || (!is_undefined(ds_map_find_value(manifest, "keyframe_rate")) && (i % ds_map_find_value(manifest, "keyframe_rate")) == 0);
}