class_name SkillPlay
extends Play

var skill_index : int

# Private

# Constructor
func _init(skill_index : int) -> void:
	self.skill_index = skill_index
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	disabled = true


# Public

# Executes the play
func execute() -> void:
	var skill = GameManager.current_match.get_turn_owner().current_skills[skill_index]
