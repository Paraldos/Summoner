extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	_start()

func _start():
	animation_player.play("fade_in")

func _stop():
	animation_player.play_backwards("fade_in")
	await animation_player.animation_finished
	queue_free()
