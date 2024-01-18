class_name Tower
extends Node2D

@export var mana_type : GameManager.ManaType = GameManager.ManaType.ARCANE

@onready var placement_component := %StaticPlacementComponent
@onready var sprite := %Sprite

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_update_mana_type_data()

# Updates the tower data from its mana type
func _update_mana_type_data() -> void:
	pass

# Public
