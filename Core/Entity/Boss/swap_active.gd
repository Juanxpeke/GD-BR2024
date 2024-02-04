class_name SwapActive
extends BossActive

# Public

# Core activation logic
func core_activate(caller : Boss) -> void:
	GameManager.current_match.swap_skills()
