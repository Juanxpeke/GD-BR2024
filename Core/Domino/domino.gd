class_name Domino
extends Node2D

var grabbed : bool = false

@onready var sprite := %Sprite
@onready var area := %Area

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	area.input_event.connect(_on_input_event)
	area.mouse_entered.connect(_on_mouse_entered)
	area.mouse_exited.connect(_on_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta: float) -> void:
	pass

# Called on input event within the node
func _on_input_event(viewport : Node, event : InputEvent, shape_idx : int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and  event.is_pressed():
		print('xd')

# Called when the mouse enters the node
func _on_mouse_entered() -> void:
	pass
	
# Called when the node exits the node
func _on_mouse_exited() -> void:
	pass
