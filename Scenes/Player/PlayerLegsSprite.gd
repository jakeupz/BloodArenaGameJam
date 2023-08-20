extends Sprite2D


var sand_steps_player = preload("res://Scenes/Player/SandStepsPlayer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = get_parent().velocity.angle()
	#end _ready


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Set the rotation of the legs based on which direction of WASD is pressed
	rotation = get_parent().velocity.angle() - (PI/2)
	
	# If moving, play the run animation
	if get_parent().velocity.length() > 0:
		$AnimationPlayer.play("walk")
		#end if

	# Set how fast the legs are animated based on the player's movement speed
	# Additional info:
	'''
	# This pauses the legs' animation when the player is not moving
	# This also means that the leg animation is ALWAYS running;
	# Note that the legs AnimationPlayer is completely separate from the
	# PlayerSprite (torso) AnimationPlayer
	'''
	$AnimationPlayer.speed_scale = get_parent().velocity.length() / 100
	
	
	#end _process
	
	
	
func play_footstep():
	# Instantiate a SandStepsPlayer
	var sans_steps_instance : = sand_steps_player.instantiate()
	add_child.call_deferred(sans_steps_instance)
	#end play_footstep
