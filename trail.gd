extends Node2D

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _draw() -> void:
	play_random_animation()

func _on_life_timer_timeout() -> void:
	queue_free()

func play_random_animation():
	var animation_names := sprite_2d.sprite_frames.get_animation_names()
	if(!len(animation_names)):
		return
	var random_ani_name = animation_names[randi() % animation_names.size()]
	sprite_2d.play(random_ani_name)
