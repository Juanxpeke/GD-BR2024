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
		var best_skill_play = get_best_skill_play()
		
		while best_skill_play != null:
			await get_tree().create_timer(REACTION_TIME).timeout
			
			best_skill_play.execute()
			best_skill_play = get_best_skill_play()
		
		await get_tree().create_timer(REACTION_TIME).timeout
		get_best_world_play().execute()


# Public

# Gets the best skill play
func get_best_skill_play() -> SkillPlay:
	var skill_plays_ordered = Play.sort(get_skill_plays())
	
	if not skill_plays_ordered.is_empty():
		return skill_plays_ordered.back()
		
	return null

# Gets the best world play
func get_best_world_play() -> WorldPlay:
	var tower_placement_plays = get_tower_placement_plays()
	var deck_play = DeckPlay.new(self)
	var pass_play = PassPlay.new(self)
	
	var world_plays = tower_placement_plays + [deck_play] + [pass_play]
	var world_plays_ordered = Play.sort(world_plays)
	
	return world_plays_ordered.back()
