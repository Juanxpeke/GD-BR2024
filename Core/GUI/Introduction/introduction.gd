class_name Introduction
extends Control

@export var first_boss_match : PackedScene

@onready var cutscene_component : CutsceneComponent = %CutsceneComponent

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	await cutscene_component.finished
	get_tree().change_scene_to_packed(first_boss_match)

