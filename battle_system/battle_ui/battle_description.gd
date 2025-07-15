extends PanelContainer

@onready var label: Label = %Label

func _ready() -> void:
	SignalBus.update_battle_description.connect(_on_update_battle_description)

func _on_update_battle_description(text : String):
	label.text = text
