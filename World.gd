extends Node3D

@export var dough_scene: PackedScene

func _process(delta):
	if Input.is_action_just_pressed("shoot"): _shoot()

func _shoot():
	var dough = dough_scene.instantiate()
	var player_position = $Player.position
	var collision_point = $Player/PlayerView/RayCast3D.get_collision_point()
	var camera_dir = -$Player/PlayerView/Camera.get_camera_transform().basis.z
	dough.initialize(player_position, collision_point, camera_dir)
	add_child(dough)
