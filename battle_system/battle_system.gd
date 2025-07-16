extends CanvasLayer

@onready var root: Control = %root
@onready var animation_player_root: AnimationPlayer = %AnimationPlayerRoot
@onready var warband_player: Node2D = %WarbandPlayer
@onready var warband_enemy: Node2D = %WarbandEnemy
var list_of_all_involved_creatures: Array[CreatureDisplay] = []
var turn_index: int
var active_display: CreatureDisplay
var active_creature: Creature
var active_action: Action

var target : Creature
var attacker : Creature

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
	next_round()

func stop_battle():
	animation_player_root.play_backwards("fade_in")
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	Utils.game_status = GlobalEnums.GameStatus.EXPLORATION

########################################### turn and round
func next_round():
	turn_index = -1
	for creature in list_of_all_involved_creatures:
		creature.creature.roll_ini()
	list_of_all_involved_creatures.sort_custom(func(a, b):
		return a.creature.current_ini > b.creature.current_ini
	)
	next_turn()

func next_turn():
	SignalBus.action_deselected.emit()
	if active_display:
		active_display.enable(false)
	turn_index += 1
	if turn_index > list_of_all_involved_creatures.size() -1:
		next_round()
	else:
		active_display = list_of_all_involved_creatures[turn_index]
		active_creature = list_of_all_involved_creatures[turn_index].creature
		active_display.enable(true)
		SignalBus.update_action_btn.emit()
