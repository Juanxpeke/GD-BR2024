class_name Play
extends Object

var value : float = 0.0
var disabled : bool = false

# Static

# Sorts an array of plays based on its values
static func sort(plays : Array) -> Array:
	plays.sort_custom(func(p1, p2): return p1.value < p2.value)
	return plays


# Private

# Constructor
func _init() -> void:
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	disabled = true


# Public

# Executes the play
func execute() -> void:
	assert(false, 'This function needs to be implemented in the child class')
	return

