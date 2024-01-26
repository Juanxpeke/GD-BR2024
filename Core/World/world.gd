class_name World
extends Node2D

@onready var camera := %Camera
@onready var background_board := %BackgroundBoard
@onready var deck := %Deck
@onready var pass_guy := %PassGuy
@onready var towers := %Towers

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.set_world(self)

# Public
