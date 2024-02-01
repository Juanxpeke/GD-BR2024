class_name StaticPlacementComponent
extends PlacementComponent

signal domino_placed(domino : Domino, entity : Entity)

@export var dynamic_placement_component_scene : PackedScene
@export var placement_areas_offset : float

@onready var placement_area_up := %PlacementAreaUp
@onready var placement_area_right := %PlacementAreaRight
@onready var placement_area_down := %PlacementAreaDown
@onready var placement_area_left := %PlacementAreaLeft

@onready var dynamic_placement_components := %DynamicPlacementComponents
@onready var static_placement_components := %StaticPlacementComponents

@onready var dominoes := %Dominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Up placement area
	placement_area_up.set_placement_component(self)
	placement_area_up.translate(Vector2.UP * (Domino.SPRITE_HEIGHT * 0.75 + placement_areas_offset))
	# Right placement area
	placement_area_right.set_placement_component(self)
	placement_area_right.rotate(PI / 2)
	placement_area_right.translate(Vector2.RIGHT * (Domino.SPRITE_WIDTH * 1.5 + placement_areas_offset))
	# Down placement area
	placement_area_down.set_placement_component(self)
	placement_area_down.rotate(PI)
	placement_area_down.translate(Vector2.DOWN * (Domino.SPRITE_HEIGHT * 0.75 + placement_areas_offset))
	# Left placement area
	placement_area_left.set_placement_component(self)
	placement_area_left.rotate(-PI / 2)
	placement_area_left.translate(Vector2.LEFT * (Domino.SPRITE_WIDTH * 1.5 + placement_areas_offset))


# Public

# Places the given domino in the given placement area
func place_domino(domino : Domino, placement_area : PlacementArea, inverted : bool = false, from_entity : bool = true) -> void:
	domino.global_transform = placement_area.global_transform
	domino.reparent(dominoes)
	if inverted: domino.rotate(PI)
	domino.set_world_state(true)

	var dynamic_placement_component = dynamic_placement_component_scene.instantiate()
	dynamic_placement_components.add_child(dynamic_placement_component)
	
	dynamic_placement_component.name = placement_area.name.replace('PlacementArea', 'DynamicPlacementComponent')
	dynamic_placement_component.direction = placement_area.direction
	dynamic_placement_component.set_static_placement_component(self)
	dynamic_placement_component.bind_to_domino(domino, inverted)
	
	PlacementManager.unqueue_placement_area(placement_area)
	placement_area.queue_free()
	
	if from_entity:
		AudioManager.play_sound(Domino.domino_placing_sound)
		domino_placed.emit(domino, GameManager.current_match.get_turn_owner())
		GameManager.current_match.end_turn()

# Gets the free placement components that are children of this one
func get_free_placement_components() -> Array[PlacementComponent]:
	var free_placement_components : Array[PlacementComponent] = []
	
	if is_free():
		free_placement_components.append(self)
	
	for dynamic_placement_component in dynamic_placement_components.get_children():
		if dynamic_placement_component.is_free():
			free_placement_components.append(dynamic_placement_component)
	
	for static_placement_component in static_placement_components.get_children():
		free_placement_components.append_array(static_placement_component.get_free_placement_components())
	
	return free_placement_components
