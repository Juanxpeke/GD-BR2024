class_name Skill
extends Resource

const POST_SKILL_ANIMATION_WAIT_TIME : float = 0.2

@export var name : String
@export var sprite : Texture2D
@export var sound : AudioStream
@export_multiline var description : String
@export var effects : Array[Effect]
@export var manas_needed : Array[int] = [0, 0, 0, 0]
@export var maximum_repetitions : int = -1 # Times this skill can be selected from the pool, -1 means infinite

var current_repetitions : int = 0

# Public

# Applies the skill effects
func apply_effects(caller : Entity) -> void:
	AudioManager.play_sound(sound)
	await GameManager.current_match.hud.play_skill_activation(self)
	await GameManager.get_tree().create_timer(POST_SKILL_ANIMATION_WAIT_TIME).timeout
	
	for effect in effects:
		effect.apply(caller)

# Gets this skill priority
func get_priority() -> float:
	var priority = 0.0
	
	for effect in effects:
		priority += effect.get_priority()
	
	return priority
