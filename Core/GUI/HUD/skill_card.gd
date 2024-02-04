class_name SkilLCard
extends Control

var skill : Skill

@onready var skill_name := %SkillName
@onready var skill_sprite := %SkillSprite
@onready var skill_description := %SkillDescription
@onready var skill_manas_container := %SkillManasContainer

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass

# Updates this mini card layout
func _update_layout() -> void:
	skill_name.text = skill.name
	skill_sprite.texture = skill.sprite
	skill_description.text = "[center]" + _parse_skill_description(skill.description) + "[/center]"
	skill_manas_container.set_skill(skill)

# Parses the given skill description
func _parse_skill_description(skill_description : String) -> String:
	var parsed_description: String = ""

	while skill_description.find("{effect}") != -1:
		var effect_start_index = skill_description.find("{effect}")
		var effect_end_index = skill_description.find("}", effect_start_index + "{effect}".length()) 

		if effect_end_index == -1:
			break
			
		var effect_data = skill_description.substr(effect_start_index + "{effect}".length() + 1, effect_end_index - effect_start_index - "{effect}".length() - 1)
		var effect_parts = effect_data.split(",")

		if effect_parts.size() != 2:
			break
			
		var effect_index = int(effect_parts[0].strip_edges())
		var effect_property = effect_parts[1].strip_edges()

		parsed_description += skill_description.substr(0, effect_start_index)
		
		var effect = skill.effects[effect_index]
		if effect_property == "value":
			parsed_description += str(effect.value)
		elif effect_property == "icon":
			parsed_description += "[img width=16 height=16]" + effect.icon.resource_path + "[/img]"
		elif effect_property == "duration" and effect is TemporalEffect:
			parsed_description += str(effect.duration)
		
		skill_description = skill_description.substr(effect_end_index + 1)

	parsed_description += skill_description
	return parsed_description


# Public

# Sets the skill for this card
func set_skill(skill : Skill) -> void:
	self.skill = skill
	_update_layout()
