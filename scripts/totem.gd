extends Node
class_name Totem

@onready var mesh: MeshInstance3D = $Mesh

var active_state = 0.0
var is_active : bool

func _process(delta):
	active_state = lerp(active_state, 1.0 if is_active else 0.0, delta * 3.0)
	#mesh.
