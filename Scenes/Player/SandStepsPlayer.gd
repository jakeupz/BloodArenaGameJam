extends AudioStreamPlayer2D


# Play a footstep when I'm spawned in
func _ready():
	play()
	#end ready



# When the sound is done playing, free the audio stream player from memory
func _on_finished():
	queue_free()
	#end _on_finished
