class_name Template
extends Node

signal signal_one

const CONSTANT_ONE : int = 1

@export var my_exported_var : float = 2.0

var my_var : bool = false

@onready var my_onready_var := %Child

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_init_node()

# Called every frame. 'delta' is the elapsed time since the previous frame
func _process(delta : float) -> void:
	pass

# Initializes the node
func _init_node() -> void:
	# Print the initialization
	print("Initializing...")
	
	my_onready_var.tree_entered.connect(_on_child_tree_entered)
	
# Called when the child enters the scene tree
func _on_child_tree_entered() -> void:
	print("Entered child")

# Public

# Returns the given value multiplied by 2
func my_public_function(value : int) -> int:
	# Multiply the value by 2
	return value * 2
	
# Returns 1 divided by the given value
func my_public_function_2(value : int) -> float:
	return 1 / value # ALERT: This can lead to 1 / 0 which will make the game crash
