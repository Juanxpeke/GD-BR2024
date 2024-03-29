class_name MainMenu
extends Control

var introduction_scene : PackedScene = load("res://Core/GUI/Introduction/introduction.tscn")
var tutorial_scene : PackedScene = load("res://Core/GUI/Tutorial/tutorial.tscn")
var credits_scene : PackedScene = load("res://Core/GUI/Credits/credits.tscn")

@onready var start_game_button := %StartGameButton
@onready var tutorial_button := %TutorialButton
@onready var credits_button := %CreditsButton
@onready var exit_button := %ExitButton

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	start_game_button.pressed.connect(_on_start_game_button_pressed)
	tutorial_button.pressed.connect(_on_tutorial_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

# Called when the start game button is pressed
func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(introduction_scene)

# Called when the tutorial button is pressed
func _on_tutorial_button_pressed() -> void:
	var tutorial_screen = tutorial_scene.instantiate()
	self.add_child(tutorial_screen)

# Called when the credits button is pressed
func _on_credits_button_pressed() -> void:
	var credits_screen = credits_scene.instantiate()
	self.add_child(credits_screen)

# Called when the exit button is pressed
func _on_exit_button_pressed() -> void:
	get_tree().quit()
