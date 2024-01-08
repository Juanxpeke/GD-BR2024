extends Area2D

var last_domino_entered : Domino = null

@onready var placement_border := %PlacementBorder

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	placement_border.hide()
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

# Called on any input event
func _input(event : InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
		if last_domino_entered == null: return
		
		last_domino_entered.set_board_state(true)
		last_domino_entered.global_position = global_position

# Called on area entered
func _on_area_entered(area : Area2D) -> void:
	var domino = area.get_parent()
	if domino is Domino:
		placement_border.show()
		last_domino_entered = domino

# Called on area exited
func _on_area_exited(area : Area2D) -> void:
	var domino = area.get_parent()
	if domino is Domino:
		placement_border.hide()
		last_domino_entered = null
