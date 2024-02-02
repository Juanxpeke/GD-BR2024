class_name Boss
extends Entity

const REACTION_TIME : float = 0.4

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()
	GameManager.set_boss(self)

# Called when the current turn ends
func _on_turn_ended() -> void:
	super()
	
	if GameManager.current_match.is_turn_owner(self):
		await get_tree().create_timer(REACTION_TIME).timeout
		get_best_world_play().execute()


# Public

# Gets the best world play
func get_best_world_play() -> WorldPlay:
	assert(false, 'This function needs to be implemented in the child class')
	return WorldPlay.new()
