class_name Ending
extends Control

@export var main_menu_scene : PackedScene

@onready var cutscene_component : CutsceneComponent = %CutsceneComponent

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	await cutscene_component.finished
	get_tree().change_scene_to_packed(main_menu_scene)

