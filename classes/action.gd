class_name Action
extends Resource

@export var title: String = "Action"
@export var description: String = "Action Description"
@export var stance = GlobalEnums.Stances.ATTACK
@export var type = GlobalEnums.AttackTypes.SLASHING
@export var icon : CompressedTexture2D

@export_range(0.0, 1.0, 0.05) var dmg := 1.0
@export_range(0.0, 1.0, 0.05) var heal := 1.0
