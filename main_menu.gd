extends Control

@onready var stream_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var color_rect_anim_player : AnimationPlayer = $ColorRect/AnimationPlayer
@onready var button : TextureButton = $ButtonControl/TextureButton

func _process(_delta: float) -> void:
	if (!stream_player.playing):
		stream_player.play()

func _on_texture_button_pressed() -> void:
	button.button_pressed = true
	color_rect_anim_player.play("fade_to_black")
	await color_rect_anim_player.animation_finished
	get_tree().change_scene_to_file("res://world.tscn")
