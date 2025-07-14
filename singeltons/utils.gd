extends Node

var map : Node2D

func timer(time: float):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return
