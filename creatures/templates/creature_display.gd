extends Node2D
class_name CreatureDisplay

@onready var ai_controller: Node = %AIController
@onready var marker_for_dmg_popup: Marker2D = %MarkerForDmgPopup
@onready var animations: Node2D = $Animations
@onready var marker: Node2D = %Marker

var dmg_popup = preload('res://creatures/templates/dmg_popup.tscn')
var rng = RandomNumberGenerator.new()
var position_index : int
var creature : Resource
var belongs_to_wareband_of_player : bool = false
var dead = false

func _ready() -> void:
	rng.randomize()
	update_position()
	disable()

func enable():
	if dead:
		BattleSystem.next_turn()
	elif belongs_to_wareband_of_player:
		BattleSystem.active_display = self
		BattleSystem.active_creature = creature
		marker.set_to_active(true)
		SignalBus.enable_battle_ui.emit()
	else:
		ai_controller.start_turn()

func disable():
	marker.set_to_active(false)

func update_position():
	position.x = position_index * 32

func spawn_dmg_popup(dmg : int):
	var popup = dmg_popup.instantiate()
	popup.dmg = dmg
	popup.global_position = marker_for_dmg_popup.global_position
	BattleSystem.add_child(popup)
