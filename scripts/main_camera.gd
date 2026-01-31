@tool
extends Camera3D
@onready var camera_target: Node3D = $"../CameraTarget"

func _process(delta: float) -> void:
	look_at(camera_target.global_position)
