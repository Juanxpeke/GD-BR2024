class_name World
extends Node2D

@onready var camera := %Camera
@onready var deck := %Deck

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.set_world(self)

# Public
