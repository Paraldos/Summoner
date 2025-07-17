extends Btn

@export var btn_index := 0
var action = null

func _ready() -> void:
	super()
	visible = false
	disabled = true
	SignalBus.enable_battle_ui.connect(_on_enable_battle_ui)
	SignalBus.disable_battle_ui.connect(_on_disable_battle_ui)
	SignalBus.unselect_all_action_btns.connect(_on_unselect_all_action_btns)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('abort'):
		BattleSystem.active_action = null
		button_pressed = false

func _on_unselect_all_action_btns():
	button_pressed = false

func _on_disable_battle_ui():
	disabled = true

func _on_enable_battle_ui():
	var creature_actions = BattleSystem.active_display.creature.actions
	button_pressed = false
	if btn_index < creature_actions.size() && creature_actions[btn_index]:
		action = creature_actions[btn_index]
		icon = action.icon
	else:
		action = null
	visible = action != null
	disabled = !visible

func _on_pressed() -> void:
	BattleSystem.active_action = action
	SignalBus.activate_display_marker.emit()
	button_pressed = true

func _on_mouse_entered() -> void:
	if action:
		var title: String = action.title.to_upper()
		var type : String = Utils.get_enum_name(GlobalEnums.AttackTypes, action.type)
		var description : String = action.description
		SignalBus.update_battle_description.emit(
			"%s (%s)\n%s" % [title, type, description]
		)

func _on_mouse_exited() -> void:
	SignalBus.update_battle_description.emit('')
