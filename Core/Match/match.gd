extends Node2D

const MAX_DOTS : int = 6

var deck : Array[Vector2i] = []

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_init_deck()
	
# Initializes the deck
func _init_deck() -> void:
	for i in range(0, MAX_DOTS + 1):
		for j in range(0, MAX_DOTS + 1):
			if not Vector2i(j, i) in deck:
				deck.append(Vector2i(i, j))
