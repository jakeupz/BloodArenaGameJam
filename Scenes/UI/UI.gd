extends CanvasLayer

@onready var blood_counter = %BloodCounter
@onready var health_counter = %HealthCounter

var current_experience = 0
var health_value = 0

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
	health_value -= 1
	health_counter.text = str(health_value)

func health_set(number: int):
	health_value = number
	health_counter.text = str(health_value)
