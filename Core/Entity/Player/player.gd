class_name Player
extends Entity

var grabbed_domino : Domino = null

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	super()
	GameManager.set_player(self)

func _input(event: InputEvent) -> void:
	if event.is_action_released("left_click") and grabbed_domino != null:
		# Set the grabbed var as false in case the domino is being grabbed but
		# you unclicked outside it because of moving the mouse too fast
		# NOTE: This has to be in the player script, instead of being on each domino
		# script, as when the domino changes its parent/viewport the released action
		# is not detected
		Domino.grabbing = false
		grabbed_domino.grabbed = false
		if not grabbed_domino.is_over_placement_area():
			grabbed_domino.reset()
		grabbed_domino = null
		ConfigurationManager.remove_cursor_shape("grabbing")

# Called when the current turn ends
func _on_turn_ended() -> void:
	super()


# Public
