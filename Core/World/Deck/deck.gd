class_name Deck
extends Structure

@export var domino_scene : PackedScene

var deck : Array[Vector2i] = []

@onready var sprite := %Sprite
@onready var area := %Area
@onready var temporal_dominoes := %TemporalDominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_fill_deck()

	GameManager.match_setted.connect(_on_match_setted)

	area.mouse_entered.connect(_on_area_mouse_entered)
	area.mouse_exited.connect(_on_area_mouse_exited)
	area.input_event.connect(_on_area_input_event)


# Called when the game match is setted
func _on_match_setted() -> void:
	for tower : Tower in GameManager.current_world.towers.get_children():
		for placement_area in tower.placement_component.get_free_placement_areas():
			tower.placement_component.place_domino(get_domino(), placement_area, false, false)

	for entity in GameManager.current_match.entities.get_children():
		for i in range(GameManager.HAND_INITIAL_DOMINOES):
			add_domino(entity)

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
	
	if event.is_action_pressed("left_click") and GameManager.current_player.hand.dominoes.get_child_count() < GameManager.HAND_MAX_DOMINOES:
		give_domino()

# Fills the deck
func _fill_deck() -> void:
	for i in range(0, GameManager.DOMINO_MAX_DOTS + 1):
		for j in range(0, GameManager.DOMINO_MAX_DOTS + 1):
			if not Vector2i(j, i) in deck:
				deck.append(Vector2i(i, j))


# Public

# Gets a random domino from the deck
func get_domino() -> Domino:
	if deck.is_empty():
		_fill_deck()

	deck.shuffle()
	var new_domino = domino_scene.instantiate()
	temporal_dominoes.add_child(new_domino)
	new_domino.set_dots(deck.pop_back())
	
	return new_domino

# Adds a domino to the given entity
func add_domino(entity : Entity) -> void:
	entity.hand.add_domino(get_domino())

# Gives a domino to the current turn owner
func give_domino() -> void:
	add_domino(GameManager.current_match.get_turn_owner())
	GameManager.current_match.end_turn()
