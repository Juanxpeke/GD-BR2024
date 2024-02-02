class_name SkillEffectsContainer
extends Control

@export var effect_information_scene : PackedScene

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body


# Public

# Sets the effects container related skill
func set_skill(skill : Skill) -> void:
	for effect_information in get_children():
		remove_child(effect_information)
		effect_information.queue_free()
		
	var effects = skill.effects
	
	for effect in effects:
		var effect_information = effect_information_scene.instantiate()
		add_child(effect_information)
		effect_information.set_effect(effect)
