extends Node2D
class_name CreatureDisplay

@onready var animations: Node2D = $Animations
@onready var hp_bar: ProgressBar = %hpBar
@onready var marker: Node2D = %Marker

var rng = RandomNumberGenerator.new()
var position_index : int
var creature : Resource
var player_creature : bool = false
var disabled = false

func _ready() -> void:
	rng.randomize()
	update_position()
	enable(false)

func enable(new_status : bool = false):
	marker.set_to_active(new_status)

func update_position():
	position.x = position_index * 32
