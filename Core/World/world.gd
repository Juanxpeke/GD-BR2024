class_name World
extends Node2D

const CAMERA_ZOOM_VELOCITY : Vector2 = Vector2(0.1, 0.1)
const CAMERA_ZOOM_MINIMUM : Vector2 = Vector2(0.1, 0.1)
const CAMERA_ZOOM_MAXIMUM : Vector2 = Vector2(7.0, 7.0) 

@onready var camera := %Camera
@onready var board := %Board
@onready var deck := %Deck

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.set_world(self)

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_pressed('wheel_up'):
		camera.zoom.x = min(camera.zoom.x + CAMERA_ZOOM_VELOCITY.x, CAMERA_ZOOM_MAXIMUM.x)
		camera.zoom.y = min(camera.zoom.y + CAMERA_ZOOM_VELOCITY.y, CAMERA_ZOOM_MAXIMUM.y)
	if event.is_action_pressed('wheel_down'):
		camera.zoom.x = max(camera.zoom.x - CAMERA_ZOOM_VELOCITY.x, CAMERA_ZOOM_MINIMUM.x)
		camera.zoom.y = max(camera.zoom.y - CAMERA_ZOOM_VELOCITY.y, CAMERA_ZOOM_MINIMUM.y)

# Public
