gmlvideo_step();

switch keyboard_lastchar
{
	case "0":
	case "1":
	case "2":
	case "3":
	case "4":
	case "5":
	case "6":
	case "7":
	case "8":
	case "9":
		gmlvideo_video_seekto(myvideo, int64(keyboard_lastchar))
		keyboard_lastchar = ""
		break
		
	case "-":
		var spd = ds_map_find_value(myvideo, "speed");
		gmlvideo_video_speed(myvideo, spd - 0.5)
		keyboard_lastchar = ""
		break

	case "=":
		var spd = ds_map_find_value(myvideo, "speed");
		gmlvideo_video_speed(myvideo, spd + 0.5)
		keyboard_lastchar = ""
		break
}