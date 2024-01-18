extends Node

var placement_areas_queue : Array[PlacementArea] = []

# Private

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_released("left_click") and not placement_areas_queue.is_empty():
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
