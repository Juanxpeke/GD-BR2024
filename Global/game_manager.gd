extends Node

signal match_setted
signal world_setted
signal camera_setted
signal background_board_setted
signal player_setted
signal boss_setted

signal being_unfrozen

enum ManaType { ARCANE, NATURE, DARK, INFERNO }

const DOMINO_MAX_DOTS : int = 6
const HAND_INITIAL_DOMINOES : int = 3
const HAND_MAX_DOMINOES : int = 7
const SKILLS_MAX_AMOUNT : int = 2

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var current_match : Match = null
var current_world : World = null
var current_camera : Camera = null
var current_background_board : BackgroundBoard = null
var current_player : Player = null
var current_boss : Boss = null

var frozen : bool = false

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

# Sets the game background board
func set_background_board(background_board : BackgroundBoard) -> void:
	current_background_board = background_board
	background_board_setted.emit()

# Sets the game player
func set_player(player : Player) -> void:
	current_player = player
	player_setted.emit()

# Sets the game boss
func set_boss(boss : Boss) -> void:
	current_boss = boss
	boss_setted.emit()

#endregion

#region Freezing

# Freezes the game by the given amount of time
func freeze(time : float) -> void:
	print('freeze')
	frozen = true
	await get_tree().create_timer(time).timeout
	frozen = false
	print('Unfreeze')
	being_unfrozen.emit()

#endregion
