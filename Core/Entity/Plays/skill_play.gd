class_name SkillPlay
extends Play

var skill_index : int

# Private

# Constructor
func _init(owner : Entity, skill_index : int) -> void:
	super(owner)
	
	self.skill_index = skill_index
	
	var skill = owner.current_skills[skill_index]
	self.priority = skill.get_priority()


# Public

# Executes the play
func execute() -> void:
	owner.handle_skill_activation(skill_index)
