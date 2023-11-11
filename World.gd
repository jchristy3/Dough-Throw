extends Node3D

@export var dough_scene: PackedScene

func _on_player_shoot_dough(player_position, collision_point, camera_direction):
	var dough = dough_scene.instantiate()
	dough.initialize(player_position, collision_point, camera_direction)
	add_child(dough)
