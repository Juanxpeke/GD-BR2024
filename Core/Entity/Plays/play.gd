class_name Play
extends Object

# Static

# Sorts an array of plays based on its values
static func sort(plays : Array[Play])-> Array[Play]:
	plays.sort_custom(func(p1, p2): return p1.value < p2.value)
	return plays


var value : float = 0.0

# Private


# Public

# Executes the play
func execute() -> void:
	pass
