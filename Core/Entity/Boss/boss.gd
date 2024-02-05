class_name Boss
extends Entity

const INITIAL_WAIT_TIME : float = 0.6
const POST_ACTIVE_WAIT_TIME : float = 0.8
const POST_SKILL_WAIT_TIME : float = 0.8

@export var boss_active : BossActive
@export var boss_active_sounds : Array

@onready var sprite : AnimatedSprite2D = %Sprite

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()
	
	hand.hide()
	
	GameManager.set_boss(self)

# Called when the current turn ends
func _on_turn_ended() -> void:
	super()
	
	if GameManager.current_match.is_turn_owner(self):
		await get_tree().create_timer(INITIAL_WAIT_TIME).timeout
		
		# Active logic
		if GameManager.rng.randi_range(0, 1) == 0 and boss_active.current_cooldown == 0:
			AudioManager.play_random_sound(boss_active_sounds)
			await boss_active.activate(self)
			await get_tree().create_timer(POST_ACTIVE_WAIT_TIME).timeout
			
		# Skill play logic
		var best_skill_play = get_best_skill_play()
		
		while best_skill_play != null:
			await best_skill_play.execute()
			await get_tree().create_timer(POST_SKILL_WAIT_TIME).timeout
			
			best_skill_play = get_best_skill_play()
		
		# World play logic
		get_best_world_play().execute()


# Public

#region Plays

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

#endregion
