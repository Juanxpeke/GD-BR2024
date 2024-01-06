class_name DominoLayoutArea
extends Area2D

const AREA_SIZE : Vector2 = Vector2(200, 200)

var time : float = 0.0

@onready var collision_shape : CollisionShape2D = %CollisionShape

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	collision_shape.shape.size = AREA_SIZE
	area_entered.connect(_on_body_entered)
	area_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	time += delta
	
# Called on body entered
func _on_body_entered(body : Area2D) -> void:
	if body.get_parent() is Domino and body.get_parent().grabbed and time > 2.0:
		print('Domino entered in area: ', get_index())
		if body.global_position.x <= global_position.x:
			get_parent().get_parent().include_domino_to_layout(get_index(), body.get_parent())
		else:
			get_parent().get_parent().include_domino_to_layout(get_index() + 1, body.get_parent())

# Called on body exited
func _on_body_exited(body : Area2D) -> void:
	if body.get_parent() is Domino and body.get_parent().grabbed and time > 2.0:
		print('Domino exited in area: ', get_index())
		get_parent().get_parent().extract_domino_from_layout(get_index())
