varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main() {
    vec4 c = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	float g = (c.r+c.g+c.b)/3.0;
	gl_FragColor = vec4(g, g, g, c.a);
}
