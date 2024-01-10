class_name PlacementManager
extends Node2D

var placed_domino : Domino
var placed_dot : int

@onready var placement_area_up := %PlacementAreaUp
@onready var placement_area_right := %PlacementAreaRight
@onready var placement_area_left := %PlacementAreaLeft

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	# Up placement area
	placement_area_up.translate(Vector2.UP * Domino.SPRITE_HEIGHT)
	# Right placement area
	placement_area_right.rotate(PI / 2)
	placement_area_right.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.25)
	placement_area_right.translate(Vector2.RIGHT * Domino.SPRITE_WIDTH * 1.5)
	# Left start placement area
	placement_area_left.rotate(-PI / 2)
	placement_area_left.translate(Vector2.UP * Domino.SPRITE_HEIGHT * 0.25)
	placement_area_left.translate(Vector2.LEFT * Domino.SPRITE_WIDTH * 1.5)


# Public

# Handles a domino placement
func handle_domino_placement(placement_area : PlacementArea) -> void:
	var domino = placement_area.last_domino_entered
	
	if domino.dots.x == placed_dot:
		
		#player.active_power(placed_dot) -> trigger de "daño" hacia el enemigo, junto con su animacion
		#trigger de efecto entre placement_area y el domino antiguo
		domino.global_transform = placement_area.global_transform
		domino.reparent(get_parent().dominoes)
		set_placed_domino(domino, false)
	elif domino.dots.y == placed_dot:
		domino.global_transform = placement_area.global_transform
		domino.reparent(get_parent().dominoes)
		domino.rotate(PI)
		set_placed_domino(domino, true)
	else:
		# TODO: Domino reset logic
		pass
	
# Sets the placed domino
func set_placed_domino(domino : Domino, inverted : bool = false) -> void:
	domino.set_board_state(true)
	
	placed_domino = domino
	placed_dot = domino.dots.x if inverted else domino.dots.y
	
	global_transform = domino.global_transform
	
	if inverted: rotate(PI)
