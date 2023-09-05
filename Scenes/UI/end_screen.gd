extends CanvasLayer

func _ready():
	get_tree().paused = true
	%RestartButton.pressed.connect(on_restart_button_pressed)
	%QuitButton.pressed.connect(on_quit_button_pressed)
	$DeathRandomStreamPlayer2DComponent.play_random()
	
func set_defeat(number: float):
	%EndLabel.text = "This evening's show \nis done"
	%ScoreLabel.text = "Score: " + str(number)
	
#func play_jingle(defeat: bool = false):
#	if defeat:
#		$DefeatStreamPlayer.play()
#	else:
#		$VictoryStreamPlayer.play()

func on_restart_button_pressed():
	Global.currently_attacking = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")


func on_quit_button_pressed():
	Global.currently_attacking = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
