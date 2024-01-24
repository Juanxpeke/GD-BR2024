extends Boss

# Public

# Gets the best play
func get_best_play() -> Play:
	var tower_placement_plays_ordered = Play.sort(get_tower_placement_plays())
	
	if tower_placement_plays_ordered.is_empty():
		return DeckPlay.new()
	else:
		return tower_placement_plays_ordered[0]
