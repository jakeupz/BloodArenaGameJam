extends CanvasLayer

var options_menu_scene = preload("res://Scenes/UI/options_menu.tscn")
var is_closing = false

func _ready():
	get_tree().paused = true
	%ResumeButton.pressed.connect(on_resume_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
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

func on_options_pressed():
	var options_menu_instance = options_menu_scene.instantiate()
	add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(on_options_back_pressed.bind(options_menu_instance))

func on_quit_pressed():
	get_tree().paused = false
	Global.currently_attacking = false
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func on_options_back_pressed(options_menu: Node):
	options_menu.queue_free()
