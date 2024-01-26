class_name PassPlay
extends Play

# Public

# Gets the play position
func get_play_position() -> Vector2:
	return GameManager.current_world.pass_guy.global_position

# Core execution logic
func core_execute() -> void:
	GameManager.current_world.pass_guy.pass_turn()
