class_name TheftActive
extends BossActive

# Public

# Core activation logic
func core_activate(caller : Boss) -> void:
	var enemy = caller.get_enemy()
	var enemy_dominoes = enemy.hand.dominoes.get_children()
	
	var random_domino_index = GameManager.rng.randi_range(0, enemy_dominoes.size() - 1)
	var random_domino = enemy_dominoes[random_domino_index]
	
	if caller.hand.dominoes.get_child_count() < GameManager.HAND_MAX_DOMINOES:
		random_domino.reparent(caller.hand.dominoes)
		caller.hand.update_dominoes_layout()
	else:
		enemy.hand.dominoes.remove_child(random_domino)
		random_domino.queue_free()
	
	enemy.hand.update_dominoes_layout()
