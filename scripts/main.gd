extends Node3D

@export var mask_scene : PackedScene
@export var shaman_scene : PackedScene
@export var shaman_circle_radius := 3.0

@onready var camera_3d: Camera3D = $Camera3D
@onready var camera_target: Node3D = $CameraTarget
@export_range(0.1, 2.0, 0.01) var camera_sensitivity := 1.0

@onready var shamans_container: Node3D = $ShamansContainer
@onready var masks_container: Node3D = $MasksContainer

var shamans : Array[Shaman]
var masks : Array[Mask]

var selected_mask: Mask
var is_animating := false
@export var levels: Array[LevelResource]

func _ready():
	load_level(levels[0])

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position() - get_viewport().get_visible_rect().size / 2.0
	camera_3d.look_at(camera_target.global_position + Vector3(mouse_position.x, 0, mouse_position.y) / 1000.0 * camera_sensitivity)
	

func create_mask(pos: Vector3)-> Mask:
	var mask := mask_scene.instantiate() as Mask
	masks_container.add_child(mask)
	masks.push_back(mask)
	mask.global_position = pos
	mask.look_at(Vector3.ZERO)
	mask.clicked.connect(func():
		click_mask(mask)
	)
	return mask

func create_shaman(pos: Vector3) -> Shaman:
	var shaman := shaman_scene.instantiate() as Shaman
	shamans_container.add_child(shaman)
	shamans.push_back(shaman)
	shaman.global_position = pos
	shaman.look_at(Vector3.ZERO)
	return shaman

func click_mask(mask: Mask):
	if is_animating: return
	if not selected_mask:
		# select mask
		selected_mask = mask
		mask.selected = true
		return;
	selected_mask.selected = false
	if selected_mask == mask:
		# unselect mask
		selected_mask = null
	else:
		# swap with selected mask
		var target_shaman = selected_mask.assigned_shaman
		selected_mask.assigned_shaman = mask.assigned_shaman
		mask.assigned_shaman = target_shaman
		is_animating = true
		await get_tree().create_timer(1.0).timeout
		is_animating = false
		apply_effect(selected_mask)
		selected_mask = null

func apply_effect(mask: Mask):
	match mask.mask_resource.effect:
		MaskResource.Effect.None:
			pass
		MaskResource.Effect.SwapNeighbours:
			var neighbours := get_neighbour_masks(mask)
			var lmask = neighbours[0].assigned_shaman
			neighbours[0].assigned_shaman = neighbours[1].assigned_shaman
			neighbours[1].assigned_shaman = lmask
		MaskResource.Effect.Clockwise:
			var omasks := get_ordered_masks()
			for i in masks.size():
				var left_index = i - 1
				if i < 0: left_index = masks.size() - 1
				omasks[i].assigned_shaman =  shamans[left_index]

func get_neighbour_masks(mask: Mask) -> Array[Mask]:
	var masks: Array[Mask]
	var index = shamans.find(mask.assigned_shaman)
	var left_index = index - 1
	if left_index < 0: left_index = shamans.size() - 1
	var right_index = (index + 1) % shamans.size()
	masks.push_back(shamans[left_index].assigned_mask)
	masks.push_back(shamans[right_index].assigned_mask)
	return masks

func get_ordered_masks() -> Array:
	return shamans.map(func(s: Shaman): return s.assigned_mask)
	
func load_level(level_resource: LevelResource):
	for s in shamans: s.queue_free()
	shamans.clear()
	
	for m in masks: m.queue_free()
	masks.clear()
	
	var count :float= level_resource.shamans_needed_masks.size()
	for i in count:
		var shaman : Shaman = create_shaman(Vector3.LEFT.rotated(Vector3.UP, i / count * TAU - PI / 2.0) * shaman_circle_radius)
		shaman.needed_mask = level_resource.shamans_needed_masks[i]
		var mask = create_mask(shaman.mask_position.global_position)
		mask.assigned_shaman = shaman
		mask.load_resource(level_resource.shamans_starting_masks[i])
