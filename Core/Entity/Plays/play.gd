class_name Play
extends Object

const CAMERA_FOCUS_WAIT_TIME : float = 1.2
const CAMERA_POST_BLOCK_TIME : float = 0.8

# Static

# Sorts an array of plays based on its values
static func sort(plays : Array[Play])-> Array[Play]:
	plays.sort_custom(func(p1, p2): return p1.value < p2.value)
	return plays


var value : float = 0.0
var disabled : bool = false

# Private

# Constructor
func _init() -> void:
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	disabled = true


# Public

# Gets the play position
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
	
	await GameManager.current_camera.get_tree().create_timer(CAMERA_POST_BLOCK_TIME).timeout
	GameManager.current_camera.unblock()

# Core execution logic
func core_execute() -> void:
	assert(false, 'This function needs to be implemented in the child class')
	pass



