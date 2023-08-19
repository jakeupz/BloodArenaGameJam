extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 25


func _ready():
	# Play the appropriate idle animation that loops automatically to start
	updateAnimation()
	#end _ready


func _process(delta):

	# Movement code
	# Look at the mouse
	look_at(get_global_mouse_position())
	
	# Get movement direction
	var movement_vector = get_movement_vector()
	# Normalize values to 1
	var direction = movement_vector.normalized()
	# Actual speed
	var target_velocity = direction * MAX_SPEED


	# Smoothes out velocity. Lerp is framerate independent
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	#Built in function to move
	move_and_slide()
	# Movement code end

	# Attack code
	# Check for player attack input
	if Input.is_action_just_pressed("primary_fire") and !Global.currently_attacking:
		
		# Attack initiated, set global var, play anim & sfx
		Global.currently_attacking = true
		$PlayerSprite/AnimationPlayer.play("chain_swing")
		$ChainAttackAnchor/ChainSFX.play()
		#end if
	# Attack code end
	
	# Run the animation function
	updateAnimation()
	
	#end _process


func updateAnimation():
	# If no active animation is playing, play the looping idle animation.
	if ( not $PlayerSprite/AnimationPlayer.is_playing() ) and velocity.length() == 0:
		$PlayerSprite/AnimationPlayer.play("idle")
		#end if
	#end updateAnimation


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
	#end get_movement_vector()


# Set the global currently_attacking variable to false if an attack animation finished
func _on_player_attack_animation_finished(anim_name):
	if anim_name == "chain_swing":
		Global.currently_attacking = false
		#end if
	#end _on_player_attack_animation_finished
