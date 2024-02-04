class_name TowerChainActive
extends BossActive

# Public

# Core activation logic
func core_activate(caller : Boss) -> void:
	for tower in GameManager.current_world.towers.get_children():
		if tower.chains_duration > 0:
			tower.chains(0)
	
	var random_tower_index = GameManager.rng.randi_range(0, 3)
	GameManager.current_world.towers.get_child(random_tower_index).chains(2)
