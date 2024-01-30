class_name Skill
extends Resource

@export var name : String
@export_multiline var description : String
@export var manas_needed : Array[int] = [0, 0, 0, 0]
@export var sprite : Texture2D

# Public

# Applies the skill effect to the given entity
func apply_effect(entity : Entity) -> void:
	pass
