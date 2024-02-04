class_name DestroyDominoEffect
extends Effect

# Private

# Constructor
func _init() -> void:
	icon = load("res://Global/Skills/Effects/destroy_domino_effect_icon.png")


# Public

# Applies this effect
func apply(caller : Entity) -> void:
	var enemy = caller.get_enemy()
	var enemy_dominoes = enemy.hand.dominoes.get_children()
	
	if enemy_dominoes.is_empty():
		enemy.subtract_current_health(int(value))
		return

	for i in range(int(value)):
		enemy_dominoes = enemy.hand.dominoes.get_children()
		
		var random_domino_index = GameManager.rng.randi_range(0, enemy_dominoes.size() - 1)
		var random_domino = enemy_dominoes[random_domino_index]
	
		enemy.hand.dominoes.remove_child(random_domino)
		random_domino.queue_free()
	
		enemy.hand.update_dominoes_layout()
