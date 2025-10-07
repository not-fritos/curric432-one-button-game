extends Node2D

var npc_scene = preload("res://npc.tscn")
@export var spawn_margin = 1000;

func _on_timer_timeout() -> void:
	var npc = npc_scene.instantiate()
	add_child(npc);
	
	npc.position = _get_spawn_pos()
	npc.rotation = randf_range(0, TAU)
	

func _get_spawn_pos() -> Vector2:
	var rect := get_viewport().get_visible_rect()

	var side = randi_range(0, 3)
	var spawn_pos = Vector2.ZERO
	match side:
		0: # top
			spawn_pos.x = randf_range(rect.position.x, rect.position.x + rect.size.x)
			spawn_pos.y = rect.position.y - spawn_margin
		1: # right
			spawn_pos.x = rect.position.x + rect.size.x + spawn_margin
			spawn_pos.y = randf_range(rect.position.y, rect.position.y + rect.size.y)
		2: # bottom
			spawn_pos.x = randf_range(rect.position.x, rect.position.x + rect.size.x)
			spawn_pos.y = rect.position.y + rect.size.y + spawn_margin
		3: # left
			spawn_pos.x = rect.position.x - spawn_margin
			spawn_pos.y = randf_range(rect.position.y, rect.position.y + rect.size.y)
			
	return spawn_pos;
