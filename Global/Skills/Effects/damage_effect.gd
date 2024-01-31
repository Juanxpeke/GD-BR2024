class_name DamageEffect
extends Effect

# Private

# Constructor
func _init() -> void:
	icon = load("res://Global/Skills/Effects/damage_effect_icon.png")


# Public

# Applies this effect
func apply() -> void:
	GameManager.current_match.get_previous_turn_owner().subtract_current_health(int(value))
