class_name ManasContainer
extends Control

static var icons = [
	load("res://Core/GUI/HUD/ManasContainer/pearl_1b.png"),
	load("res://Core/GUI/HUD/ManasContainer/pearl_01d.png"),
	load("res://Core/GUI/HUD/ManasContainer/pearl_01c.png"),
	load("res://Core/GUI/HUD/ManasContainer/pearl_01a.png")
]

var entity : Entity

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	pass # Replace with function body

# Updates this manas container layout
func _update_layout(mana_type : GameManager.ManaType) -> void:
	print('Updating mana layout', mana_type)
	get_child(mana_type).mana_icon.texture = icons[mana_type]
	get_child(mana_type).mana_amount.text = str(entity.current_manas[mana_type])


# Public

# Sets this health container entity
func set_entity(entity : Entity) -> void:
	self.entity = entity
	entity.mana_changed.connect(_update_layout)
	for mana_type in range(GameManager.ManaType.size()):
		_update_layout(mana_type)


