class_name HealingEffect
extends Effect

# Public

# Applies this effect
func apply() -> void:
	GameManager.current_match.get_turn_owner().add_current_health(int(value))
