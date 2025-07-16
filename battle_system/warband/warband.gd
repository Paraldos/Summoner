extends Node2D

@onready var leader_marker: Marker2D = %LeaderMarker
@onready var creatures: Marker2D = %Creatures
@export var player_warband := false

func add_creatures(list_of_creatures : Array[Creature]):
	for position_index in list_of_creatures.size():
		var creature_data = list_of_creatures[position_index]
		if creature_data == null: return
		add_creature(creature_data, position_index)

func add_creature(creature_data : Creature, position_index : int):
	## create creature
	var creature_display = creature_data.display.instantiate()
	creature_display.position_index = position_index
	creature_display.creature_data = creature_data
	creature_display.player_creature = player_warband
	## logistic
	creatures.add_child(creature_display)
	BattleSystem.list_of_all_involved_creatures.append(creature_display)
