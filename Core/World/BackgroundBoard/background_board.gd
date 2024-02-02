class_name BackgroundBoard
extends TileMap

signal region_blocked

enum Layer {
	WORLD_VISUAL_LAYER,
	WORLD_FREE_LAYER,
}

const TILES = {
	'DEBUG_TILE': Vector2(0, 0),
}

var astar : AStar2D = AStar2D.new()

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# NOTE: tile_set.tile_size = Vector2i(Domino.SPRITE_WIDTH, Domino.SPRITE_WIDTH)
	for cell in get_used_cells(Layer.WORLD_VISUAL_LAYER):
		set_cell(Layer.WORLD_FREE_LAYER, cell, 1, TILES.DEBUG_TILE)
	
	GameManager.set_background_board(self)


# Public

# Global version of get_used_rect
func get_global_used_rect() -> Rect2:
	var global_used_rect : Rect2
	var used_rect = get_used_rect()
	
	var rect_position = Vector2(used_rect.position * Domino.SPRITE_WIDTH)
	var rect_size = Vector2(used_rect.size * Domino.SPRITE_WIDTH)
	
	return Rect2(rect_position, rect_size)
	

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

# Gets the center position of the given cell
func get_cell_center(cell : Vector2i) -> Vector2:
	return global_position + map_to_local(cell)
	
# Given a position in the board, it returns the center position of the cell that
# covers that position
func get_cell_centerp(board_position : Vector2) -> Vector2:
	return get_cell_center(get_cell(board_position))

# Gets the top left position of the given cell
func get_cell_top_left(cell : Vector2i) -> Vector2:
	return get_cell_center(cell) - Vector2(Domino.SPRITE_WIDTH * 0.5, Domino.SPRITE_WIDTH * 0.5)

# Given a position in the board, it returns the top left position of the cell that
# covers that position
func get_cell_top_leftp(board_position : Vector2) -> Vector2:
	return get_cell_centerp(board_position) - Vector2(Domino.SPRITE_WIDTH * 0.5, Domino.SPRITE_WIDTH * 0.5)

#endregion

#region Region and Blocking Methods

# Gets the region that contains the given area
func get_region(area : Area2D) -> Region:
	var origin_position = area.global_position
	var collision_shape = null
	
	for child in area.get_children():
		if child is CollisionShape2D:
			collision_shape = child
	
	var shape = collision_shape.shape
	
	assert(shape is RectangleShape2D, 'Area shape must be a RectangleShape2D to get a container region')
	
	var area_top_left = origin_position - shape.size * 0.5
	var origin_center = area_top_left + Vector2(Domino.SPRITE_WIDTH * 0.5, Domino.SPRITE_WIDTH * 0.5)
	var origin = get_cell(origin_center)
	
	var N = shape.size.y / Domino.SPRITE_WIDTH
	var M = shape.size.x / Domino.SPRITE_WIDTH
	
	return Region.new(origin, N, M)

# Gets the center of a random free region of size N x M in the world
func get_free_region_center(N : int, M : int) -> Vector2:
	var free_cells = get_used_cells(Layer.WORLD_FREE_LAYER)
	free_cells.shuffle()
	
	var region : Region
	
	for i in range(free_cells.size()):
		region = Region.new(free_cells[i], N, M)
		
		if is_region_free(region):
			break
		
		assert(i < free_cells.size() - 1, 'Not found free region of %d x %d in background board' % [N, M])
	
	return region.get_center_position()

# Returns true if the given region is free in the world
func is_region_free(region : Region) -> bool:
	var free_cells = get_used_cells(Layer.WORLD_FREE_LAYER)
	
	for i in range(region.M):
		for j in range(region.N):
			if not (region.origin + Vector2i(i, j)) in free_cells:
				return false
	
	return true

# Returns true if the given area region is free in the world
func is_area_region_free(area : Area2D) -> bool:
	var area_region = get_region(area)
	return is_region_free(area_region)

# Blocks the given region
func block_region(region : Region) -> void:
	for i in range(region.M):
		for j in range(region.N):
			erase_cell(Layer.WORLD_FREE_LAYER, (region.origin + Vector2i(i, j)))
	region_blocked.emit()

# Blocks the given area region
func block_area_region(area : Area2D) -> void:
	var area_region = get_region(area)
	block_region(area_region)

# Blocks the given domino region
func block_domino_region(domino : Domino) -> void:
	var domino_horizontal = abs((int(round(domino.global_rotation_degrees)) / 90) % 2) == 1
	var domino_region : Region
	
	if domino_horizontal:
		var domino_left_position = domino.global_position + Domino.SPRITE_WIDTH * 0.5 * Vector2.LEFT
		domino_region = Region.new(get_cell(domino_left_position), 1, 2)
	else:
		var domino_top_position = domino.global_position + Domino.SPRITE_WIDTH * 0.5 * Vector2.UP
		domino_region = Region.new(get_cell(domino_top_position), 2, 1)
		
	block_region(domino_region)

#endregion


# Class representing a rectangle region on the board
class Region:
	var origin : Vector2i
	var N : int
	var M : int
	
	# Constructor
	func _init(origin : Vector2i, N : int, M : int) -> void:
		self.origin = origin
		self.N = N
		self.M = M
	
	# Gets the region center position
	func get_center_position() -> Vector2:
		var origin_top_left = GameManager.current_background_board.get_cell_top_leftp(origin)
		var center_x = origin_top_left.x + M * Domino.SPRITE_WIDTH * 0.5
		var center_y = origin_top_left.y + N * Domino.SPRITE_WIDTH * 0.5
		return Vector2(center_x, center_y)
