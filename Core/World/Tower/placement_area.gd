class_name PlacementArea
extends Area2D

var last_domino_entered : Domino = null

@onready var placement_border := %PlacementBorder

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	placement_border.hide()
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

# Called on area entered
func _on_area_entered(area : Area2D) -> void:
	var domino = area.get_parent()
	if domino is Domino:
		last_domino_entered = domino
		get_parent().get_parent().queue_placement_area(self)

# Called on area exited
func _on_area_exited(area : Area2D) -> void:
	var domino = area.get_parent()
	if domino is Domino:
		get_parent().get_parent().unqueue_placement_area(self)
		last_domino_entered = null


# Public

# Shows the area hint
func show_hint() -> void:
	placement_border.show()

# Hides the area hint
func hide_hint() -> void:
	placement_border.hide()

# Places the domino inside this area
func place() -> void:
	get_parent().handle_domino_placement(self)
