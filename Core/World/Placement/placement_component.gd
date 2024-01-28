class_name PlacementComponent
extends Node2D

enum Direction { UP, RIGHT, DOWN, LEFT }

var dot : int = 0

@onready var placement_areas = %PlacementAreas

# Public

# Handles a domino placement
func handle_domino_placement(placement_area : PlacementArea) -> void:
	var domino = placement_area.last_domino_entered
	
	if domino.dots.x == dot:
		place_domino(domino, placement_area, false)
	elif domino.dots.y == dot:
		place_domino(domino, placement_area, true)
	else:
		domino.reset()

# Places the given domino in the given placement area
func place_domino(domino : Domino, placement_area : PlacementArea, inverted : bool = false, from_entity : bool = true) -> void:
	pass

# Returns true if there is at least a free placement area, false otherwise
func is_free() -> bool:
	return not get_free_placement_areas().is_empty()

# Gets the non-blocked placement areas
func get_free_placement_areas() -> Array[PlacementArea]:
	var free_placement_areas : Array[PlacementArea]
	free_placement_areas.assign(placement_areas.get_children().filter(
			func(placement_area): return not placement_area.blocked))
	return free_placement_areas

# Blocks the placement area in the given direction
func block_placement_area(direction : Direction) -> void:
	for placement_area in placement_areas.get_children():
		if placement_area.direction == direction:
			placement_area.set_blocked(true)


