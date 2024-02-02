class_name ManasContainer
extends Control

var entity : Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body

# Updates this manas container layout
func _update_layout(mana_type : GameManager.ManaType) -> void:
	get_child(mana_type).mana_amount.text = str(entity.current_manas[mana_type])


# Public

# Sets this health container entity
func set_entity(entity : Entity) -> void:
	self.entity = entity
	entity.mana_changed.connect(_update_layout)
	for mana_type in range(GameManager.ManaType.size()):
		_update_layout(mana_type)


