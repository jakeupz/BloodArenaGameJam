extends AudioStreamPlayer2D

# General purpose script for playing a sound until completion and then deleting
# itself.
# This is used so that we can have overlapping sound effects or death animations
# that do not get cut off abruptly.

# Make sure to instantiate the appropriate SFX scene and also make sure that
# all signals are set up correctly or this could cause memory leaks.

func _ready():
	# Play the sound
	play()
	#end ready

# When the sound is done playing, free the audio stream player from memory
func _on_finished():
	queue_free()
	#end _on_finished
