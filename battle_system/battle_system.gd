extends CanvasLayer

@onready var root: Control = %root
@onready var animation_player_root: AnimationPlayer = %AnimationPlayerRoot
@onready var warband_player: Node2D = %WarbandPlayer
@onready var warband_enemy: Node2D = %WarbandEnemy
var list_of_all_involved_creatures: Array[CreatureDisplay] = []
var turn_index: int
var currently_active_creature: CreatureDisplay

func _ready() -> void:
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE

func start_battle(battle : Battle):
	# animation
	animation_player_root.play("fade_in")
	# prep
	root.mouse_filter = Control.MOUSE_FILTER_STOP
	Utils.game_status = GlobalEnums.GameStatus.BATTLE
	list_of_all_involved_creatures = []
	# add warebands
	warband_player.add_creatures(PlayerData.creatures)
	warband_enemy.add_creatures(battle.creatures.duplicate())
	new_round()

func stop_battle():
	animation_player_root.play_backwards("fade_in")
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	Utils.game_status = GlobalEnums.GameStatus.EXPLORATION

########################################### turn and round
func new_round():
	turn_index = -1
	for creature in list_of_all_involved_creatures:
		creature.creature_data.roll_ini()
	list_of_all_involved_creatures.sort_custom(func(a, b):
		return a.creature_data.current_ini > b.creature_data.current_ini
	)
	new_turn()

func new_turn():
	## update index
	turn_index += 1
	if turn_index > list_of_all_involved_creatures.size():
		new_round()
	currently_active_creature = list_of_all_involved_creatures[turn_index]
	## enable creature
	currently_active_creature.activate(true)
