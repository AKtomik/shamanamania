extends Resource
class_name MaskResource

@export var available_move: AvailableMove 
@export var effect: Effect 
@export var model_scene: PackedScene

enum AvailableMove {
	AdjacentCell,
	All
}

enum Effect {
	None,
	SwapNeighbours,
	Clockwise
}
