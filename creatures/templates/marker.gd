extends Node2D

@onready var target_marker: NinePatchRect = %TargetMarker
@onready var active_marker: NinePatchRect = %ActiveMarker
@onready var button: Button = %Button

@export var parent : CreatureDisplay

func _ready():
	button.disabled = true
	if parent.player_creature:
		modulate = Color('c65197')
	else:
		modulate = Color('a53030')
	SignalBus.action_selected.connect(_on_action_selected)
	SignalBus.action_deselected.connect(_on_action_deselected)

func set_to_active(new_status : bool):
	active_marker.visible = new_status

func _on_action_selected():
	_on_action_deselected()
	if parent.player_creature:
		if BattleSystem.currently_selected_action.target_player[parent.position_index]:
			button.disabled = false
			target_marker.visible = true
	else:
		if BattleSystem.currently_selected_action.target_enemy[parent.position_index]:
			button.disabled = false
			target_marker.visible = true

func _on_action_deselected():
	button.disabled = true
	target_marker.visible = false
