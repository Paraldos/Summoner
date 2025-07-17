extends Node2D

@onready var label: Label = %Label
var dmg : int

func _ready() -> void:
	label.text = "%s" % dmg
