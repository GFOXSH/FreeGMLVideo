function _gmlvideo_video_framebuffer_to_vertexbuffer()
{
	var frameSize = argument[0];
	var frameBuffer = argument[1];
	var s = ds_list_size(frameSize);
	var n = 0;
	var bytesPerVertex = 4;
	var vertex_vid = ds_map_find_value(global.gmlvideo, "vertex_vid");
	var vb;

	for (var i = 0; i < s; i++)
	{
	    var thisFrameSize = ds_list_find_value(frameSize, i);
    
	    if (thisFrameSize > 0)
	        vb[i] = vertex_create_buffer_from_buffer_ext(frameBuffer, vertex_vid, n, thisFrameSize / bytesPerVertex);
	    else
	        vb[i] = -1;
    
	    n += thisFrameSize;
	}

	return vb;
}