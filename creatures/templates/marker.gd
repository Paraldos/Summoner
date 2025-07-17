extends Node2D

@onready var target_marker: Sprite2D = %TargetMarker
@onready var active_marker: Line2D = %ActiveMarker
@onready var button: Button = %Button
@export var parent : CreatureDisplay

func _ready():
	modulate = Color('a53030')
	SignalBus.activate_display_marker.connect(_on_activate_display_marker)
	SignalBus.disable_battle_ui.connect(_on_disable_battle_ui)

func set_to_active(new_status : bool):
	active_marker.visible = new_status

func _on_activate_display_marker():
	button.disabled = true
	target_marker.visible = false
	parent.animations.modulate = Color('606060')
	if parent.dead: return
	if BattleSystem.active_display == parent: return
	if parent.belongs_to_wareband_of_player:
		if BattleSystem.active_action.allied_targets[parent.position_index]:
			button.disabled = false
			target_marker.visible = true
	else:
		if BattleSystem.active_action.enemy_targets[parent.position_index]:
			button.disabled = false
			target_marker.visible = true
			parent.animations.modulate = Color('e5e5e5')

func _on_disable_battle_ui():
	button.disabled = true
	target_marker.visible = false
	parent.animations.modulate = Color('ffffff')

func _on_button_pressed() -> void:
	BattleSystem.active_action.start(parent, BattleSystem.active_display)

func _on_button_mouse_entered() -> void:
	var name = parent.creature.title
	var type = Utils.get_enum_name(GlobalEnums.CreatureTypes, parent.creature.type)
	SignalBus.update_battle_description.emit('%s (%s)' % [name, type])
	if !button.disabled:
		parent.animations.modulate = Color('ffffff')

func _on_button_mouse_exited() -> void:
	SignalBus.update_battle_description.emit('')
	if !button.disabled:
		parent.animations.modulate = Color('e5e5e5')
