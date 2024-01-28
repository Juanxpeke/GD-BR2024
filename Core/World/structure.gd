class_name Structure
extends Node2D

@export var cell_centered : bool = true

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	if cell_centered:
		global_position = GameManager.current_background_board.get_cell_centerp(global_position)
	else:
		global_position = GameManager.current_background_board.get_cell_top_leftp(global_position)
