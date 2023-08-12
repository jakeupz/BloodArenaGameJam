extends Area2D

func _process(delta):
	pass
#end _process



func _on_area_entered(area):
	print ("ChainAttack hit bat!")
	
	# If the area I am intersecting with is a player attack, kill me!
	if area.is_in_group("player_attacks"):
		print ("Bat killed!")
		queue_free()
		#end if
	
	#end _on_area_entered
