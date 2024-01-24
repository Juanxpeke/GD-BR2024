class_name Tower
extends Node2D

@export var mana_type : GameManager.ManaType = GameManager.ManaType.ARCANE

@export var placement_area_up_blocked : bool = false
@export var placement_area_right_blocked : bool = false
@export var placement_area_down_blocked : bool = false
@export var placement_area_left_blocked : bool = false

@onready var placement_component := %StaticPlacementComponent
@onready var sprite := %Sprite

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_update_mana_type_data()
	_update_placement_areas()
	
	placement_component.domino_placed.connect(_on_domino_placed)

# Called when a domino is placed in the tower placement component
func _on_domino_placed(domino : Domino, entity : Entity) -> void:
	print('Tower domino placed by ', entity.name)
	entity.add_current_mana(1, mana_type)
	print(entity.current_manas)

# Updates the tower data from its mana type
func _update_mana_type_data() -> void:
	pass

# Updates the tower placement areas
func _update_placement_areas() -> void:
	if placement_area_up_blocked: placement_component.block_placement_area(PlacementComponent.Direction.UP)
	if placement_area_right_blocked: placement_component.block_placement_area(PlacementComponent.Direction.RIGHT)
	if placement_area_down_blocked: placement_component.block_placement_area(PlacementComponent.Direction.DOWN)
	if placement_area_left_blocked: placement_component.block_placement_area(PlacementComponent.Direction.LEFT)


# Public

# Gets the free placement components that are children of this tower placement component
func get_free_placement_components() -> Array[PlacementComponent]:
	return placement_component.get_free_placement_components()
