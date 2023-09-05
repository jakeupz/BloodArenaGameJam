extends Node

@export var end_screen_scene: PackedScene
@onready var ui = $UI

signal score_update

var pause_menu_scene = preload("res://Scenes/UI/pause_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.health_component.died.connect(on_player_died)

# Last-in-line of input events.
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()

func on_player_died():
	var end_scene_instance = end_screen_scene.instantiate()
	add_child(end_scene_instance)
	end_scene_instance.set_defeat(ui.current_experience)
	Global.score_update(ui.current_experience)
