extends Node

@export var max_speed: int = 40
@export var acceleration: float = 5

var velocity = Vector2.ZERO
var angle_to_player = Vector2.ZERO

# This will allow the character to check for the player position in a straight line
func accelerate_to_player():
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return
		
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	var direction = (player.global_position - owner_node2d.global_position).normalized()
	accelerate_in_direction(direction)
	
# This will change the velocity
func accelerate_in_direction(direction: Vector2):
	var desired_velocity = direction * max_speed
	# acceleration = Smoothing process, delta = consistent. 1 - exp allows to eventually reach instead of stalling from a distance
	velocity = velocity.lerp(desired_velocity, 1 - exp(-acceleration * get_process_delta_time()))


# If you wanna slow down, do this
func decelerate():
	accelerate_in_direction(Vector2.ZERO)


# This will actually move the character through their velocity
func move(character_body: CharacterBody2D):
	character_body.velocity = velocity
	character_body.move_and_slide()
	velocity = character_body.velocity
