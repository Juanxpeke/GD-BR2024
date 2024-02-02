class_name Play
extends Object

const NEW_DOMINO_PRIORITY : float = 0.3 
const MINIMUM_USEFUL_MANA_PRIORITY : float = 0.2
const SAVE_USELESS_MANA_PRIORITY : float = 0.1

var owner : Entity
var priority : float = 0.0
var disabled : bool = false

# Static

# Sorts an array of plays based on its values
static func sort(plays : Array) -> Array:
	plays.sort_custom(func(p1, p2): return p1.priority < p2.priority)
	return plays


# Private

# Constructor
func _init(owner : Entity) -> void:
	self.owner = owner
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	disabled = true


# Public

# Executes the play
func execute() -> void:
	assert(false, 'This function needs to be implemented in the child class')
	pass

