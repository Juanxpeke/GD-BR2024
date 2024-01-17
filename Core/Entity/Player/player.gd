class_name Player
extends Entity

var grabbed_domino : Domino = null

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()
	GameManager.set_player(self)

# Called when the current turn ends
func _on_turn_ended() -> void:
	pass


# Public

# Sets the player grabbed domino
func set_grabbed_domino(domino : Domino) -> void:
	grabbed_domino = domino

# Clears the player grabbed domino
func clear_grabbed_domino() -> void:
	grabbed_domino = null
