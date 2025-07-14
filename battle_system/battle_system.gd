extends CanvasLayer

@onready var control_root: Control = %ControlRoot
@onready var animation_player_root: AnimationPlayer = %AnimationPlayerRoot

func _ready() -> void:
	control_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	start_battle()

func start_battle():
	animation_player_root.play("fade_in")
	control_root.mouse_filter = Control.MOUSE_FILTER_STOP
	Utils.game_status = GlobalEnums.GameStatus.BATTLE

func stop_battle():
	animation_player_root.play_backwards("fade_in")
	control_root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	Utils.game_status = GlobalEnums.GameStatus.EXPLORATION
