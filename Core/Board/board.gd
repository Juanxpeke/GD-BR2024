class_name Board
extends Node2D

var start_domino : Domino
var end_domino : Domino

var start_dot : int
var end_dot : int

@onready var start_placement_area := %StartPlacementArea
@onready var start_placement_area_2 := %StartPlacementArea2
@onready var start_placement_area_3 := %StartPlacementArea3
@onready var end_placement_area := %EndPlacementArea
@onready var end_placement_area_2 := %EndPlacementArea2
@onready var end_placement_area_3 := %EndPlacementArea3
@onready var dominoes := %Dominoes

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	start_placement_area.monitoring = false
	start_placement_area_2.monitoring = false
	start_placement_area_3.monitoring = false
	end_placement_area.monitoring = false
	end_placement_area_2.monitoring = false
	end_placement_area_3.monitoring = false
	
	start_placement_area.domino_placed.connect(_on_start_domino_placed)
	start_placement_area_2.domino_placed.connect(_on_start_domino_placed)
	start_placement_area_3.domino_placed.connect(_on_start_domino_placed)
	end_placement_area.domino_placed.connect(_on_end_domino_placed)
	end_placement_area_2.domino_placed.connect(_on_end_domino_placed)
	end_placement_area_3.domino_placed.connect(_on_end_domino_placed)

# Called when a domino is placed in a start area
func _on_start_domino_placed(domino : Domino) -> void:
	start_domino = domino
	if domino.dots.x == start_dot:
		start_dot = domino.dots.y
	else:
		start_dot = domino.dots.x
		
	domino.reparent(dominoes)
	_update_start_placement_areas()

# Called when a domino is placed in an end area
func _on_end_domino_placed(domino : Domino) -> void:
	end_domino = domino
	if domino.dots.x == end_dot:
		end_dot = domino.dots.y
	else:
		end_dot = domino.dots.x
		
	domino.reparent(dominoes)
	_update_end_placement_areas()

# Updates the start placement areas
func _update_start_placement_areas() -> void:
	var start_domino_up_vector = -start_domino.global_transform.y
	var start_domino_right_vector = start_domino_up_vector.rotated(PI / 2)
	
	# First start placement area
	start_placement_area.global_transform = start_domino.global_transform
	start_placement_area.translate(start_domino_up_vector * Domino.SPRITE_HEIGHT)
	start_placement_area.monitoring = true
	# Second start placement area
	start_placement_area_2.global_transform = start_domino.global_transform
	start_placement_area_2.rotate(PI / 2)
	start_placement_area_2.translate(start_domino_up_vector * Domino.SPRITE_HEIGHT * 0.25)
	start_placement_area_2.translate(start_domino_right_vector * Domino.SPRITE_WIDTH * 1.5)
	start_placement_area_2.monitoring = true
	# Third start placement area
	start_placement_area_3.global_transform = start_domino.global_transform
	start_placement_area_3.rotate(-PI / 2)
	start_placement_area_3.translate(start_domino_up_vector * Domino.SPRITE_HEIGHT * 0.25)
	start_placement_area_3.translate(-start_domino_right_vector * Domino.SPRITE_WIDTH * 1.5)
	start_placement_area_3.monitoring = true

# Updates the end placement areas
func _update_end_placement_areas() -> void:
	var end_domino_up_vector = -end_domino.global_transform.y
	var end_domino_right_vector = end_domino_up_vector.rotated(PI / 2)
	# TODO: Refactor this because is literally the same logic but multiplied by -1
	# First end placement area
	end_placement_area.global_transform = end_domino.global_transform
	end_placement_area.translate(end_domino_up_vector * Domino.SPRITE_HEIGHT)
	start_placement_area.monitoring = true
	# Second end placement area
	end_placement_area_2.global_transform = end_domino.global_transform
	# Third end placement area
	end_placement_area_3.global_transform = end_domino.global_transform


# Public

# Add xd
func add_xd(xd : Vector2i) -> void:
	var domino = get_parent().domino_scene.instantiate()
	dominoes.add_child(domino)
	domino.set_dots(xd)
	domino.set_board_state(true)
	domino.rotate(deg_to_rad(90))
	
	domino.global_position = dominoes.global_position
	
	start_domino = domino
	end_domino = domino
	
	start_dot = domino.dots.x
	end_dot = domino.dots.y
	
	_update_start_placement_areas()
	_update_end_placement_areas()

# Add initial domino
func add_initial_domino(domino : Domino) -> void:
	dominoes.add_child(domino)
	domino.global_position = dominoes.global_position
	
	start_domino = domino
	end_domino = domino
	
	start_dot = domino.dots.x
	end_dot = domino.dots.y
	
	_update_start_placement_areas()
	_update_end_placement_areas()
