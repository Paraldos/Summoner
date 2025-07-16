extends ProgressBar

@export var parent : CreatureDisplay

func _ready() -> void:
	SignalBus.update_hp_bar.connect(_on_update_hp_bar)
	_on_update_hp_bar()

func _on_update_hp_bar():
	max_value = parent.creature.max_hp
	value = parent.creature.current_hp
