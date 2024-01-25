class_name TowerPlacementPlay
extends Play

var placement_component : PlacementComponent
var placement_area_index : int
var domino : Domino
var inverted : bool

# Private

# Constructor
func _init(placement_component : PlacementComponent, domino : Domino, inverted : bool = false) -> void:
	super()
	self.placement_component = placement_component
	self.domino = domino
	self.inverted = inverted
	self.placement_area_index = GameManager.rng.randi_range(0, placement_component.get_free_placement_areas().size() - 1)


# Public

# Gets the play position
func get_play_position() -> Vector2:
	return placement_component.get_free_placement_areas()[placement_area_index].global_position

# Core execution logic
func core_execute() -> void:
	placement_component.place_domino(domino, placement_component.get_free_placement_areas()[placement_area_index], inverted)
