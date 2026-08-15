function _gmlvideo_frame_is_keyframe()
{
	var _manifest = argument[0];
	var _i = argument[1];
	var _rate = ds_map_find_value(_manifest, "keyframe_rate");
	return (_i == 0 || (!is_undefined(_rate) && _rate > 0 && (_i % _rate) == 0));
}