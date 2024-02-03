class_name HealthContainer
extends Control

var entity : Entity

@onready var health_bar := %HealthBar
@onready var health_amount := %HealthAmount

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body

# Updates this health container layout
func _update_layout() -> void:
	health_bar.max_value = entity.health
	health_bar.value = entity.current_health
	health_amount.text = str(entity.current_health) + "/" + str(entity.health) 


# Public

# Sets this health container entity
func set_entity(entity : Entity) -> void:
	self.entity = entity
	entity.health_changed.connect(_update_layout)
	_update_layout()


