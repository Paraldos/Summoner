extends Node2D

@export var parent : CreatureDisplay
var hit_offset := Vector2(-10, 5)
var attack_offset := Vector2(5, -10)
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	_offset_creature()
	if parent.belongs_to_wareband_of_player == false:
		attack_offset.y *= -1
		hit_offset.y *= -1
	_play_animation('Idle')
	SignalBus.return_display_to_idle_animation.connect(_on_return_display_to_idle_animation)

func _on_return_display_to_idle_animation():
	if parent.dead: return
	if parent.creature.current_hp > 0:
		_tween_pos(Vector2.ZERO, 0.2)
		_play_animation('Idle')
	else:
		await _tween_pos(Vector2.ZERO, 0.2)
		death_animation()
		parent.dead = true

func _offset_creature():
	var display_offset = Vector2(1, 3)
	position += Vector2(
		rng.randi_range(display_offset.x, -display_offset.x),
		rng.randi_range(display_offset.y, -display_offset.y))

func _tween_pos(target_pos: Vector2, time: float):
	var tween = create_tween()
	tween.tween_property(self, 'position', target_pos, time)
	await tween.finished
	return

func _play_animation(animation_name : String) -> void:
	var selected_animation = get_node(animation_name)
	for animation in get_children():
		animation.visible = selected_animation == animation
		if not animation is AnimatedSprite2D: continue
		animation.stop()
	if selected_animation is AnimatedSprite2D:
		selected_animation.play()

########################################### animations
func hit_animation():
	if parent.dead: return
	await Utils.timer(0.1)
	_tween_pos(hit_offset, 0.1)
	_play_animation('Hit')

func attack_animation():
	if parent.dead: return
	if rng.randi_range(1, 2) == 1:
		_play_animation('Attack1')
	else:
		_play_animation('Attack2')
	_tween_pos(attack_offset, 0.1)

func death_animation():
	if parent.dead: return
	_play_animation('Death')

########################################### animation finished
func _on_attack_1_animation_finished() -> void:
	BattleSystem.active_action.use()

func _on_attack_2_animation_finished() -> void:
	BattleSystem.active_action.use()
