class_name DynamicPlacementComponent
extends PlacementComponent

var direction : Direction
var static_placement_component : StaticPlacementComponent
var bound_domino : Domino

@onready var placement_area_up := %PlacementAreaUp
@onready var placement_area_right := %PlacementAreaRight
@onready var placement_area_left := %PlacementAreaLeft

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Up placement area
	placement_area_up.set_placement_component(self)
	placement_area_up.translate(Vector2.UP * Domino.SPRITE_HEIGHT)
	# Right placement area
	placement_area_right.set_placement_component(self)
	placement_area_right.rotate(PI / 2)
	placement_area_right.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.25)
	placement_area_right.translate(Vector2.RIGHT * Domino.SPRITE_WIDTH * 1.5)
	# Left placement area
	placement_area_left.set_placement_component(self)
	placement_area_left.rotate(-PI / 2)
	placement_area_left.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.25)
	placement_area_left.translate(Vector2.LEFT * Domino.SPRITE_WIDTH * 1.5)


# Public

# Sets the related static placement component
func set_static_placement_component(static_placement_component : StaticPlacementComponent) -> void:
	self.static_placement_component = static_placement_component

# Places the given domino in the given placement area
func place_domino(domino : Domino, placement_area : PlacementArea, inverted : bool = false, from_entity : bool = true) -> void:
	domino.global_transform = placement_area.global_transform
	domino.reparent(static_placement_component.dominoes)
	if inverted: domino.rotate(PI)
	domino.set_world_state(true)

	bind_to_domino(domino, inverted)
	
	if from_entity:
		static_placement_component.domino_placed.emit(domino, GameManager.current_match.get_turn_owner())
		GameManager.current_match.end_turn()

# Binds this component to the given domino
func bind_to_domino(domino : Domino, inverted : bool = false) -> void:
	bound_domino = domino
	dot = domino.dots.x if inverted else domino.dots.y
	
	global_transform = domino.global_transform
	
	if inverted: rotate(PI)
