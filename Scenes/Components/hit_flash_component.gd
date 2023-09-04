extends Node

@export var health_component: Node
@export var sprite: Sprite2D
@export var hit_flash_material = ShaderMaterial
@export var light_fade_material = CanvasItemMaterial

var hit_flash_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.health_changed.connect(on_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_health_changed():
	sprite.material = hit_flash_material
	if hit_flash_tween != null && hit_flash_tween.is_valid():
		hit_flash_tween.kill()
		
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween = create_tween()
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, .25)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	hit_flash_tween.tween_callback(change_light_fade)
		
func change_light_fade():
	sprite.material = light_fade_material
