class_name SkillEffectInformation
extends Control

@onready var skill_effect_icon := %SkillEffectIcon
@onready var skill_effect_value := %SkillEffectValue

# Private

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Public

# Sets the related effect
func set_effect(effect : Effect) -> void:
	skill_effect_icon.texture = effect.icon
	skill_effect_value.text = str(effect.value)
