extends CharacterBody2D

@export var speed = 50
@export var navigation_agent: NavigationAgent2D 
@onready var health_component = $HealthComponent

var target_node = null
var last_known_position = target_node
var backup = 25
var bruh


func _ready():
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	recalc_path()
	
	
func _process(delta):
	$HealthLabel.text = str($HealthComponent.current_health)
	# Keep the health label upright
	$HealthLabel.rotation = -rotation	
	
func _physics_process(_delta):
	if navigation_agent.is_navigation_finished():
		return
	
	var axis = to_local(navigation_agent.get_next_path_position()).normalized()
	var intended_velocity = axis * speed
	navigation_agent.set_velocity(intended_velocity)
	
	if target_node and target_node.is_in_group("bruh"):
		navigation_agent.target_position = target_node.global_position
		last_known_position = target_node
	
func recalc_path():
	if target_node == null:
		return
	
	navigation_agent.target_position = target_node.global_position
		

func _on_recalculate_timer_timeout():
	recalc_path()

func _on_agro_range_area_entered(area: Area2D):
	if area.is_in_group("bruh"):
		target_node = area.owner
	

func _on_de_aggro_range_area_exited(area: Area2D):
	if area.owner == target_node:
		last_known_position = target_node
		target_node = null
		
		
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()




func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_attacks"):
		# If the area that collided is Player/ChainAttackAnchor/ChainAttack
		if area.name == "ChainAttack":
			$HealthComponent.damage(area.attack_damage)
				#end if
			#end if

		# If bat is out of health, kill it / free memory
		if $HealthComponent.current_health <= 0:
			$HealthComponent.check_death()
