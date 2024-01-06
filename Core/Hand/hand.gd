class_name Hand
extends Node2D

@export var domino_layout_area_scene : PackedScene

var dominoes_layout : Array[Domino] = []

@onready var border := %Border
@onready var dominoes := %Dominoes
@onready var dominoes_layout_areas := %DominoesLayoutAreas

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	var xd_scene = load("res://Core/Domino/domino.tscn")
	for i in 3:
		var xd : Domino = xd_scene.instantiate()
		add_domino(xd)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta : float) -> void:
	pass

# Updates the dominoes layout
func _update_dominoes_layout() -> void:
	for do in dominoes_layout_areas.get_children():
		do.time = 0.0
	
	var dominoes_layout_centers : Array[Vector2] = []
	var initial_x_offset = DominoLayoutArea.AREA_SIZE.x * (1 - dominoes_layout.size()) / 2
	
	for i in range(dominoes_layout.size()):
		var offset = Vector2(initial_x_offset + i * DominoLayoutArea.AREA_SIZE.x, 0)
		dominoes_layout_centers.append(global_position + offset)

	for i in range(dominoes_layout_centers.size()):
		if i < dominoes_layout_areas.get_child_count():
			dominoes_layout_areas.get_child(i).global_position = dominoes_layout_centers[i]
		else:
			var domino_layout_area = domino_layout_area_scene.instantiate()
			dominoes_layout_areas.add_child(domino_layout_area)
			domino_layout_area.global_position = dominoes_layout_centers[i]
			
	if dominoes_layout_areas.get_child_count() > dominoes_layout_centers.size():
		var count_diff = dominoes_layout_areas.get_child_count() - dominoes_layout_centers.size()
		for i in range(count_diff):
			# ALERT: Possible error
			dominoes_layout_areas.get_child(dominoes_layout_centers.size() + i).queue_free()

	
	for i in range(dominoes_layout.size()):
		# TODO: Change this to support animations
		dominoes_layout[i].global_position = dominoes_layout_areas.get_child(i).global_position

# Public

# Adds a domino to the hand
func add_domino(domino : Domino) -> void:
	dominoes.add_child(domino)
	include_domino_to_layout(dominoes_layout.size() / 2, domino)

# Moves the dominoes
func move_dominoes() -> void:
	pass
	
# Extracts a domino from the hand layout
func extract_domino_from_layout(layout_idx : int) -> void:
	dominoes_layout.remove_at(layout_idx)
	_update_dominoes_layout()

# Includes a domino in the hand layout
func include_domino_to_layout(layout_idx : int, domino : Domino) -> void:
	dominoes_layout.insert(layout_idx, domino)
	_update_dominoes_layout()


