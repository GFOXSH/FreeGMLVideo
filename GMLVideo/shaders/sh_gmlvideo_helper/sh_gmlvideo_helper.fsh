//
// GMLVideo helper shader
//

varying vec4 v_vColour;

void main()
{
    gl_FragColor = vec4(v_vColour.rgb, 1.0);
}
