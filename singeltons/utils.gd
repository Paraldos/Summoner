extends Node

var map : Node2D
var game_status = GlobalEnums.GameStatus.EXPLORATION

func timer(time: float):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return
