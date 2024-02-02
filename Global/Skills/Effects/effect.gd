class_name Effect
extends Resource

@export var value : float = 0.0

var icon : Texture2D

# Public

# Applies this effect
func apply(_caller : Entity) -> void:
	assert(false, 'This function needs to be implemented in the child class')

# Gets this effect priority
func get_priority() -> float:
	return value
