class_name OOCIndicatorComponent
extends Node2D

@export var indicator_texture : Texture2D

@onready var indicator_area := %IndicatorArea
@onready var indicator_collision_shape := %IndicatorArea/CollisionShape
@onready var indicator_sprite := %IndicatorSprite

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	indicator_sprite.texture = indicator_texture
	indicator_area.visible = false
	
	indicator_area.mouse_entered.connect(_on_indicator_area_mouse_entered)
	indicator_area.mouse_exited.connect(_on_indicator_area_mouse_exited)
	indicator_area.input_event.connect(_on_indicator_area_input)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	var camera_rect = GameManager.current_camera.get_rect()
	
	if _is_outside_rect(camera_rect):
		# TODO: Use the world top layer instead of a layer for each indicator
		var viewport_size = get_viewport_rect().size
		var camera_position = camera_rect.position + camera_rect.size * 0.5
		var indicator_padding = indicator_collision_shape.shape.radius
		
		if global_position.x == camera_position.x: return
		
		var slope = (camera_position.y - global_position.y) / (global_position.x - camera_position.x)
		var indicator_position = Vector2()

		if global_position.y < camera_position.y:
			indicator_position = Vector2((viewport_size.y * 0.5 - indicator_padding) / slope + viewport_size.x * 0.5, indicator_padding) 
		else:
			indicator_position = Vector2((-viewport_size.y * 0.5 + indicator_padding) / slope + viewport_size.x * 0.5, viewport_size.y - indicator_padding)
		if indicator_position.x < indicator_padding:
			indicator_position = Vector2(indicator_padding, (viewport_size.x * 0.5 - indicator_padding) * slope + viewport_size.y * 0.5)
		elif indicator_position.x > viewport_size.x - indicator_padding:
			indicator_position = Vector2(viewport_size.x - indicator_padding, (-viewport_size.x * 0.5 + indicator_padding) * slope + viewport_size.y * 0.5)
		
		indicator_area.global_position = indicator_position
		
		if not indicator_area.visible:
			indicator_area.visible = true

	elif indicator_area.visible:
		indicator_area.visible = false

# Called when the mouse enters the indicator area
func _on_indicator_area_mouse_entered() -> void:
	ConfigurationManager.add_cursor_shape("pointer")

# Called when the mouse exits the indicator area
func _on_indicator_area_mouse_exited() -> void:
	ConfigurationManager.remove_cursor_shape("pointer")

# Called when the indicator area receives an input
func _on_indicator_area_input(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if event.is_action_pressed("left_click"):
		GameManager.current_camera.grabbed = false
		GameManager.current_camera.global_position = global_position
		GameManager.current_camera.zoom = GameManager.current_camera.ZOOM_DEFAULT

# Returns true if the indicator is outside the given rect, false otherwise
func _is_outside_rect(rect : Rect2) -> bool:
	return global_position.x < rect.position.x or global_position.y < rect.position.y or \
			global_position.x > rect.position.x + rect.size.x or global_position.y > rect.position.y + rect.size.y
