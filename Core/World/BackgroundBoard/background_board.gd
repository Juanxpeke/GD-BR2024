class_name BackgroundBoard
extends TileMap

enum Layer {
	WORLD_VISUAL_LAYER,
	WORLD_FREE_LAYER,
}

var astar : AStar2D = AStar2D.new()

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# NOTE: tile_set.tile_size = Vector2i(Domino.SPRITE_WIDTH, Domino.SPRITE_WIDTH)
	for cell in get_used_cells(Layer.WORLD_VISUAL_LAYER):
		set_cell(Layer.WORLD_FREE_LAYER, cell, 0, Vector2i(0, 0))

# Public

#region Base Cell Methods

# Given a cell center, returns a unique identifier. It uses improved Szudzik pair 
# algorithm to calculate the ID, and first transforms the center position to the
# correspondent cell, in order reduce the IDs values
func get_cell_id(cell_center : Vector2) -> int:
	var cell : Vector2i = get_cell(cell_center)
	var x : int = cell.x
	var y : int = cell.y
	
	var a := x * 2 if x >= 0 else (x * -2) - 1
	var b := y * 2 if y >= 0 else (y * -2) - 1
	var c = (a * a) + a + b if a >= b else (b * b) + a
	
	if a >= 0 and b < 0 or b >= 0 and a < 0:
		return -c - 1
	
	return c

# Given a position in the board, it returns the cell that covers that position
func get_cell(board_position : Vector2) -> Vector2i:
	return local_to_map(to_local(board_position))

# Given a cell in the board, it returns the center position of the cell
func get_cell_center(cell : Vector2i) -> Vector2:
	return global_position + map_to_local(cell)
	
# Given a position in the board, it returns the center position of the cell that
# covers that position
func get_cell_centerp(board_position : Vector2) -> Vector2:
	return get_cell_center(get_cell(board_position))

#endregion

#region Free Areas 

# Returns the center of a random free area of cells of size N x M in the world
func get_free_area_center(N : int, M : int) -> Vector2:
	var free_cells = get_used_cells(Layer.WORLD_FREE_LAYER)
	free_cells.shuffle()
	
	var origin_cell : Vector2i
	
	for i in range(free_cells.size()):
		origin_cell = free_cells[i]
		
		if is_area_free(origin_cell, N, M):
			break
		
		assert(i < free_cells.size() - 1, 'Not found free area of %d x %d in background board' % [N, M])
	
	var origin_cell_top_left = get_cell_center(origin_cell) - Vector2(Domino.SPRITE_WIDTH * 0.5, Domino.SPRITE_WIDTH * 0.5)
	var area_center_x = origin_cell_top_left.x + M * Domino.SPRITE_WIDTH * 0.5
	var area_center_y = origin_cell_top_left.y + N * Domino.SPRITE_WIDTH * 0.5
	return Vector2(area_center_x, area_center_y)

# Returns true if the area of cells of size N x M starting from the given cell
# is free in the world
func is_area_free(cell : Vector2i, N : int, M : int) -> bool:
	var free_cells = get_used_cells(Layer.WORLD_FREE_LAYER)
	
	for i in range(M):
		for j in range(N):
			if not (cell + Vector2i(i, j)) in free_cells:
				return false
	
	return true

# Blocks the area of cells of size N x M starting from the given cell
func block_area(cell : Vector2i, N : int, M : int) -> void:
	for i in range(M):
		for j in range(N):
			erase_cell(Layer.WORLD_FREE_LAYER, (cell + Vector2i(i, j)))

# Registers the given blocked area component
func register_blocked_area_component(blocked_area_component : BlockedAreaComponent) -> void:
	var shape_size = blocked_area_component.collision_shape.shape.size
	
	var origin_cell_top_left = blocked_area_component.global_position - shape_size * 0.5
	var origin_cell_center = origin_cell_top_left + Vector2(Domino.SPRITE_WIDTH * 0.5, Domino.SPRITE_WIDTH * 0.5)
	var origin_cell = get_cell(origin_cell_center)
	
	var N = shape_size.y / Domino.SPRITE_WIDTH
	var M = shape_size.x / Domino.SPRITE_WIDTH
	
	block_area(origin_cell, N, M)

#endregion
