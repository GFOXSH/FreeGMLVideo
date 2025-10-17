var vw = sprite_width - 5;
var vh = sprite_height - 5;

for (var i = 0; i < room_width; i += vw)
{
    for (var j = 0; j < room_height; j += vh)
        gmlvideo_video_draw(myvideo, i, j, sprite_width, sprite_height);
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
draw_text(10, room_height - 30, string_hash_to_newline("FPS: " + string(fps)));
draw_text(170, room_height - 30, string_hash_to_newline("TIME: " + string_format(gmlvideo_get_position(myvideo), 0, 2)));
draw_text(330, room_height - 30, string_hash_to_newline("LENGTH: " + string_format(gmlvideo_length(myvideo), 0, 2)));
draw_text(490, room_height - 30, string_hash_to_newline("SPEED: " + string_format(ds_map_find_value(myvideo, "speed"), 0, 2)));