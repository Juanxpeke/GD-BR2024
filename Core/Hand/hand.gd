class_name Hand
extends Node2D

const MAX_DOMINOES : int = 7
const DOMINOES_SEPARATION_FACTOR : float = 0.5

var grabbed_domino_index : int

@onready var dominoes := %Dominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass

# Updates the dominoes layout
func _update_dominoes_layout() -> void:
	for i in range(dominoes.get_child_count()):
		var domino = dominoes.get_child(i)
		domino.position = Vector2(i * Domino.SPRITE_WIDTH * (1 + DOMINOES_SEPARATION_FACTOR), 0)


# Public

# Adds a domino to the hand
func add_domino(domino : Domino) -> void:
	dominoes.add_child(domino)
	domino.being_grabbed.connect(func(): grabbed_domino_index = domino.get_index())
	domino.world_state_changed.connect(_update_dominoes_layout)
	_update_dominoes_layout()
	
# Handles a domino reset
func handle_domino_reset(domino : Domino) -> void:
	domino.reparent(dominoes, false)
	dominoes.move_child(domino, grabbed_domino_index)

