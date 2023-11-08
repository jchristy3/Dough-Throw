extends Node3D

@export var dough_scene: PackedScene

func _process(delta):
	if Input.is_action_just_pressed("shoot"): _shoot()

func _shoot():
	var dough = dough_scene.instantiate()
	var player_position = $Player.position
	var collision_point = $Player/PlayerView/RayCast3D.get_collision_point()
	var camera_rotation = $Player/PlayerView.rotation
	dough.initialize(player_position, collision_point)
	add_child(dough)
