class_name BossActive
extends Resource

const IDLE_ANIMATION_NAME : String = 'idle'

@export var animation_name : String
@export var cooldown : int

var current_cooldown : int = 0

# Private

# Constructor
func _init() -> void:
	GameManager.match_setted.connect(_on_match_setted)
	
# Called when the game match is setted
func _on_match_setted() -> void:
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	if !GameManager.current_match:
		return
	if GameManager.current_match.turn % 2 == 0:
		current_cooldown = max(current_cooldown - 1, 0)


# Public

# Activates this boss active
func activate(caller : Boss) -> void:
	assert(current_cooldown == 0, 'Tried to activate boss active on cooldown')
	
	current_cooldown = cooldown
	
	caller.sprite.animation = animation_name
	await caller.sprite.animation_finished
	
	await core_activate(caller)
	
	caller.sprite.animation = IDLE_ANIMATION_NAME
	caller.sprite.play()

# Core activation logic
func core_activate(_caller : Boss) -> void:
	assert(false, 'This function needs to be implemented in the child class')
	pass
