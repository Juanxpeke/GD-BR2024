class_name Boss
extends Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()

# Called when the current turn ends
func _on_turn_ended() -> void:
	super()
	
	if GameManager.current_match.is_turn_owner(self):
		get_best_play().execute()


# Public

# Gets the best play
func get_best_play() -> Play:
	assert(false, 'This function need to be implemented in the child class')
	return Play.new()
