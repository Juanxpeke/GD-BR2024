class_name Board
extends Node2D

var placement_areas_queue : Array[PlacementArea] = []

@onready var start_placement_manager := %StartPlacementManager
@onready var end_placement_manager := %EndPlacementManager
@onready var dominoes := %Dominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_released("right_click") and not placement_areas_queue.is_empty():
		placement_areas_queue.back().place()


# Public

# Queues the given placement area
func queue_placement_area(placement_area : PlacementArea) -> void:
	if not placement_areas_queue.is_empty():
		placement_areas_queue.back().hide_hint()
	
	if not placement_area in placement_areas_queue:
		placement_areas_queue.push_back(placement_area)
	
	placement_area.show_hint()

# Unqueues the given placement area
func unqueue_placement_area(placement_area : PlacementArea) -> void:
	if placement_area in placement_areas_queue:
		placement_areas_queue.erase(placement_area)
		
	placement_area.hide_hint()
	
	if not placement_areas_queue.is_empty():
		placement_areas_queue.back().show_hint() 

# Add xd
func add_xd(xd : Vector2i) -> void:
	var domino = get_parent().domino_scene.instantiate()
	dominoes.add_child(domino)
	domino.set_dots(xd)
	domino.rotate(deg_to_rad(90))
	
	domino.global_position = dominoes.global_position
	
	start_placement_manager.set_placed_domino(domino, false)
	end_placement_manager.set_placed_domino(domino, true)
