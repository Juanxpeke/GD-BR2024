class_name HUD
extends CanvasLayer

@onready var player_interface := %PlayerInterface
@onready var boss_interface := %BossInterface
@onready var skill_card := %SkillCard
@onready var animation_skill_card := %AnimationSkillCard
@onready var animation_player := %AnimationPlayer

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	skill_card.hide()
	animation_skill_card.hide()
	
	GameManager.match_setted.connect(_on_match_setted)

# Called when the game match is setted
func _on_match_setted() -> void:
	player_interface.set_entity(GameManager.current_player)
	boss_interface.set_entity(GameManager.current_boss)


# Public

# Plays the given skill activation
func play_skill_activation(skill : Skill) -> void:
	skill_card.hide()
	
	animation_skill_card.set_skill(skill)
	
	animation_player.play("skill_activation")
	await animation_player.animation_finished
