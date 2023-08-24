extends Node2D

@export var health_component: Node
@onready var animation_player = $AnimationPlayer

# Called when character dies
func _ready():
	health_component.died.connect(on_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_died():
	if owner == null || not owner is Node2D:
		return
	
	# Spawn at location of "owner" aka enemy
	var spawn_position = owner.global_position
	
	# Spawn in entities in main
	var entities = get_tree().get_first_node_in_group("entities_layer")
	get_parent().remove_child(self)
	entities.add_child(self)
	
	global_position = spawn_position
	# Has a queue_free at the end of the animation player
	animation_player.play("spawn")
