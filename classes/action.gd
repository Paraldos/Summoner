class_name Action
extends Resource

@export var title: String = "Action"
@export var description: String = "Action Description"
@export var stance = GlobalEnums.Stances.ATTACK
@export var type = GlobalEnums.AttackTypes.SLASHING
@export var icon : CompressedTexture2D
@export var allied_targets : Array[bool] = [
	true,
	true,
	true
]
@export var enemy_targets : Array[bool] = [
	true,
	true,
	true
]
@export_range(0.0, 1.0, 0.05) var dmg := 1.0
@export_range(0.0, 1.0, 0.05) var heal := 1.0


func start(target : CreatureDisplay, attacker : CreatureDisplay):
	SignalBus.disable_battle_ui.emit()
	BattleSystem.attacker = attacker.creature
	BattleSystem.target = target.creature
	BattleSystem.target_display = target
	target.animations.hit_animation()
	attacker.animations.attack_animation()

func use():
	var target = BattleSystem.target
	var attacker = BattleSystem.attacker
	# inflict dmg
	var dmg = attacker.attack * dmg
	dmg -= target.defense
	if target.resistances.has(type):
		dmg *= 0.5
	target.current_hp -= dmg
	BattleSystem.target_display.spawn_dmg_popup(dmg)
	# inflict status
	# heald
	SignalBus.update_hp_bar.emit()
	SignalBus.return_display_to_idle_animation.emit()
	BattleSystem.next_turn()
