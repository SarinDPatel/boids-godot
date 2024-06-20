shader_type canvas_item;
uniform vec4 my_color : source_color = vec4(.9, .5, .5, 1.0);
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	COLOR = mix(COLOR, my_color, .9);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
