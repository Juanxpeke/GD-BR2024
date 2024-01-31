extends Node

var skills = [
	load("res://Global/Skills/Fireball/fireball.tres"),
]

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body


# Public

# Gets a random skill
func get_random_skill() -> Skill:
	var random_index = GameManager.rng.randi_range(0, skills.size() - 1)
	var random_skill = skills[random_index]
	
	random_skill.current_repetitions += 1
	
	if random_skill.current_repetitions == random_skill.maximum_repetitions:
		skills.remove_at(random_index)
		
	return random_skill
