extends Node

@export_range(0,1) var drop_percent: float = 1
@export var blood_drop_scene: PackedScene
@export var health_component: Node
	# Potental multidrops, not working right
@export_range(0, 100, 1) var spawn_amount: int = 10
var spawn_start: int = 0

func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	#end ready
	
	
func on_died():
	var adjusted_drop_percent = drop_percent
	# RNG drop is figured out here
	if randf() > adjusted_drop_percent:
		return
		#end if
	
	if blood_drop_scene == null:
		return
		#end if
		
	if not owner is Node2D:
		return
		#end if
		
	# Spawn blood to collect
	var spawn_position = (owner as Node2D).global_position
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	
#	entities_layer.get_parent().call_deferred("add_child", blood_drop_instance)
	while spawn_start < spawn_amount:
		var blood_drop_instance = blood_drop_scene.instantiate() as Node2D
#		entities_layer.add_child(blood_drop_instance)
		entities_layer.get_parent().call_deferred("add_child", blood_drop_instance)
		blood_drop_instance.global_position = spawn_position
		spawn_start += 1
	#end on_died
