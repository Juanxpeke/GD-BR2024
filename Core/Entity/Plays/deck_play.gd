class_name DeckPlay
extends Play

# Public

# Executes the play
func execute() -> void:
	GameManager.current_world.deck.give_domino()
