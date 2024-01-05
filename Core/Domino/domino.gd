class_name Domino
extends Node2D

var grabbed : bool = false

var dots : Vector2i = Vector2i(0, 0)

@onready var sprite := %Sprite
@onready var area := %Area

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	area.input_event.connect(_on_input_event)
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	if grabbed:
		global_position = get_viewport().get_mouse_position()

# Called on input event within the node
func _on_input_event(viewport : Node, event : InputEvent, shape_idx : int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var pressed = event.is_pressed()
		if pressed:
			grabbed = true
		else:
			grabbed = false

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
	var texture_position = Vector2()
	var texture_size = Vector2() 
	
	sprite.texture = AtlasTexture.new()
	sprite.texture.region = Rect2(texture_position, texture_size)
