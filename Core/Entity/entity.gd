class_name Entity
extends Node2D

signal health_changed
signal skills_changed(dot : int)
signal dead

@export var health : int = 50
@export var skills : Array[Skill] = []

var current_health : int = health

@onready var hand : Hand = %Hand

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.match_setted.connect(
		func(): GameManager.current_match.turn_ended.connect(self._on_turn_ended))

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

#region Skills

# Sets the given skill to the player for the given dot
func set_skill(skill : Skill, dot : int) -> void:
	skills[dot] = skill
	skills_changed.emit(dot)

#endregion Skills
