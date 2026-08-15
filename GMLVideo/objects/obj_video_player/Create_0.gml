game_set_speed(30, gamespeed_fps);
gmlvideo_flushcache();
myvideo = -1;

myvideo = gmlvideo_load("threelaws_gms2.vid");

if (myvideo == -1)
{
	var _selected_file = get_open_filename("vid|*.vid", "");
	if (_selected_file != "")
		myvideo = gmlvideo_load(_selected_file);
}

if (myvideo == -1)
	show_error("VIDEO FILE FAILED TO LOAD", true);

os_powersave_enable(false);
x = (room_width / 2) - (sprite_width / 2);
y = (room_height / 2) - (sprite_height / 2);