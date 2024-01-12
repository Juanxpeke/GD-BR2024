class_name Player
extends Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.set_player(self)
