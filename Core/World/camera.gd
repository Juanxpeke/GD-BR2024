class_name Camera
extends Camera2D

const ZOOM_VELOCITY : Vector2 = Vector2(0.1, 0.1)
const ZOOM_MINIMUM : Vector2 = Vector2(0.1, 0.1)
const ZOOM_MAXIMUM : Vector2 = Vector2(7.0, 7.0) 
const ZOOM_DEFAULT : Vector2 = Vector2(1.7, 1.7)

var blocked : bool = false
var grabbed : bool = false
var grab_position : Vector2
var grab_mouse_position : Vector2

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	zoom = ZOOM_DEFAULT
	GameManager.set_camera(self)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(_delta: float) -> void:
	if grabbed and not blocked and GameManager.current_player.grabbed_domino == null:
		global_position = grab_position + (grab_mouse_position - get_viewport().get_mouse_position()) / zoom

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_pressed('left_click'):
		grab_position = global_position
		grab_mouse_position = get_viewport().get_mouse_position()
		grabbed = true
	elif event.is_action_released('left_click'):
		grabbed = false
	
	if event.is_action_pressed('wheel_up'):
		zoom.x = min(zoom.x + ZOOM_VELOCITY.x, ZOOM_MAXIMUM.x)
		zoom.y = min(zoom.y + ZOOM_VELOCITY.y, ZOOM_MAXIMUM.y)
	elif event.is_action_pressed('wheel_down'):
		zoom.x = max(zoom.x - ZOOM_VELOCITY.x, ZOOM_MINIMUM.x)
		zoom.y = max(zoom.y - ZOOM_VELOCITY.y, ZOOM_MINIMUM.y)


# Public

# Gets the camera rect
func get_rect() -> Rect2:
	var camera_size = get_viewport_rect().size / zoom
	return Rect2(get_screen_center_position() - camera_size * 0.5, camera_size)

# Focuses the gamera on the given position
func focus(focus_position : Vector2) -> void:
	grabbed = false
	global_position = focus_position
	zoom = ZOOM_DEFAULT
