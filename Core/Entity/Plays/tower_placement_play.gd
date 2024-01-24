class_name TowerPlacementPlay
extends Play

var placement_component : PlacementComponent
var domino : Domino
var inverted : bool

# Private

# Constructor
func _init(placement_component : PlacementComponent, domino : Domino, inverted : bool = false) -> void:
	self.placement_component = placement_component
	self.domino = domino
	self.inverted = inverted


# Public

# Executes the play
func execute() -> void:
	placement_component.place_domino(domino, placement_component.get_free_placement_areas()[0], inverted)
