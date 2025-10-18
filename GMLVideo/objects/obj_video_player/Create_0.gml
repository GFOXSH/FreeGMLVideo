game_set_speed(30, gamespeed_fps);
gmlvideo_flushcache();
myvideo = -1;
loadFile = 0;

if (loadFile)
    myvideo = gmlvideo_load(get_open_filename("vid|*.vid", ""));
else
    myvideo = gmlvideo_load("threelaws_gms2.vid");

if (myvideo == -1)
    show_error("VIDEO FILE FAILED TO LOAD", 1);

os_powersave_enable(0);
x = (room_width / 2) - (sprite_width / 2);
y = (room_height / 2) - (sprite_height / 2);
