extends CharacterBody2D

@export var SPEED = 255;
signal score_increment;
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

@onready var anim_player = $"../ColorRect/AnimationPlayer"

var frozen = false

func _physics_process(delta: float) -> void:
	if frozen:
		return
	play_animation()
	velocity = transform.x * SPEED
	var collision = move_and_collide(velocity * delta);
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (!area.get_parent().is_in_group("trails")):
		frozen = true
		anim_player.play("fade_to_black")
		await anim_player.animation_finished
		get_tree().change_scene_to_file("res://main_menu.tscn")
	else:
		score_increment.emit();
		area.get_parent().free()

func play_animation() -> void:
	sprite_2d.flip_h = true
	sprite_2d.play("default")
