extends Node
class_name Runes

class levelMaskResourceHistory:
	var array : Array[MaskResource]
var historyDictionnary : Dictionary[String, levelMaskResourceHistory]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	historyDictionnary = {}

func set_history(levelId : String, history : Array[MaskResource]) -> void:
	var levelHistory = levelMaskResourceHistory.new()
	levelHistory.array = history
	historyDictionnary[levelId] = levelHistory

func add_mask_to_history(levelId : String, mask : MaskResource) -> void:
	var levelHistory = historyDictionnary[levelId]
	levelHistory.array.append(mask)
	historyDictionnary[levelId] = levelHistory

func get_history_object(levelId : String) -> levelMaskResourceHistory:
	return historyDictionnary[levelId]
	
func get_history_parsed(levelId : String) -> String:
	return "TODO"
