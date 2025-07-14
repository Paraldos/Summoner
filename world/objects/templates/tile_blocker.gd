extends Polygon2D

func _ready() -> void:
	visible = false
	await Utils.timer(0.1)
	var tile = Utils.map.tile_map_floor.local_to_map(global_position)
	Utils.map.astar.set_point_solid(tile, true)
