extends CharacterBody2D

@export var speed: float = 300.0
@export var trail_timer: float = 1.

var time_elapsed: float = 0

var trail_scene = preload("res://trail.tscn")

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
