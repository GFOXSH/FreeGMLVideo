




//
// Simple passthrough fragment shader
//
varying vec4 v_vColour;

void main()
{
    gl_FragColor = vec4(v_vColour.r, v_vColour.g, v_vColour.b, 1.0);
}
