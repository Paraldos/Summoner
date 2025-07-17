extends "res://message_system/message_template.gd"

func _on_btn_pressed() -> void:
	BattleSystem.stop_battle()
	_stop()
