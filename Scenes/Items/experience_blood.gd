extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D

func _ready():
	$Area2D.area_entered.connect(on_area_entered)

func tween_collect(percent: float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	
	# Direction movement
	global_position = start_position.lerp(player.global_position, percent)
	var direction_from_start = player.global_position - start_position
	
	# Rotate to player
	var target_rotation = direction_from_start.angle() + deg_to_rad(90)
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(-2 * get_process_delta_time()))

func collect():
	Global.emit_experience_blood_collected(1)
	queue_free()

func disable_collision():
	collision_shape_2d.disabled = true

func on_area_entered(_other_area: Area2D):
	#Runs function on next idle frame after on_area_entered
	Callable(disable_collision).call_deferred()
	
	var tween = create_tween()
	# Following tweens all go at once
	tween.set_parallel()
	# Pushes away slightly then comes to player
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, .5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK) 
	# Changes scale, adds delay t o  match previous timing
	tween.tween_property(sprite, "scale", Vector2.ZERO, .05).set_delay(.45)
	# Wait for tweens to finish
	tween.chain()
	tween.tween_callback(collect)
	
