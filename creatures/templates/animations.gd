extends Node2D

var parent : CreatureDisplay
var hit_offset = Vector2(-10, 2)
var attack_offset = Vector2(20, -5)
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	_offset_creature()

func _offset_creature():
	var display_offset = Vector2(1, 3)
	position += Vector2(
		rng.randi_range(display_offset.x, -display_offset.x),
		rng.randi_range(display_offset.y, -display_offset.y))

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
	tween.tween_property(self, 'position', target_pos, time)

func _play_animation(animation_name : String) -> void:
	var selected_animation = get_node(animation_name)
	for animation in get_children():
		animation.visible = selected_animation == animation
		if not animation is AnimatedSprite2D: continue
		animation.stop()
	if selected_animation is AnimatedSprite2D:
		selected_animation.play()
