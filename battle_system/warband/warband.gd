extends Node2D

@onready var leader_marker: Marker2D = %LeaderMarker
@onready var position_marker = [
	%BackMarker,
	%MiddleMarker,
	%FrontMarker
]

func add_creatures(list_of_creatures : Array[Creature]):
	for index in list_of_creatures.size():
		var creature_data = list_of_creatures[index]
		if creature_data == null: return
		add_creature(creature_data, index)

func add_creature(creature_data : Creature, index : int):
	## create creature
	var creature_display = creature_data.display.instantiate()
	creature_display.index = index
	creature_display.position = position_marker[index].position
	creature_display.creature_data = creature_data
	## logistic
	add_child(creature_display)
	BattleSystem.list_of_all_involved_creatures.append(creature_display)
