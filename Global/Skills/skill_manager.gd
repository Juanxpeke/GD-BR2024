extends Node

var skills = [
	# Arcane
	load("res://Global/Skills/MagicMissiles/magic_missiles.tres"),
	load("res://Global/Skills/ManaLance/mana_lance.tres"),
	# Nature
	load("res://Global/Skills/ElectroBolt/electro_bolt.tres"),
	load("res://Global/Skills/ThunderStrike/thunder_strike.tres"),
	# Dark
	load("res://Global/Skills/DarkBlast/dark_blast.tres"),
	load("res://Global/Skills/BlackHole/black_hole.tres"),
	# Inferno
	load("res://Global/Skills/Fireball/fireball.tres"),
	# Nature & Dark
	load("res://Global/Skills/PoolOfPoison/pool_of_poison.tres"),
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
	
	while GameManager.current_match and random_skill in GameManager.current_match.get_usable_skills():
		random_index = GameManager.rng.randi_range(0, skills.size() - 1)
		random_skill = skills[random_index]
	
	random_skill.current_repetitions += 1
	
	if random_skill.current_repetitions == random_skill.maximum_repetitions:
		skills.remove_at(random_index)
		
	return random_skill
