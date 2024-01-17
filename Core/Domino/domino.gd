class_name Domino
extends Node2D

const SPRITE_WIDTH : int = 32
const SPRITE_HEIGHT : int = 64

static var dominoes_atlas : Texture2D = load("res://Core/Domino/Dominos2x.png")
static var grabbing : bool = false

var grabbed : bool = false

var dots : Vector2i = Vector2i(-1, -1)

@onready var sprite := %Sprite
@onready var area := %Area

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	area.input_event.connect(_on_input_event)
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(_delta: float) -> void:
	if grabbed:
		global_position = get_global_mouse_position()

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_released("right_click"):
		# Set the grabbed var as false in case the domino is being grabbed but
		# you unclicked outside it because of moving the mouse too fast
		grabbed = false
		grabbing = false

# Called on input event within the node
func _on_input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if event.is_action_pressed("right_click"):
		print('RC in ', _viewport.name)
	if event.is_action_released("right_click"):
		print('UnRC in ', _viewport.name)
	
	if not GameManager.current_match.is_turn_owner(GameManager.current_player):
		print('NOT TURN OWNER')
		return
	
	if event.is_action_pressed("right_click") and not grabbing:
		grabbed = true
		grabbing = true
		GameManager.current_player.set_grabbed_domino(self)
	elif event.is_action_released("right_click"):
		grabbed = false
		grabbing = false
		GameManager.current_player.clear_grabbed_domino()

# Called when the mouse enters the node
func _on_mouse_entered() -> void:
	pass
	
# Called when the node exits the node
func _on_mouse_exited() -> void:
	pass

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

# Sets the domino board state
func set_board_state(value : bool) -> void:
	area.monitorable = not value
	area.visible = not value

	if value:
		grabbed = false

