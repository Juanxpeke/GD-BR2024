extends Boss

# Public

# Gets the best play
func get_best_play() -> Play:
	var tower_placement_plays_ordered = Play.sort(get_tower_placement_plays())
	
	if not tower_placement_plays_ordered.is_empty():
		return tower_placement_plays_ordered[0]
	
	if hand.dominoes.get_child_count() < GameManager.HAND_MAX_DOMINOES:
		return DeckPlay.new()
	
	return PassPlay.new()
