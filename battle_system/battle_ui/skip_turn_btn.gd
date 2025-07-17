extends Btn

func _ready() -> void:
	SignalBus.enable_battle_ui.connect(_on_enable_battle_ui)
	SignalBus.disable_battle_ui.connect(_on_disable_battle_ui)

func _on_enable_battle_ui():
	disabled = false
	visible = true

func _on_disable_battle_ui():
	disabled = true

func _on_mouse_entered() -> void:
	SignalBus.update_battle_description.emit('Skip Turn')

func _on_mouse_exited() -> void:
	SignalBus.update_battle_description.emit('')

func _on_pressed() -> void:
	SignalBus.disable_battle_ui.emit()
	BattleSystem.next_turn()
