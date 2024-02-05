class_name CutsceneComponent
extends CanvasLayer

signal finished

@export var auto_start : bool = true
@export var cutscene_resources : Array[CutsceneResource] 

var current_panel : int = 0

@onready var cutscene_label := %CutsceneLabel
@onready var next_button := %NextButton

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	hide()
	cutscene_label.text_typing_finished.connect(_on_text_typing_finished)
	next_button.pressed.connect(_on_next_button_pressed)
	
	if auto_start:
		start()

# Called when the label has finished the typing animation
func _on_text_typing_finished() -> void:
	if !next_button.visible:
		next_button.visible = true

# Called when the next button is pressed
func _on_next_button_pressed() -> void:
	if current_panel >= cutscene_resources.size() - 1:
		finished.emit()
		return
	
	current_panel += 1
	cutscene_label.set_cutscene_resource(cutscene_resources[current_panel])


# Public

# Starts this cutscene component
func start() -> void:
	show()
	
	if not cutscene_resources.is_empty():
		cutscene_label.set_cutscene_resource(cutscene_resources[current_panel])
