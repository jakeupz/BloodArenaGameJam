extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 25;


func _process(delta):
	look_at(get_global_mouse_position())
	# Get movement direction
	var movement_vector = get_movement_vector()
	# Normalize values to 1
	var direction = movement_vector.normalized()
	# Actual speed
	var target_velocity = direction * MAX_SPEED
	
	# Smoothes out velocity. Lerp is framerate independent
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	#Build in function to move
	move_and_slide()

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
