function _gmlvideo_drawVertexFrame()
{
	var _manifest = argument[0];
	var _frameSize = argument[1];
	var _frameBuffer = argument[2];

	if (is_undefined(_frameBuffer) || !buffer_exists(_frameBuffer))
		return;

	var _width = ds_map_find_value(_manifest, "width");
	var _blockSize = ds_map_find_value(_manifest, "block_size");
	var _blockCount = ds_list_size(_frameSize);
	var _blockCount_W = ceil(_width / _blockSize);

	var _old_alpha = draw_get_alpha();
	draw_set_alpha(1.0);
	var _old_blend = gpu_get_blendmode();
	gpu_set_blendmode(bm_normal);

	buffer_seek(_frameBuffer, buffer_seek_start, 0);

	for (var _i = 0; _i < _blockCount; _i++)
	{
		var _thisFrameSize = ds_list_find_value(_frameSize, _i);
		if (_thisFrameSize <= 0)
			continue;

		var _block_x = (_i % _blockCount_W) * _blockSize;
		var _block_y = (_i div _blockCount_W) * _blockSize;
		var _num_pixels = _thisFrameSize div 4;

		repeat (_num_pixels)
		{
			var _r = buffer_read(_frameBuffer, buffer_u8);
			var _g = buffer_read(_frameBuffer, buffer_u8);
			var _b = buffer_read(_frameBuffer, buffer_u8);
			var _pos = buffer_read(_frameBuffer, buffer_u8);

			var _px = _block_x + (_pos % _blockSize);
			var _py = _block_y + (_pos div _blockSize);

			draw_point_colour(_px, _py, make_colour_rgb(_r, _g, _b));
		}
	}

	gpu_set_blendmode(_old_blend);
	draw_set_alpha(_old_alpha);
}