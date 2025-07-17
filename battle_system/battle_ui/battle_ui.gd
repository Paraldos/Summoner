extends MarginContainer
@onready var action_btns: GridContainer = %ActionBtns

func _ready():
	for btn in action_btns.get_children():
		btn.disabled = true
		btn.visible = false
