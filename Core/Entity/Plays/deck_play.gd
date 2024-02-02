class_name DeckPlay
extends WorldPlay

# Public

# Gets the play position
func get_play_position() -> Vector2:
	return GameManager.current_world.deck.global_position

# Core execution logic
func core_execute() -> void:
	GameManager.current_world.deck.give_domino()
