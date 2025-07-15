extends Node

var map : Node2D
var game_status = GlobalEnums.GameStatus.EXPLORATION
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func timer(time: float):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return

func get_enum_name(enum_dict: Dictionary, value: int) -> String:
	for key in enum_dict:
		if enum_dict[key] == value:
			return key.capitalize()
	return "UNKNOWN"

func roll_dice(sides : int = 20):
	return rng.randi_range(1, sides)
