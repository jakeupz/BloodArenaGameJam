# This code is DEPRECATED and part of an older version of the game.
# It is currently UNUSED and only here for archival/reference purposes.
extends Area2D

@export var attack_damage : int = 1
# Get the player node's Chain Attack Anchor child node from the Main Scene
@onready var anchor_node : Node = get_node("/root/Main/Player/ChainAttackAnchor")


# _ready() runs as soon as the object is spawned in
func _ready():
	
	# Set initial position & rotation
	position = anchor_node.position
	rotation = anchor_node.rotation + (PI / 2)
	
	# Set currently_attacking global var to true to prevent other attacks
	Global.currently_attacking = true

	# Play the chain swing animation and sfx
	$Sprite2D/AnimationPlayer.play("swing")
	# Uses a AudioStreamPlayer instead of AudioStreamPlayer2D to save resources because the chain 
	# is right on top of the player and does not need environmental attenuation
	# Has built-in RNG for pitch and which sound file it plays.
	$ChainSFX.play()
	
	#end _ready

func _process(_delta):
	# Set the ChainAttack's pos/rot to the value of the animated anchor node
	position = anchor_node.position
	rotation = anchor_node.rotation + (PI / 2)
	#end _process


# When the swinging chain attack hitbox touches another area
func _on_area_entered(_area):
	# In future, we will use this signal to deal damage to enemies.
	# For now, it just has a debug message.
	print ("ChainAttack hit something!")
	
	# 	Example of how to detect what got hit (such as a vampire enemy):
	#	if body == get_node("/root/Scenes/Enemies/Vampire"):
	#		sendDamageToVampire()
	#	#endif
	#	end of Example
	#end _on_area_entered



# Once the swing animation is finished, delete this instance of ChainAttack
func _on_animation_player_animation_finished(_anim_name):
	# Set the currently_attacking global var to false before deleting this object
	Global.currently_attacking = false
	queue_free()
	#end _on_animation_player_animation_finished



