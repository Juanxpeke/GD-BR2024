class_name PassPlay
extends WorldPlay

# Private

# Constructor
func _init(owner : Entity) -> void:
	super(owner)
	self.priority = 0.0001


# Public

# Gets the play position
func get_play_position() -> Vector2:
	return GameManager.current_world.pass_guy.global_position

# Core execution logic
func core_execute() -> void:
	GameManager.current_world.pass_guy.pass_turn()
