class_name Hand
extends Node2D

const DOMINOES_SEPARATION_FACTOR : float = 0.5

var grabbed_domino_index : int

@onready var dominoes := %Dominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass


# Public

# Updates the dominoes layout
func update_dominoes_layout() -> void:
	var initial_position = Vector2.LEFT * (GameManager.HAND_MAX_DOMINOES * 0.5 * Domino.SPRITE_WIDTH * (1 + DOMINOES_SEPARATION_FACTOR) - Domino.SPRITE_WIDTH * 0.5) + \
			Vector2.UP * Domino.SPRITE_WIDTH
	
	for i in range(dominoes.get_child_count()):
		var domino = dominoes.get_child(i)
		var domino_offset = Vector2.RIGHT * i * Domino.SPRITE_WIDTH * (1 + DOMINOES_SEPARATION_FACTOR)
		domino.position = initial_position + domino_offset

# Adds a domino to the hand
func add_domino(domino : Domino) -> void:
	domino.reparent(dominoes, false)
	domino.being_grabbed.connect(func(): grabbed_domino_index = domino.get_index())
	domino.world_state_changed.connect(update_dominoes_layout)
	update_dominoes_layout()

# Handles a domino reset
func handle_domino_reset(domino : Domino) -> void:
	domino.reparent(dominoes, false)
	dominoes.move_child(domino, grabbed_domino_index)

