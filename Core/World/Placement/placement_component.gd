class_name PlacementComponent
extends Node2D

enum Direction { UP, RIGHT, DOWN, LEFT }

var dot : int = 0

# Public

# Handles a domino placement
func handle_domino_placement(placement_area : PlacementArea) -> void:
	var domino = placement_area.last_domino_entered
	
	if domino.dots.x == dot:
		place_domino(domino, placement_area, false)
		GameManager.current_match.end_turn()
	elif domino.dots.y == dot:
		place_domino(domino, placement_area, true)
		GameManager.current_match.end_turn()
	else:
		# TODO: Domino reset logic
		domino.reset()

# Places the given domino in the given placement area
func place_domino(domino : Domino, placement_area : PlacementArea, inverted : bool = false) -> void:
	pass

# Blocks the placement area in the given direction
func block_placement_area(direction : Direction) -> void:
	pass