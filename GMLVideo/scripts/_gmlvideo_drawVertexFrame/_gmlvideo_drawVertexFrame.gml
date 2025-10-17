function _gmlvideo_drawVertexFrame()
{
	var vb = argument1;
	var manifest = argument0;
	var width = ds_map_find_value(manifest, "width");
	var height = ds_map_find_value(manifest, "height");
	var blockSize = ds_map_find_value(manifest, "block_size");
	var blockCount = ds_list_size(ds_get_embedded(manifest, "frameSize", 0));
	var blockCount_W = ceil(width / blockSize);
	shader_set(sh_gmlvideo_helper);
	var shdpos = shader_get_uniform(sh_gmlvideo_helper, "offset_pos");

	for (var i = 0; i < blockCount; i++)
	{
	    if (array_get(vb, i) == -1)
	        continue;
    
	    var block_x = i % blockCount_W;
	    var block_y = i div blockCount_W;
	    shader_set_uniform_f(shdpos, block_x * blockSize, block_y * blockSize);
	    vertex_submit(array_get(vb, i), pr_pointlist, -1);
	}

	shader_reset();
}