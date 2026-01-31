@tool
extends Node3D
class_name Shaman

@export var mask_position: Node3D
@export var correct_mask_particles: GPUParticles3D

var needed_mask : MaskResource
var assigned_mask: Mask :
	set(value):
		assigned_mask = value
		update_particles()

func update_particles():
	correct_mask_particles.emitting = assigned_mask.mask_resource == needed_mask

func _process(delta: float) -> void:
	look_at(Vector3.ZERO)
