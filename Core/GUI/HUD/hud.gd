class_name HUD
extends CanvasLayer

@onready var mute_music_button := %MuteMusicButton
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
	
	mute_music_button.toggled.connect(_on_mute_music_button_toggled)

# Called when the game match is setted
func _on_match_setted() -> void:
	player_interface.set_entity(GameManager.current_player)
	boss_interface.set_entity(GameManager.current_boss)

# Called when the mute music button is toggled
func _on_mute_music_button_toggled(toggled_on : bool) -> void:
	if toggled_on:
		AudioManager.stop_music()
	else:
		AudioManager.play_music(Match.match_music)

# Public

# Plays the given skill activation
func play_skill_activation(skill : Skill) -> void:
	skill_card.hide()
	
	animation_skill_card.set_skill(skill)
	
	animation_player.play("skill_activation")
	await animation_player.animation_finished
