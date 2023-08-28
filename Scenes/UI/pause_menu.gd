extends CanvasLayer

var is_closing = false

func _ready():
	get_tree().paused = true
	%ResumeButton.pressed.connect(on_resume_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	
	
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		close()
		get_tree().root.set_input_as_handled()

func close():
	if is_closing:
		return
	
	is_closing = true
	get_tree().paused = false
	queue_free()
	
func on_resume_pressed():
	close()

func on_quit_pressed():
	get_tree().quit()
	get_tree().paused = false
#	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
