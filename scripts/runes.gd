extends Node
class_name Runes

class levelMaskResourceHistory:
	var array : Array[MaskResource]
var historyDictionnary : Dictionary[String, levelMaskResourceHistory]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	historyDictionnary = {}

func setHistory(levelId : String, history : Array[MaskResource]):
	var levelHistory = levelMaskResourceHistory.new()
	levelHistory.array = history
	historyDictionnary[levelId] = levelHistory
	
func addMaskToHistory(levelId : String, mask : MaskResource):
	var levelHistory = historyDictionnary[levelId]
	levelHistory.array.append(mask)
	historyDictionnary[levelId] = levelHistory
	
func getHistory(levelId : String):
	return historyDictionnary[levelId]
