extends Area2D

@export var max_health : int = 5
@onready var health : int = max_health


func _process(_delta):
	# Update the bat debugging health
	$Bat/BatHealthLabel.text = str(health)
	#end _process


func _on_area_entered(area):
	
	# If the area I am intersecting with is a player attack, kill me!
	if area.is_in_group("player_attacks"):
		
		# If the area that collided is ChainAttack.tscn's ChainAttack(Area2D)
		if area.name == "ChainAttack":
			health -= area.attack_damage
			#end if
		
		# If bat is out of health, kill it / free memory
		if health <= 0:
			print ("Bat killed!")
			# Delete this instance
			queue_free()
			#end if
	
	#end _on_area_entered
