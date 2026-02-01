extends Node
class_name Totem

@export var mesh: MeshInstance3D

var active_state = 0.0
var is_active : bool

func _process(delta):
	active_state = lerp(active_state, 1.0 if is_active else 0.0, delta * 2.0)
	mesh.material_override.set("emission_energy_multiplier", lerp(0.0, 16.0, active_state))
