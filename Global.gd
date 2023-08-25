extends Node

# This is a script that is set to AutoLoad that can be used for storing global variables/constants.
# In any script in the project, you can access variables in this script by typing 
# Global.[scriptname]

signal experience_blood_collected(number: float)
signal player_damaged()
signal health_set_on_ui(number: int)

func emit_experience_blood_collected(number: float):
	experience_blood_collected.emit(number)

func emit_player_damaged():
	player_damaged.emit()
	
func emit_set_player_health(number: int):
	health_set_on_ui.emit(number)

var currently_attacking : bool = false
