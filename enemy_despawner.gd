extends Node2D

@export var despawn_margin = 2500

func _process(_delta: float) -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	
	for enemy in enemies:
		if (enemy is CharacterBody2D and _is_out_of_range(enemy)):
			enemy.queue_free()
			
func _is_out_of_range(enemy : CharacterBody2D) -> bool:
	if (abs(enemy.global_position.x) > despawn_margin):
		return true
	elif (abs(enemy.global_position.y) > despawn_margin):
		return true
	
	return false;
