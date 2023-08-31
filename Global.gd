extends Node

# This is a script that is set to AutoLoad that can be used for storing global variables/constants.
# In any script in the project, you can access variables in this script by typing 
# Global.[scriptname]

signal experience_blood_collected(number: float)

func emit_experience_blood_collected(number: float):
	experience_blood_collected.emit(number)


var currently_attacking : bool = false
