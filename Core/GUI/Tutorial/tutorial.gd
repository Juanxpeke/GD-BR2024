extends Control

@export var tutorial_panels : Array[TutorialPanel]

var current_panel : int = 0

@onready var texture := %Texture
@onready var label := %Label
@onready var previous_button = %Previous
@onready var next_button = %Next

#Private
func _ready() -> void:
	previous_button.pressed.connect(set_previous_panel)
	next_button.pressed.connect(set_next_panel)
	_init_node()

func _init_node() -> void:
	texture.texture = tutorial_panels[current_panel].panel_image
	label.text = tutorial_panels[current_panel].panel_text

# Sets the next tutorial panel
func set_next_panel() -> void:
	current_panel +=1
	texture.texture = tutorial_panels[current_panel].panel_image
	label.text = tutorial_panels[current_panel].panel_text


# Sets the previous tutorial panel
func set_previous_panel() -> void:
	current_panel -= 1
	texture.texture =tutorial_panels[current_panel].panel_image
	label.text = tutorial_panels[current_panel].panel_text
