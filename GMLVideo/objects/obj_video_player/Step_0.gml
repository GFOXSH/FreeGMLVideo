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
			var progress = int64(keyboard_lastchar) / 10
			gmlvideo_video_seekto(myvideo, progress * gmlvideo_length(myvideo))
			break

		case ord("V"):
			var spd = ds_map_find_value(myvideo, "speed");
			gmlvideo_video_speed(myvideo, spd - 0.5)
			break

		case ord("B"):
			var spd = ds_map_find_value(myvideo, "speed");
			gmlvideo_video_speed(myvideo, spd + 0.5)
			break
		
		case ord("S"):
			gmlvideo_video_stop(myvideo)
			break
			
		case vk_space:
			gmlvideo_video_play(myvideo)
			break
			
		case ord("A"):
			var volume = gmlvideo_get_volume(myvideo)
			volume -= 0.1
			gmlvideo_video_volume(myvideo, volume)
			break
			
		case ord("Q"):
			var volume = gmlvideo_get_volume(myvideo)
			volume += 0.1
			gmlvideo_video_volume(myvideo, volume)
			break
			
		case ord("Z"):
			gmlvideo_video_volume(myvideo)
			break
	}
}
