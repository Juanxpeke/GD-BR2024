extends Control

@onready var exit_button = %ExitButton

#Private

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	exit_button.pressed.connect(_on_exit_button_pressed)


#Called when exit button is pressed
func _on_exit_button_pressed() -> void:
	queue_free()
