extends CanvasLayer

var options_scene = preload("res://Scenes/UI/options_menu.tscn")

func _ready():
	%PlayButton.pressed.connect(on_play_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%CreditsButton.pressed.connect(on_credits_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	
	# Set the default values of music/sfx volume to 50% and 80% 
	var music_bus_index = AudioServer.get_bus_index("Music")
	var sfx_bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(music_bus_index, linear_to_db(0.3))
	AudioServer.set_bus_volume_db(sfx_bus_index, linear_to_db(0.8))
	#end ready


func on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main/main.tscn")

func on_credits_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/credits_menu.tscn")	

func on_options_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
	

func on_quit_pressed():
	get_tree().quit()

func on_options_closed(options_instance: Node):
	options_instance.queue_free()
