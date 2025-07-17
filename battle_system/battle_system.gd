extends CanvasLayer

@onready var root: Control = %root
@onready var animation_player_root: AnimationPlayer = %AnimationPlayerRoot
@onready var warband_player: Node2D = %WarbandPlayer
@onready var warband_enemy: Node2D = %WarbandEnemy
var list_of_all_displays: Array[CreatureDisplay] = []
var list_of_player_displays: Array[CreatureDisplay] = []
var list_of_enemy_displays: Array[CreatureDisplay] = []
var turn_index: int
var active_display: CreatureDisplay
var active_creature: Creature
var active_action: Action
var win_message := preload('res://message_system/battle_won_message.tscn')
var lost_message := preload('res://message_system/battle_lost_message.tscn')

var target : Creature
var target_display : CreatureDisplay
var attacker : Creature

func _ready() -> void:
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE

func start_battle(battle : Battle):
	# animation
	animation_player_root.play("fade_in")
	# prep
	root.mouse_filter = Control.MOUSE_FILTER_STOP
	Utils.game_status = GlobalEnums.GameStatus.BATTLE
	# add warebands
	for display in list_of_all_displays:
		display.queue_free()
	list_of_all_displays = []
	list_of_player_displays = []
	list_of_enemy_displays = []
	warband_player.add_creatures(PlayerData.creatures)
	warband_enemy.add_creatures(battle.creatures.duplicate())
	# star first round
	SignalBus.disable_battle_ui.emit()
	await animation_player_root.animation_finished
	await Utils.timer(1.0)
	next_round()

func stop_battle():
	animation_player_root.play_backwards("fade_in")
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	Utils.game_status = GlobalEnums.GameStatus.EXPLORATION

########################################### turn and round
func next_round():
	turn_index = -1
	for creature in list_of_all_displays:
		creature.creature.roll_ini()
	list_of_all_displays.sort_custom(
		func(a, b): return a.creature.current_ini > b.creature.current_ini
	)
	next_turn()

func next_turn():
	if list_of_enemy_displays.all(func(d): return d.dead):
		Utils.display_message(win_message)
	elif list_of_player_displays.all(func(d): return d.dead):
		Utils.display_message(lost_message)
	else:
		turn_index += 1
		if active_display: active_display.disable()
		if list_of_all_displays.size() > turn_index:
			list_of_all_displays[turn_index].enable()
		else:
			next_round()
