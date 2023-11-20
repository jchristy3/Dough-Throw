extends Node3D

@export var dough_scene: PackedScene
@export var static_dough_scene: PackedScene

func _on_player_shoot_dough(player_position, collision_point, camera_direction):
	var dough = dough_scene.instantiate()
	dough.connect("create_stuck_dough", _on_dough_scene_create_stuck_dough)
	dough.initialize(player_position, collision_point, camera_direction)
	add_child(dough)
	
func _on_dough_scene_create_stuck_dough(position: Vector3, body: Node3D, _scale: Vector3):
	print(_scale)
	if body.is_in_group("Players"):
		pass
	else:
		create_static_dough(position, _scale)
		
func create_static_dough(position: Vector3, _scale: Vector3):
	var dough = static_dough_scene.instantiate()
	dough.initialize(position, _scale)
	add_child(dough)
