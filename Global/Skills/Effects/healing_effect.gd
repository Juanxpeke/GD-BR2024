class_name HealingEffect
extends Effect

# Private

# Constructor
func _init() -> void:
	icon = load("res://Global/Skills/Effects/healing_effect_icon.png")


# Public

# Applies this effect
func apply(caller : Entity) -> void:
	caller.add_current_health(int(value))
