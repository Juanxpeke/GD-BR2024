class_name Skill
extends Resource

@export var name : String
@export_multiline var description : String
@export var manas_needed : Array[int] = [0, 0, 0, 0]
@export var sprite : Texture2D
@export var maximum_repetitions : int = -1 # Times this skill can be selected from the pool, -1 means infinite

var current_repetitions : int = 0

# Public

# Applies the skill effect
func apply_effect() -> void:
	pass
