class_name Entity
extends Node2D

signal health_changed
signal mana_changed(mana_type : GameManager.ManaType)
signal skills_changed()
signal dead

@export var health : int = 50
@export var skills : Array[Skill] = []

var current_health : int = health

var current_manas : Array[int] = []

@onready var hand : Hand = %Hand

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	current_manas.resize(GameManager.ManaType.size())
	
	GameManager.match_setted.connect(_on_match_setted)

# Called when the game match is setted
func _on_match_setted() -> void:
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	pass

# Public

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

#endregion

#region Skills

# Adds a skill to the player
func add_skill(skill : Skill) -> void:
	skills.append(skill)
	skills_changed.emit()

#endregion Skills
