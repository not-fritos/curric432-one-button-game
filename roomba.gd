extends CharacterBody2D

@export var SPEED = 15;
signal score_increment;

func _ready() -> void:
	velocity = Vector2(150, 100); #Starting Velocity

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta);
	if collision:
		velocity = velocity.bounce(collision.get_normal())

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (!area.get_parent().is_in_group("trails")):
		get_tree().reload_current_scene() #TODO: Change to menu record high score
	else:
		score_increment.emit();
		area.get_parent().free()
