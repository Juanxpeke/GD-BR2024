class_name TemporalEffect
extends Effect

@export var duration : int

var activations : Array[Activation] = []

# Private

# Constructor
func _init() -> void:
	GameManager.match_setted.connect(_on_match_setted)
	
# Called when the game match is setted
func _on_match_setted() -> void:
	GameManager.current_match.turn_ended.connect(_on_turn_ended)

# Called when the current turn ends
func _on_turn_ended() -> void:
	if GameManager.current_match.turn % 2 == 1:
		return
	
	var dead_activations = []
	
	for activation in activations:
		activation.time_call.call()
		activation.lifetime -= 1
		
		if activation.lifetime <= 0:
			dead_activations.append(activation)
	
	for dead_activation in dead_activations:
		activations.erase(dead_activation)


# Public

# Applies this effect
func apply(caller : Entity) -> void:
	var new_activation = Activation.new(duration, func(): apply_activation(caller))
	activations.append(new_activation)

# Applies the activation effect
func apply_activation(caller : Entity) -> void:
	assert(false, 'This function needs to be implemented in the child class')

# Gets this effect priority
func get_priority() -> float:
	return value * duration


# Class representing a temporal effect activation
class Activation:
	var lifetime : int
	var time_call : Callable
	
	# Constructor
	func _init(lifetime : int, time_call : Callable) -> void:
		self.lifetime = lifetime
		self.time_call = time_call
