class_name Player
extends Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()
	GameManager.set_player(self)

# Called when the current turn ends
func _on_turn_ended() -> void:
	pass
