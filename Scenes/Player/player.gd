extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 25
#var anim_state_machine_playback = $PlayerSprite/AnimationTree["parameters/playback"]


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
		# Play the chain attacak animation and sfx
		$PlayerSprite/AnimationTree["parameters/playback"].travel("chain_swing")
		$ChainAttackAnchor/ChainSFX.play()
		#end if
	# Attack code end
	
	
	#end _process


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
	#end get_movement_vector()


# Set the global currently_attacking variable to false if an attack animation finished
func _on_player_animation_finished(anim_name):
	# If chain attack
	if anim_name == "chain_swing":
		Global.currently_attacking = false
		#end if
	#end _on_player_attack_animation_finished

