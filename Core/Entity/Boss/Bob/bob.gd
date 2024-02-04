class_name Bob
extends Boss

# Public

# Subtract an amount from the current health
func subtract_current_health(amount : int) -> void:
	amount = min(amount, 1)
	set_current_health(current_health - amount)
	# TODO: Floating number and animation logic (apart from skill stuff)
