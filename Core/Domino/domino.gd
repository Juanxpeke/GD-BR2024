class_name Domino
extends Node2D

signal being_grabbed
signal world_state_changed

const SPRITE_WIDTH : int = 32
const SPRITE_HEIGHT : int = 64

static var dominoes_atlas : Texture2D = load("res://Core/Domino/Dominos2x.png")
static var grabbing : bool = false

var grabbed : bool = false
var grab_position : Vector2
var placement_areas_below : int = 0

var dots : Vector2i = Vector2i(-1, -1)

@onready var sprite := %Sprite
@onready var area := %Area

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	area.input_event.connect(_on_input_event)
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(_delta: float) -> void:
	if grabbed:
		global_position = get_global_mouse_position()

# Called on input event within the node
func _on_input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if not GameManager.current_match.is_turn_owner(GameManager.current_player):
		return
	
	if event.is_action_pressed("left_click") and not grabbing:
		grabbing = true
		grabbed = true
		grab_position = global_position
		GameManager.current_player.grabbed_domino = self
		being_grabbed.emit()

# Called when the mouse enters the node
func _on_mouse_entered() -> void:
	pass
	
# Called when the node exits the node
func _on_mouse_exited() -> void:
	pass

# Called when an area enters the node
func _on_area_entered(area : Area2D) -> void:
	if area is PlacementArea:
		placement_areas_below += 1

# Called when an area exits the node
func _on_area_exited(area : Area2D) -> void:
	if area is PlacementArea:
		placement_areas_below -= 1


# Public

# Sets the domino dots
func set_dots(dots : Vector2i) -> void:
	self.dots = dots
	set_dots_texture(dots)

# Sets the dots texture
func set_dots_texture(dots : Vector2i) -> void:
	# NOTE: Sprites in atlas are rotated 90 degrees, so is the sprite node
	var texture_position = Vector2(dots.x * SPRITE_HEIGHT, dots.y * SPRITE_WIDTH)
	var texture_size = Vector2(SPRITE_HEIGHT, SPRITE_WIDTH) 
	
	sprite.texture = AtlasTexture.new()
	sprite.texture.atlas = dominoes_atlas
	sprite.texture.region = Rect2(texture_position, texture_size)

# Sets the domino world state
func set_world_state(value : bool) -> void:
	area.monitoring = not value
	area.monitorable = not value
	area.visible = not value

	if value:
		grabbed = false
		
	world_state_changed.emit()

# Returns true if the domino is over a placement area, false otherwise
func is_over_placement_area() -> bool:
	return placement_areas_below > 0

# Resets the domino position in the hand
func reset() -> void:
	if get_parent() == GameManager.current_world:
		GameManager.current_player.hand.handle_domino_reset(self)
	global_position = grab_position

