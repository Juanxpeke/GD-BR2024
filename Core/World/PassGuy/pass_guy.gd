class_name PassGuy
extends Node2D

var previous_turn_passed : Dictionary = {}
var accumulated_passes : Dictionary = {}

@onready var area := %Area

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.match_setted.connect(_on_match_setted)
	
	area.mouse_entered.connect(_on_area_mouse_entered)
	area.mouse_exited.connect(_on_area_mouse_exited)
	area.input_event.connect(_on_area_input_event)

# Called when the game match is setted
func _on_match_setted() -> void:
	for entity in GameManager.current_match.entities.get_children():
		accumulated_passes[entity.name] = 0
		previous_turn_passed[entity.name] = false
		
	GameManager.current_match.turn_ended.connect(_on_turn_ended)
	
# Called when a turn ends
func _on_turn_ended() -> void:
	# The previous turn owner ended its turn without passing
	if not previous_turn_passed[GameManager.current_match.get_previous_turn_owner().name]:
		accumulated_passes[GameManager.current_match.get_previous_turn_owner().name] = 0
	
	previous_turn_passed[GameManager.current_match.get_previous_turn_owner().name] = false

# Called when the mouse enters the area
func _on_area_mouse_entered() -> void:
	ConfigurationManager.add_cursor_shape("pointer")

# Called when the mouse exits the area
func _on_area_mouse_exited() -> void:
	ConfigurationManager.remove_cursor_shape("pointer")

# Called on input event within the area
func _on_area_input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if not GameManager.current_match.is_turn_owner(GameManager.current_player):
		return
	
	if event.is_action_pressed("left_click"):
		pass_turn()

# Rewards the current turn owner for passing
func _reward_pass() -> void:
	var accumulated_pass =  accumulated_passes[GameManager.current_match.get_turn_owner().name]
	

# Public

# Passes the turn of the current turn owner
func pass_turn() -> void:
	accumulated_passes[GameManager.current_match.get_turn_owner().name] += 1
	previous_turn_passed[GameManager.current_match.get_turn_owner().name] = true
	
	_reward_pass()
	
	GameManager.current_match.end_turn()
