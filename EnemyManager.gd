extends Node

const SPAWN_RADIUS = 375

@export var bat_enemy_scene: PackedScene
@export var person_enemy_scene: PackedScene

@onready var timer = $Timer

var base_spawn_time = 0
var enemy

func _ready():
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	
func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	#Checks each direction to make sure it works
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		var additional_check_offset = random_direction * 20
		
		#Int based on collision mask value number. The << is to change bit position. 1 << 19 would be layer 20
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position + additional_check_offset, 1 << 0)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)
	
		if result.is_empty():
			# We are clear
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
			
	return spawn_position

func on_timer_timeout():
	timer.start()
	
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
		
	var random_spawn = randi_range(1, 2)
	match random_spawn:
		1:
			enemy = bat_enemy_scene.instantiate()
		2:
			enemy = person_enemy_scene.instantiate()
			
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer") 
	entities_layer.add_child(enemy)
	enemy.global_position = get_spawn_position()
