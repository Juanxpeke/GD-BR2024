class_name TowerChains
extends Sprite2D

@export var tower : Tower
@export var chained_sprite : Texture2D
@export var unchained_sprite : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	
	GameManager.match_setted.connect(_on_match_setted)
	
	tower.chains_duration_changed.connect(_on_tower_chain_duration_changed)

# Called when the game match is setted
func _on_match_setted() -> void:
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	_update_chains_sprite()

# Called when the tower chains duration changes
func _on_tower_chain_duration_changed() -> void:
	_update_chains_sprite()

# Updates the chains sprite
func _update_chains_sprite() -> void:
	if tower.chains_duration > 0:
		show()
		if GameManager.current_match.get_turn_owner() == GameManager.current_player:
			texture = chained_sprite
		else:
			texture = unchained_sprite
	else:
		hide()
