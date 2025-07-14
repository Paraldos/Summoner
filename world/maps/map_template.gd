extends Node2D

@onready var tile_map_floor: TileMapLayer = %TileMapFloor

var astar := AStarGrid2D.new()

func _ready() -> void:
	Utils.map = self
	_astar_base_setup()
	_astar_map_setup()

func _astar_base_setup():
	var used_rect = tile_map_floor.get_used_rect()
	var origin = used_rect.position
	var size = used_rect.size
	astar.region = Rect2i(origin, size)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()

func _astar_map_setup() -> void:
	var used_cells := tile_map_floor.get_used_cells()
	for y in range(astar.region.position.y, astar.region.end.y):
		for x in range(astar.region.position.x, astar.region.end.x):
			var cell := Vector2i(x, y)
			var solid := not used_cells.has(cell)
			astar.set_point_solid(cell, solid)

func find_path(start: Vector2i, goal: Vector2i) -> Array[Vector2i]:
	if not astar.is_in_boundsv(start) or not astar.is_in_boundsv(goal):
		return []
	if astar.is_point_solid(goal):
		return []
	return astar.get_id_path(start, goal)
