class_name Creature
extends Resource

@export var title : String = "Creature"
@export var type = GlobalEnums.CreatureTypes.Undead
#@export var actions : Array[Action] = []
@export var display: PackedScene
@export var resistances : Array[GlobalEnums.AttackTypes] = []
@export var description: String = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,"

@export var xp: int = 0
@export var level: int = 1

@export var attack: int = 45
@export var crit_chance : int = 4
@export var defense: int = 35

@export var max_hp: int = 40
@export var current_hp: int = max_hp

func add_XP(amount : int):
	xp += amount
	if xp >= xp_for_next_level():
		level_up()

func xp_for_next_level():
	return level * 100

func level_up():
	xp -= xp_for_next_level()
	attack = ceil(attack * 1.2)
	crit_chance += 1
	defense = ceil(defense * 1.2)
