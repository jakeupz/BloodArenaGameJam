extends CanvasLayer

@onready var blood_counter = $MarginContainer/BloodCounter

var current_experience = 0

func _ready():
	blood_counter.text = str(current_experience)
	Global.experience_blood_collected.connect(on_experience_updated)
	
func increment_experience(number: float):
	# Add to count
	current_experience += number
	blood_counter.text = str(current_experience)

func on_experience_updated(number: float):
	increment_experience(number)
