extends CharacterBody2D

@export var max_health : int = 5
@onready var health : int = max_health

var bat_death_sound = preload("res://Scenes/Enemies/BatDeathSFX.tscn")




func _ready():
	# Play the fly animation
	$Sprite2D/AnimationPlayer.play("fly")
	# Pick a random part of the fly animation so not all bats flap at the same time
	$Sprite2D/AnimationPlayer.seek(randf_range(0.0, 1))

	
	#end ready


func _process(_delta):
	# Update the bat debugging health
	$HealthLabel.text = str(health)

	# Keep the health label upright
	$HealthLabel.rotation = -rotation
	
	#end _process


func _on_area_entered(area):

	
	# If the area I am intersecting with is a player attack, hurt me!
	if area.is_in_group("player_attacks"):

		# If the area that collided is Player/ChainAttackAnchor/ChainAttack
		if area.name == "ChainAttack":
			health -= area.attack_damage
			play_hurt_sfx()
				#end if
			#end if

		# If bat is out of health, kill it / free memory
		if health <= 0:
			die()
			#end if

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
