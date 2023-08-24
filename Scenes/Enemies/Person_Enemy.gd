extends CharacterBody2D

# Health managed through this component
@onready var health_component = $HealthComponent
# Movement managed through this component
@onready var velocity_component = $VelocityComponent

var bat_death_sound = preload("res://Scenes/Enemies/BatDeathSFX.tscn")

func _ready():
	pass


func _process(_delta):
	velocity_component.accelerate_to_player()
	velocity_component.move(self)
	
	# Update the bat debugging health
	$HealthLabel.text = str($HealthComponent.current_health)
	# Keep the health label upright
	$HealthLabel.rotation = -rotation
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
