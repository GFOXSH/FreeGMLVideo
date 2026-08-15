if (myvideo != -1)
	gmlvideo_step();

if (keyboard_check_pressed(vk_anykey))
{
	switch (keyboard_key)
	{
		case ord("0"):
		case ord("1"):
		case ord("2"):
		case ord("3"):
		case ord("4"):
		case ord("5"):
		case ord("6"):
		case ord("7"):
		case ord("8"):
		case ord("9"):
			var _progress = int64(keyboard_lastchar) / 10;
			gmlvideo_video_seekto(myvideo, _progress * gmlvideo_length(myvideo));
			break;

		case ord("V"):
			var _spd_down = ds_map_find_value(myvideo, "speed");
			gmlvideo_video_speed(myvideo, _spd_down - 0.1);
			break;

		case ord("B"):
			var _spd_up = ds_map_find_value(myvideo, "speed");
			gmlvideo_video_speed(myvideo, _spd_up + 0.1);
			break;
		
		case ord("S"):
			gmlvideo_video_stop(myvideo);
			break;
			
		case vk_space:
			gmlvideo_video_play(myvideo);
			break;
			
		case ord("A"):
			var _vol_down = gmlvideo_get_volume(myvideo);
			_vol_down -= 0.1;
			gmlvideo_video_volume(myvideo, _vol_down);
			break;
			
		case ord("Q"):
			var _vol_up = gmlvideo_get_volume(myvideo);
			_vol_up += 0.1;
			gmlvideo_video_volume(myvideo, _vol_up);
			break;
			
		case ord("Z"):
			gmlvideo_video_volume(myvideo);
			break;
			
		case vk_f4:
			window_set_fullscreen(!window_get_fullscreen());
			break;
	}
}