class_name Bob
extends Boss

@export var damage_nullified_sounds : Array

# Public

# Subtract an amount from the current health
func subtract_current_health(amount : int) -> void:
	if amount > 1:
		AudioManager.play_random_sound(damage_nullified_sounds)
	elif amount > 0:
		AudioManager.play_random_sound(reaction_sounds)
	amount = min(amount, 1)
	set_current_health(current_health - amount)
	# TODO: Floating number and animation logic (apart from skill stuff)
