class_name Match
extends Node2D

const CAMERA_ZOOM_SPEED : float = 0.1

var turn : int = 0

@onready var camera := %Camera
@onready var board := %Board
@onready var deck := %Deck
@onready var player := %Player

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.set_match(self)

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_pressed('wheel_up'):
		camera.zoom += Vector2(CAMERA_ZOOM_SPEED, CAMERA_ZOOM_SPEED)
	if event.is_action_pressed('wheel_down'):
		camera.zoom -= Vector2(CAMERA_ZOOM_SPEED, CAMERA_ZOOM_SPEED)
