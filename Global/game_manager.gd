extends Node

signal match_setted
signal world_setted
signal camera_setted
signal board_setted
signal player_setted

enum ManaType { ARCANE, NATURE, DARK, INFERNO }

const MAX_DOTS : int = 6

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var current_match : Match = null
var current_world : World = null
var current_camera : Camera = null
var current_player : Player = null

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	rng.randomize()


# Public

#region Setters

# Sets the game match
func set_match(amatch : Match) -> void:
	current_match = amatch
	match_setted.emit()

# Sets the game world
func set_world(world : World) -> void:
	current_world = world
	world_setted.emit()

# Sets the game camera
func set_camera(camera : Camera) -> void:
	current_camera = camera
	camera_setted.emit()

# Sets the game player
func set_player(player : Player) -> void:
	current_player = player
	player_setted.emit()

#endregion
