class_name RegenerationEffect
extends TemporalEffect

# Private

# Constructor
func _init() -> void:
	super()
	icon = load("res://Global/Skills/Effects/TemporalEffects/regeneration_effect_icon.png")


# Public

# Applies the activation effect
func apply_activation(caller : Entity) -> void:
	caller.add_current_health(int(value))
