extends Node2D

const MAX_DOTS : int = 6

@export var domino_scene : PackedScene

var deck : Array[Vector2i] = []

var turn : int = 0

@onready var deck_area := %DeckArea
@onready var hand := %Hand

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_init_deck()
	deck_area.input_event.connect(_on_deck_area_input)
	
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
