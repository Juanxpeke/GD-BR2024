class_name EntityInterface
extends Control

@export var health_container : HealthContainer
@export var manas_container : ManasContainer
@export var skills_container : SkillsContainer

# Private

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body


# Public

# Sets this interface entity
func set_entity(entity : Entity) -> void:
	health_container.set_entity(entity)
	manas_container.set_entity(entity)
	skills_container.set_entity(entity)
