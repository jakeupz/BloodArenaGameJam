extends CanvasLayer

@onready var back_button = %BackButton

func _ready():
	back_button.pressed.connect(on_back_pressed)


func on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)
