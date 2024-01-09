extends Node2D

const CAMERA_ZOOM_SPEED : float = 0.1

const MAX_DOTS : int = 6

@export var domino_scene : PackedScene

var deck : Array[Vector2i] = []

var turn : int = 0

@onready var camera := %Camera
@onready var board := %Board
@onready var deck_area := %DeckArea
@onready var hand := %Hand

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_init_deck()
	deck_area.input_event.connect(_on_deck_area_input)
	deck.shuffle()
	board.add_xd(deck.pop_back())

# Called on any input event
func _input(event : InputEvent) -> void:
	if event.is_action_pressed('wheel_up'):
		camera.zoom += Vector2(CAMERA_ZOOM_SPEED, CAMERA_ZOOM_SPEED)
	if event.is_action_pressed('wheel_down'):
		camera.zoom -= Vector2(CAMERA_ZOOM_SPEED, CAMERA_ZOOM_SPEED)

# Called on input event within the deck area
func _on_deck_area_input(viewport : Node, event : InputEvent, shape_idx : int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if deck.is_empty():
			# TODO: Special end game logic
			return

		deck.shuffle()
		var new_domino = domino_scene.instantiate()
		hand.add_domino(new_domino)
		new_domino.set_dots(deck.pop_back())

# Initializes the deck
func _init_deck() -> void:
	for i in range(0, MAX_DOTS + 1):
		for j in range(0, MAX_DOTS + 1):
			if not Vector2i(j, i) in deck:
				deck.append(Vector2i(i, j))
