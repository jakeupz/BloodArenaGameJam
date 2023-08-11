extends Camera2D

var target_position = Vector2.ZERO
# Change this to change camera speed
var interpolate_val = 5
# Change camera bounds
var CAMERA_DISTANCE_DIVISION = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	# Just on player
#	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))
	
	var mid_x = (target_position.x + get_global_mouse_position().x) / 2
	var mid_y = (target_position.y + get_global_mouse_position().y) / 2

	
	global_position = global_position.lerp(Vector2(mid_x,mid_y), interpolate_val * delta) 
	
func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0]
		target_position = player.global_position
