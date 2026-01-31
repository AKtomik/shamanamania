shader_type spatial;

uniform sampler2D albedo;

void vertex() {
	// Called for every vertex the material is visible on.
	VERTEX.y += sin((VERTEX.x * 10.0 + VERTEX.z * 10.0 + TIME / 2.0) * TAU) / 40.0 * VERTEX.y;
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = texture(albedo, UV).xyz;
	ALPHA = texture(albedo, UV).a;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
