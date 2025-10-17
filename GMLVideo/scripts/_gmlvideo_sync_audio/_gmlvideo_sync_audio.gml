function _gmlvideo_sync_audio() {
	var video = argument0;
	var manifest = ds_map_find_value(video, "manifest");

	if (!is_undefined(ds_map_find_value(video, "audio_instance")))
	{
	    audio_sound_set_track_position(ds_map_find_value(video, "audio_instance"), ds_map_find_value(video, "frame") / ds_map_find_value(manifest, "target_fps"));
	    audio_sound_pitch(ds_map_find_value(video, "audio_instance"), ds_map_find_value(video, "speed"));
	}
}