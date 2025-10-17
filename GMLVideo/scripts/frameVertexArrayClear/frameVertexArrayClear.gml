function frameVertexArrayClear()
{
	var vb = argument0;

	for (var i = 0; i < array_length_1d(vb); i++)
	{
	    if (vb[i] != -1)
	        vertex_delete_buffer(vb[i]);
	}
}