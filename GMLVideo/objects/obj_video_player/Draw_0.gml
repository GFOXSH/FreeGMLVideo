var _vw = sprite_width - 5;
var _vh = sprite_height - 5;

for (var _i = 0; _i < room_width; _i += _vw)
{
	for (var _j = 0; _j < room_height; _j += _vh)
	{
		gmlvideo_video_draw(myvideo, _i, _j, sprite_width, sprite_height);
	}
}

draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(-1, -1, room_width + 1, room_height + 1, false);
draw_set_alpha(1);
draw_set_color(c_white);
gmlvideo_video_draw(myvideo, x, y, sprite_width, sprite_height);
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(-1, room_height - 50, room_width + 1, room_height + 1, false);
draw_set_color(c_white);
draw_text(0, room_height - 30, string_hash_to_newline("FPS: " + string(fps)));
draw_text(150, room_height - 30, string_hash_to_newline("TIME: " + string_format(gmlvideo_get_position(myvideo), 0, 2)));
draw_text(300, room_height - 30, string_hash_to_newline("LENGTH: " + string_format(gmlvideo_length(myvideo), 0, 2)));
draw_text(450, room_height - 30, string_hash_to_newline("SPEED: " + string_format(ds_map_find_value(myvideo, "speed"), 0, 2)));
draw_text(600, room_height - 30, string_hash_to_newline("VOLUME: " + string_format(gmlvideo_get_volume(myvideo), 0, 2)));