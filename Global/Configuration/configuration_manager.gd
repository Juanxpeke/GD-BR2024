extends Node

# Load the custom images for the mouse cursor
var default = load("res://icon.svg")
var pointer = load("res://icon.svg")
var grab = load("res://icon.svg")
var grabbing = load("res://icon.svg")

# Shapes counters
var shape_counters = {
	"default": 0,
	"pointer": 0,
	"grab": 0,
	"grabbing": 0,
}

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	Input.set_custom_mouse_cursor(default, Input.CURSOR_ARROW)
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(grab, Input.CURSOR_DRAG)
	Input.set_custom_mouse_cursor(grabbing, Input.CURSOR_CROSS)

# Updates the current cursor shape based on the shape counters
func _update_cursor_shape() -> void:
	var shapes = shape_counters.keys()
	var cursor_shape = shapes[0]
	
	for shape in shapes:
		if shape_counters[shape] > 0:
			cursor_shape = shape
	
	print(cursor_shape)

	match cursor_shape:
		"default": Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		"pointer": Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		"grab": Input.set_default_cursor_shape(Input.CURSOR_DRAG)
		"grabbing": Input.set_default_cursor_shape(Input.CURSOR_CROSS)

# Public

# Adds a cursor shape
func add_cursor_shape(shape : String) -> void:
	shape_counters[shape] = shape_counters[shape] + 1
	_update_cursor_shape()

# Removes a cursor shape
func remove_cursor_shape(shape : String) -> void:
	shape_counters[shape] = min(shape_counters[shape] - 1, 0)
	_update_cursor_shape()
