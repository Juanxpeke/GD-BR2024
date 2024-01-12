extends Node

signal match_setted
signal camera_setted
signal board_setted
signal player_setted

const MAX_DOTS : int = 6

var current_match : Match = null
var current_camera : Camera2D = null
var current_board : Board = null
var current_player : Player = null

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body


# Public

#region Setters

# Sets the game match
func set_match(amatch : Match) -> void:
	set_camera(amatch.camera)
	current_match = amatch
	match_setted.emit()

# Sets the game camera
func set_camera(camera : Camera2D) -> void:
	current_camera = camera
	camera_setted.emit()

# Sets the game board
func set_board(board : Board) -> void:
	current_board = board
	board_setted.emit()

# Sets the game player
func set_player(player : Player) -> void:
	current_player = player
	player_setted.emit()

#endregion

#region Misc

# Gets the mouse world position
func get_mouse_world_position() -> Vector2:
	var viewport_offset = 0.5 * current_camera.get_viewport_rect().size * (Vector2(1, 1) - Vector2(1, 1) / current_camera.zoom)
	return current_camera.get_viewport().get_mouse_position() / current_camera.zoom + viewport_offset


#endregion
