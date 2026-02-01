extends Resource
class_name MaskResource

@export var available_move: AvailableMove 
@export var effect: Effect 
@export var model_scene: PackedScene
@export var color: Color

@export var audio : AudioStream
@export var symbol := "▽○⎔"

enum AvailableMove {
	AdjacentCell,
	All
}

enum Effect {
	None,
	SwapNeighbours,
	Clockwise
}
