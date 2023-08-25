extends CanvasLayer

@onready var blood_counter = %BloodCounter
@onready var health_counter = %HealthCounter

var current_experience = 0
var health = 0

func _ready():
	blood_counter.text = str(current_experience)
	Global.experience_blood_collected.connect(on_experience_updated)
	Global.player_damaged.connect(on_player_damaged)
	Global.health_set_on_ui.connect(health_set)
	
func increment_experience(number: float):
	# Add to count
	current_experience += number
	blood_counter.text = str(current_experience)

func on_experience_updated(number: float):
	increment_experience(number)

func on_player_damaged():
	print("Health in UI:", health)
	health -= 1
	health_counter.text = str(health)

func health_set(number: int):
	health = number
	var player = get_tree().get_first_node_in_group("player")
	health_counter.text = str(player.health_component.current_health)
