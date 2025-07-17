extends Node2D

@export var parent : CreatureDisplay
@onready var progress_bar: TextureProgressBar = $ProgressBar

func _ready() -> void:
	SignalBus.update_hp_bar.connect(_on_update_hp_bar)
	_on_update_hp_bar()

func _on_update_hp_bar():
	if parent.dead: return
	progress_bar.max_value = parent.creature.max_hp
	progress_bar.value = parent.creature.current_hp
	if parent.creature.current_hp <= 0:
		parent.animations.death_animation()
		parent.dead = true
