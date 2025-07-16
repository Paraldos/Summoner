extends MarginContainer
@onready var action_btns: GridContainer = %ActionBtns

func _ready():
	SignalBus.start_action.connect(_on_start_action)

func _on_start_action():
	for btn in action_btns.get_children():
		btn.disabled = true
