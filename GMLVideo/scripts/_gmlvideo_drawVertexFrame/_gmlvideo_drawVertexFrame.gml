function _gmlvideo_drawVertexFrame()
{
	var manifest = argument[0];
	var frameSize = argument[1];
	var frameBuffer = argument[2];

	if (is_undefined(frameBuffer) || !buffer_exists(frameBuffer))
		return;

	var width = ds_map_find_value(manifest, "width");
	var blockSize = ds_map_find_value(manifest, "block_size");
	var blockCount = ds_list_size(frameSize);
	var blockCount_W = ceil(width / blockSize);

	var old_alpha = draw_get_alpha();
	draw_set_alpha(1.0);
	var old_blend = gpu_get_blendmode();
	gpu_set_blendmode(bm_normal);

	buffer_seek(frameBuffer, buffer_seek_start, 0);

	for (var i = 0; i < blockCount; i++)
	{
		var thisFrameSize = ds_list_find_value(frameSize, i);
		if (thisFrameSize <= 0)
			continue;

		var block_x = (i % blockCount_W) * blockSize;
		var block_y = (i div blockCount_W) * blockSize;
		var num_pixels = thisFrameSize div 4;

		repeat (num_pixels)
		{
			var r = buffer_read(frameBuffer, buffer_u8);
			var g = buffer_read(frameBuffer, buffer_u8);
			var b = buffer_read(frameBuffer, buffer_u8);
			var pos = buffer_read(frameBuffer, buffer_u8);

			var px = block_x + (pos % blockSize);
			var py = block_y + (pos div blockSize);

			draw_point_colour(px, py, make_colour_rgb(r, g, b));
		}
	}

	gpu_set_blendmode(old_blend);
	draw_set_alpha(old_alpha);
}