class_name Store
extends Node2D


# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass

# Resets the store
func _reset() -> void:
	_reset_content()
	_reset_position()

# Resets the store content
func _reset_content() -> void:
	pass

# Resets the store position
func _reset_position() -> void:
	global_position = GameManager.current_world.background_board.get_free_area_center()

# Public
