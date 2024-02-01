class_name PoisonEffect
extends TemporalEffect

# Private

# Constructor
func _init() -> void:
	icon = load("res://Global/Skills/Effects/TemporalEffects/poison_effect_icon.png")


# Public

# Applies the activation effect
func apply_activation(caller : Entity) -> void:
	caller.get_enemy().subtract_current_health(int(value))
