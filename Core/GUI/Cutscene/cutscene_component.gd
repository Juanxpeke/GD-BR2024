class_name CutsceneComponent
extends CanvasLayer

@export var cutscene_panels : Array[CutsceneResource] 

var current_panel : int = 0


@onready var cutscene_label = %CutsceneLabel
@onready var next_button = %NextButton

#Public

#Called when the node is ready
func _ready() -> void:
	cutscene_label.text_typing_finished.connect(_on_text_typing_finished)
	next_button.pressed.connect(_on_next_button_pressed)
	cutscene_label.set_cutscene_text(cutscene_panels[current_panel])

#Called when the label has finished the typing animation
func _on_text_typing_finished() -> void:
	if !next_button.visible:
		next_button.visible = true


#Called when the next button is pressed
func _on_next_button_pressed() -> void:
	if current_panel == cutscene_panels.size() - 1:
		pass #Emit cutscene finished signal and return
	current_panel += 1
	cutscene_label.set_cutscene_text(cutscene_panels[current_panel])
