extends Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Look at the player
	look_at(get_parent().get_parent().get_node("Player").position)
	rotation = rotation - (PI / 2)
	# end process
