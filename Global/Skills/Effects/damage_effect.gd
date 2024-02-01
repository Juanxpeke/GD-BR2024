class_name DamageEffect
extends Effect

# Private

# Constructor
func _init() -> void:
	icon = load("res://Global/Skills/Effects/damage_effect_icon.png")


# Public

# Applies this effect
func apply(caller : Entity) -> void:
	caller.get_enemy().subtract_current_health(int(value))
