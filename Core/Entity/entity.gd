class_name Entity
extends Node2D

signal health_changed
signal mana_changed(mana_type : GameManager.ManaType)
signal skills_changed()
signal dead

@export var health : int = 50

var current_health : int = health
var current_manas : Array[int] = []
var current_skills : Array[Skill] = []

# Cache for the priority of manas needed in the current turn
var manas_needed : Array[int] = [] 

@onready var hand : Hand = %Hand

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	current_manas.resize(GameManager.ManaType.size())
	manas_needed.resize(GameManager.ManaType.size())
	
	GameManager.match_setted.connect(_on_match_setted)

# Called when the game match is setted
func _on_match_setted() -> void:
	_refill_current_skills()
	
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	_refill_current_skills()
	
	manas_needed.fill(0)
	
	if GameManager.frozen: await GameManager.being_unfrozen

# Updates the manas needed
func _update_manas_needed() -> void:
	for skill in current_skills:
		for mana_type in range(manas_needed.size()):
			manas_needed[mana_type] += max(current_manas[mana_type] - skill.manas_needed[mana_type], 0)

# Refills the entity current skills
func _refill_current_skills() -> void:
	for i in range(GameManager.SKILLS_MAX_AMOUNT - current_skills.size()):
		add_current_skill(SkillManager.get_random_skill())

# Public

#region Enemy

# Gets the entity enemy
func get_enemy() -> Entity:
	if self == GameManager.current_player:
		return GameManager.current_boss
	return GameManager.current_player

#endregion

#region Health

# Gets the current health
func get_current_health() -> int:
	return current_health

# Sets the given amount to the current health
func set_current_health(amount : int) -> void:
	current_health = clamp(amount, 0, health)
	health_changed.emit()
	
	if current_health == 0:
		dead.emit()

# Adds an amount to the current health
func add_current_health(amount : int) -> void:
	set_current_health(current_health + amount)
	# TODO: Floating number and animation logic (apart from skill stuff)

# Subtract an amount from the current health
func subtract_current_health(amount : int) -> void:
	set_current_health(current_health - amount)
	# TODO: Floating number and animation logic (apart from skill stuff)

#endregion

#region Manas

# Gets the current mana of the given type
func get_current_mana(mana_type : GameManager.ManaType) -> int:
	return current_manas[mana_type]

# Sets the given amount to the current mana of the given type
func set_current_mana(amount : int, mana_type : GameManager.ManaType) -> void:
	current_manas[mana_type] = max(amount, 0)
	mana_changed.emit(mana_type)

# Adds an amount to the current mana of the given type
func add_current_mana(amount : int, mana_type : GameManager.ManaType) -> void:
	set_current_mana(current_manas[mana_type] + amount, mana_type)
	# TODO: Floating number and animation logic (apart from world or skill stuff)

# Subtract an amount from the current mana of the given type
func subtract_current_mana(amount : int, mana_type : GameManager.ManaType) -> void:
	set_current_mana(current_manas[mana_type] - amount, mana_type)
	# TODO: Floating number and animation logic (apart from world or skill stuff)

# Gets the manas needed by the entity given the current skills in possesion
func get_manas_needed() -> Array[int]:
	if manas_needed == []:
		_update_manas_needed()
	return manas_needed

#endregion

#region Skills

# Sets the given skills to the entity current skills
func set_current_skills(skills : Array[Skill]) -> void:
	current_skills = skills
	skills_changed.emit()

# Adds a skill to the entity current skills
func add_current_skill(skill : Skill) -> void:
	current_skills.append(skill)
	skills_changed.emit()

# Removes the given skill from the entity current skills
func remove_current_skill(skill : Skill) -> void:
	current_skills.erase(skill)
	skills_changed.emit()
	
# Handles the skill in the given index activation
func handle_skill_activation(skill_index : int) -> void:
	print('Handling skill activation')
	var skill = current_skills[skill_index]
	
	print('Current manas: ', current_manas)
	
	var mana_consumption_calls = []
	for mana_type in range(skill.manas_needed.size()):
		if skill.manas_needed[mana_type] == 0:
			continue
		elif current_manas[mana_type] >= skill.manas_needed[mana_type]:
			print('Added mcc: ', skill.manas_needed[mana_type], ' - ', mana_type)
			var mana_consumption_call = Callable(func(): subtract_current_mana(skill.manas_needed[mana_type], mana_type))
			mana_consumption_calls.append(mana_consumption_call)
		else:
			# TODO: Unable sound
			return
	
	for mana_consumption_call in mana_consumption_calls:
		mana_consumption_call.call()
	
	skill.apply_effects(self)
	
	remove_current_skill(skill)

#endregion Skills

#region Plays

# Gets all the tower placement plays
func get_tower_placement_plays() -> Array[WorldPlay]:
	var tower_placement_plays : Array[WorldPlay] = []
	var manas_weights = get_manas_needed()
	
	for tower in GameManager.current_world.towers.get_children():
		for placement_component in tower.get_free_placement_components():
			for domino in hand.dominoes.get_children():
				if domino.dots.x == placement_component.dot:
					var tower_placement_play = TowerPlacementPlay.new(placement_component, domino, false)
					tower_placement_play.value = manas_weights[tower.mana_type]
					tower_placement_plays.append(tower_placement_play)
				if domino.dots.y == placement_component.dot:
					var tower_placement_play = TowerPlacementPlay.new(placement_component, domino, true)
					tower_placement_play.value = manas_weights[tower.mana_type]
					tower_placement_plays.append(tower_placement_play)
	
	return tower_placement_plays

#endregion
