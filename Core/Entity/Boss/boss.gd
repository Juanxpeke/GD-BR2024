class_name Boss
extends Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()

# Called when the current turn ends
func _on_turn_ended() -> void:
	if GameManager.current_match.is_turn_owner(self):
		_calculate_best_play()
		GameManager.current_match.end_turn()

# Calculates the best play
func _calculate_best_play():
	print('My best play xd')
