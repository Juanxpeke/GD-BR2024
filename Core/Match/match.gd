class_name Match
extends Node

signal turn_ended

@export var next_scene : PackedScene

const MUSIC_REPETITION_WAIT_TIME : float = 20.0

static var match_music : AudioStream = load("res://Core/Match/match_music.wav")
static var skill_swapping_sound : AudioStream = load("res://SFX/skill_swapping.wav")

var turn : int = 0
var loss_screen : PackedScene = load("res://Core/GUI/LossScreen/loss_screen.tscn")

@onready var world_viewport_container : SubViewportContainer = %WorldViewportContainer
@onready var entities : Node2D = %Entities
@onready var hud : HUD = %HUD
@onready var cutscene_component : CutsceneComponent = %CutsceneComponent

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	cutscene_component.finished.connect(_on_cutscene_component_finished)
	world_viewport_container.mouse_entered.connect(_on_world_viewport_container_mouse_entered)
	world_viewport_container.mouse_exited.connect(_on_world_viewport_container_mouse_exited)
	GameManager.current_player.dead.connect(player_lose)
	GameManager.current_boss.dead.connect(player_win)
	GameManager.set_match(self)
	
# Called when the cutscene component finishes
func _on_cutscene_component_finished() -> void:
	cutscene_component.hide()
	AudioManager.play_music(match_music)
	AudioManager.music_stream_player.finished.connect(
		func():
			await get_tree().create_timer(MUSIC_REPETITION_WAIT_TIME).timeout
			AudioManager.play_music(match_music))
	
# Called when the mouse enters the world viewport container
func _on_world_viewport_container_mouse_entered() -> void:
	if GameManager.current_player.grabbed_domino == null: return
	
	GameManager.current_player.grabbed_domino.reparent(GameManager.current_world, false)

# Called when the mouse exits the world viewport container
func _on_world_viewport_container_mouse_exited() -> void:
	if GameManager.current_player.grabbed_domino == null: return
	
	GameManager.current_player.grabbed_domino.reparent(GameManager.current_player.hand.dominoes, false)



# Called when the opponent loses the game
func player_win() -> void:
	entities.queue_free()
	world_viewport_container.queue_free()
	print("connected")
	for connection in turn_ended.get_connections():
		turn_ended.disconnect(connection.callable)
	print("disconnected")
	get_tree().change_scene_to_packed(next_scene)
	GameManager.current_match = null

# Called when the player loses the game
func player_lose() -> void:
	entities.queue_free()
	world_viewport_container.queue_free()
	print("connected")
	for connection in turn_ended.get_connections():
		turn_ended.disconnect(connection.callable)
	print("disconnected")
	get_tree().change_scene_to_packed(loss_screen)
	GameManager.current_match = null

# Public

#region Turn Logic

# Ends the current turn
func end_turn() -> void:
	turn += 1
	
	turn_ended.emit()

# Gets the previous turn owner
func get_previous_turn_owner() -> Entity:
	return entities.get_child((turn - 1) % entities.get_child_count())

# Gets the current turn owner
func get_turn_owner() -> Entity:
	return entities.get_child(turn % entities.get_child_count())

# Returns true if the given entity is the turn owner, false otherwise
func is_turn_owner(entity : Entity) -> bool:
	return get_turn_owner() == entity

#endregion

#region Skills Logic

# Gets all the entities skills in this match
func get_entities_skills() -> Array[Skill]:
	return GameManager.current_player.current_skills + GameManager.current_boss.current_skills

# Swaps the skills of the entities
func swap_skills() -> void:
	var skills_cache = get_turn_owner().current_skills
	get_turn_owner().set_current_skills(get_turn_owner().get_enemy().current_skills)
	get_turn_owner().get_enemy().set_current_skills(skills_cache)
	
	AudioManager.play_sound(skill_swapping_sound)

#endregion
