class_name DynamicPlacementComponent
extends PlacementComponent

var bound_domino : Domino

@onready var placement_area_up := %PlacementAreaUp
@onready var placement_area_right := %PlacementAreaRight
@onready var placement_area_left := %PlacementAreaLeft

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Up placement area
	placement_area_up.translate(Vector2.UP * Domino.SPRITE_HEIGHT)
	# Right placement area
	placement_area_right.rotate(PI / 2)
	placement_area_right.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.25)
	placement_area_right.translate(Vector2.RIGHT * Domino.SPRITE_WIDTH * 1.5)
	# Left placement area
	placement_area_left.rotate(-PI / 2)
	placement_area_left.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.25)
	placement_area_left.translate(Vector2.LEFT * Domino.SPRITE_WIDTH * 1.5)


# Public

# Gets the related static placement component
func get_static_placement_component() -> StaticPlacementComponent:
	return get_parent()

# Places the given domino in the given placement area
func place_domino(domino : Domino, placement_area : PlacementArea, inverted : bool = false) -> void:
	domino.global_transform = placement_area.global_transform
	domino.reparent(get_static_placement_component().dominoes)
	domino.set_world_state(true)
	if inverted: domino.rotate(PI)

	bind_to_domino(domino, inverted)
	
	get_static_placement_component().domino_placed.emit(domino, GameManager.current_match.get_turn_owner())

# Binds this component to the given domino
func bind_to_domino(domino : Domino, inverted : bool = false) -> void:
	bound_domino = domino
	dot = domino.dots.x if inverted else domino.dots.y
	
	global_transform = domino.global_transform
	
	if inverted: rotate(PI)

# Blocks the placement area in the given direction
func block_placement_area(direction : Direction) -> void:
	if direction == Direction.UP and placement_area_up != null:
		placement_area_up.queue_free()
	elif direction == Direction.RIGHT and placement_area_right != null:
		placement_area_right.queue_free()
	elif placement_area_left != null:
		placement_area_left.queue_free()
