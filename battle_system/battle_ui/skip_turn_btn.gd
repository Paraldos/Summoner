extends Btn

func _on_mouse_entered() -> void:
	SignalBus.update_battle_description.emit('Skip Turn')

func _on_mouse_exited() -> void:
	SignalBus.update_battle_description.emit('')

func _on_pressed() -> void:
	BattleSystem.next_turn()
