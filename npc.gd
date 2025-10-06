extends CharacterBody2D

@export var speed: float = 300.0
@export var trail_timer: float = 1.
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var time_elapsed: float = 0

var trail_scene = preload("res://trail.tscn")

func _draw() -> void:
	play_random_animation()

func _physics_process(delta: float) -> void:
	time_elapsed += delta * Globals.TIME_MOD
	if (time_elapsed > trail_timer):
		time_elapsed = 0
		var t = trail_scene.instantiate()
		t.global_position = global_position + Vector2(randf_range(-4,4), randf_range(-4,4))
		get_tree().current_scene.add_child(t)
	
	velocity = -transform.y.normalized() * speed * Globals.TIME_MOD
	move_and_slide()

func _on_life_timer_timeout() -> void:
	queue_free()


func play_random_animation():
	var animation_names := sprite_2d.sprite_frames.get_animation_names()
	if(!len(animation_names)):
		return
	var random_ani_name = animation_names[randi() % animation_names.size()]
	sprite_2d.play(random_ani_name)
