class_name SkillManasContainer
extends Control

@export var mana_icon_scene : PackedScene
@export var manas_icons : Array[Texture2D]
@export var manas_icons_separation : int

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	add_theme_constant_override("separation", manas_icons_separation)


# Public

# Sets the manas container related skill
func set_skill(skill : Skill) -> void:
	for mana_icon in get_children():
		remove_child(mana_icon)
		mana_icon.queue_free()
	
	var manas = skill.manas_needed
	
	for mana_type in range(manas.size()):
		for mana_count in range(manas[mana_type]):
			var mana_icon = mana_icon_scene.instantiate()
			add_child(mana_icon)
			mana_icon.texture = manas_icons[mana_type]
