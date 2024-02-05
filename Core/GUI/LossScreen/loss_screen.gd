extends Control


var main_menu_scene : PackedScene = load("res://Core/GUI/MainMenu/main_menu.tscn")

@onready var return_button := %ReturnButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	return_button.pressed.connect(_on_return_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#Called when the return button is pressed
func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)
