class_name BlockedAreaComponent
extends Area2D

@onready var collision_shape := $CollisionShape

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	assert(collision_shape, 'Blocked area component collision shape not found')
	assert(collision_shape.shape is RectangleShape2D, 'Blocked area component shape must be a RectangleShape2D')
	
	GameManager.world_setted.connect(_on_world_setted)

# Called when the game world is setted
func _on_world_setted() -> void:
	GameManager.current_world.background_board.register_blocked_area_component(self)
