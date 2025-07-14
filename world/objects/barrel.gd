extends Sprite2D

@onready var tile_marker: Polygon2D = %TileMarker

func _ready() -> void:
	tile_marker.queue_free()
	await Utils.timer(0.1)
	var tile = Utils.map.tile_map_floor.local_to_map(global_position)
	Utils.map.astar.set_point_solid(tile, true)
