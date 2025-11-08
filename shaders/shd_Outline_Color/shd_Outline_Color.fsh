varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 v_outline_color;

void main() {
    vec4 c = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor = vec4(v_outline_color.rgb, c.a);
}
