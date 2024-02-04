class_name ManaThirstEffect
extends TemporalEffect

@export_enum("Arcane", "Nature", "Dark", "Inferno", "Random") var mana_type: String = "Random"

# Private

# Constructor
func _init() -> void:
	super()
	icon = load("res://Global/Skills/Effects/TemporalEffects/mana_thirst_effect_icon.png")


# Public

# Applies the activation effect
func apply_activation(caller : Entity) -> void:
	var type : GameManager.ManaType
	var enemy_current_manas = caller.get_enemy().current_manas
	
	match mana_type:
		"Arcane": type = GameManager.ManaType.ARCANE
		"Nature": type = GameManager.ManaType.NATURE
		"Dark": type = GameManager.ManaType.DARK
		"Inferno": type = GameManager.ManaType.INFERNO
		"Random":
			var possible_mana_types = []
			
			for enemy_mana_type in range(enemy_current_manas.size()):
				if enemy_current_manas[enemy_mana_type] > 0:
					possible_mana_types.append(enemy_mana_type)
			
			if not possible_mana_types.is_empty():
				var type_index = GameManager.rng.randi_range(0, possible_mana_types.size() - 1)
				type = possible_mana_types[type_index]
	
	if enemy_current_manas[type] > 0:
		caller.get_enemy().subtract_current_mana(int(value), type)
