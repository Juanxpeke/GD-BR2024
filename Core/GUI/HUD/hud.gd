class_name HUD
extends CanvasLayer

@onready var player_interface := %PlayerInterface

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	GameManager.match_setted.connect(_on_match_setted)

# Called when the game match is setted
func _on_match_setted() -> void:
	player_interface.set_entity(GameManager.current_player)
