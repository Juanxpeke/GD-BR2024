class_name SkillsContainer
extends Control

@export var skill_card_mini_scene : PackedScene

var entity : Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body

# Updates this skills container layout
func _update_layout() -> void:
	var skills = entity.current_skills
	var child_count = get_child_count()
	
	for child in get_children():
		child.hide()
	
	for skill_index in range(skills.size()):
		if skill_index < child_count:
			get_child(skill_index).set_skill_index(skill_index)
			get_child(skill_index).show()
		else:
			var skill_card_mini = skill_card_mini_scene.instantiate()
			add_child(skill_card_mini)
			skill_card_mini.set_entity(entity)
			skill_card_mini.set_skill_index(skill_index)


# Public

# Sets this skills container entity
func set_entity(entity : Entity) -> void:
	self.entity = entity
	entity.skills_changed.connect(_update_layout)
	_update_layout()


