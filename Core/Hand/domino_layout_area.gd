class_name DominoLayoutArea
extends Area2D

const AREA_SIZE : Vector2 = Vector2(200, 200)

var last_domino_entered : Domino = null
var last_domino_exited : Domino = null

var time : float = 0.0

@onready var collision_shape : CollisionShape2D = %CollisionShape

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	collision_shape.shape.size = AREA_SIZE
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
# Called on area entered
func _on_area_entered(area : Area2D) -> void:
	var domino = area.get_parent()
	if domino is Domino and domino.grabbed:
		print('Domino entered in area: ', get_index())
		last_domino_entered = domino
		if domino.global_position.x <= global_position.x:
			get_parent().get_parent().include_domino_to_layout(get_index(), domino)
		else:
			get_parent().get_parent().include_domino_to_layout(get_index() + 1, domino)

# Called on area exited
func _on_area_exited(area : Area2D) -> void:
	var domino = area.get_parent()
	if domino is Domino and domino.grabbed and domino != last_domino_entered:
		print('Domino exited from area: ', get_index())
		last_domino_exited = domino
		get_parent().get_parent().extract_domino_from_layout(get_index())
