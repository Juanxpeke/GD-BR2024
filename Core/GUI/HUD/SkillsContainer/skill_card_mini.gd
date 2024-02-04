class_name SkilLCardMini
extends Control

var entity : Entity
var skill_index : int

@onready var skill_name := %SkillName
@onready var skill_sprite := %SkillSprite
@onready var skill_effects_container := %SkillEffectsContainer
@onready var skill_manas_container := %SkillManasContainer

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

# Called on any input within this control node
func _gui_input(event: InputEvent) -> void:
	if not GameManager.current_match.is_turn_owner(GameManager.current_player) or \
			GameManager.current_boss == entity or \
			GameManager.frozen:
		return
	
	if event.is_action_pressed("left_click"):
		entity.handle_skill_activation(skill_index)

# Called when the mouse enters the mini card
func _on_mouse_entered() -> void:
	GameManager.current_match.hud.skill_card.set_skill(entity.current_skills[skill_index])
	GameManager.current_match.hud.skill_card.show()

# Called when the mouse exits the mini card
func _on_mouse_exited() -> void:
	GameManager.current_match.hud.skill_card.hide()

# Updates this mini card layout
func _update_layout() -> void:
	var skill = entity.current_skills[skill_index]
	skill_name.text = skill.name
	skill_sprite.texture = skill.sprite
	skill_effects_container.set_skill(skill)
	skill_manas_container.set_skill(skill)


# Public

# Sets the entity for this mini card
func set_entity(entity : Entity) -> void:
	self.entity = entity

# Sets the skill index for this mini card
func set_skill_index(skill_index : int) -> void:
	self.skill_index = skill_index
	_update_layout()
