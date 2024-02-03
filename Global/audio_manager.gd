extends Node

signal sound_played

const MINIMUM_SOUND_DELAY : float = 0.01 

var sounds_queue : Array[AudioStream] = []

var sound_stream_player : AudioStreamPlayer = AudioStreamPlayer.new()
var sound_stream_player_2 : AudioStreamPlayer = AudioStreamPlayer.new()

# Private

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	add_child(sound_stream_player)
	add_child(sound_stream_player_2)

# Public

# Queues the given sound
func queue_sound(sound : AudioStream) -> void:
	if not sound in sounds_queue:
		sounds_queue.append(sound)
		
	if not sound_stream_player.playing:
		play_next_queued_sound()

# Plays the next queued sound
func play_next_queued_sound() -> void:
	if not sounds_queue.is_empty():
		sound_stream_player.stop()
		sound_stream_player.stream = sounds_queue.pop_front()
		sound_stream_player.play()
		await sound_stream_player.finished
		play_next_queued_sound()

# Plays the given sound
func play_sound(sound : AudioStream, override : bool = false, delay : float = 0.0) -> void:
	if delay > MINIMUM_SOUND_DELAY:
		await get_tree().create_timer(delay).timeout
	
	if override:
		sound_stream_player_2.stop()
		sound_stream_player.stop()
		sound_stream_player.stream = sound
		sound_stream_player.play()
	else:
		if sound_stream_player.playing:
			sound_stream_player_2.stop()
			sound_stream_player_2.stream = sound
			sound_stream_player_2.play()
		else:
			sound_stream_player.stop()
			sound_stream_player.stream = sound
			sound_stream_player.play()
