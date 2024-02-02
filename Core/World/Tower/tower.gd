class_name Tower
extends Structure

const EXPLOSION_FOCUS_WAIT_TIME : float = 1.0
const POST_SWAP_WAIT_TIME : float = 1.0
const EXPLOSION_UNFOCUS_WAIT_TIME : float = 1.0

const DEFAULT_MANA_REWARD : int = 1
const EXPLOSION_MANA_REWARD : int = 2

static var tower_sprites : Array[Texture2D] = [
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

@export var charged_domino_material : ShaderMaterial

var extractions : int = 0
var explosions : int = 0
var explosions_needed_extractions : Array[int] = [4, 3, 2]

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
	extractions += 1
	
	var explosion_needed_extractions = explosions_needed_extractions[min(explosions, explosions_needed_extractions.size() - 1)]
	
	if extractions < explosion_needed_extractions:
		entity.add_current_mana(DEFAULT_MANA_REWARD, mana_type)
		
		if extractions == explosion_needed_extractions - 1:
			for placed_domino in placement_component.dominoes.get_children():
				placed_domino.sprite.set_material(charged_domino_material)
	
	elif extractions >= explosion_needed_extractions:
		entity.add_current_mana(EXPLOSION_MANA_REWARD, mana_type)
		
		for placed_domino in placement_component.dominoes.get_children():
			placed_domino.sprite.set_material(null)
			
		extractions = 0
		explosions += 1
		
		GameManager.freeze()
		GameManager.current_camera.block()
		
		GameManager.current_camera.focus(global_position, Camera.ZOOM_MAXIMUM)
		await GameManager.current_camera.get_tree().create_timer(EXPLOSION_FOCUS_WAIT_TIME).timeout
	
		GameManager.current_camera.shake()
		GameManager.current_match.swap_skills()
		await GameManager.current_camera.get_tree().create_timer(POST_SWAP_WAIT_TIME).timeout
		
		GameManager.current_camera.focus(global_position, Camera.ZOOM_DEFAULT)
		await GameManager.current_camera.get_tree().create_timer(EXPLOSION_UNFOCUS_WAIT_TIME).timeout
		
		GameManager.current_camera.unblock()
		GameManager.unfreeze()
	
	GameManager.current_match.end_turn()

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
