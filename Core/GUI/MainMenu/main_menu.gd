class_name MainMenu
extends Control

var match_scene : PackedScene = load("res://Core/Match/match.tscn")

@onready var start_game_button := %StartGameButton
@onready var options_button := %OptionsButton
@onready var credits_button := %CreditsButton
@onready var exit_button := %ExitButton

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	start_game_button.pressed.connect(_on_start_game_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

# Called when the start game button is pressed
func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(match_scene)

# Called when the exit button is pressed
func _on_exit_button_pressed() -> void:
	get_tree().quit()
