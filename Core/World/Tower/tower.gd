class_name Tower
extends Structure

static var tower_sprites = [
	load("res://Core/World/Tower/TowerSprites/arcane_well.png"),
	load("res://Core/World/Tower/TowerSprites/nature_well.png"),
	load("res://Core/World/Tower/TowerSprites/dark_well.png"),
	load("res://Core/World/Tower/TowerSprites/inferno_well.png"),
] 

@export var mana_type : GameManager.ManaType = GameManager.ManaType.ARCANE

@export var placement_area_up_blocked : bool = false
@export var placement_area_right_blocked : bool = false
@export var placement_area_down_blocked : bool = false
@export var placement_area_left_blocked : bool = false

@export var threshold_material : ShaderMaterial

var extractions : int = 0
var accumulated_extractions : int = 0
var accumulated_extractions_threshold : int = 5

@onready var placement_component := %StaticPlacementComponent
@onready var indicator_component := %OOCIndicatorComponent
@onready var sprite := %Sprite

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()
	
	_update_mana_type_data()
	_update_placement_areas()
	
	placement_component.domino_placed.connect(_on_domino_placed)

# Called when a domino is placed in the tower placement component
func _on_domino_placed(domino : Domino, entity : Entity) -> void:
	entity.add_current_mana(1, mana_type)
	extractions += 1
	accumulated_extractions += 1
	
	if accumulated_extractions == accumulated_extractions_threshold - 1 and threshold_material:
		for placed_domino in placement_component.dominoes.get_children():
			placed_domino.sprite.set_material(threshold_material)
	
	elif accumulated_extractions == accumulated_extractions_threshold:
		for placed_domino in placement_component.dominoes.get_children():
			placed_domino.sprite.set_material(null)
			
		accumulated_extractions = 0
		GameManager.current_match.swap_skills()

# Updates the tower data from its mana type
func _update_mana_type_data() -> void:
	sprite.texture = tower_sprites[mana_type]
	indicator_component.indicator_sprite.texture = tower_sprites[mana_type]

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
