class_name CutsceneComponent
extends CanvasLayer

signal finished

@export var auto_start : bool = true
@export var cutscene_resources : Array[CutsceneResource] 

var current_panel : int = 0
var cutscene_label_finished : bool = false

@onready var cutscene_label := %CutsceneLabel
@onready var next_button := %NextButton
@onready var close_button := %CloseButton

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	hide()
	
	cutscene_label.text_typing_finished.connect(_on_text_typing_finished)
	
	next_button.button_down.connect(_on_next_button_down)
	next_button.button_up.connect(_on_next_button_up)
	next_button.pressed.connect(_on_next_button_pressed)
	
	close_button.button_down.connect(func(): AudioManager.play_sound(AudioManager.click_sound))
	close_button.pressed.connect(_on_close_button_pressed)
	
	if auto_start:
		start()

# Called when the label has finished the typing animation
func _on_text_typing_finished() -> void:
	if not cutscene_label_finished:
		cutscene_label_finished = true

# Called when the next button is pressed
func _on_next_button_pressed() -> void:
	if cutscene_label_finished:
		if current_panel >= cutscene_resources.size() - 1:
			finished.emit()
			return
		
		current_panel += 1
		cutscene_label_finished = false
		cutscene_label.set_cutscene_resource(cutscene_resources[current_panel])

# Called when the next button is downed
func _on_next_button_down() -> void:
	AudioManager.play_sound(AudioManager.click_sound)
	cutscene_label.speed_up()

# Called when the next button is upped
func _on_next_button_up() -> void:
	cutscene_label.speed_down()

# Called when the close button is pressed
func _on_close_button_pressed() -> void:
	hide()
	finished.emit()
	return


# Public

# Starts this cutscene component
func start() -> void:
	show()
	
	if not cutscene_resources.is_empty():
		cutscene_label.set_cutscene_resource(cutscene_resources[current_panel])
