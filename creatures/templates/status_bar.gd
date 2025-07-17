extends ProgressBar

@export var parent : CreatureDisplay

func _ready() -> void:
	SignalBus.update_hp_bar.connect(_on_update_hp_bar)
	_on_update_hp_bar()

func _on_update_hp_bar():
	if parent.dead: return
	if value != parent.creature.current_hp:
		var difference = value - parent.creature.current_hp
		print(difference)
		max_value = parent.creature.max_hp
		value = parent.creature.current_hp
	if parent.creature.current_hp <= 0:
		parent.animations.death_animation()
		parent.dead = true
