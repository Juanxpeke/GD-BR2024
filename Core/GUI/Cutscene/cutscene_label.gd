class_name TypingLabel
extends RichTextLabel

signal text_typing_finished

var slow_timer : float = 1.2


var slowdown : int = 0

var full_text : String = ""
var character_pos : int = 0
var current_panel : int = 0
var text_length : int = 0

@onready var timer = %Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


#Sets the corresponding text to the panel
func set_cutscene_text(cutscene_resource : CutsceneResource) -> void:
	full_text = cutscene_resource.cutscene_text
	text_length = cutscene_resource.cutscene_text.length()
	timer.wait_time = cutscene_resource.typing_speed
	slowdown = cutscene_resource.slowdown_threshold
	visible_characters = 0
	text = "[center]" + full_text + "[/center]"




# Called every time the timer finishes counting
func _on_timer_timeout() -> void:
	if visible_characters >= text_length:
		timer.stop()
		text_typing_finished.emit()
		return
	if visible_characters == text_length - slowdown - 1:
		timer.wait_time = slow_timer
	visible_characters += 1
	
	
