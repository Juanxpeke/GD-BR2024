class_name CutsceneLabel
extends RichTextLabel

signal text_typing_finished

var cutscene_resource : CutsceneResource

@onready var timer = %Timer

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)

# Called on a input event inside this control node
func _gui_input(event: InputEvent) -> void:
	if not cutscene_resource: return
	
	if event.is_action_pressed("left_click"):
		timer.wait_time = cutscene_resource.character_wait_time / 8.0
	elif event.is_action_released("left_click"):
		timer.wait_time = cutscene_resource.character_wait_time

# Public

# Sets the corresponding resource to the label
func set_cutscene_resource(cutscene_resource : CutsceneResource) -> void:
	self.cutscene_resource = cutscene_resource
	
	visible_characters = 0
	timer.wait_time = cutscene_resource.character_wait_time
	text = "[center]" + cutscene_resource.text + "[/center]"
	timer.start()

# Called every time the timer finishes counting
func _on_timer_timeout() -> void:
	if visible_characters >= cutscene_resource.text.length():
		timer.stop()
		text_typing_finished.emit()
		return
	
	if visible_characters == cutscene_resource.text.length() - cutscene_resource.slowdown_threshold - 1:
		timer.wait_time = cutscene_resource.character_slow_wait_time
	
	visible_characters += 1
	
	
