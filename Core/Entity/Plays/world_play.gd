class_name WorldPlay
extends Play

const CAMERA_FOCUS_WAIT_TIME : float = 1.2
const POST_EXECUTION_WAIT_TIME : float = 1.0

# Public

# Gets the play position in the world
func get_play_position() -> Vector2:
	assert(false, 'This function needs to be implemented in the child class')
	return Vector2.ZERO

# Executes the play
func execute() -> void:
	assert(not disabled, 'Play is disabled as turn has been passed')
	
	GameManager.current_camera.block()
	GameManager.current_camera.focus(get_play_position())
	await GameManager.current_camera.get_tree().create_timer(CAMERA_FOCUS_WAIT_TIME).timeout
	
	core_execute()
	
	await GameManager.current_camera.get_tree().create_timer(POST_EXECUTION_WAIT_TIME).timeout
	GameManager.current_camera.unblock()

# Core execution logic
func core_execute() -> void:
	assert(false, 'This function needs to be implemented in the child class')
	pass



