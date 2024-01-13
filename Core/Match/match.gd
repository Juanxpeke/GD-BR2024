class_name Match
extends Node2D

signal turn_ended

const CAMERA_ZOOM_SPEED : float = 0.1

var turn : int = 0

@onready var camera := %Camera
@onready var board := %Board
@onready var deck := %Deck

@onready var entities := %Entities
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

# Public

#region Turn Logic

# Ends the current turn
func end_turn() -> void:
	print('Turn ended: ', turn)
	turn += 1
	turn_ended.emit()

# Gets the current turn owner
func get_turn_owner() -> Entity:
	return entities.get_child(turn % entities.get_child_count())

# Returns true if the given entity is the turn owner, false otherwise
func is_turn_owner(entity : Entity) -> bool:
	return get_turn_owner() == entity

#endregion
