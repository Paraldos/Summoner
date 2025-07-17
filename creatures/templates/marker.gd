extends Node2D

@onready var target_marker: Sprite2D = %TargetMarker
@onready var active_marker: Line2D = %ActiveMarker
@onready var button: Button = %Button
@export var parent : CreatureDisplay

func _ready():
	button.disabled = true
	modulate = Color('a53030')
	SignalBus.action_selected.connect(_on_action_selected)
	SignalBus.action_deselected.connect(_on_action_deselected)
	SignalBus.start_action.connect(_on_action_deselected)

func set_to_active(new_status : bool):
	if parent.disabled: return
	active_marker.visible = new_status

func _on_action_selected():
	_on_action_deselected()
	if parent.disabled: return
	if BattleSystem.active_display == parent: return
	if parent.belongs_to_wareband_of_player:
		if BattleSystem.active_action.target_allied[parent.position_index]:
			button.disabled = false
			target_marker.visible = true
	else:
		if BattleSystem.active_action.target_enemy[parent.position_index]:
			button.disabled = false
			target_marker.visible = true

func _on_action_deselected():
	button.disabled = true
	target_marker.visible = false

func _on_button_pressed() -> void:
	BattleSystem.active_action.start(parent, BattleSystem.active_display)
	SignalBus.start_action.emit()
