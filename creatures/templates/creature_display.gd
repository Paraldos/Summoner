extends Node2D
class_name CreatureDisplay

@onready var animations: Node2D = $Animations
@onready var hp_bar: ProgressBar = %hpBar
@onready var button: Button = %Button
@onready var marker: Node2D = %Marker
@onready var target_marker: NinePatchRect = %TargetMarker
@onready var active_marker: NinePatchRect = %ActiveMarker

var rng = RandomNumberGenerator.new()
var display_offset = Vector2(1, 3)
var hit_offset = Vector2(-10, 2)
var attack_offset = Vector2(20, -5)
var position_index : int
var craeture_offset := Vector2.ZERO
var creature_data : Resource
var player_creature : bool = false

func _ready() -> void:
	## variables
	button.disabled = true
	target_marker.visible = false
	active_marker.visible = false
	rng.randomize()
	## prep creature
	_offset_creature(true)
	_init_faction(player_creature)
	_on_update_hp_bar()
	enable(false)
	## signals
	SignalBus.update_hp_bar.connect(_on_update_hp_bar)
	SignalBus.action_selected.connect(_on_action_selected)
	SignalBus.action_deselected.connect(_on_action_deselected)

func _on_action_selected():
	_on_action_deselected()
	if player_creature:
		if BattleSystem.currently_selected_action.target_player[position_index]:
			button.disabled = false
			target_marker.visible = true
	else:
		if BattleSystem.currently_selected_action.target_enemy[position_index]:
			button.disabled = false
			target_marker.visible = true

func _on_action_deselected():
	button.disabled = true
	target_marker.visible = false

func _on_update_hp_bar():
	hp_bar.max_value = creature_data.max_hp
	hp_bar.value = creature_data.current_hp

########################################### helper
func enable(new_status : bool = false):
	active_marker.visible = new_status

########################################### prep creature
func _init_faction(player_creature : bool):
	if player_creature:
		marker.modulate = Color('c65197')
	else:
		marker.modulate = Color('a53030')

func _offset_creature(create_new_offset := false):
	if create_new_offset:
		craeture_offset = Vector2(
		rng.randi_range(display_offset.x, -display_offset.x),
		rng.randi_range(display_offset.y, -display_offset.y))
	animations.position += craeture_offset

########################################### animations
func _hit_animation():
	await Utils.timer(0.1)
	_tween_pos(hit_offset, 0.1)
	_play_animation('Hit')

func _attack_animation():
	if rng.randi_range(1, 2) == 1:
		_play_animation('Attack1')
	else:
		_play_animation('Attack2')
	_tween_pos(attack_offset, 0.1)

func _death_animation():
	_play_animation('Death')

func _tween_pos(target_pos: Vector2, time: float):
	var tween = create_tween()
	tween.tween_property(animations, 'position', target_pos, time)

func _play_animation(animation_name : String) -> void:
	var selected_animation = animations.get_node(animation_name)
	for animation in animations.get_children():
		animation.visible = selected_animation == animation
		if not animation is AnimatedSprite2D: continue
		animation.stop()
	if selected_animation is AnimatedSprite2D:
		selected_animation.play()
