class_name Boss
extends Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()

# Called when the current turn ends
func _on_turn_ended() -> void:
	if GameManager.current_match.is_turn_owner(self):
		pass
		# var best_plays = _calculate_best_play()
		#var best_counter_plays = _calculate_best_counter_play()
		
		#if best_play.weight > best_counter_play.weight:
		#	best_play.execute()
		#else:
		#	best_counter_play.execute() 
		
		#GameManager.current_match.end_turn()

# Calculates the 3 best plays
# func _calculate_best_plays() -> Array[Play]:
#	return [Play.new()]

# Calculates the 3 best counter plays
#func _calculate_best_counter_plays() -> Array[Play]:
#	return [Play.new()]
