extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var velocity_component = $VelocityComponent

var number_colliding_bodies = 0

signal health_set_on_ui

func _ready():
	health_component.health_changed.connect(on_health_changed)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	Global.emit_set_player_health(health_component.max_health)
	#end _ready

func _process(_delta):

	# Movement code
	# Look at the mouse
	look_at(get_global_mouse_position())
	
	# Get movement direction
	var movement_vector = get_movement_vector()
	# Normalize values to 1
	var direction = movement_vector.normalized()
	# Actual speed
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(self)

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
func _on_player_attack_animation_finished(anim_name):
	if anim_name == "chain_swing":
		Global.currently_attacking = false
		#end if
	#end _on_player_attack_animation_finished

func on_health_changed():
	Global.emit_player_damaged()

func on_damage_interval_timer_timeout():
	check_deal_damage()
	
func check_deal_damage():
#	print("Number of bodies: ", number_colliding_bodies)
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
#	print("Current player health: ", health_component.current_health)
	health_component.damage(1)
	damage_interval_timer.start()
#	print("Current player health: ", health_component.current_health)
	if health_component.current_health == 0:
		health_component.check_death()
		
		
func on_body_entered(_other_body: Node2D):
	if _other_body.is_in_group("enemy"):
		number_colliding_bodies += 1
		check_deal_damage()

func on_body_exited(_other_body: Node2D):
	if _other_body.is_in_group("enemy"):
		number_colliding_bodies -= 1
