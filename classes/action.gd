class_name Action
extends Resource

@export var title: String = "Action"
@export var description: String = "Action Description"
@export var stance = GlobalEnums.Stances.ATTACK
@export var type = GlobalEnums.AttackTypes.SLASHING
@export var icon : CompressedTexture2D
@export var target_player : Array[bool] = [
	true,
	true,
	true
]
@export var target_enemy : Array[bool] = [
	true,
	true,
	true
]
@export_range(0.0, 1.0, 0.05) var dmg := 1.0
@export_range(0.0, 1.0, 0.05) var heal := 1.0


func start(target : CreatureDisplay, attacker : CreatureDisplay):
	BattleSystem.attacker = attacker.creature
	BattleSystem.target = target.creature
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
	target.current_hp -= max(0, dmg)
	# inflict status
	# heald
	pass
	SignalBus.update_hp_bar.emit()
	SignalBus.end_action.emit()
