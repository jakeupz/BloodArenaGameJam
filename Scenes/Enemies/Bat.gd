extends CharacterBody2D


var bat_death_sound = preload("res://Scenes/Enemies/BatDeathSFX.tscn")

# Health managed through this component
@onready var health_component = $HealthComponent
# Movement managed through this component
@onready var velocity_component = $VelocityComponent


func _ready():
	# Play the fly animation
	$Sprite2D/AnimationPlayer.play("fly")
	# Pick a random part of the fly animation so not all bats flap at the same time
	$Sprite2D/AnimationPlayer.seek(randf_range(0.0, 1))

	
	#end ready


func _process(_delta):
	# Move to player
	velocity_component.rotate_to_player()
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	# Update the bat debugging health
	$HealthLabel.text = str(health_component.current_health)

	# Keep the health label upright
	$HealthLabel.rotation = -rotation
	
	# Set the flapping speed to match how fast the bat flies
	$Sprite2D/AnimationPlayer.speed_scale = velocity.length() / 77
	
	#end _process


func _on_area_entered(area):
	# If the area I am intersecting with is a player attack, hurt me!
	if area.is_in_group("player_attacks"):
		# If the area that collided is Player/ChainAttackAnchor/ChainAttack
		if area.name == "ChainAttack":
			$HealthComponent.damage(area.attack_damage)
			#$HealthLabel.text = $HealthComponent.current_health
			play_hurt_sfx()
			#end if

		# If bat is out of health, kill it / free memory
		if $HealthComponent.current_health <= 0:
			var death_sfx = bat_death_sound.instantiate()
			death_sfx.position = position
			get_parent().add_child(death_sfx)
			$HealthComponent.check_death()
			#end if
		#end if player_attack
	#end _on_area_entered


func play_hurt_sfx():
	if not $HurtSFX.is_playing():
		$HurtSFX.play()
	#end play_hurt_sfx


func die():
	print ("die(()")
	# Make a new instance of the bat death scene
	# So that it can play until completion
	var death_sfx = bat_death_sound.instantiate()
	death_sfx.position = position
	get_parent().add_child(death_sfx)
	
	# Delete this bat instance
	queue_free()
	#end die
