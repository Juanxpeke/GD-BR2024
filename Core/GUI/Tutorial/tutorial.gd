extends Control

@export var tutorial_panels : Array[TutorialPanel]

var current_panel : int = 0

@onready var texture := %Texture
@onready var label := %Label
@onready var previous_button = %Previous
@onready var next_button = %Next
@onready var exit_button = %ExitButton

#Private
func _ready() -> void:
	previous_button.pressed.connect(set_previous_panel)
	next_button.pressed.connect(set_next_panel)
	exit_button.pressed.connect(close_tutorial)
	print(tutorial_panels.size())
	_init_node()

func _init_node() -> void:
	texture.texture = tutorial_panels[current_panel].panel_image
	label.text = tutorial_panels[current_panel].panel_text

# Sets the next tutorial panel
func set_next_panel() -> void:
	if current_panel == tutorial_panels.size() - 1:
		return
	else:
		current_panel += 1
		texture.texture = tutorial_panels[current_panel].panel_image
		label.text = tutorial_panels[current_panel].panel_text


# Sets the previous tutorial panel
func set_previous_panel() -> void:
	if current_panel == 0:
		pass
	else:
		current_panel -= 1
		texture.texture =tutorial_panels[current_panel].panel_image
		label.text = tutorial_panels[current_panel].panel_text

func close_tutorial() -> void:
	queue_free()
