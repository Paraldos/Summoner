extends Node2D

@onready var leader_marker: Marker2D = %LeaderMarker
@onready var creatures: Marker2D = %Creatures
@export var player_warband := false

func add_creatures(list_of_creatures : Array[Creature]):
	for position_index in list_of_creatures.size():
		var creature = list_of_creatures[position_index].duplicate()
		if creature == null: return
		add_creature(creature, position_index)

func add_creature(creature : Creature, position_index : int):
	## create creature
	var creature_display = creature.display.instantiate()
	creature_display.position_index = position_index
	creature_display.creature = creature
	creature_display.belongs_to_wareband_of_player = player_warband
	## logistic
	creatures.add_child(creature_display)
	BattleSystem.list_of_all_displays.append(creature_display)
	if player_warband:
		BattleSystem.list_of_player_displays.append(creature_display)
	else:
		BattleSystem.list_of_enemy_displays.append(creature_display)
