varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 c = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = vec4(c.r*0.5, 0.0, 0.0, c.a);
}
