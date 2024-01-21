class_name CameraMovementArea
extends Area2D

const BASE_SPEED : float = 0.4
const TIME_ACCELERATION_FACTOR : float = 3.0
const DISTANCE_ACCELERATION_FACTOR : float = 1.5
const ACTIVATION_TIME : float = 0.1

@export var movement_direction : Vector2

var hovered : bool = false
var time_hovered : float = 0.0

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

# Called on each frame
func _process(delta: float) -> void:
	if hovered:
		time_hovered += delta

	if time_hovered > ACTIVATION_TIME:
		var mouse_distance_speed_factor = pow(get_local_mouse_position().project(movement_direction.normalized()).length(), DISTANCE_ACCELERATION_FACTOR)
		var time_speed_factor = min(TIME_ACCELERATION_FACTOR * (time_hovered - ACTIVATION_TIME), 7.0)
		var speed = BASE_SPEED * mouse_distance_speed_factor * time_speed_factor
		GameManager.current_camera.translate(movement_direction * speed * delta)

# Called when the mouse enters
func _on_mouse_entered() -> void:
	hovered = true
	time_hovered = 0.0

# Called when the mouse exits
func _on_mouse_exited() -> void:
	hovered = false
	time_hovered = 0.0
