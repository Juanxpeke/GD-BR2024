class_name Deck
extends Node2D

@export var domino_scene : PackedScene

var deck : Array[Vector2i] = []

@onready var area := %Area

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_init_deck()
	
	area.input_event.connect(_on_area_input_event)
	
	deck.shuffle()
	var new_domino = domino_scene.instantiate()
	GameManager.current_board.add_initial_domino(new_domino, deck.pop_back())

# Called on input event within the area
func _on_area_input_event(viewport : Node, event : InputEvent, shape_idx : int) -> void:
	if event.is_action_pressed("right_click"):
		if deck.is_empty():
			# TODO: Special end game logic (?)
			return

		deck.shuffle()
		var new_domino = domino_scene.instantiate()
		GameManager.current_player.hand.add_domino(new_domino)
		new_domino.set_dots(deck.pop_back())

# Initializes the deck
func _init_deck() -> void:
	for i in range(0, GameManager.MAX_DOTS + 1):
		for j in range(0, GameManager.MAX_DOTS + 1):
			if not Vector2i(j, i) in deck:
				deck.append(Vector2i(i, j))
