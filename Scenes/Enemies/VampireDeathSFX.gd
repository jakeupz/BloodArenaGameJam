extends AudioStreamPlayer2D

func _ready():
	# Play the sound
	play()
	#end ready

# When the sound is done playing, free the audio stream player from memory
func _on_finished():
	queue_free()
	#end _on_finished
