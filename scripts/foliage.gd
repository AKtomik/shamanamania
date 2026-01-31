@tool
extends Node3D

@export_range(0.1, 10.0, 0.1) var min_scale = 1.0
@export_range(0.1, 10.0, 0.1) var max_scale = 1.0

@export var random_rotation_y := false
@export var is_inited := false

func _ready():
	if not Engine.is_editor_hint(): return;
	is_inited = true
	if random_rotation_y: rotate_y(randf() * TAU)
	scale = Vector3.ONE * lerp(min_scale, max_scale, randf())
