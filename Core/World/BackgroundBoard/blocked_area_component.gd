class_name BlockedAreaComponent
extends Area2D

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	var collision_shape = null
	
	for child in get_children():
		if child is CollisionShape2D:
			collision_shape = child
	
	assert(collision_shape, 'Blocked area component collision shape not found')
	assert(collision_shape.shape is RectangleShape2D, 'Blocked area component shape must be a RectangleShape2D')
	
	if GameManager.current_world:
		_on_world_setted()
	else:
		GameManager.world_setted.connect(_on_world_setted)

# Called when the game world is setted
func _on_world_setted() -> void:
	GameManager.current_background_board.block_area_region(self)
