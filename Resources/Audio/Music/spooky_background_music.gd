extends AudioStreamPlayer



func _ready():
	# Play the sound
	play()
	
func _process(_delta):
	if playing == false:
		play()
		#end if
