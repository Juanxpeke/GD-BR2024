class_name Deck
extends Node2D

@export var domino_scene : PackedScene

var deck : Array[Vector2i] = []

@onready var sprite := %Sprite
@onready var area := %Area

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_fill_deck()

	# deck.shuffle()
	# var new_domino = domino_scene.instantiate()
	# GameManager.current_board.add_initial_domino(new_domino, deck.pop_back())
	area.mouse_entered.connect(_on_area_mouse_entered)
	area.mouse_exited.connect(_on_area_mouse_exited)
	area.input_event.connect(_on_area_input_event)

# Called when the mouse enters the area
func _on_area_mouse_entered() -> void:
	ConfigurationManager.add_cursor_shape("pointer")

# Called when the mouse exits the area
func _on_area_mouse_exited() -> void:
	ConfigurationManager.remove_cursor_shape("pointer")

# Called on input event within the area
func _on_area_input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if not GameManager.current_match.is_turn_owner(GameManager.current_player):
		return
	
	if event.is_action_pressed("left_click"):
		give_domino()

# Fills the deck
func _fill_deck() -> void:
	for i in range(0, GameManager.MAX_DOTS + 1):
		for j in range(0, GameManager.MAX_DOTS + 1):
			if not Vector2i(j, i) in deck:
				deck.append(Vector2i(i, j))


# Public

# Gives a domino to the current turn owner
func give_domino() -> void:
	if deck.is_empty():
		_fill_deck()

	deck.shuffle()
	var new_domino = domino_scene.instantiate()
	GameManager.current_match.get_turn_owner().hand.add_domino(new_domino)
	new_domino.set_dots(deck.pop_back())

	GameManager.current_match.end_turn()
