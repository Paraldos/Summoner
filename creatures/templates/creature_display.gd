extends Node2D
class_name CreatureDisplay

@onready var ai_controller: Node = %AIController
@onready var animations: Node2D = $Animations
@onready var hp_bar: ProgressBar = %hpBar
@onready var marker: Node2D = %Marker

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
