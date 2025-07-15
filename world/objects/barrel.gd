extends Sprite2D

@export var battle : Battle

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		BattleSystem.start_battle(battle)

func _on_area_2d_mouse_entered() -> void:
	material.set_shader_parameter("outline_color", Color.RED)

func _on_area_2d_mouse_exited() -> void:
	material.set_shader_parameter("outline_color", Color.TRANSPARENT)
