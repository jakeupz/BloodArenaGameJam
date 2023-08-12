extends CharacterBody2D

const MAX_SPEED = 200
const ACCELERATION_SMOOTHING = 25;

# Get a reference variable to the chain_attack scene for use in the attack code
var chain_attack_scene = preload("res://Scenes/Player/Attacks/chain_attack.tscn")


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
	
	
	# Attack code
	# Check for player attack input
	if Input.is_action_just_pressed("primary_fire") and !Global.currently_attacking:
		
		# Instantiate a new chain_attack scene 
		var chain_attack : = chain_attack_scene.instantiate()
		
		# Set chain attack position and rotation to the player's position and rotation
	
		# The position of the chain_attack is relative to its parent node (Player), 
		# so we set its position (of type Vector2) to roughly (0,0), then adjust so it sits in hand
		chain_attack.position = Vector2(48, 0)
		# Simple rotation of the chain_attack by 90 degrees
		chain_attack.rotation += (PI / 2)
		
		# Add the chain_attack to the scene tree as a child of player
		add_child.call_deferred(chain_attack)
		
		#end if
	
	#end _process


func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
#end get_movement_vector()
