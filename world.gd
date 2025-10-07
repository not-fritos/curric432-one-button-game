extends Node2D

@onready var anim_player : AnimationPlayer = $ColorRect/AnimationPlayer
@onready var color_rect = $ColorRect

func _ready() -> void:
	anim_player.play("fade_from_black")
