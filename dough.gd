extends RigidBody3D

signal create_stuck_dough(position: Vector3, body: Node3D, _scale: Vector3)

var grav_vel: Vector3
var throw_speed = 2000
var gravity: float = 3
var hasHit = false
var scaleSpeed = 1
var maxScale = 5
var force: Vector3 = Vector3(0,0,0);
var stuck = false
var growing = false
var at_max_scale = false
var bodies: Array[Node3D] = []
var jumpScaleSpeed = 20
var absoluteMaxScale = 10

@onready var joint: HingeJoint3D = $PinJoint3D
@onready var collisionShape: CollisionShape3D = $CollisionShape3D
@onready var meshInstance: MeshInstance3D = $MeshInstance3D

func _physics_process(delta):
	if !stuck:
		bodies = get_colliding_bodies()
		if bodies.size() > 0:
			stick(bodies, delta)
	else:
		convert_dough(bodies)
	
func initialize(player_position, target_position, camera_direction):
	var start_position: Vector3 = Vector3(player_position.x, player_position.y, player_position.z)
	start_position += camera_direction.normalized() * 3
	look_at_from_position(start_position, target_position, Vector3.UP)
	force = camera_direction.normalized() * throw_speed
	apply_force(force)
	
func stick(bodies, delta):
	growing = true
	sleeping = true
	freeze = true
	stuck = true
	
	var b = bodies[0]
	var bName = b.get_name()
	
	if b.is_in_group("StaticEnvironment"):
		convert_dough(bodies)
	elif b.is_in_group("Dough") && !b.is_done_growing():
		b.bump_size(delta)
		queue_free()
	
func convert_dough(bodies: Array[Node3D]):
	if bodies.size() > 0:
		create_stuck_dough.emit(position, bodies[0], meshInstance.scale)
		queue_free()
		

	
