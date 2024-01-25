class_name DeckPlay
extends Play

# Public

# Gets the play position
func get_play_position() -> Vector2:
	return GameManager.current_world.deck.global_position

# Executes the play
func execute() -> void:
	await super()
	GameManager.current_world.deck.give_domino()
