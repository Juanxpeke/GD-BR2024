class_name Camera
extends Camera2D

const ZOOM_DEFAULT : Vector2 = Vector2(1.7, 1.7)
const ZOOM_MINIMUM : Vector2 = Vector2(0.7, 0.7)
const ZOOM_MAXIMUM : Vector2 = Vector2(3.7, 3.7)
const ZOOM_WHEEL_STEP : Vector2 = Vector2(0.2, 0.2) 
const ZOOM_SPEED : float = 10.0
const ZOOM_DIFFERENCE_THRESHOLD : float = 0.02

const SHAKING_DECAY_SPEED : float = 3.0

var target_zoom : Vector2

var block_queries : int = 0

var shaking_factor : float = 0.0

var grabbed : bool = false
var grab_position : Vector2
var grab_mouse_position : Vector2

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	zoom = ZOOM_DEFAULT
	target_zoom = ZOOM_DEFAULT
	
	GameManager.world_setted.connect(_on_world_setted)
	
	GameManager.set_camera(self)

# Called when the game world is setted
func _on_world_setted() -> void:
	_set_limits()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	# Grabbing logic
	if grabbed and not is_blocked() and GameManager.current_player.grabbed_domino == null:
		global_position = grab_position + (grab_mouse_position - get_viewport().get_mouse_position()) / zoom

	# Smooth zoom logic
	if target_zoom.distance_to(zoom) > ZOOM_DIFFERENCE_THRESHOLD:
		zoom = lerp(zoom, target_zoom, delta * ZOOM_SPEED)
		if target_zoom.distance_to(zoom) < ZOOM_DIFFERENCE_THRESHOLD:
			zoom = target_zoom
	
	# Shaking logic
	if shaking_factor > 0.0:
		_apply_shaking()
		shaking_factor = max(shaking_factor - delta * SHAKING_DECAY_SPEED, 0.0)

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_pressed('left_click'):
		grab_position = get_screen_center_position()
		grab_mouse_position = get_viewport().get_mouse_position()
		grabbed = true
	elif event.is_action_released('left_click'):
		grabbed = false
	
	if event.is_action_pressed('wheel_up'):
		target_zoom.x = min(zoom.x + ZOOM_WHEEL_STEP.x, ZOOM_MAXIMUM.x)
		target_zoom.y = min(zoom.y + ZOOM_WHEEL_STEP.y, ZOOM_MAXIMUM.y)
	elif event.is_action_pressed('wheel_down'):
		target_zoom.x = max(zoom.x - ZOOM_WHEEL_STEP.x, ZOOM_MINIMUM.x)
		target_zoom.y = max(zoom.y - ZOOM_WHEEL_STEP.y, ZOOM_MINIMUM.y)

# Sets the camera limits
func _set_limits() -> void:
	var background_board_rect = GameManager.current_background_board.get_global_used_rect()
	var background_board_position = background_board_rect.position
	var background_board_size = background_board_rect.size
	
	limit_bottom = background_board_position.y + background_board_size.y
	limit_top = background_board_position.y
	limit_left = background_board_position.x
	limit_right = background_board_position.x + background_board_size.x

# Applies the current shaking to the camera
func _apply_shaking() -> void:
	var amount = pow(shaking_factor, 2)
	rotation = 0.1 * amount * GameManager.rng.randf_range(-1, 1)
	offset.x = Vector2(100, 75).x * amount * GameManager.rng.randf_range(-1, 1)
	offset.y = Vector2(100, 75).y * amount * GameManager.rng.randf_range(-1, 1)


# Public

#region Base Camera Methods

# Gets the camera rect
func get_rect() -> Rect2:
	var camera_size = get_viewport_rect().size / zoom
	return Rect2(get_screen_center_position() - camera_size * 0.5, camera_size)

#endregion

#region Focusing

# Focuses the gamera on the given position
func focus(focus_position : Vector2, focus_zoom : Vector2 = ZOOM_DEFAULT) -> void:
	grabbed = false
	global_position = focus_position
	target_zoom = focus_zoom

#endregion

#region Blocking

# Returns true if the camera is blocked, false otherwise
func is_blocked() -> bool:
	return block_queries > 0

# Generates a camera block querie
func block() -> void:
	block_queries +=1
	
# Removes a camera block querie
func unblock() -> void:
	block_queries = max(block_queries - 1, 0)

#endregion

#region Shaking

# Shakes the camera
func shake():
	shaking_factor = 1.0

#endregion
