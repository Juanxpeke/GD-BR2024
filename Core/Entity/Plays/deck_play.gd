class_name DeckPlay
extends WorldPlay

# Private

# Constructor
func _init(owner : Entity) -> void:
	super(owner)
	self.priority = Play.NEW_DOMINO_PRIORITY if owner.hand.dominoes.get_child_count() < GameManager.HAND_MAX_DOMINOES else 0.0


# Public

# Gets the play position
func get_play_position() -> Vector2:
	return GameManager.current_world.deck.global_position

# Core execution logic
func core_execute() -> void:
	GameManager.current_world.deck.give_domino()
