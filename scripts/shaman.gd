extends Node3D
class_name Shaman

@onready var mask_position: Node3D = $MaskPosition
@onready var correct_mask_particles: GPUParticles3D = $CorrectMaskParticles

var needed_mask : MaskResource
var assigned_mask: Mask :
	set(value):
		assigned_mask = value
		if assigned_mask:
			print(assigned_mask.mask_resource, " ", needed_mask, assigned_mask.mask_resource == needed_mask)
		correct_mask_particles.emitting = assigned_mask.mask_resource == needed_mask
