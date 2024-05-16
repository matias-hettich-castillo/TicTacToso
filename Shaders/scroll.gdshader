shader_type canvas_item;

uniform float x_speed = 0.4;
uniform float y_speed = 0.5;

void vertex() {
	// Called for every vertex the material is visible on.
	UV.x += TIME * x_speed;
	UV.y += TIME * y_speed;
}
