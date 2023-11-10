extends CharacterBody3D

@export_range(1, 35, 1) var speed: float = 10 # m/s
@export_range(10, 400, 1) var acceleration: float = 100 # m/s^2

@export_range(0.1, 3.0, 0.1) var jump_height: float = 1 # m
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1

var jumping: bool = false
var mouse_captured: bool = false

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Node3D = $EnemyView

func _physics_process(delta):
	var player_position = get_node("../Player")
	look_at_from_position(position, player_position.position, Vector3.UP)
	velocity = Vector3.FORWARD * 2
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	move_and_slide()
	
