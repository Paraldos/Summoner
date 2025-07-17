extends Node

@export var parent : CreatureDisplay

func start_turn():
	await Utils.timer(2.0)
	var possible_actions = _prep_possible_actions()
	for action in possible_actions:
		if action == null: continue
		var valid_targets : Array = _get_valid_targets(action)
		if valid_targets:
			BattleSystem.active_action = action
			action.start(valid_targets.pop_front(), parent)
			return

func _prep_possible_actions() -> Array[Action]:
	var possible_actions = parent.creature.actions.duplicate()
	possible_actions.shuffle()
	return possible_actions

func _get_valid_targets(action : Action) -> Array:
	var valid_targets := []
	for player_display in BattleSystem.list_of_player_displays:
		if player_display.dead: continue
		if action.enemy_targets[player_display.position_index]:
			valid_targets.push_back(player_display)
	for enemy_display in BattleSystem.list_of_enemy_displays:
		if enemy_display.dead: continue
		if action.allied_targets[enemy_display.position_index]:
			valid_targets.push_back(enemy_display)
	return valid_targets
