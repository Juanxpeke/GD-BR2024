class_name StaticPlacementComponent
extends PlacementComponent

signal domino_placed(domino : Domino, entity : Entity)

@export var dynamic_placement_component_scene : PackedScene

@onready var placement_area_up := %PlacementAreaUp
@onready var placement_area_right := %PlacementAreaRight
@onready var placement_area_down := %PlacementAreaDown
@onready var placement_area_left := %PlacementAreaLeft
@onready var dominoes := %Dominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Up placement area
	placement_area_up.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.75)
	# Right placement area
	placement_area_right.rotate(PI / 2)
	placement_area_right.translate(Vector2.RIGHT * Domino.SPRITE_WIDTH * 1.5)
	# Down placement area
	placement_area_down.rotate(PI)
	placement_area_down.translate(Vector2.DOWN * Domino.SPRITE_HEIGHT * 0.75)
	# Left placement area
	placement_area_left.rotate(-PI / 2)
	placement_area_left.translate(Vector2.LEFT * Domino.SPRITE_WIDTH * 1.5)


# Public

# Places the given domino in the given placement area
func place_domino(domino : Domino, placement_area : PlacementArea, inverted : bool = false) -> void:
	domino.global_transform = placement_area.global_transform
	domino.reparent(dominoes)
	domino.set_world_state(true)
	if inverted: domino.rotate(PI)

	var dynamic_placement_component = dynamic_placement_component_scene.instantiate()
	add_child(dynamic_placement_component)
	
	dynamic_placement_component.name = placement_area.name.replace('PlacementArea', 'DynamicPlacementComponent')
	dynamic_placement_component.bind_to_domino(domino, inverted)
	
	PlacementManager.unqueue_placement_area(placement_area)
	placement_area.queue_free()
	
	domino_placed.emit(domino, GameManager.current_match.get_turn_owner())

# Blocks the placement area in the given direction
func block_placement_area(direction : Direction) -> void:
	if direction == Direction.UP and placement_area_up != null:
		placement_area_up.queue_free()
	elif direction == Direction.RIGHT and placement_area_right != null:
		placement_area_right.queue_free()
	elif direction == Direction.DOWN and placement_area_down != null:
		placement_area_down.queue_free()
	elif placement_area_left != null:
		placement_area_left.queue_free()
