extends "res://charakters/charakter_template.gd"

var current_path: Array[Vector2i] = []
var move_speed := 100.0
var target_world_position: Vector2 = position

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('left_click'):
		_update_path()
	_move(delta)

func _update_path():
	var mous_pos = get_global_mouse_position()
	var clicked_tile = Utils.map.tile_map_floor.local_to_map(mous_pos)
	var current_tile = Utils.map.tile_map_floor.local_to_map(global_position)
	current_path = Utils.map.find_path(current_tile, clicked_tile)
	if current_path.size() > 0:
		current_path.remove_at(0)
		if current_path.size() > 0:
			target_world_position = Utils.map.tile_map_floor.map_to_local(current_path[0])

func _move(delta):
	if current_path.size() == 0: return
	var direction = (target_world_position - global_position).normalized()
	var velocity = move_speed * delta
	var distance_to_target = global_position.distance_to(target_world_position)
	if distance_to_target <= velocity:
		global_position = target_world_position
		current_path.remove_at(0)
		if current_path.size() > 0:
			target_world_position = Utils.map.tile_map_floor.map_to_local(current_path[0])
	else:
		global_position += direction * velocity
