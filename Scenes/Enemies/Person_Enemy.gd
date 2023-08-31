extends CharacterBody2D

# Health managed through this component
@onready var health_component = $HealthComponent
# Movement managed through this component
@onready var velocity_component = $VelocityComponent

var bat_death_sound = preload("res://Scenes/Enemies/BatDeathSFX.tscn")
var player = preload ("res://Scenes/Player/player.tscn")

func _ready():
	# Play looping walk animation
	$Sprite2D/AnimationPlayer.play("walk")
	
	# Pick a random part of the walk animation
	# so not all enemies walk in sync
	$Sprite2D/AnimationPlayer.seek(randf_range(0.0, 1))
	#end ready


func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	
	# Update the debugging health
	$HealthLabel.text = str($HealthComponent.current_health)
	# Keep the health label upright
	$HealthLabel.rotation = -rotation
	
	# Look at the player's position
	# Main > Enemy Manager > Spawned Enemy
	# Enemy Manager and Player are sibling nodes
	look_at(get_parent().get_parent().get_node("Player").position)
	
	
	# Set walking animation speed based on velocity
	$Sprite2D/AnimationPlayer.speed_scale = velocity.length() / 100
	#end _process

func _on_hurtbox_area_entered(area):
	# If the area I am intersecting with is a player attack, hurt me!
	if area.is_in_group("player_attacks"):
		# If the area that collided is Player/ChainAttackAnchor/ChainAttack
		if area.name == "ChainAttack":
			$HealthComponent.damage(area.attack_damage)
				#end if
			#end if

		# If bat is out of health, kill it / free memory
		if $HealthComponent.current_health <= 0:
			var death_sfx = bat_death_sound.instantiate()
			death_sfx.position = position
			get_parent().add_child(death_sfx)
			print("I started in Person_Enemy at before check_death")
			$HealthComponent.check_death()
			#end if
	#end _on_area_entered

var sand_steps_player = preload("res://Scenes/Player/SandStepsPlayer.tscn")

func play_footstep():
	# Instantiate a SandStepsPlayer
	var sand_steps_instance : = sand_steps_player.instantiate()
	sand_steps_instance.pitch_scale = 0.7
	sand_steps_instance.attenuation = 10
	add_child.call_deferred(sand_steps_instance)
	#end play_footstep
