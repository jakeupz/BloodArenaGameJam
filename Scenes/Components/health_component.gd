extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10
@export var current_health: float


func _ready():
	current_health = max_health


func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)
	# A "hit taken" signal would happen but nothings implemented right now
	health_changed.emit()
	#Calls at the end of the current frame
	Callable(check_death).call_deferred()

# If we need a health bar
func get_health_percent():
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)

# This will emit the died signal in death component
func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
